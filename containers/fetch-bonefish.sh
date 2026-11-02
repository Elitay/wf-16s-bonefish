#!/usr/bin/env bash
# Download a pinned bonefish release binary into containers/bonefish.
set -euo pipefail
VERSION="${BONEFISH_VERSION:-v0.4.0}"
DEST="$(cd "$(dirname "$0")" && pwd)/bonefish"
case "$(uname -m)" in
    x86_64) bfarch=x86_64 ;;
    aarch64|arm64) bfarch=arm64 ;;
    *) echo "unsupported architecture: $(uname -m)" >&2; exit 1 ;;
esac
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
url="https://github.com/DylanCosto/bonefish/releases/download/${VERSION}/bonefish-${VERSION}-linux-${bfarch}.tar.gz"
echo "Downloading ${url}"
wget -O "$tmp/bf.tgz" "$url"
tar -xzf "$tmp/bf.tgz" -C "$tmp"
install -m 0755 "$tmp/bonefish-${VERSION}-linux-${bfarch}/bonefish" "$DEST"
"$DEST" --version
echo "Wrote $DEST"
