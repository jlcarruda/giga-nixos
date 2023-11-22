import os
import subprocess

from libqtile import qtile, hook
from scripts.variables import *

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen([home])

@hook.subscribe.client_new
def client_to_group(client):
    for group in groups:
        match = next((m for m in group.matches if m.compare(client)), None)
        if match:
            targetgroup = qtile.groups_map[group.name]
            targetgroup.toscreen(toggle=False)
            break
