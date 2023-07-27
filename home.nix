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
	
	#Hotkey configs
	services.sxhkd = {
	    enable = true;
	    keybindings = {
	    	"super + Return" = "wezterm";
		"super + w" = "firefox";
		"super + f" = "wezterm -e ranger"; 
		#Reset sxhkd
		"super + Escape" = "pkill -USR1 -x sxhkd";
		#Close/Kill program
		"super + {_, shift +}q" = "bspc node -{c,k}";
		#Switch between tiled and monocle
		"super + m" = "bspc desktop -l next";
		#Switch biggest node with current one"
		"super + g" = "bspc node -s biggest.local";
		#Set window state
		"super + {t,shift + t,s,f}" = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";
		#Change focus
		"super + {Left,Down,Up,Right}" = "bspc node -f {west,south,north,east}";
	    	#Focus last node
		"alt + tab" = "bspc node -f last";
		#Focus or send to desktop
		"super + {_,shift + }{1-5}" = "bspc {desktop -f,node -d} {1-5}";
   	   };
	};
        
        #Here we configure git
        programs.git = {
            enable = true;
            userName = "B-Cut";    
            userEmail = "cgoncalves@id.uff.br";
        };
	#Picom config here
	services.picom = {
	    enable = true;
            #backend = "glx";
	    inactiveOpacity = 0.8;
	    activeOpacity = 0.85;
 	    settings ={
	    	round-borders = 1;
		#blur = {
		#    method = "dual_kawase";
		#    size = 5;
		#    deviation = 5.0;
		#};
	    };
	};
	#Bspwm config
	xsession.windowManager.bspwm = {
	    enable = true;
	    monitors = {
		#Check xrandr to get the monitor name on a real machine
	    	Virtual-1 = [ "I" "II" "III" "IV" "V"];
	    };
	};
    };
}
