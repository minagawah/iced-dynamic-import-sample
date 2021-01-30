#!/usr/bin/env bash

APP=${1%\/}
PROFILE=${2:=debug}

ROOT_DIR="$PWD"

SRC_DIR="$ROOT_DIR/src_for_wasm/$APP"
OUT_DIR="$ROOT_DIR/public/wasm/$APP"
CARGO_TOML="$SRC_DIR/Cargo.toml"
PACKAGE_JSON="$OUT_DIR/package.json"

###WASM_APP="$(echo "$APP" | tr '-' '_')"

cd "$SRC_DIR"
cargo build "--$PROFILE" --package "$APP" --target wasm32-unknown-unknown
wasm-bindgen "target/wasm32-unknown-unknown/$PROFILE/$APP.wasm" --out-dir "$OUT_DIR" --web

CURRENT_VERSION="$(toml get $CARGO_TOML package.version | tr -d \")"

echo "CURRENT_VERSION: $CURRENT_VERSION"
echo "CARGO_TOML: $CARGO_TOML"
echo "PACKAGE_JSON: $PACKAGE_JSON"

cat << EOF > "$PACKAGE_JSON"
{
  "name": "$APP",
  "version": "$CURRENT_VERSION",
  "files": [
    "${APP}_bg.wasm",
    "$APP.js",
    "$APP.d.ts"
  ],
  "module": "$APP.js",
  "types": "$APP.d.ts",
  "sideEffects": false
}
EOF
