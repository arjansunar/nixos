{ config, pkgs, inputs, ... }:

{

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "rjan";
  home.homeDirectory = "/home/rjan";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    neovim
    tree-sitter

    tree
    stow
    mise
    gh
    nerd-fonts.jetbrains-mono
    eza
    bat
    fzf
    yazi
    gcc
    zellij
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/a/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  # Gnome extensions
  programs.gnome-shell = {
    enable = true;

    extensions = [
      {
        package = pkgs.gnomeExtensions.dash-to-panel;
      }
    ];
  };
  
  dconf = {
    enable = true;

  # settings = {
  #   "org/gnome/shell/extensions/dash-to-panel" = {
  #     panel-position = "BOTTOM";
  #     panel-size = 36;
  #     panel-uses-custom-bg = true;
  #     panel-bg-color = "#1e1e2e";
  #     panel-uses-custom-opacity = true;
  #     panel-opacity = 0.9;
  #   };
  # };
  };

  # dev machine setup
	programs = {
	  starship.enable = true;
	  zoxide.enable = true;
	  lazygit.enable = true;
	  
    kitty = {
	    enable = true;
	    font = {
	    name = "JetBrainsMono Nerd Font";
	    size = 13.0;
	  };

	  settings = {
	    # Window
	    hide_window_decorations = "yes";
	    window_padding_width = 8;
	    window_margin_width = 0;

	    # Appearance
	    background_opacity = "0.95";

	    # Cursor
	    cursor_shape = "beam";
	    cursor_blink_interval = "0.5";

	    # Tabs
	    tab_bar_edge = "bottom";
	    tab_bar_style = "powerline";

	    # Tokyo Night
	    background = "#1a1b26";
	    foreground = "#c0caf5";

	    selection_background = "#33467c";
	    selection_foreground = "#c0caf5";

	    cursor = "#c0caf5";
	    cursor_text_color = "#1a1b26";

	    color0 = "#15161e";
	    color1 = "#f7768e";
	    color2 = "#73daca";
	    color3 = "#e0af68";
	    color4 = "#7aa2f7";
	    color5 = "#bb9af7";
	    color6 = "#7dcfff";
	    color7 = "#a9b1d6";

	    color8 = "#414868";
	    color9 = "#f7768e";
	    color10 = "#73daca";
	    color11 = "#e0af68";
	    color12 = "#7aa2f7";
	    color13 = "#bb9af7";
	    color14 = "#7dcfff";
	    color15 = "#c0caf5";
	  };
	  };
	};

}
