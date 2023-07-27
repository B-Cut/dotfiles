{ config, pkgs, ... }:
let
    home-manager = builtins.fetchTarball {
	url = "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
	
    };
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

    };

    services.xserver.windowManager.bspwm.configFile = ./configs/bspwmrc;
    services.xserver.windowManager.bspwm.sxhkd.configFile = ./configs/sxhkdrc;

    


}
