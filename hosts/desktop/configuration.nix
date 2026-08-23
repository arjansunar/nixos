# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/kanata.nix
    ./kanata.nix
    inputs.home-manager.nixosModules.default
  ];

  # enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot = {
    # Bootloader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # Set your time zone.
  time.timeZone = "Asia/Kathmandu";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    # Enable the X11 windowing system.
    # You can disable this if you're only using the Wayland session.
    xserver.enable = true;
    # Enable the KDE Plasma Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.envfs.enable = true;
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."rjan" = {
    isNormalUser = true;
    description = "rjan";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    shell = pkgs.fish;
    packages = with pkgs; [
      kdePackages.kate
      #  thunderbird
    ];
  };

  # home manager users
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "rjan" = import ./home.nix;
    };
  };

  programs = {
    nix-ld.enable = true;
    nix-ld.libraries = [
      # Add any missing dynamic libraries for unpackaged programs
      # here, NOT in environment.systemPackages
    ];
    helium = {

      enable = true;
      # 🎯 Policies - Written to /etc/chromium/policies/managed/helium-nixos.json
      # Also written to /etc/helium/policies/managed/ for future compatibility
      policies = {
        "BrowserSignin" = 0;
        "PasswordManagerEnabled" = false;
        "SyncDisabled" = true;
        "SpellcheckEnabled" = true;
        "SpellcheckLanguage" = [ "en-US" ];
        "ExtensionInstallForcelist" = [
          # Pre-install extensions
          "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
        ];
      };
    };
    fish.enable = true;
    firefox.enable = true;
    git = {
      enable = true;
      config = {
        user.name = "arjansunar";
        user.email = "arjan.gahatrajsunar@gmail.com";
        init.defaultBranch = "main";
        pull.rebase = true;
      };
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # system libraries
    gcc
    gnumake
    pkg-config
    python3
    # mysqlclient dependencies for pip package
    mariadb
    mariadb-connector-c
    # dependency for magic file detection
    file

    android-studio
    android-tools
    signal-desktop
    localsend
    pass
    gnupg
    pinentry-curses
    wl-clipboard

    neovim
    tree-sitter
    tree
    stow
    gh
    nerd-fonts.jetbrains-mono
    eza
    bat
    fzf
    yazi
    zellij

    # nix lang specifics
    nixfmt
    statix

    lutris
    mesa
    vulkan-tools
  ];

  # Docker setups
  virtualisation.docker = {
    # Consider disabling the system wide Docker daemon
    enable = false;

    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  networking = {

    hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networkmanager.enable = true;

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    firewall.allowedTCPPorts = [
      53317
    ];
  };
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system = {
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    stateVersion = "26.05"; # Did you read the comment?
    # Automatic updates
    autoUpgrade.enable = true;
    autoUpgrade.dates = "weekly";
  };

  environment.variables = {
    # mysqlclient dependencies for pip package
    MYSQLCLIENT_CFLAGS = "-I${pkgs.mariadb-connector-c.dev}/include/mariadb";
    MYSQLCLIENT_LDFLAGS = "-L${pkgs.mariadb-connector-c}/lib/mariadb -lmariadb";
    LD_LIBRARY_PATH = "${pkgs.file}/lib";
  };

}
