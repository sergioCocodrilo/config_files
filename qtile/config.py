
from typing import List  # noqa: F401

from libqtile import bar, layout, widget, extension
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
terminal = guess_terminal()

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Key([mod], "r", lazy.spawncmd(),
        # desc="Spawn a command using a prompt widget"),


    ############################################################
    # Sergio's key bindings
    Key([mod], "f", lazy.spawn('firefox'), desc='run Firefox'),
    Key([mod], "b", lazy.hide_show_bar(), desc="Toggle bar"),
    Key(['mod4'], 'r', lazy.run_extension(extension.DmenuRun(
        dmenu_prompt=">",
        dmenu_font="Fira Code",
        background="#002b36",
        foreground="#fdf6e3",
        selected_background="#000000",
        selected_foreground="#859900",
        dmenu_height=34,  # Only supported by some dmenu forks
    ))),
]

############################################################
# Workspaces labels
workspaces = [
    {'name': 'WWW', 'key': '1'},
    {'name': 'DEV', 'key': '2'},
    {'name': '3', 'key': '3'},
    {'name': '4', 'key': '4'},
    {'name': '5', 'key': '5'},
    {'name': '6', 'key': '6'},
    {'name': '7', 'key': '7'},
    {'name': 'AUD', 'key': '8'},
    {'name': '9', 'key': '9'},
    ]


groups = []

for ws in workspaces:
    groups.append(Group(ws['name']))
    keys.append(
        Key(
            [mod],
            ws['key'],
            lazy.group[ws['name']].toscreen(),
            desc="Focus this desktop",
            ),
    )
    keys.append(
        Key(
            [mod, "shift"],
            ws["key"],
            lazy.window.togroup(ws["name"]),
            desc="Move focused window to another group",
        )
    )

############################################################

# groups = [Group(i) for i in "123456789"]

# for i in groups:
    # keys.extend([

        # Key([mod], i.name, lazy.group[i.name].toscreen(),
            # desc="Switch to group {}".format(i.name)),

        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            # desc="move focused window to group {}".format(i.name)),
    # ])

layouts = [

    layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),

    # layout.RatioTile(),
    # layout.Columns(border_focus_stack='#d75f5f'),
    # layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.MonadTall(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='Fira Code',
    fontsize=16,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                # widget.CurrentLayout(),
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        'launch': ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Net(),
                widget.Sep(),
                widget.Volume(fmt='Vol. {}'),
                widget.Sep(),
                widget.Battery(),
                widget.Sep(),
                widget.Systray(),
                widget.Sep(),
                widget.Clock(format='%A %B %d %H:%M'),
                widget.Sep(),
                # widget.QuickExit(),
            ],
            34,
            background='#002b36',
            # opacity=0.7,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
