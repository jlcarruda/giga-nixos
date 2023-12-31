import os
import json
from libqtile import bar, layout, widget
from libqtile.config import Match, Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

import scripts.hooks
from scripts.variables import *
from scripts.keybindings import keys, mouse
from scripts.functions import get_net_dev

from qtile_extras import widget as extraWidgets
from qtile_extras.popup.toolkit import (PopupImage, PopupRelativeLayout,PopupText, PopupWidget)
from qtile_extras.widget.decorations import (BorderDecoration,PowerLineDecoration,RectDecoration)

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower() if i < len(group_layouts) else "monadtall",
            label=group_labels[i] if i < len(group_labels) else "󰏃",
            matches=[Match(wm_class=group_matches[i])] if i < len(group_matches) else []
        )
    )

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
        ]
    )

# TODO: Use Pywal to set colorscheme
with open(home + '/.config/qtile/colors.json') as wal_import:
  data = json.load(wal_import)
#   wallpaper = data['wallpaper']
  colors = data['colors']
  val_colors = list(colors.values())
  def getList(val_colors):
    return [*val_colors]
    
  def init_colors():
    return [*val_colors]

color = init_colors()
transparent=color[0] + "00"

## ============ LAYOUTS ================
def default_layout_theme():
    return {
        "font": main_font,
        "fontsize": font_size,
        "margin": layout_margin,
        "border_on_single": False,
        "border_width": layout_border_width,
        "border_normal": color[0],
        "border_focus": color[2],
        "single_margin": single_layout_margin,
        "single_border_width": single_border_width,
        "change_ratio": 0.01,
        "new_client_position":'bottom',
    }

default_layout_configs = default_layout_theme()

layouts = [
    layout.Columns(**default_layout_configs),
    layout.MonadTall(max_ratio=max_ratio, ratio=ratio, **default_layout_configs),
    layout.MonadWide(max_ratio=max_ratio, ratio=0.85, **default_layout_configs),
    layout.Matrix(**default_layout_configs)
]

widget_defaults = dict(
    font=main_font,
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

wifi = get_net_dev()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.TextBox(
                    foreground=color[1],
                    background=transparent,
                    padding=-1,
                    fontsize=font_size+7,
                    text="░▒▓",
                ),
                widget.CurrentLayoutIcon(),
                # widget.CurrentLayout(),
                widget.Spacer(
                    length=5,
                    background=transparent,
                ),
                widget.GroupBox(
                    font=awesome_font,
                    borderwidth=1
                ),
                widget.Prompt(),
                widget.Sep(
                    padding=5
                ),
                widget.TaskList(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Memory(),
                widget.Sep(
                    padding=5
                ),
                widget.Net(interface=wifi),
                widget.Systray(),
                widget.KeyboardLayout(),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                widget.Battery(),
                widget.QuickExit(),
                widget.TextBox(
                    foreground=color[1],
                    background=transparent,
                    padding=-1,
                    fontsize=font_size+7,
                    text="▓▒░",
                )
            ],
            24,
            border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]

# Drag floating layouts.
# mouse = [
#     Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
#     Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
#     Click([mod], "Button2", lazy.window.bring_to_front()),
# ]
floating_layout = layout.Floating(
    border_width=layout_border_width,
    border_normal=color[0],
    border_focus=color[2],
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = 'floating_only'
cursor_warp = True

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
dpi_scale = 1.0

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = False

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
