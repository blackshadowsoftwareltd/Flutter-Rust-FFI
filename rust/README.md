## To Generate binary from rust code. run this command from rust directory

windows(.dll), linux(.so)

#### Current Device

```
cargo build --release
```

#### Windows

```
cargo build --target=x86_64-pc-windows-gnu --release
```

#### Mac m1

```
cargo build --target aarch64-apple-darwin --release
```
