#!/usr/bin/env python3
import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, Gdk, GLib
import subprocess

CATEGORIES = {
    "NAV": [
        ("Marble Maps", "marble"),
        ("Viking GPS", "viking"),
        ("KStars", "kstars"),
        ("Stellarium", "stellarium"),
        ("QGIS", "qgis"),
        ("OpenCPN", "opencpn"),
        ("GPS Monitor", "kitty -e xgps"),
        ("GPS Babel", "kitty -e gpsbabel"),
        ("Routino", "kitty -e routino"),
    ],
    "COMMS": [
        ("Direwolf APRS", "kitty -e direwolf"),
        ("JS8Call", "js8call"),
        ("WSJTX", "wsjtx"),
        ("Mumble", "mumble"),
        ("GQRX SDR", "gqrx"),
        ("Signal", "kitty -e signal-cli"),
        ("Tor Browser", "bash -c 'MOZ_ENABLE_WAYLAND=1 torbrowser-launcher'"),
        ("Firefox", "firefox"),
    ],
    "SURVIVAL": [
        ("GoldenDict", "goldendict-ng"),
        ("Logseq Notes", "logseq"),
        ("Zim Notes", "zim"),
        ("LibreOffice", "libreoffice"),
        ("Okular Docs", "okular"),
        ("KeePassXC", "keepassxc"),
        ("VeraCrypt", "veracrypt"),
        ("Qalculate", "qalculate-gtk"),
        ("Unit Converter", "kitty -e units"),
        ("GnuPlot", "kitty -e gnuplot"),
        ("VLC Media", "vlc"),
    ],
    "INTEL": [
        ("Wireshark", "wireshark"),
        ("Nmap", "kitty -e nmap"),
        ("Aircrack-ng", "kitty -e aircrack-ng"),
        ("GIMP", "gimp"),
        ("GnuCash", "gnucash"),
        ("Grafana", "firefox http://localhost:3000"),
        ("VS Code", "code"),
    ],
    "TOOLS": [
        ("Ark Archiver", "ark"),
        ("Htop", "kitty -e htop"),
        ("Disk Usage", "kitty -e ncdu"),
        ("Rsync", "kitty -e rsync"),
        ("Sensors", "kitty -e watch sensors"),
        ("Power Top", "kitty -e sudo powertop"),
        ("i2c Detect", "kitty -e sudo i2cdetect -l"),
        ("Network Monitor", "kitty -e nmtui"),
        ("Vim Editor", "kitty -e vim"),
        ("TLP Status", "kitty -e sudo tlp-stat"),
        ("UFW Status", "kitty -e sudo ufw status verbose"),
    ],
    "SYS": [
        ("Terminal", "kitty"),
        ("Files", "nautilus"),
        ("Network", "nm-connection-editor"),
        ("Audio", "pavucontrol"),
        ("Settings", "gnome-control-center"),
        ("Tweaks", "gnome-tweaks"),
    ],
}

CSS = b"""
* {
    font-family: 'DejaVu Sans Mono';
}
window {
    background-color: #0A0A0A;
    border: 2px solid #FFD300;
}
#title {
    color: #FFD300;
    font-size: 24px;
    font-weight: bold;
    letter-spacing: 6px;
    padding: 16px;
    border-bottom: 2px solid #FFD300;
}
#subtitle {
    color: #888888;
    font-size: 11px;
    letter-spacing: 3px;
    padding-bottom: 12px;
}
.category-label {
    color: #FFD300;
    font-size: 13px;
    font-weight: bold;
    letter-spacing: 3px;
    padding: 12px 16px 4px 16px;
    border-bottom: 1px solid #1A1A1A;
}
.app-button {
    background-color: transparent;
    color: #AAAAAA;
    border: none;
    border-bottom: 1px solid #111111;
    padding: 8px 24px;
    font-size: 13px;
}
.app-button:hover {
    background-color: #1A1A1A;
    color: #FFD300;
    border-left: 3px solid #FFD300;
}
.app-button:focus {
    background-color: #1A1A1A;
    color: #FFD300;
    outline: none;
    border-left: 3px solid #FFD300;
}
scrolledwindow {
    background-color: #0A0A0A;
}
"""

class MissionMenu(Gtk.Window):
    def __init__(self):
        super().__init__(title="MISSION MENU")
        self.set_default_size(400, 600)
        self.set_position(Gtk.WindowPosition.CENTER)
        self.set_decorated(False)
        self.set_keep_above(True)

        style_provider = Gtk.CssProvider()
        style_provider.load_from_data(CSS)
        Gtk.StyleContext.add_provider_for_screen(
            Gdk.Screen.get_default(),
            style_provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        )

        self.connect("key-press-event", self.on_key_press)

        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        self.add(main_box)

        title = Gtk.Label(label="MILITECH OS")
        title.set_name("title")
        main_box.pack_start(title, False, False, 0)

        subtitle = Gtk.Label(label="MISSION CONTROL")
        subtitle.set_name("subtitle")
        main_box.pack_start(subtitle, False, False, 0)

        scroll = Gtk.ScrolledWindow()
        scroll.set_policy(Gtk.PolicyType.NEVER, Gtk.PolicyType.AUTOMATIC)
        main_box.pack_start(scroll, True, True, 0)

        content = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        scroll.add(content)

        for category, apps in CATEGORIES.items():
            cat_label = Gtk.Label(label=f"[ {category} ]")
            cat_label.set_name("category-label")
            cat_label.set_xalign(0)
            content.pack_start(cat_label, False, False, 0)

            for app_name, command in apps:
                btn = Gtk.Button(label=f"  {app_name}")
                btn.get_style_context().add_class("app-button")
                btn.set_relief(Gtk.ReliefStyle.NONE)
                btn_label = btn.get_child()
                if btn_label:
                    btn_label.set_xalign(0)
                if command:
                    btn.connect("clicked", self.launch_app, command)
                else:
                    btn.connect("clicked", self.not_installed, app_name)
                content.pack_start(btn, False, False, 0)

    def launch_app(self, widget, command):
        subprocess.Popen(command.split())
        self.destroy()

    def not_installed(self, widget, name):
        print(f"{name} not yet installed")
        self.destroy()

    def on_key_press(self, widget, event):
        if event.keyval == Gdk.KEY_Escape:
            self.destroy()

def main():
    win = MissionMenu()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()
