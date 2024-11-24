# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

   networking.hostName = "T4e"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
   networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
   time.timeZone = "Asia/Ho_Chi_Minh";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

   fonts.packages = with pkgs; [
     noto-fonts
     noto-fonts-emoji
     liberation_ttf
     fira-code
     fira-code-symbols
     mplus-outline-fonts.githubRelease
     dina-font
     proggyfonts
     (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
   ];

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  #console = {
  #   font = "fira-code";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };


  # Enable the X11 windowing system.
   services.xserver = { 
   enable = true;
   videoDrivers = ["nvidia"];
   };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  programs.uwsm.enable = true;
  programs.uwsm.waylandCompositors.hyprland = {
      prettyName = "Hyprland";
      comment = "Hyprland compositor managed by UWSM";
      binPath = "/run/current-system/sw/bin/Hyprland";
    };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound
   security.rtkit.enable = true;
   services.pipewire = {
     enable = true;
     wireplumber.enable = true;
     pulse.enable = true;
     alsa.enable = true;
     jack.enable = true;
     alsa.support32Bit = true;
   };

   programs.appimage = {
     enable = true;
     binfmt = true;
   };
  # Enable touchpad support (enabled default in most desktopManager).
   services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.surpur = {
     isNormalUser = true;
     extraGroups = [ "wheel" "input" "networkmanager" "libvirt" "libvirt-qemu"]; 
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     neovim
     kitty
     waybar
     dunst
     libnotify
     rofi-wayland
     hyprpicker
     hyprcursor
     hyprlock
     hyprpaper
     vlc
     mpv
     firefox
     firefoxpwa
     hyprpolkitagent
     libvirt
     nodejs_18
     blueberry
     neofetch
     htop
     ranger
     tealdeer
     telegram-desktop
     keepassxc
     vesktop
     clipse
     tmux
     unzip
     kiwix
     freetube
     thunderbird 
     psmisc
     bash-completion
     blesh
     zsh
     libreoffice
     qemu
     wl-clipboard
     wget
     wireplumber
     networkmanagerapplet
     git
     pavucontrol
     gamemode
     mangohud
     birdtray
     yt-dlp
     ghidra
     thc-hydra
     nmap
     wireshark
     tshark
     metasploit
     lynis
     wpscan
     sqlmap
     tor
     tcpdump
     python3Full
     jdk8
     jdk17
     jdk21
     virt-manager
   ];

   programs.virt-manager.enable = true;
   virtualisation.libvirtd = {
     enable = true;
     qemu.ovmf.enable = true;
     qemu.runAsRoot = false;
     onBoot = "ignore";
   };

   services.displayManager.autoLogin.enable = true;
   services.displayManager.autoLogin.user = "surpur";

   services.displayManager.defaultSession = "hyprland-uwsm";
   services.displayManager.sddm = {
     enable = true;
     wayland.enable = true;
   };

   nixpkgs.config.allowUnfree = true;

   hardware = { 
     opengl.enable = true;
     bluetooth.enable = true;
   };

   hardware.nvidia = {
     modesetting.enable = true;
     open = false;
     powerManagement.enable = true;
     dynamicBoost.enable = lib.mkForce true;
     nvidiaSettings = true;
   };

   programs.hyprland = {
     enable = true;
     xwayland.enable = true;
   };

   security.polkit.enable = true;
   programs.nm-applet.enable = true;

   environment.sessionVariables = {
     NIXOS_OZONE_WL = "1";
     WLR_NO_HARDWARE_CURSORS = "1";
   };
   

   services.create_ap = {
     enable = true;
     settings = {
       INTERNET_IFACE = "enp3s0";
       WIFI_IFACE = "wlp4s0";
       SSID = "KittyPhan 2nd floor";
       PASSPHRASE = "kitty12112014";
     };
   };

   qt = {
     enable = true;
     platformTheme = "gnome";
     style = "adwaita-dark";
   };

#   system.autoUpgrade = {
#   enable = true;
#   channel = "https://nixos.org/channels/nixos-24.05";
#  };

   nix.settings.auto-optimise-store = true;
   nix.optimise.automatic = true;
   nix.gc = {
     automatic = true;
     dates = "weekly";
     options = "--delete-older-than 14d";
   };

   services.hypridle.enable = true;

   services.devmon.enable = true;
   services.gvfs.enable = true; 
   services.udisks2.enable = true;

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
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}

