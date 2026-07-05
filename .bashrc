fastfetch
EDITOR=nvim
alias sec='sudoedit /etc/nixos/configuration.nix'
alias sep='sudoedit /etc/nixos/packages.toml'
alias sef='sudoedit /etc/nixos/flake.nix'
alias nixswitch='sudo nixos-rebuild --flake /etc/nixos#default switch'
alias nixtest='sudo nixos-rebuild --flake /etc/nixos#default switch'
