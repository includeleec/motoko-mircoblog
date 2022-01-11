import List "mo:base/List";
import Principal "mo:base/Principal";
import Iter "mo:base/Iter";
import Time "mo:base/Time";
import Array "mo:base/Array";

// https://github.com/dfinity/motoko-base/blob/master/src/Time.mo

actor {
    public type Message = {
        text : Text;
        time : Time.Time;
    };
    
    public type Microblog = actor {
        follow: shared(Principal) -> async();
        follows: shared query () -> async [Principal];
        post: shared(Text) -> async ();
        posts: shared query(Time.Time) -> async [Message];
        timeline: shared (Time.Time) -> async [Message];
    };

    stable var followed : List.List<Principal> = List.nil();

    public shared func follow(id: Principal) : async() {
        followed := List.push(id, followed);
    };

    public shared query func follows() : async [Principal] {
        List.toArray(followed);
    };

    stable var messages : List.List<Message> = List.nil();

    public shared({caller}) func post(text: Text) : async() {
        // assert(Principal.toText(caller) == "mazjf-cqufb-kyxyu-s2oci-syebe-s4ab3-pdp5j-3jh4w-buydz-oyqwe-hqe");

        let msg : Message = {
            text = text;
            time = Time.now();
        };

        messages := List.push(msg, messages);
    };

    private func lessTimeArr(arr: [Message], since: Time.Time) : [Message] {
        Array.filter(arr, func (arrItem: Message) : Bool {
            arrItem.time >= since;
        });
    };

    public shared query func posts(since: Time.Time) : async [Message] {
        let arr = List.toArray(messages);
        lessTimeArr(arr, since);
    };

    public shared func timeline(since: Time.Time) : async [Message] {
        var all : List.List<Message> = List.nil();

        for(id in Iter.fromList(followed)) {
            let canister:Microblog = actor(Principal.toText(id));
            let msgs = await canister.posts(since);

            for (msg in Iter.fromArray(msgs)) {
                all := List.push(msg, all);
            }

        };

        let arr = List.toArray(all);
        lessTimeArr(arr, since);
    };
};
