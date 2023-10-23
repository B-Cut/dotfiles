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

    programs.zsh = {
      enable = true;
      oh-my-zsh.enable = true;
      oh-my-zsh.theme = "agnoster";
      #PATH can come here
      initExtra = "
        alias rebuild='~/dotfiles/rebuild.sh'
        eval '$(direnv hook zsh)'
      ";
    };

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
        "org/gnome/shell" = {
          "enabled-extensions" = [
            "blur-my-shell@aunetx"
            #"forge@jmmaranan.com"
            "gsconnect@andyholmes.github.io"
            "mediacontrols@cliffniff.github.com"
            "sound-output-device-chooser@kgshank.net"
            "drive-menu@gnome-shell-extensions.gcampax.github.com"
            "user-theme@gnome-shell-extensions.gcampax.github.com"
          ];
          "disable-user-extensions" = false;
        };
      };
      
    };

    gtk = {
      enable = true;

      iconTheme = {
        name = "rose-pine-moon";
        package = pkgs.rose-pine-icon-theme;
      };

      theme = {
        name = "rose-pine-moon";
        package = pkgs.rose-pine-gtk-theme;
      };

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

    home.sessionVariables.GTK_THEME = "rose-pine-moon";
  };
}
