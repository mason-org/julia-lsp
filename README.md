# julia-lsp

Wrapper around [julia-vscode](https://github.com/julia-vscode/julia-vscode) that enables running the Julia language
server as a standalone executable.

## Usage

`julia-lsp` receives one argument, the Julia environment to use. This should preferably be programmatically provided by
detecting the current project's environment.

```sh
$ julia-lsp "<julia_env_path>"

# Example:
$ julia-lsp ~/.julia/environments/v1.8/
```

## Storage locations

The executable is configured to store caches to `$JULIA_LSP_STORAGE` if defined, otherwise it defaults to `../store`
relative to where the executable is located.

[modeline]: vim:tw=120:et:sw=4
