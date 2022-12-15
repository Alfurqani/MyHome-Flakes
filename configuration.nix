# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader = {
  systemd-boot.enable = true;
  efi.canTouchEfiVariables = true;
  efi.efiSysMountPoint = "/boot/efi";
  timeout = 2;
  };

  ## NETWORKING ##
  networking =
  {
    hostName = "nixos";
    # hostName = "nixos"; # Define your hostname.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networkmanager =
    {
      enable = true;
      # dns = "dnsmasq";
      # enableStrongSwan = true;
    };

    ## WIREGUARD ##
    # wg-netmanager.enable = true;
    # wireguard =
    # {
    #   enable = true;
    #   interfaces = 
    #   {
    #     wg0 = {
    #       ips = [
    #         "192.168.20.4/24"
    #       ];
    #       peers = [
    #         {
    #           allowedIPs = [
    #             "192.168.20.1/32"
    #           ];
    #           endpoint = "demo.wireguard.io:12913";
    #           publicKey = "xTIBA5rboUvnH4htodjb6e697QjLERt1NAB4mZqp8Dg=";
    #         }
    #       ];
    #       privateKey = "yAnz5TF+lXXJte14tji3zlMNq+hd2rYUIgJBgB3fBmk=";
    #     };
    #   };
    # };

    # wg-quick.interfaces = 
    # {
    #   wg0 = {
    #     address = [
    #       "192.168.20.4/24"
    #     ];
    #     peers = [
    #       {
    #         allowedIPs = [
    #           "192.168.20.1/32"
    #         ];
    #         endpoint = "demo.wireguard.io:12913";
    #         publicKey = "xTIBA5rboUvnH4htodjb6e697QjLERt1NAB4mZqp8Dg=";
    #       }
    #     ];
    #     privateKey = "yAnz5TF+lXXJte14tji3zlMNq+hd2rYUIgJBgB3fBmk=";
    #   };
    # };

    # # RESOLVCONF 
    # useHostResolvConf = true;
    # resolvconf =
    # {
    #   enable = true;
    #   extraConfig = "libc=NO"; 
    #   useLocalResolver = true;
    # };
  };



  # Enable network manager applet
  programs.nm-applet.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = 
  {
    LC_ADDRESS = "id_ID.utf8";
    LC_IDENTIFICATION = "id_ID.utf8";
    LC_MEASUREMENT = "id_ID.utf8";
    LC_MONETARY = "id_ID.utf8";
    LC_NAME = "id_ID.utf8";
    LC_NUMERIC = "id_ID.utf8";
    LC_PAPER = "id_ID.utf8";
    LC_TELEPHONE = "id_ID.utf8";
    LC_TIME = "id_ID.utf8";
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable the MATE,PANTHEON,XFCE Desktop Environment.
  services.xserver = {
  enable = true;
  displayManager.lightdm.enable = false;
  desktopManager.pantheon.enable = false;

  ## CONFIGURE PANTHEON ##

  desktopManager.cinnamon.enable = false;
  desktopManager.mate.enable = false;
  desktopManager.xfce.enable = false;
  
  # GNOME
  displayManager.gdm.enable = true;
  desktopManager.gnome.enable = true;

  };

  # THIS USING XFCE DE AND I3 WINDOW MANAGER
  # services.xserver = {
  #   enable = true;   
  #   desktopManager = {
  #     default = "xfce";
  #     xterm.enable = false;
  #     xfce = {
  #       enable = true;
  #       noDesktop = true;
  #       enableXfwm = false;
  #     };
  #   };
  #   windowManager.i3.enable = true;
  # };
  
  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # systemWide = true;
    # wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  ### SERVICES ###
  services = 
  {
    # ## NEXTDNS ##
    # nextdns = 
    # {
    #   enable = true;
    #   # arguments = 
    #   # [ 
    #   #   "-config" 
    #   #     "149.112.112.112/20=quad9v4"
    #   # #   "108.162.192.0/18=abcdef"
    #   # #   "188.114.96.0/20=cfv4"
    #   # #   "2606:4700::/32=cfv6"
    #   # #   "2a06:98c0::/29=cfv6"
    #   # #   # "-cache-size" "10MB"
    #   # ];
    # };

    ## ADGUARDHOME ##
    adguardhome = 
    {
      enable = true;
      openFirewall = true;
      settings =
      {
        dns =
        {
          bind_host = 
            # "1.1.1.1";
            "173.245.48.0";
        
          bind_port = "20";

          # query logging
          querylog_enabled = true;
          querylog_file_enabled = true;
          querylog_interval = "24h";
          querylog_size_memory = 1000;   # entries
          anonymize_client_ip = true;   # for now

          # adguard
          protection_enable = true;
          blocking_mode = "default";
          filtering_enable = true;

          # cloudflare DNS
          cloudflare.dns =
          [
            "1.1.1.1"
            "1.0.0.1"
          ];

          # caching
          cache_size = 536870912;  # 512 MB
          cache_ttl_min = 1800;    # 30 min
          cache_optimistic = true; # return stale and then refresh
        };
      };
    };

    ## DNSCRYPT-PROXY2 ##
    dnscrypt-proxy2 =
    {
      enable = true;
      upstreamDefaults = true;
      settings = 
      {
        sources.public-resolvers = {
          urls = [ "https://download.dnscrypt.info/resolvers-list/v2/public-resolvers.md" ];
          cache_file = "public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
          refresh_delay = 72;
        };
      };
    };

    # ## TOR ##
    # tor =
    # {
    #   enable = true;
    #   client.dns.enable = true;
    #   openFirewall = true;
    # };

    # ## CLOUDFLARE-CFDYNDNS ##
    # cfdyndns = 
    # {
    #   enable = true;
    #   email = "syifa.alfurqoni@gmail.com";
    #   apikeyFile = "https://api.cloudflare.com/client/v4";
    # };

    # ## cloudflare, custom, google, opendns, quad9
    # https-dns-proxy = 
    # {
    # enable = true;
    # provider.kind = "quad9";
    # # provider.url = "94.140.14.14";
    # # provider.ips = [
    # # "188.114.96.0/20"
    # # "173.245.48.0/20"
    # # "190.93.240.0/20"
    # # ];
    # };

    # ## RESOLVED ##
    # resolved =
    #   {
    #     enable = true;
    #     fallbackDns = 
    #     [
    #       # cloudflare
    #       "1.1.1.1"
    #       "1.0.0.1"
    #       # # quad9
    #       # "9.9.9.9"
    #       # "149.112.112.112"
    #       # # opendns
    #       # "208.67.222.222"
    #       # "208.67.220.220"
    #       # # adguarddns
    #       # "94.140.14.14"
    #       # "94.140.15.15"
    #       # # comodo secure dns
    #       # "8.26.56.26"
    #       # "8.20.247.20"
    #     ];
    #     domains =
    #     [
    #       # "https://doh-jp.blahdns.com/dns-query"
    #       # "https://dns.adguard-dns.com/dns-query"
    #     ];
    #   };
  };


  ## USERS ##

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = 
  {
    users.alfurqani = 
    { isNormalUser = true;
      description = "4LEND";
      extraGroups = [ "networkmanager" "wheel" ];
    };
    # Default Shells
    defaultUserShell = pkgs.fish;
  };

  # packages = with pkgs; [
  # ];

  ### PROGRAMS CONFIGURATION ###

  virtualisation.docker =
  {
    enable = true;
  };
  programs.zsh =
  {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting = 
    {
      enable = true;
      highlighters = 
      [
        "main"
      ];
    };
    autosuggestions =
    {
      enable = true;
      async = true;
      strategy = 
      [
	"history"
	"completion"
        "match_prev_cmd"
      ];
      # extraConfig = 
      # {
      #   "bindkey '\t'" = "autosuggest-accept";
      # };
    };
    # ohMyZsh =
    # {
    #   enable = true;
    # };
  };
   
  programs.fish = 
  {
    enable = true;
    # shellInit	= fishConfig;
  }; 

  ## STARSHIP ##
  programs.starship = 
  {
    enable	= true;
    settings	= {
    add_newline = true;
    command_timeout = 1000;
    cmd_duration = {
      format = " [$duration]($style) ";
      style = "bold #EC7279";
      show_notifications = true;
    };
    nix_shell = {
      format = " [$symbol$state]($style) ";
    };
    battery = {
      full_symbol = "🔋 ";
      charging_symbol = "⚡️ ";
      discharging_symbol = "💀 ";
    };
    git_branch = {
      format = "[$symbol$branch]($style) ";
    };
    gcloud = {
      format = "[$symbol$active]($style) ";
    };
    };
  };

  ## ALACRITTY ##
  # programs.alacritty = {
  #   enable	= true;
  # };

  ## TMUX ##
  programs.tmux = {
    enable	= true;
    shortcut	= "a";
    terminal 	= "screen-256color";
    keyMode	= "vi";
    clock24 	= true;
    # extraConfig	= 
    # "
    #   set -g default-command /run/current-system/sw/bin/zsh
    # ";
    plugins 	= with pkgs.tmuxPlugins; [
      jump
      battery
      copycat
      vim-tmux-navigator
      prefix-highlight
      tmux-fzf
      yank
      cpu
      net-speed
      nord
      ];
  };

  ## NEOVIM ##
  programs.neovim = {
    enable	= true;
    viAlias	= true;
    vimAlias	= true;
    defaultEditor = true;
  };

  ## GIT ##
  programs.git = {
    enable = true;
    config = {
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;


  ### FONTS ### 
    fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      nerdfonts
      nerd-font-patcher
      comic-mono
      comic-neue
      comic-relief
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace	=  [ "ComicMono" ];
        sansSerif	=  [ "ComicMono" ];
        serif		=  [ "ComicMono" ];
	emoji		=  [ "Material-Design-Icons" ];
        # monospace	=  [ "ComicRelief" ];
        # sansSerif	=  [ "ComicRelief" ];
        # serif		=  [ "ComicRelief" ];
      };
    };
  };


  ### PACKAGES ###
  environment = 
  {
    shellAliases = 
    {
      l		= "exa -1 -g -l --icons -s type";
      la	= "exa -1 -g -l --icons -s type -a";
      lt	= "exa -1 -g -l --icons -s type -T";
      lat	= "exa -1 -g -l --icons -s type -a -T";
      du	= "${pkgs.du-dust}/bin/dust";

      nbs	= "sudo nixos-rebuild switch";
      nbb	= "sudo nixos-rebuild build";
      nbt	= "sudo nixos-rebuild test";
      conix	= "sudo nvim /etc/nixos/configuration.nix";
      nc	= "nix-channel";
      ncl	= "nix-channel --list"; 
      nca	= "nix-channel --add";
      ncu	= "nix-channel --update";
      hb	= "home-manager build";
      hs	= "home-manager switch";
      hg	= "home-manager generations";

      tls	= "tmux list-sessions";
      tkls	= "tmux kill-session -t";
      kat	= "pkill -f tmux";
      tks	= "tmux kill-server";
      
      g		= "git";
      gs	= "git status";
      ge	= "git clone";
      gcg	= "git config --global";
      gc	= "git config";
      gcl	= "git config --list";
      gcgl	= "git config --global --list";
      ga	= "git add";
      gal	= "git add -A";
      gcm	= "git commit -m";
      gam	= "git commit -a -m";
      gsi	= "git switch";
      gr 	= "git remote";
      gra	= "git remote add";
      grmv	= "git remote remove";
      grv	= "git remote -v";
      gbl	= "git branch --list";
      gp	= "git push -u";
      gl	= "git log";

      y		= "yt-dlp";
      yy	= "yt-dlp --extract-audio --audio-quality 0";
      c		= "cd";
      d		= "cd ..";
      v		= "vim";
      nv	= "nvim";
      t 	= "tmux";
      e		= "exit";
      lv	= "lvim";
      sp	= "speedtest-cli";
      py	= "python";
      py3	= "python3";
      b		= "bat";
      cl	= "clear";
      s		= "sudo su";
      sd	= "sudo";
      mkd	= "mkdir";
      cpr	= "cp -r";
      rm	= "rm";
      rmf 	= "rm -rf"; 
      a		= "aria2c";
      vf	= "vifm";
      ra	= "ranger";
      pc	= "protonvpn-cli";
      nq	= "notepadqq";
      bs	= "bash";

      ud	= "udisksctl";
      udm	= "udisksctl mount -b";
      udmd	= "udisksctl unmount -b";
    };

    systemPackages = with pkgs;
    [
      javaCup  dbus_java  maven  dotnet-sdk  dotnet-runtime  glib  lua  xdg-desktop-portal  xdg-desktop-portal-wlr  dbus  python310Packages.dbus-python  yarn  docker  python39Full  python310Full  electron  cargo  dbus
      
      # nodejs & npm
      nodejs  
      nodePackages.npm
      nodePackages_latest.npm
      node2nix

      cmatrix
      flatpak
      firewalld
      gnupg
      gparted
      input-remapper
      nix-index
      ntfs3g
      steam
      xorg.xkill

      # file manager
      pcmanfm
      libsForQt5.dolphin

      # cinnamon package
      cinnamon.nemo

      # image
      darktable
      shotwell
      nomacs
      inkscape

      # text editor, notes, office productivity
      vscode-with-extensions 
      geany
      wpsoffice
      notepadqq
      libreoffice
      onlyoffice-bin
      standardnotes
      simplenote
      okular

      # share
      opendrop

      # social
      discord
      # whatsapp-for-linux
      rPackages.telegram
      tdesktop
      mailspring
      rPackages.Rfacebook
      rPackages.facebookadsR
      caprine-bin
      gfbgraph
      rPackages.rfacebookstat
      mautrix-facebook
      purple-facebook
      libreddit
      headset
      lemmy-ui
      lemmy-server
      giara
      # haskellPackages.reddit
      rPackages.twitteR
      python310Packages.twitter
      turses

      franz
      cawbird

      # audio
      wireplumber
      easyeffects
      pipewire
      pipewire-media-session
      ffmpeg
      freac  boca

      # archiver
      archiver
      xarchiver
      fsarchiver
      unrar
      zip

      # network
      adguardhome
      tor
      dnscrypt-proxy2
      protonvpn-cli
      protonvpn-gui
      python310Packages.protonvpn-nm-lib

      # media player
      audacious
      mpv
      vlc
      cmus
      cava
      streamlink
      python310Packages.deemix
      python310Packages.deezer-py
      python310Packages.deezer-python
      nuclear
      spotify
      spotify-tui
      spotify-cli-linux
      downonspot
      sptlrx 

      # terminal
      alacritty
      kitty
      kitty-themes
      tmux
      terminal-typeracer
      vim
      page
      neovim-unwrapped
      nvimpager
      neovide
      uivonim
      bat
      duf
      ascii
      atool
      pfetch
      plank
      ranger
      vifm
      vifm-full
      trash-cli
      exa
      git
      speedtest-cli
      yank
      xsel
      wl-clipboard

      # browser
      firefox
      librewolf
      brave
      chromium
      tor-browser-bundle-bin
      google-chrome
      opera
      palemoon

      # downloader
      yt-dlp
      youtube-dl 
      ytmdl
      subdl
      aria
      python310Packages.aria2p
      uget
      uget-integrator
      wget
      qbittorrent

      # usb bootable
      woeusb
      woeusb-ng
      etcher
      ventoy-bin
      # ventoy-full-bin

      # xfce package
      xfce.ristretto
      xfce.thunar
      xfce.thunar-archive-plugin
      xfce.tumbler

      # shell
      fish
      zsh
      bashInteractive
      starship

      # configuration dotfiles
      home-manager
      rcm

      # terminal display system information
      btop
      htop
      neofetch
      checkip
      freshfetch
      ipfetch
      hyfetch
      pridefetch

      # virtual machine
      gnome.gnome-boxes
      vmware-workstation
      virtualbox
      qemu
      qemu_kvm
      qtemu
      virtualboxWithExtpack

      # an
      anime-downloader
      hakuneko
      ani-cli
      anup
      adl
      filebot
      # haskellPackages.myanimelist-export
    ];
  };


  # NIXPKGS CONFIG
  nixpkgs.config.permittedInsecurePackages = [
                "electron-12.2.3"  # etcher
		];

  nixpkgs.config = 
  {
  allowUnsupportedSystem = true;

  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
   services.flatpak.enable = true;
   xdg.portal.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  # system.stateVersion = "22.05"; # Did you read the comment?

  nix = 
  {
    sshServe = 
    {
      enable = true;
      keys = []; 
    };
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

}