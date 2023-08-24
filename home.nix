{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball {
		url = "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";	
  };
  gap = "15";
in
{
  imports = [
		(import "${home-manager}/nixos")
  ];

  home-manager.users.nyx = {
	  #This should be the same number as system.stateVersion in configuration.nix
	  home.stateVersion = "23.05";
        
    #Here we configure git
    programs.git = {
      enable = true;
      userName = "B-Cut";    
      userEmail = "cgoncalves@id.uff.br";
    };
	  programs.exa = {
		  enable = true;
		  enableAliases = true;
		  icons = true;
	  };
    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
        
      };
    };

    gtk = {
      enable = true;

      gtk3.extraConfig = {
        Settings = "
          gtk-application-prefer-dark-theme=1
        ";
      };

      gtk4.extraConfig = {
        Settings = "
          gtk-application-prefer-dark-theme=1
        ";
      };
    };
  };
}
