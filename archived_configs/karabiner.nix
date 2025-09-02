# karabiner-config.nix
{ lib, pkgs, ... }:

let
  generateSubLayerVar = key: "hyper_sublayer_${key}";

  createHyperSubLayer = sublayer_key: commands: otherSubLayerVars:
    let
      thisVar   = generateSubLayerVar sublayer_key;
      cmdNames  = lib.attrNames commands;
      otherVars = lib.filter (v: v != thisVar) otherSubLayerVars;
    in
    [
      {
        description     = "Toggle Hyper sublayer ${sublayer_key}";
        type            = "basic";
        from            = { key_code = sublayer_key; modifiers = { optional = [ "any" ]; }; };
        to              = [ { set_variable = { name = thisVar; value = 1; }; } ];
        to_after_key_up = [ { set_variable = { name = thisVar; value = 0; }; } ];
        conditions      =
          [ { type = "variable_if"; name = "hyper"; value = 1; } ]
          ++ (lib.map (v: { type = "variable_if"; name = v; value = 0; }) otherVars);
      }
    ]
  # Commands inside sublayer
  ++ ( lib.concatMap (k:
        let cmd = commands.${k};
        in if cmd ? to then
          [
            {
              description = cmd.description or "Hyper ${sublayer_key}+${k}";
              type        = "basic";
              from        = { key_code = k; modifiers = { optional = [ "any" ]; }; };
              to          = cmd.to;
              conditions  = [ { type = "variable_if"; name = thisVar; value = 1; } ];
            }
          ]
        else
          # рекурсивный вызов, если внутри ещё сабслойка
          (createHyperSubLayer k cmd otherSubLayerVars)
     ) cmdNames
  );

  # Function to create all sublayers and simple rules
  createHyperSubLayers = subLayers:
    let
      layerKeys = lib.attrNames subLayers;
      # Only create sublayer variables for actual sublayers (not simple key mappings)
      actualSubLayers = lib.filter (k: !(subLayers.${k} ? to)) layerKeys;
      allVars   = lib.map (k: generateSubLayerVar k) actualSubLayers;
    in
    lib.concatMap (k:
      let
        val       = subLayers.${k};
        thisVar   = generateSubLayerVar k;
        otherVars = lib.filter (v: v != thisVar) allVars;
      in
      if val ? to then
        [
          {
            description  = "Hyper Key with ${k}";
            manipulators = [
              {
                description = "Hyper Key with ${k}";
                type        = "basic";
                from        = { key_code = k; modifiers = { optional = [ "any" ]; }; };
                to          = val.to;
                conditions  =
                  [ { type = "variable_if"; name = "hyper"; value = 1; } ]
                  ++ (lib.map (v: { type = "variable_if"; name = v; value = 0; }) otherVars);
              }
            ];
          }
        ]
      else
        [
          {
            description  = "Hyper Key sublayer ${k}";
            manipulators = createHyperSubLayer k val allVars;
          }
        ]
    ) layerKeys;
  
  # Define all sublayers based on your existing configuration
  subLayers = {
    
    

    # Browser Shortcuts
    b = {
      r = { to = [ { shell_command = "open https://reddit.com"; } ]; description = "Open Reddit"; };
      l = { to = [ { shell_command = "open https://lsj.gr"; } ]; description = "Open LSJ"; };
      e = { to = [ { shell_command = "open https://emacsdocs.org"; } ]; description = "Open Emacs Docs"; };
    };
    
    # Application Shortcuts
    o = {
      a = { to = [ { shell_command = "open -a 'Anki.app'"; } ]; description = "Open Anki"; };
      w = { to = [ { shell_command = "open -a 'Warp.app'"; } ]; description = "Open Warp"; };
      c = { to = [ { shell_command = "open -a 'ChatGPT.app'"; } ]; description = "Open ChatGPT"; };
      g = { to = [ { shell_command = "open -a 'Ghostty.app'"; } ]; description = "Open Ghostty"; };
      f = { to = [ { shell_command = "open -a 'Finder.app'"; } ]; description = "Open Finder"; };
      b = { to = [ { shell_command = "open -a 'Books.app'"; } ]; description = "Open Obsidian"; };
      s = { to = [ { shell_command = "open -a 'Safari.app'"; } ]; description = "Open Safari"; };
      t = { to = [ { shell_command = "open -a 'AyuGram.app'"; } ]; description = "Open AyuGram"; };
      z = { to = [ { shell_command = "open -a 'Zen.app'"; } ]; description = "Open Zen Browser"; };
      e = { to = [ { shell_command = "open raycast://script-commands/emacsclient"; } ]; description = "Open Emacs"; };
    };

    
    # Raycast/Bluetooth Shortcuts
    r = {
      "1" = { to = [ { shell_command = "open raycast://extensions/VladCuciureanu/toothpick/connect-favorite-device-1"; } ]; description = "Connect Bluetooth Device 1"; };
      "2" = { to = [ { shell_command = "open raycast://extensions/VladCuciureanu/toothpick/connect-favorite-device-2"; } ]; description = "Connect Bluetooth Device 2"; };
      h = { to = [ { shell_command = "open raycast://extensions/raycast/clipboard-history/clipboard-history"; } ]; description = "Clipboard History"; };
      t = { to = [ { shell_command = "open raycast://extensions/gebeto/translate/quick-translate"; } ]; description = "Translate"; };
    };
    
  };
  
  
  # GACS Home Row Modifiers Configuration
  homeRowModRules = [
    # Left hand modifiers (GACS: GUI, Alt, Control, Shift)
    {
      description = "Home Row Modifiers - Left Hand";
      manipulators = [
        # A -> GUI (Command) - only when hyper key is not active
        {
          description = "A key -> GUI (Left Command)";
          type = "basic";
          from = { key_code = "a"; modifiers = { optional = [ "any" ]; }; };
          to = [ { key_code = "left_command"; } ];
          to_if_alone = [ { key_code = "a"; } ];
          conditions = [ { type = "variable_if"; name = "hyper"; value = 0; } ];
          parameters = {
            basic.to_if_alone_timeout_milliseconds = 200;
            basic.to_delayed_action_delay_milliseconds = 0;
          };
        }
        # S -> Alt (Option) - only when hyper key is not active
        {
          description = "S key -> Alt (Left Option)";
          type = "basic";
          from = { key_code = "s"; modifiers = { optional = [ "any" ]; }; };
          to = [ { key_code = "left_option"; } ];
          to_if_alone = [ { key_code = "s"; } ];
          conditions = [ { type = "variable_if"; name = "hyper"; value = 0; } ];
          parameters = {
            basic.to_if_alone_timeout_milliseconds = 200;
            basic.to_delayed_action_delay_milliseconds = 0;
          };
        }
        # D -> Control - only when hyper key is not active  
        {
          description = "D key -> Control (Left Control)";
          type = "basic";
          from = { key_code = "d"; modifiers = { optional = [ "any" ]; }; };
          to = [ { key_code = "left_control"; } ];
          to_if_alone = [ { key_code = "d"; } ];
          conditions = [ { type = "variable_if"; name = "hyper"; value = 0; } ];
          parameters = {
            basic.to_if_alone_timeout_milliseconds = 200;
            basic.to_delayed_action_delay_milliseconds = 0;
          };
        }
        # F -> Shift - only when hyper key is not active
        {
          description = "F key -> Shift (Left Shift)";
          type = "basic";
          from = { key_code = "f"; modifiers = { optional = [ "any" ]; }; };
          to = [ { key_code = "left_shift"; } ];
          to_if_alone = [ { key_code = "f"; } ];
          conditions = [ { type = "variable_if"; name = "hyper"; value = 0; } ];
          parameters = {
            basic.to_if_alone_timeout_milliseconds = 200;
            basic.to_delayed_action_delay_milliseconds = 0;
          };
        }
      ];
    }
    # Right hand modifiers (mirror GACS)
    {
      description = "Home Row Modifiers - Right Hand";
      manipulators = [
        # J -> Shift - only when hyper key is not active
        {
          description = "J key -> Shift (Right Shift)";
          type = "basic";
          from = { key_code = "j"; modifiers = { optional = [ "any" ]; }; };
          to = [ { key_code = "right_shift"; } ];
          to_if_alone = [ { key_code = "j"; } ];
          conditions = [ { type = "variable_if"; name = "hyper"; value = 0; } ];
          parameters = {
            basic.to_if_alone_timeout_milliseconds = 200;
            basic.to_delayed_action_delay_milliseconds = 0;
          };
        }
        # K -> Control - only when hyper key is not active
        {
          description = "K key -> Control (Right Control)";
          type = "basic";
          from = { key_code = "k"; modifiers = { optional = [ "any" ]; }; };
          to = [ { key_code = "right_control"; } ];
          to_if_alone = [ { key_code = "k"; } ];
          conditions = [ { type = "variable_if"; name = "hyper"; value = 0; } ];
          parameters = {
            basic.to_if_alone_timeout_milliseconds = 200;
            basic.to_delayed_action_delay_milliseconds = 0;
          };
        }
        # L -> Alt (Option) - only when hyper key is not active
        {
          description = "L key -> Alt (Right Option)";
          type = "basic";
          from = { key_code = "l"; modifiers = { optional = [ "any" ]; }; };
          to = [ { key_code = "right_option"; } ];
          to_if_alone = [ { key_code = "l"; } ];
          conditions = [ { type = "variable_if"; name = "hyper"; value = 0; } ];
          parameters = {
            basic.to_if_alone_timeout_milliseconds = 200;
            basic.to_delayed_action_delay_milliseconds = 0;
          };
        }
        # Semicolon -> GUI (Command) - only when hyper key is not active
        {
          description = "Semicolon key -> GUI (Right Command)";
          type = "basic";
          from = { key_code = "semicolon"; modifiers = { optional = [ "any" ]; }; };
          to = [ { key_code = "right_command"; } ];
          to_if_alone = [ { key_code = "semicolon"; } ];
          conditions = [ { type = "variable_if"; name = "hyper"; value = 0; } ];
          parameters = {
            basic.to_if_alone_timeout_milliseconds = 200;
            basic.to_delayed_action_delay_milliseconds = 0;
          };
        }
      ];
    }
    # SPACE-layer for navigation
    {
      description = "Space layer for Vim-style navigation";
      manipulators = [
        {
          # Удержание Space активирует слой
          type = "basic";
          from = { key_code = "spacebar"; modifiers = { optional = [ "any" ]; }; };
          to = [{ set_variable = { name = "space_layer"; value = 1; }; }];
          to_after_key_up = [{ set_variable = { name = "space_layer"; value = 0; }; }];
          to_if_alone = [{ key_code = "spacebar"; }];
          parameters = {
            basic.to_if_alone_timeout_milliseconds = 200;
            basic.to_delayed_action_delay_milliseconds = 0;
          };
        }

        {
          # h -> ←
          type = "basic";
          from = { key_code = "h"; modifiers = { optional = [ "any" ]; }; };
          to = [{ key_code = "left_arrow"; }];
          conditions = [{ type = "variable_if"; name = "space_layer"; value = 1; }];
        }

        {
        # j -> ↓
          type = "basic";
          from = { key_code = "j"; modifiers = { optional = [ "any" ]; }; };
          to = [{ key_code = "down_arrow"; }];
          conditions = [{ type = "variable_if"; name = "space_layer"; value = 1; }];
        }

        {
          # k -> ↑
          type = "basic";
          from = { key_code = "k"; modifiers = { optional = [ "any" ]; }; };
          to = [{ key_code = "up_arrow"; }];
          conditions = [{ type = "variable_if"; name = "space_layer"; value = 1; }];
        }

        {
          # l -> →
          type = "basic";
          from = { key_code = "l"; modifiers = { optional = [ "any" ]; }; };
          to = [{ key_code = "right_arrow"; }];
          conditions = [{ type = "variable_if"; name = "space_layer"; value = 1; }];
        }
      ];
    }
  ];

  # Assemble all rules
  rules =
    # Akimbo cmd to F12 rule
    [
      {
        description  = "Akimbo CMD to F12";
        manipulators = [
          {
            type = "basic";
            from = {
              simultaneous = [
                { key_code = "left_command"; }
                { key_code = "right_command"; }
              ];
              simultaneous_options = {
                to_after_key_up = [
                  {
                    key_code = "f12";
                    modifiers = [ "fn" ];
                  }
                ];
              };
            };
            to = [ { key_code = "vk_none"; } ];
          }
        ];
      }
    ]
    
    
    # CapsLock as Hyper 
    ++ [
      {
        description  = "Hyper Key (Control Option Shift Command)";
        manipulators = [
          {
            description     = "Caps Lock to Hyper Key (non-Emacs)";
            type            = "basic";
            from            = { key_code = "caps_lock"; modifiers = { optional = [ "any" ]; }; };
            to = [
              { set_variable = { name = "hyper"; value = 1; }; }
            ];
            to_after_key_up = [
              { set_variable = { name = "hyper"; value = 0; }; }
            ];
            to_if_alone     = [ { key_code = "escape"; } ];
            # conditions      = [
            #   {
            #     type = "frontmost_application_unless";
            #     file_paths = [ "/emacs$" ];
            #   }
            # ];
          }
        ];
      }
    ]

    # CapsLock as Control in Emacs (tap = Esc; mark capslock_down)
    # ++ [
    #   {
    #     description  = "Caps Lock acts as Control in Emacs; tap = Esc";
    #     manipulators = [
    #       {
    #         type = "basic";
    #         from = { key_code = "caps_lock"; modifiers = { optional = [ "any" ]; }; };
    #         to = [
    #           # помечаем, что CapsLock зажат
    #           { set_variable = { name = "capslock_down"; value = 1; }; }
    #           # при удержании пусть ведёт себя как Control
    #           { key_code = "left_control"; }
    #         ];
    #         to_after_key_up = [
    #           { set_variable = { name = "capslock_down"; value = 0; }; }
    #         ];
    #         # одиночное нажатие = Esc
    #         to_if_alone = [ { key_code = "escape"; } ];
    #         conditions = [
    #           {
    #             type = "frontmost_application_if";
    #             file_paths = [ "/emacs$" ];
    #           }
    #         ];
    #       }
    #     ];
    #   }
    # ]

    # Emacs: исключение CapsLock+o -> открыть сабслойку Hyper 'o'
    # ++ [
    #   {
    #     description  = "Emacs: CapsLock+o opens Hyper sublayer 'o'";
    #     manipulators = [
    #       {
    #         type = "basic";
    #         from = {
    #           key_code  = "o";
    #           # Важно: в событии уже будет Control (т.к. CapsLock -> Control),
    #           # поэтому ловим Control как обязательный модификатор:
    #           modifiers = { mandatory = [ "left_control" ]; optional = [ "any" ]; };
    #         };
    #         # Включаем непосредственно переменную сабслойки 'o'
    #         to = [
    #           { set_variable = { name = generateSubLayerVar "o"; value = 1; }; }
    #         ];
    #         to_after_key_up = [
    #           { set_variable = { name = generateSubLayerVar "o"; value = 0; }; }
    #         ];
    #         # чтобы Emacs не печатал 'o', дополнительных key_code не даём (только set_variable)
    #         conditions = [
    #           # только в Emacs
    #           { type = "frontmost_application_if";
    #             file_paths = [ "/emacs$" ]; }
    #           # и только если Control пришёл именно от CapsLock (а не от настоящего Control)
    #           { type = "variable_if"; name = "capslock_down"; value = 1; }
    #         ];
    #       }
    #     ];
    #   }
    # ]
    # Emacs: исключение CapsLock+a -> открыть сабслойку Hyper 'a'
    # ++ [
    #     {
    #         description  = "Emacs: CapsLock+a opens Hyper sublayer 'a'";
    #         manipulators = [
    #             {
    #                 type = "basic";
    #                 from = {
    #                     key_code  = "a";
    #                     modifiers = { mandatory = [ "left_control" ]; optional = [ "any" ]; };
    #                 };
    #                 to   = [ { set_variable = { name = generateSubLayerVar "a"; value = 1; }; } ];
    #                 to_after_key_up = [
    #                   { set_variable = { name = generateSubLayerVar "a"; value = 0; }; }
    #                 ];
    #                 conditions = [
    #                     { type = "frontmost_application_if"; file_paths = [ "/emacs$" ]; }
    #                     { type = "variable_if"; name = "capslock_down"; value = 1; }
    #                 ];
    #             }
    #         ];
    #     }
    # ]
  
++ [
{
  description = "Remap Cmd+Tab to AeroSpace window back-and-forth";
  manipulators = [
    {
      type = "basic";
      from = {
        key_code = "tab";
        modifiers = { mandatory = [ "command" ]; optional = [ "any" ]; };
      };
      to = [
        {
          key_code = "tab";
          modifiers = [ "left_control" "left_command" ];
        }
      ];
    }
  ];
}
]

    # Add home row modifiers
    ++ homeRowModRules
    
    # Add all sublayer rules
    ++ createHyperSubLayers subLayers;

in
{
  global = { show_in_menu_bar = false; };
  profiles = [
    {
      name                  = "Default";
      complex_modifications = { rules = rules; };
    }
  ];
}

