#!/usr/bin/env bash

set -euo pipefail

FORCE=0

while getopts "f" opt; do
  case $opt in
    f)
      FORCE=1
      ;;
  esac
done

VERSION=${VERSION:-""}

if [[ -z $VERSION ]]; then
    VERSION=$(gh release view --repo julia-vscode/julia-vscode --json tagName -q .tagName)
fi

if [[ $FORCE != 1 ]] && gh release view "$VERSION"; then
    echo "Release $VERSION already exists."
    exit 0
fi

rm -rf build
mkdir build
cp -r bin build/
pushd build > /dev/null

STRIPPED_VERSION=$(sed -E 's/v(.+)/\1/' <<< "$VERSION")

gh release download --repo julia-vscode/julia-vscode --output "extension.vsix" --pattern "language-julia-${STRIPPED_VERSION}.vsix" "$VERSION"
unzip extension.vsix

ZIP="julia-lsp-${VERSION}.zip"

zip -r "$ZIP" bin/ extension/

if ! gh release view "$VERSION"; then
    gh release create "$VERSION" --generate-notes
fi
gh release upload --clobber v1.38.2 "$ZIP"

popd > /dev/null
rm -rf build
