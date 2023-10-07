# Original script made by https://github.com/Fluffy-Bean
# Adjusted for use of jlcarruda

# ----------------------------------------
#  Importing
# ----------------------------------------
#  Used to control windows and window
#  placement
from libqtile.command import lazy
from libqtile.config import EzKey, EzDrag, EzClick
import os

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
    EzKey("A-k", lazy.layout.up(), desc="Move focus up")
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

keys = [
    *windowFocus,
    *windowControl,
    *qtileControl,
    *scrcap,
    *launchers,
    *applicationSpawns
]