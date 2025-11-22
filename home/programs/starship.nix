{
  enable = true;
  enableZshIntegration = true;
  settings = {
    battery = {
      full_symbol = "🔋 ";
      charging_symbol = "⚡️ ";
      discharging_symbol = "💀 ";
      display = [
        {
          threshold = 10;
          style = "bold red";
        }
        {
          threshold = 30;
          style = "bold yellow";
        }
      ];
    };

    character = {
      success_symbol = "[➜ ](bold green)";
      error_symbol = "[✗ ](bold red)";
    };

    directory = {
      truncation_length = 3;
      truncation_symbol = "…/";
    };

    lua = {
      symbol = "🌕 ";
    };

    sudo = {
      disabled = false;
    };
  };
}
