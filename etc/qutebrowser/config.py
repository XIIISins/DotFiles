#!/usr/bin/env python3
from qutebrowser.config.configfiles import ConfigAPI
from qutebrowser.config.config import ConfigContainer
from os.path import expanduser

import subprocess
import yaml

c = c
config = config
home = expanduser("~")


def read_xresources(prefix):
    props = {}
    x = subprocess.run(['xrdb', '-query'], stdout=subprocess.PIPE)
    lines = x.stdout.decode().split('\n')
    for line in filter(lambda l: l.startswith(prefix), lines):
        prop, _, value = line.partition(':\t')
        props[prop] = value
    return props

xresources = read_xresources('*')
border_width = subprocess.getoutput("bspc config border_width")

config.load_autoconfig()

# Behaviour
c.auto_save.session = True
c.backend = 'webengine'
c.downloads.location.directory = home + '/tmp/'
c.downloads.remove_finished = 5000
c.downloads.location.prompt = False
c.scrolling.bar = False
c.scrolling.smooth = True
c.tabs.background = True
c.input.insert_mode.auto_load = True
c.input.insert_mode.auto_leave = True
c.messages.timeout = 6000


c.url.default_page = 'https://xiiisins.info/homepage'
c.url.start_pages = c.url.default_page
c.url.searchengines["DEFAULT"] = "https://google.com/search?q={}"

# FONTS
c.fonts.monospace = ('"spectrum berry", "xos4 Terminus", Terminus, Monospace, '
                     '"DejaVu Sans Mono", Monaco, "Bitstream Vera Sans Mono", '
                     '"Andale Mono", "Courier New", Courier, '
                     '"Liberation Mono", monospace, Fixed, Consolas, Terminal')
c.fonts.prompts = '10pt monospace'
c.fonts.web.family.cursive = 'monospace'
c.fonts.web.family.fantasy = c.fonts.web.family.cursive
c.fonts.web.family.fixed = c.fonts.web.family.cursive
c.fonts.web.family.sans_serif = c.fonts.web.family.cursive
c.fonts.web.family.serif = c.fonts.web.family.cursive
c.fonts.web.family.standard = c.fonts.web.family.cursive
c.fonts.web.size.default = 11

# COLORS
# Statusbar
c.colors.statusbar.normal.bg = xresources['*.color0']
c.colors.statusbar.command.bg = xresources['*.color0']
# Statusbar messages
c.colors.messages.error.bg = xresources['*.color1']
c.colors.messages.warning.bg = xresources['*.color3']
c.colors.messages.info.bg = xresources['*.color8']
# Tabs
c.colors.tabs.bar.bg = xresources['*.color0']
c.colors.tabs.even.bg = xresources['*.color0']
c.colors.tabs.odd.bg = xresources['*.color8']
c.colors.tabs.selected.odd.bg = xresources['*.foreground']
c.colors.tabs.selected.even.bg = xresources['*.foreground']
# Misc
c.colors.webpage.bg = '#ffffff'
c.colors.prompts.border = xresources['*.color12']
c.colors.prompts.bg = xresources['*.color0']

# BINDINGS
# Youtube MPV
config.bind('m', 'spawn /home/ghost/bin/umpv {url}')
config.bind('M', 'hint links spawn /home/ghost/bin/umpv {hint-url}')
config.bind(';M', 'hint --rapid links spawn /home/ghost/bin/umpv {hint-url}')
