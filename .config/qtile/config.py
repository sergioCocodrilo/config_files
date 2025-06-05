# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
# terminal = guess_terminal()

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack",),
    # Key([mod], "Return", lazy.spawn('kitty'), desc="Launch terminal"),
    Key([mod], "Return", lazy.spawn('alacritty'), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window",),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod], "s", lazy.next_screen(), desc="Go to next screen"),
    Key([mod], "d", lazy.spawn("rofi -show run"), desc="Show Rofi"),
    Key([mod], "i", lazy.spawn("brave"), desc="Open Firefox"),
    Key(["mod1"], "k", lazy.widget["keyboardlayout"].next_keyboard(), desc='layout toggle'),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod1 + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + group number = switch to & move focused window to group
            # Key(
                # [mod, "shift"],
                # i.name,
                # lazy.window.togroup(i.name, switch_group=True),
                # desc="Switch to & move focused window to group {}".format(i.name),
            # ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + group number = move focused window to group
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
                desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.Bsp(),
    layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    layout.Stack(num_stacks=2),
    layout.Matrix(),
    layout.MonadTall(),
    layout.MonadWide(),
    layout.RatioTile(),
    layout.Tile(),
    layout.TreeTab(),
    layout.VerticalTile(),
    layout.Zoomy(),
]

widget_defaults = dict(
    font="sans",
    fontsize=18,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
				widget.Spacer(length=15, background='#282738',),
                widget.GroupBox(
                    font="JetBrains Mono Bold",
                    fontsize=20,
                    borderwidth=3,
                    highlight_method='block',
                    active='#887742',
                    block_highlight_text_color="#FFC300",
                    highlight_color='#4B427E',
                    inactive='#49463b',
                    foreground='#4B427E',
                    background='#282738',
                    this_current_screen_border='#282738',
                    this_screen_border='#282738',
                    other_current_screen_border='#282738',
                    other_screen_border='#282738',
                    urgent_border='#282738',
                    rounded=True,
                    disable_drag=True,
                 ),
                widget.Spacer( length=8, background='#282738',),
                widget.CurrentLayout(
                    background='#282738',
                    foreground='#CAA9E0',
                    fmt='{}',
                    font="JetBrains Mono Bold",
                    fontsize=18,
                ),
                widget.Spacer( length=8, background='#282738',),
                widget.WindowName(
                    background = '#282738',
                    format = "{name}",
                    font='JetBrains Mono Bold',
                    foreground='#CAA9E0',
                    empty_group_string = 'Desktop',
                    fontsize=13,

                ),
                widget.Spacer( length=8, background='#282738',),
                widget.TextBox("📶 ", name="spacer", background="#282738", foreground='#4B427E'),
                # widget.TextBox("⚡", name="spacer", background="#282738", foreground='#FFC300'),
                widget.NetGraph(interface="wlp7s0", background="#282738",),
                widget.Spacer( length=8, background='#282738',),
                widget.TextBox("∴", name="spacer", background="#282738", foreground='#FFC300'),
                widget.NetGraph(interface="enp8s0", background="#282738",),
                widget.TextBox("🔋", name="spacer", background="#282738", foreground='#4B427E'),
                widget.Battery(
                    font='JetBrains Mono Bold',
                    background='#282738',
                    foreground='#CAA9E0',
                    format='{percent:2.0%}',
                    fontsize=13,
                ),
                widget.Spacer( length=8, background='#282738',),
                widget.TextBox("🎵", name="spacer", background="#282738", foreground='#4B427E'),
                widget.PulseVolume(
                    font='Iosevka Nerd Font',
                    # emoji=True,
                    foreground='#CAA9E0',
                    emoji=False,
                    fontsize=13,
                    background='#282738',
                ),
                widget.Spacer( length=8, background='#282738',),
                widget.KeyboardLayout(
                    font='Iosevka Nerd Font',
                    foreground='#CAA9E0',
                    emoji=False,
                    fontsize=13,
                    background='#282738',
                    configured_keyboards=['us', 'es'],
                ),
                widget.Spacer( length=8, background='#282738',),
                widget.Spacer( length=18, background='#282738',),
                widget.Clock(
                    format='%d/%m %I:%M %p',
                    background='#282738',
                    foreground='#FFC300',
                    font="JetBrains Mono Bold",
                    fontsize=18,
                ),
                widget.Spacer( length=18, background='#282738',),
                widget.TextBox("~", name="spacer", background="#282738", foreground='#4B427E'),
                widget.Systray(),
                widget.TextBox("~", name="spacer", background="#282738", foreground='#4B427E'),
            ],
            30,
            border_color = '#282738',
            border_width = [0,0,0,0],
            # margin = [15,60,6,60],
        ),
    ),

    Screen(
        top=bar.Bar(
            [
				widget.Spacer(length=15, background='#282738',),
                widget.GroupBox(
                    font="JetBrains Mono Bold",
                    fontsize=20,
                    borderwidth=3,
                    highlight_method='block',
                    active='#887742',
                    block_highlight_text_color="#FFC300",
                    highlight_color='#4B427E',
                    inactive='#49463b',
                    foreground='#4B427E',
                    background='#282738',
                    this_current_screen_border='#282738',
                    this_screen_border='#282738',
                    other_current_screen_border='#282738',
                    other_screen_border='#282738',
                    urgent_border='#282738',
                    rounded=True,
                    disable_drag=True,
                 ),
                widget.Spacer( length=8, background='#282738',),
                widget.CurrentLayout(
                    background='#282738',
                    foreground='#CAA9E0',
                    fmt='{}',
                    font="JetBrains Mono Bold",
                    fontsize=18,
                ),
                widget.Spacer( length=8, background='#282738',),
                widget.WindowName(
                    background = '#282738',
                    format = "{name}",
                    font='JetBrains Mono Bold',
                    foreground='#CAA9E0',
                    empty_group_string = 'Desktop',
                    fontsize=13,

                ),
                widget.Spacer( length=8, background='#282738',),
                widget.TextBox("📶 ", name="spacer", background="#282738", foreground='#4B427E'),
                # widget.TextBox("⚡", name="spacer", background="#282738", foreground='#FFC300'),
                widget.NetGraph(interface="wlp7s0", background="#282738",),
                widget.Spacer( length=8, background='#282738',),
                widget.TextBox("∴", name="spacer", background="#282738", foreground='#FFC300'),
                widget.NetGraph(interface="enp8s0", background="#282738",),
                widget.TextBox("🔋", name="spacer", background="#282738", foreground='#4B427E'),
                widget.Battery(
                    font='JetBrains Mono Bold',
                    background='#282738',
                    foreground='#CAA9E0',
                    format='{percent:2.0%}',
                    fontsize=13,
                ),
                widget.Spacer( length=8, background='#282738',),
                widget.TextBox("🎵", name="spacer", background="#282738", foreground='#4B427E'),
                widget.PulseVolume(
                    font='Iosevka Nerd Font',
                    # emoji=True,
                    foreground='#CAA9E0',
                    emoji=False,
                    fontsize=13,
                    background='#282738',
                ),
                widget.Spacer( length=8, background='#282738',),
                widget.KeyboardLayout(
                    font='Iosevka Nerd Font',
                    foreground='#CAA9E0',
                    emoji=False,
                    fontsize=13,
                    background='#282738',
                    configured_keyboards=['us', 'es'],
                ),
                widget.Spacer( length=8, background='#282738',),
                widget.Spacer( length=18, background='#282738',),
                widget.Clock(
                    format='%d/%m %I:%M %p',
                    background='#282738',
                    foreground='#FFC300',
                    font="Iosevka Nerd Font",
                    fontsize=18,
                ),
                widget.Spacer( length=18, background='#282738',),
            ],
            30,
            border_color = '#282738',
            border_width = [0,0,0,0],
            # margin = [15,10,6,10],
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
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
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

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
