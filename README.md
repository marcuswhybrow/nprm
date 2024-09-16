## Install

```shell
nix profile install github:marcuswhybrow/nprm
```

#Usage 

```shell
nprm
```

An `fzf` fuzzy finder UI will appear with every nix store path in `nix profile list`. Filter by typing. Whichever item you select has it's index passed to `nix profile remove`.
