{
  users.users.user.uid = 1000;
  users.users.user.group = "users";
  users.users.user.createHome = true;
  users.users.user.isNormalUser = true;
  users.users.user.password = "";
  users.users.user.extraGroups = [ "networkmanager" ];
  services.displayManager.autoLogin.user = "user";
}
