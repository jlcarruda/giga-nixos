import os
# from libqtile.config import Match

mod = "mod4"
home = os.path.expanduser('~')

awesome_font = "Font Awesome 6 Pro" # Font for the icons
main_font = "Fira Code Medium" # Font in use for the entire system
font_size=17 
bar_size=30
layout_margin=10
single_layout_margin=10
layout_border_width=5
single_border_width=5
max_ratio=0.85
ratio=0.70

groups = []
group_names = ["Escape","1","2","3","4","5","6","7","8","9"]
group_layouts=["monadtall", "monadtall", "monadtall", "monadtall","monadtall", "monadtall", "monadtall","monadwide", "monadtall", "monadtall"]
group_matches=[["Alacritty"], ["Navigator"], ["Code"], ["slack"]]
# group_labels=["零","一","二","三","四","五","六","七","八","九"]
# group_labels=["󰏃","󰏃","󰏃","󰏃","󰏃","󰏃","󰏃","󰏃","󰏃","󰏃"]
group_labels=["","","","",]