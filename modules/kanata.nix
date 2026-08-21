{ config, lib, ... }:

let
  cfg = config.my.kanata;
in
{
  options.my.kanata = {
    enable = lib.mkEnableOption "Kanata keyboard remapping";

    devices = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Input devices Kanata should manage.";
    };

    config = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Kanata configuration.";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.kernelModules = [ "uinput" ];

    hardware.uinput.enable = true;

    services.udev.extraRules = ''
      KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    '';

    users.groups.uinput = {};

    systemd.services.kanata-internalKeyboard.serviceConfig.SupplementaryGroups = [
      "input"
      "uinput"
    ];

    services.kanata = {
      enable = true;

      keyboards.internalKeyboard = {
        devices = cfg.devices;
        config = cfg.config;
	extraDefCfg = "process-unmapped-keys yes";
      };
    };
  };
}

