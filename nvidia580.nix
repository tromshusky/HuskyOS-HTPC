{ config, lib, ... }:{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "nvidia-x11" "nvidia-settings" "nvidia-kernel-modules" ];
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  hardware.nvidia.open = false;
  hardware.nvidia.powerManagement.enable = false; # workaround: otherwise black screen on resume sleep
}
