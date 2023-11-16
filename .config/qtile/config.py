import os
import json
from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

import scripts.autostart
from scripts.keybindings import keys, mouse
from scripts.utils import get_net_dev

# from qtile_extras import widget as extraWidgets

mod = "mod4"
home = os.path.expanduser('~')

# groups = [Group(i) for i in "123456789"]
groups = []
group_names = ["Escape","1","2","3","4","5","6","7","8","9"]
group_layouts=["monadtall", "monadtall", "monadtall", "monadtall","monadtall", "monadtall", "monadtall","monadwide", "monadtall", "monadtall"]
group_labels=["零","一","二","三","四","五","六","七","八","九"]
# group_labels=["SHELL","WWW","CODE","三","四","五","六","七","八","九"]

main_font = "Fira Code Medium" # Font in use for the entire system
awesome_font = "Font Awesome 6 Pro" # Font for the icons
font_size=17 
bar_size=30

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        )
    )

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

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

layouts = [
    layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
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
                widget.Sep(
                    padding=5
                ),
                widget.GroupBox(
                    font=awesome_font,
                    borderwidth=1
                ),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),

                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                widget.Net(interface=wifi),
                widget.CurrentLayoutIcon(),
                widget.CurrentLayout(),
                widget.Systray(),
                widget.KeyboardLayout(),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                widget.QuickExit(),
            ],
            24,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
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

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = True
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
dpi_scale = 1.0

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

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
