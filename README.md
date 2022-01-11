# Mircoblog

## local
microblog: rrkah-fqaaa-aaaaa-aaaaq-cai
microblog2: ryjl3-tyaaa-aaaaa-aaaba-cai
```
dfx start
dfx deploy
dfx canister call microblog posts "(0)"
dfx canister call microblog follows
dfx canister call microblog follow "(principal \"ryjl3-tyaaa-aaaaa-aaaba-cai\")"

dfx canister call microblog2 posts "(0)"
dfx canister call microblog2 follows

dfx canister call microblog post "(\"first blog from microblog\")"
dfx canister call microblog2 post "(\"first blog from microblog2\")"

dfx canister call microblog timeline "(0)"
```

## network IC
microblog: ztdgx-aiaaa-aaaai-qbloq-cai
microblog2: z2anl-waaaa-aaaai-qblpa-cai
```
dfx canister --network ic call ztdgx-aiaaa-aaaai-qbloq-cai posts "(0)"
dfx canister --network ic call ztdgx-aiaaa-aaaai-qbloq-cai follows
dfx canister --network ic call ztdgx-aiaaa-aaaai-qbloq-cai follow "(principal \"z2anl-waaaa-aaaai-qblpa-cai\")"
dfx canister --network ic call ztdgx-aiaaa-aaaai-qbloq-cai timeline "(0)"
dfx canister --network ic call ztdgx-aiaaa-aaaai-qbloq-cai timeline "(1_641_898_334_149_084_316)"

dfx canister --network ic call z2anl-waaaa-aaaai-qblpa-cai posts "(0)"
dfx canister --network ic call ztdgx-aiaaa-aaaai-qbloq-cai posts "(1_641_898_250_477_162_930)"
dfx canister --network ic call z2anl-waaaa-aaaai-qblpa-cai posts "(1_641_898_334_149_084_316)"
```