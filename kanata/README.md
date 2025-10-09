# Core

Elegant and powerful layout for 34 key keyboard

## Key Features & Design Principles

- Dual-language support: Seamless English and Russian layouts with custom configurations.
- Modular layout system: Easily rearrange, add, or create new layouts by copypasting and modifying existing ones.
- By making the layout adaptable, you can easily disable the config or switch to QWERTY/ЙЦУКЕН, making it easier to share your PC.
- Cross-platform compatibility: Expect consistent behavior across GNU Linux (with focus on KDE Plasma DE), Apple MacOS, and MS Windows 11.
- Ergonomic focus: Optimized for 34-key split keyboards, yet fully compatible with legacy row staggered keyboards.
- Intuitive layering: Dedicated Navigation, Symbol, and Numeric layers built around a comfortable 3x3 home block.
- Consistent symbol access: A unified symbol layer ensures the same symbols are in the same positions for both languages.
- Firmware flexibility: Simple enough for core functionality implementation with QMK or ZMK, yet powerful enough to surpass QMK Vial's capabilities, especially on seamless crossplatform behavior.
- Advanced Home Row Mods: Comprehensive home row modifiers with per-finger customization.

## Layers pictures and description

- Todo. Read [main.kbd](main.kbd) to have a brief understanding of layers available

## How to:

1. Install [Kanata](https://github.com/jtroo/kanata)
2. Clone the repo
3. Arrange your ergo split keyboard keys [as shown in defsrc](main.kbd#L2-L5)
4. Check and select your keyboard layouts in [main.kbd](main.kbd). Move row with `(include default-layouts.kbd)` up if you want to use system layouts (qwerty/йцукен) as default layouts. 
5. (Optional) set env variables to adjust language switching, check options in [lang-switching.kbd](lang-switching.kbd).
6. Run main.kbd config with kanata or enable the service and enjoy!
7. (Optional) you can still use it on legacy row staggered keyboard, using space and right alt as main thumb keys

## Example Systemd service

Create file:

```bash
sudo nano /etc/systemd/system/kanata.service
```

Ensure specifying path to your config folder:

```
[Unit]
Description=Kanata Keyboard Remapping Service
After=network.target

[Service]
Environment=LANG_MODE=SEPARATE
ExecStart=/usr/bin/kanata -c /home/user/Documents/Core/main.kbd
Restart=always
User=root

[Install]
WantedBy=multi-user.target
```

Enable and start:

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now kanata.service
```

View log real time:

```bash
journalctl -u kanata.service -f
```
