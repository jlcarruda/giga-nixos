# Original script made by https://github.com/Fluffy-Bean
# Adjusted for use of jlcarruda

# ----------------------------------------
#  Importing
# ----------------------------------------
#  Used to control windows and window
#  placement
import os
# from functions import screenshot
from libqtile.command import lazy
from libqtile.config import EzKey, EzDrag, EzClick

@lazy.window.function
def float_to_front(window):
    if window.floating:
        window.cmd_bring_to_front()


# ----------------------------------------
#  Default apps
# ----------------------------------------
#  I mostly use Rofi to launch apps so not
#  too important to me
TERMINAL = "alacritty"
SCREENSHOT = "flameshot gui"
LAUNCHER = "rofi -show drun\
    -theme-str '#window {\
        anchor: center; location: center;\
        y-offset: 0; x-offset: 0;\
    }'"
BROWSER = "firefox"


# ----------------------------------------
#  Modifier keys
# ----------------------------------------
#  Used to move and control window
#  placement within Qtile
EzKey.modifier_keys = {
    "M": "mod4",    # Windows
    "A": "mod1",    # Alt
    "S": "shift",   # Shift
    "C": "control", # Ctrl
}

# ----------------------------------------
#  Mouse
# ----------------------------------------
#  Controling floating windows with a
#  mouse
mouse = [
    EzDrag(
        "M-<Button1>",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    EzDrag(
        "M-<Button3>", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    EzClick("M-<Button2>", lazy.window.bring_to_front()),
]

# ------------------------------------------
#  Window Controls
# ------------------------------------------
windowFocus = [
    EzKey("A-h", lazy.layout.left(), desc="Move focus to left"),
    EzKey("A-l", lazy.layout.right(), desc="Move focus to right"),
    EzKey("A-j", lazy.layout.down(), desc="Move focus down"),
    EzKey("A-k", lazy.layout.up(), desc="Move focus up"),
    EzKey("A-g", lazy.window.toggle_fullscreen()),
    EzKey("A-S", lazy.window.toggle_floating()),
]

windowControl = [
    EzKey("M-w", lazy.window.kill())
]

# ------------------------------------------
#  Applications
# ------------------------------------------
applicationSpawns = [
    EzKey("A-<Return>", lazy.spawn(TERMINAL)),
    EzKey("A-b", lazy.spawn(BROWSER)),
]

# ------------------------------------------
#  Qtile
# ------------------------------------------``
qtileControl = [
    EzKey("M-S-r", lazy.restart()),
    EzKey("M-S-q", lazy.shutdown()),
]

# ------------------------------------------
#  Launchers
# ------------------------------------------``
launchers = [
    EzKey("A-<Space>", lazy.spawn(LAUNCHER)),
    EzKey("M-r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
]

scrcap = [
    EzKey("<Print>", lazy.spawn(SCREENSHOT)),
]

# Volume
volumeControls = [
    Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")), # Mute
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -q set Master 2%- && dunstify -a Volume ' '$(pamixer --get-volume-human) -h int:value:$(pamixer --get-volume)", shell=True)),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -q set Master 2%+ && dunstify -a Volume ' '$(pamixer --get-volume-human) -h int:value:$(pamixer --get-volume)", shell=True)), # Raise Volume
]

keys = [
    *windowFocus,
    *windowControl,
    *qtileControl,
    *scrcap,
    *launchers,
    *applicationSpawns,
    *volumeControls
]