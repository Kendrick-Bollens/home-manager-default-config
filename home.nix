{ config, lib, pkgs, ... }:

{
  home.username = "kenny";
  home.homeDirectory = "/home/kenny";
  home.stateVersion = "23.11"; # Please read the comment before changing
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  #Allowing non free packages to be installed
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home.packages = with pkgs; [
      #commandline stuff
      #vim
      jre_minimal
      ventoy
      wireguard-tools
      rustup

      #zsh
      zsh-powerlevel10k
      interception-tools-plugins.caps2esc


      #gui packages
      rpi-imager
      tailscale-systray
      discord
      spotify
      libreoffice
      plex-media-player
      gimp
      bambu-studio
      anki
      orca-slicer
      


      # gnome
      gnome-tweaks
      gnomeExtensions.gsconnect
      gnomeExtensions.caffeine
      
      gnomeExtensions.blur-my-shell
      
      gnomeExtensions.vitals
      
      gnomeExtensions.coverflow-alt-tab
      
      gnomeExtensions.burn-my-windows
      
      #gnomeExtensions.pano
      gnomeExtensions.clipboard-indicator
      
      gnomeExtensions.grand-theft-focus
      
      gnomeExtensions.ddterm
      
      gnomeExtensions.appindicator
      gnomeExtensions.quick-settings-tweaker


    # You can also create simple shell scripts directly inside your
    # configuration. For example, this adds a command 'my-hello' to your
    # environment:
    (writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
    '')
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    initExtra = "
      [[ ! -f ${./p10k-config/p10k.zsh} ]] || source ${./p10k-config/p10k.zsh}
      fastfetch

    ";


    #plugin config hard way 
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
      
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }

      {
        name = "enhancd";
        src = pkgs.fetchFromGitHub {
          owner = "babarot";
          repo = "enhancd";
          rev = "v2.5.1";
          sha256 = "sha256-kaintLXSfLH7zdLtcoZfVNobCJCap0S/Ldq85wd3krI=";
        };
      }
      {
        name = "zsh-history-substring-search";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-history-substring-search";
          rev = "v1.1.0";
          sha256 = "sha256-GSEvgvgWi1rrsgikTzDXokHTROoyPRlU0FVpAoEmXG4=";
        };
      }
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "v1.1.2";
          sha256 = "sha256-Qv8zAiMtrr67CbLRrFjGaPzFZcOiMVEFLg1Z+N6VMhg=";
        };
      }
    ];

  };

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos_small";
        padding = {
          right = 1;
        };
      };
      display = {
        binaryPrefix = "si";
        color = "blue";
        separator = "  ";
      };
      modules = [
        {
          type = "datetime";
          key = "Date";
          format = "{1}-{3}-{11}";
        }
        {
          type = "datetime";
          key = "Time";
          format = "{14}:{17}:{20}";
        }
        "break"
        "player"
        "media"
      ];
    };
  };

  programs.neovim = {
    enable = true;
    extraConfig = ''
      set number relativenumber
    '';
  };

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    delta = { enable = true; };
    userName  = "Kendrick Bollens";
    userEmail = "kendrick.bollens@gmail.com";
    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    #mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
    
    ]++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "nix-ide";
        publisher = "jnoortheen";
        version = "0.3.3";
        sha256 = "sha256-/vBbErwwecQhsqQwnw8ijooof8DPWt85symLQQtBC+Y=";
      }
      {
        name = "indented-block-highlighting";
        publisher = "byi8220";
        version = "1.0.7";
        sha256 = "sha256-BYQyENOsqJVPZ+VFwn0d3TyHljOZu9zIu5MX0K2CxRY=";
      }
      {
        name = "vscode-edit-csv";
        publisher = "janisdd";
        version = "0.9.2";
        sha256 = "sha256-F/YEMrRlkLdIOATq+u6ovdZt21MgVbYH1PAnpyncFqs=";
      }
      {
        name = "rust-analyzer";
        publisher = "rust-lang";
        version = "0.3.2062";
        sha256 = "sha256-S0RWodQwVPiXuYeXOvlCeDCoi4XGIAnc5JPTLARDIyc=";
      }
      {
        name = "vscode-neovim";
        publisher = "asvetliakov";
        version = "1.18.7";
        sha256 = "sha256-ltgygZBWLG79FNxKqloOm8NNSDBbXU2bNkmd+9ksuOg=";
      }
      {
        name = "vscode-icons";
        publisher = "vscode-icons-team";
        version = "12.8.0";
        sha256 = "sha256-2+Wf0AL9C5xOQCjA9maMt/W/kviNuiyMfaOFDU82KxM=";
      }
      {
        name = "micro-bit-python";
        publisher = "makinteract";
        version = "0.1.21";
        sha256 = "sha256-J+PEo+SXWD2R1ykvq6Q95lbXSzzjG5z3EQk3eAaXE/8=";
      }
    ];

    userSettings = {
    
      "files.autoSave" = "afterDelay";
      "[nix]"."editor.tabSize" = 2;
      "workbench.preferredDarkColorTheme"= "Solarized Dark";
      "workbench.preferredLightColorTheme"= "Solarized Light";
      "window.autoDetectColorScheme"= true;
      "workbench.colorTheme"= "Solarized Dark";
      "keyboard.dispatch"= "keyCode";
      "workbench.icontheme"= "vscode-icons";
      "git.enableCommitSigning"= true;
      "explorer.excludeGitIgnore"= true;
    };
  };
  programs.firefox = {
    enable = true;

    profiles.default= {
      id = 0;
      name = "default";
      isDefault = true;
      settings = {
        "browser.bookmarks.toolbar"= "always";
        "browser.startup.open-previous" = true;
        "signon.rememberSignons" = false;
      };
      
     search = {
           force = true;
           default = "Kagi";
        
           engines = {
        
             "Kagi" = {
               urls = [
                 {
                   template = "https://kagi.com/search?";
                   params = [
                     {
                       name = "q";
                       value = "{searchTerms}";
                     }
                   ];
                 }
               ];
             };
        }; 
     };

      bookmarks = [
          {
            name = "toolbar";
            toolbar = true;
            bookmarks = [
              {
                name = "generell";
                bookmarks = [];  # Empty folder used as a spacer
              }
              {
                name = "";  # Display icon only
                url = "https://calendar.proton.me/u/0/week/2024/9/5";
              }
              {
                name = "";  # Display icon only
                url = "https://calendar.google.com/calendar/u/0/r/settings/export";
              }
              {
                name = "";  # Display icon only
                url = "https://mail.proton.me/u/0/inbox";
              }
              {
                name = "";  # Display icon only
                url = "https://mail.google.com/";
              }
              {
                name = "";  # Display icon only
                url = "https://chatgpt.com/";
              }
              {
                name = "";  # Display icon only
                url = "https://trello.com/myx54968614/home";
              }
              {
                name = "";  # Display icon only
                url = "http://10.0.0.11/Docker/UpdateContainer?xmlTemplate=edit:/boot/config/plugins/dockerMan/templates-user/my-frigate.xml";
              }
              {
                name = "nix";
                bookmarks = [];  # Empty folder used as a spacer
              }
              {
                name = "";  # Display icon only
                url = "https://search.nixos.org/packages";
              }
              {
                name = "";  # Display icon only
                url = "https://home-manager-options.extranix.com/";
              }
              {
                name = "Entertain";
                bookmarks = [];  # Empty folder used as a spacer
              }
              {
                name = "";  # Display icon only
                url = "https://www.youtube.com/";
              }
              {
                name = "";  # Display icon only
                url = "http://10.0.0.11:32400/web/index.html#!/";
              }
              {
                name = "";  # Display icon only
                url = "https://www.netflix.com/browse";
              }
              {
                name = "Shopping";
                bookmarks = [];  # Empty folder used as a spacer
              }
              {
                name = "";  # Display icon only
                url = "https://www.amazon.de/";
              }
              {
                name = "";  # Display icon only
                url = "https://www.ebay.de/";
              }
              {
                name = "";  # Display icon only
                url = "https://www.testberichte.de/eingabegeraete/299/maeuse/gaming-maeuse.html";
              }
              {
                name = "";  # Display icon only
                url = "https://www.mydealz.de/";
              }
              {
                name = "";  # Display icon only
                url = "https://www.humblebundle.com/";
              }
              {
                name = "3DP";
                bookmarks = [];  # Empty folder used as a spacer
              }
              {
                name = "";  # Display icon only
                url = "https://ellis3dp.com/Print-Tuning-Guide/";
              }
              {
                name = "";  # Display icon only
                url = "https://www.printables.com/";
              }
              {
                name = "";  # Display icon only
                url = "https://thangs.com/";
              }
              {
                name = "";  # Display icon only
                url = "https://www.thingiverse.com/";
              }
              {
                name = "";  # Display icon only
                url = "https://makerworld.com/en/3d-models";
              }
              {
                name = "Learning";
                bookmarks = [];  # Empty folder used as a spacer
              }
              {
                name = "";  # Display icon only
                url = "https://coaching.healthygamer.gg/guide/index";
              }
              {
                name = "";  # Display icon only
                url = "https://www.keybr.com/";
              }
              {
                name = "";  # Display icon only
                url = "https://www.typingclub.com/sportal/program-181.game";
              }
              {
                name = "";  # Display icon only
                url = "https://vim-adventures.com/";
              }
              {
                name = "";  # Display icon only
                url = "https://spacetraders.io/";
              }
              {
                name = "";  # Display icon only
                url = "https://adventofcode.com/";
              }
              {
                name = "Arbeit";
                bookmarks = [];  # Empty folder used as a spacer
              }
              {
                name = "";  # Display icon only
                url = "https://campus.srh-hochschule-berlin.de/";
              }
              {
                name = "";  # Display icon only
                url = "https://classroom.google.com/";
              }
              {
                name = "";  # Display icon only
                url = "https://outlook.office.com/mail/?actSwt=true";
              }
              {
                name = "";  # Display icon only
                url = "https://teams.microsoft.com/v2/";
              }
              {
                name = "";  # Display icon only
                url = "https://www.japanese-like-a-breeze.com/guide-for-beginners/";
              }
            ];
          }
        ];
       
       

       
    };
  };

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

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

  dconf = { # use "dconf watch /" for checkin what changes when toggling settings in gnome
    enable = true;
    settings = {

        # enable dark mode by default
      #"org/gnome/desktop/interface".color-scheme = "prefer-dark";
      
      # Add the touchpad click method setting
      "org/gnome/desktop/peripherals/touchpad".click-method = "areas" ;
      
      # add eurokey and make it the keyboardlayout
      "org/gnome/desktop/input-sources" = {
      show-all-sources = true;
      sources = [ ( lib.hm.gvariant.mkTuple [ "xkb" "eu" ]) ( lib.hm.gvariant.mkTuple [ "xkb" "us+altgr-intl" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" "caps:escape"];
      }; 

      # enable these extensions
      "org/gnome/shell".enabled-extensions = [
        "burn-my-windows@schneegans.github.com" 
        "caffeine@patapon.info"
        "clipboard-history@alexsaveau.dev"
        "CoverflowAltTab@palatis.blogspot.com"
        "gsconnect@andyholmes.github.io"
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com"
        "Vitals@CoreCoding.com"
        "drive-menu@gnome-shell-extensions.gcampax.github.com"
        "places-menu@gnome-shell-extensions.gcampax.github.com"
        "native-window-placement@gnome-shell-extensions.gcampax.github.com"
        "grand-theft-focus@zalckos.github.com"
        "ddterm@amezin.github.com"
        "pano@elhan.io"
        "apps-menu@gnome-shell-extensions.gcampax.github.com"
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "quick-settings-tweaks@qwreey"
        "blur-my-shell@aunetx"
        "clipboard-indicator@tudmotu.com"
      ];
      
      # disabling the blur applications feature for blur my shell because it sometimes hides the window on the external monitor
      "org/gnome/shell/extensions/blur-my-shell/applications".blur = false; 

      #ddterm settings
      "com/github/amezin/ddterm".hide-when-focus-lost = true;
      "com/github/amezin/ddterm".hide-window-on-esc = true;
      "com/github/amezin/ddterm".foreground-color = "rgb(51,209,122)";

      #make pano the super v key or clippboard indicator
      "org/gnome/shell/keybindings".toggle-message-tray =["<Super>z"];
      "org/gnome/shell/extensions/pano".global-shortcut = ["<Super>v"];
      "org/gnome/shell/extensions/clipboard-indicator".toggle-menu = ["<Super>v"];



      # disable panos anoying notfication
      "org/gnome/shell/extensions/pano".send-notification-on-copy = false;

      
      "org/gnome/shell/extensions/burn-my-windows".active-profile = "/home/kenny/.config/burn-my-windows/profiles/custom.conf";
    };
  };



  # Home Manager can also manage your environment variables through
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  home.activation.rmOldVsCodiumSettings = {
    after = [];
    before = [ "checkLinkTargets" ];
    data = ''
      userDir=${config.home.homeDirectory}/.config/VSCodium/User
      rm -rf $userDir/settings.json
    '';
  };

  home.activation.setVsCodiumSettings = {
    after = [ "writeBoundary" ];
    before = [];
    data = ''
      userDir=${config.home.homeDirectory}/.config/VSCodium/User
      rm -rf $userDir/settings.json
      cat \
        ${(pkgs.formats.json {}).generate "blabla"
          config.programs.vscode.userSettings} \
        > $userDir/settings.json
    '';
  };


  home.activation.addBurnMywindowsProfile = {
    after = [ "writeBoundary" ];
    before = [];
    data = ''
      userDir=${config.home.homeDirectory}/.config/burn-my-windows/profiles
      rm -rf $userDir/custom.conf
      cat <<EOF >  $userDir/custom.conf
      [burn-my-windows-profile]
      fire-enable-effect=false
      tv-glitch-enable-effect=true
      profile-animation-type=0 
      EOF
    '';
  };

  


}
