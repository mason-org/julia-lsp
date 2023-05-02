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

## Symbol caches

Symbols will automatically be downloaded to the store cache. To disable symbol downloads from the symbol server, set the
`SYMBOL_CACHE_DOWNLOAD` environment variable to `0`, for example:

```sh
$ SYMBOL_CACHE_DOWNLOAD=0 julia-lsp "<julia_env_path>"
```

To configure the symbol server (default is `https://www.julia-vscode.org/symbolcache`), set the `SYMBOL_SERVER`
environment variable, for example:

```sh
$ SYMBOL_SERVER=https://symbol-server julia-lsp "<julia_env_path>"
```

[modeline]: vim:tw=120:et:sw=4
