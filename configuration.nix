# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./home.nix
      ./vscode.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nyx"; 
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # ATM i'm in a vm, no need for this	
  
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "altgr-intl";
  };

  nix.settings.experimental-features = [ "flakes" "nix-command" ];

  #X server configurations and DE/WM
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese
    gnome-music
    gnome-terminal
    epiphany
    geary
    evince
    totem
    tali
    iagno
    hitori
    atomix
  ]);

  #Video stuff
  #services.xserver.videoDrivers = [ "nvidia" ];
  #hardware.opengl.driSupport32Bit = true;  
  #boot.blacklistedKernelModules = [ "noveau" ];
  #Uncomment when switching to actual pc
  services.spice-vdagentd.enable = lib.mkOverride 0 true;
  services.xserver.videoDrivers = [ "qx1" ];
  services.xserver.resolutions = lib.mkOverride 9 { x = 1920; y = 1080; }; 
 # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nyx = {
    isNormalUser = true;
    description = "Nyx";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      rustc
      cargo
      neovim
	    vscode
      lua
	    ripgrep
      nodejs
      nodePackages.npm
      #Gnome stuff
      gnome.gnome-tweaks
      gnome.dconf-editor
      #Extensions
      gnomeExtensions.appindicator
      gnomeExtensions.gsconnect
      gnomeExtensions.sound-output-device-chooser
      gnomeExtensions.blur-my-shell
      #Theming
      gradience
    ];
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable virtualization for vms
  virtualisation.libvirtd.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #Basic packages for whole system, necessary stuff
    vim
    wget
    curl
    firefox-bin
    git     
    appimage-run
    wezterm
    gcc
    python3
    python311Packages.nix-prefetch-github 
  ];

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  #Adding vscode support
  vscode.user = "nyx";
  vscode.homeDir = "/home/nyx";
  vscode.extensions = with pkgs.vscode-extensions; [
    bbenoist.nix
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
