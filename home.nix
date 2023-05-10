# Edit this to install packages and modify dotfile configuration in your
# $HOME.
#
# https://nix-community.github.io/home-manager/index.html#sec-usage-configuration
{ pkgs, ... }: {
  imports = [
    # This loads ./home/neovim/default.nix - neovim configured for Haskell dev, and other things.
    ./home/neovim
    # Add more of your home-manager modules here.
  ];

  # Nix packages to install to $HOME
  #
  # Search for packages here: https://search.nixos.org/packages
  home.packages = with pkgs; [
    nix-output-monitor # https://github.com/maralorn/nix-output-monitor
    nix-info
    cachix
    lazygit # Better git UI
    ripgrep # Better `grep`
    nil # Nix language server
  ];

  # Programs natively supported by home-manager.
  programs = {
    # on macOS, you probably don't need this
    bash = {
      enable = true;
      initExtra = ''
        # Make Nix and home-manager installed things available in PATH.
        export PATH=/run/current-system/sw/bin/:$HOME/.nix-profile/bin:/etc/profiles/per-user/$USER/bin:$PATH
      '';
    };

    # For macOS's default shell.
    zsh = {

      shellAliases = {
        gl = "git pull";
        code-backend="code /Users/suraj.kumar1/nammayatri/Backend";
        code-kernel="code /Users/suraj.kumar1/shared-kernel";
        code-custom="code ~/.oh-my-zsh/custom/";
        code-config="code /Users/suraj.kumar1/nix-config";
        svc=", run-svc";
        qsvc="nix run .#arion -- up --remove-orphans -d";
        sac="nix run .#arion -- down --remove-orphans";
        pgadmin="nix run .#arion -- up --remove-orphans pg-admin";
        qpgadmin="nix run .#arion -- up --remove-orphans -d pg-admin";
        rms=", run-mobility-stack-dev";
        kill-server="sh /Users/suraj.kumar1/.oh-my-zsh/custom/portkill.sh";
        gsta="git stash";
        gstaa="git stash apply";
        gb="git branch";
        gco="git checkout";
        gcb="git checkout -b";
        backend="cd /Users/suraj.kumar1/nammayatri/Backend";
        kernel="cd /Users/suraj.kumar1/shared-kernel";
        ".."="cd ..";
        server-cold-start="sh /Users/suraj.kumar1/.oh-my-zsh/custom/server-start.sh";
      };

      enable = true;
      envExtra = ''
        # Make Nix and home-manager installed things available in PATH.
        export PATH=/run/current-system/sw/bin/:$HOME/.nix-profile/bin:/etc/profiles/per-user/$USER/bin:$PATH
      '';
    };

    # https://haskell.flake.page/direnv
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    starship.enable = true;

    # Type `z <pat>` to cd to some directory
    zoxide.enable = true;
  };
}
