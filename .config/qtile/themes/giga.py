def giga_theme_widgets():
  return  [
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
            widget.QuickExit(),
            widget.TextBox(
                foreground=color[1],
                background=transparent,
                padding=-1,
                fontsize=font_size+7,
                text="▓▒░",
            )
        ],