Vim�UnDo� ;�� ͧ�!����-~��^�&�ƹ7��~�d�   V   6c.url.searchengines["twitch"] = "https://twitch.tv/{}"   /                          Z�#�    _�                     .        ����                                                                                                                                                                                                                                                                                                                                                             Z�#�     �   .   0   U    �   .   /   U    5�_�                    /       ����                                                                                                                                                                                                                                                                                                                                                             Z�#�     �   .   0   V      6c.url.searchengines["twitch"] = "https://twitch.tv/{}"5�_�                    /   &    ����                                                                                                                                                                                                                                                                                                                                                             Z�#�     �   .   0   V      3c.url.searchengines["mal"] = "https://twitch.tv/{}"5�_�                    /   &    ����                                                                                                                                                                                                                                                                                                                                                             Z�#�     �   .   0   V      &c.url.searchengines["mal"] = "https://5�_�                    /   &    ����                                                                                                                                                                                                                                                                                                                                                             Z�#�     �   .   0   V      (c.url.searchengines["mal"] = "https://{}5�_�                    /   E    ����                                                                                                                                                                                                                                                                                                                                                             Z�#�     �   .   0   V      Ec.url.searchengines["mal"] = "https://myanimelist.net/search/all?q={}5�_�                     /   E    ����                                                                                                                                                                                                                                                                                                                                                             Z�#�    �   U   W          Mconfig.bind(';M', 'hint --rapid links spawn /home/ghost/bin/umpv {hint-url}')�   T   V          Dconfig.bind('M', 'hint links spawn /home/ghost/bin/umpv {hint-url}')�   S   U          4config.bind('m', 'spawn /home/ghost/bin/umpv {url}')�   R   T          # Youtube MPV�   Q   S          
# BINDINGS�   P   R           �   O   Q          ,c.colors.prompts.bg = xresources['*.color0']�   N   P          1c.colors.prompts.border = xresources['*.color12']�   M   O          c.colors.webpage.bg = '#ffffff'�   L   N          # Misc�   K   M          ;c.colors.tabs.selected.even.bg = xresources['*.foreground']�   J   L          :c.colors.tabs.selected.odd.bg = xresources['*.foreground']�   I   K          -c.colors.tabs.odd.bg = xresources['*.color8']�   H   J          .c.colors.tabs.even.bg = xresources['*.color0']�   G   I          -c.colors.tabs.bar.bg = xresources['*.color0']�   F   H          # Tabs�   E   G          2c.colors.messages.info.bg = xresources['*.color8']�   D   F          5c.colors.messages.warning.bg = xresources['*.color3']�   C   E          3c.colors.messages.error.bg = xresources['*.color1']�   B   D          # Statusbar messages�   A   C          6c.colors.statusbar.command.bg = xresources['*.color0']�   @   B          5c.colors.statusbar.normal.bg = xresources['*.color0']�   ?   A          # Statusbar�   >   @          # COLORS�   =   ?           �   <   >          c.fonts.web.size.default = 11�   ;   =          8c.fonts.web.family.standard = c.fonts.web.family.cursive�   :   <          5c.fonts.web.family.serif = c.fonts.web.family.cursive�   9   ;          :c.fonts.web.family.sans_serif = c.fonts.web.family.cursive�   8   :          5c.fonts.web.family.fixed = c.fonts.web.family.cursive�   7   9          7c.fonts.web.family.fantasy = c.fonts.web.family.cursive�   6   8          (c.fonts.web.family.cursive = 'monospace'�   5   7          "c.fonts.prompts = '10pt monospace'�   4   6          O                     '"Liberation Mono", monospace, Fixed, Consolas, Terminal')�   3   5          >                     '"Andale Mono", "Courier New", Courier, '�   2   4          O                     '"DejaVu Sans Mono", Monaco, "Bitstream Vera Sans Mono", '�   1   3          Oc.fonts.monospace = ('"spectrum berry", "xos4 Terminus", Terminus, Monospace, '�   0   2          # FONTS�   /   1           �   .   0          Fc.url.searchengines["mal"] = "https://myanimelist.net/search/all?q={}"�   -   /          6c.url.searchengines["twitch"] = "https://twitch.tv/{}"�   ,   .          7c.url.searchengines["github"] = "https://github.com/{}"�   +   -          Ac.url.searchengines["DEFAULT"] = "https://google.com/search?q={}"�   *   ,          &c.url.start_pages = c.url.default_page�   )   +          5c.url.default_page = 'https://xiiisins.info/homepage'�   (   *           �   '   )           �   &   (          c.messages.timeout = 6000�   %   '          %c.input.insert_mode.auto_leave = True�   $   &          $c.input.insert_mode.auto_load = True�   #   %          c.tabs.background = True�   "   $          c.scrolling.smooth = True�   !   #          c.scrolling.bar = False�       "          #c.downloads.location.prompt = False�      !          "c.downloads.remove_finished = 5000�                 /c.downloads.location.directory = home + '/tmp/'�                c.backend = 'webengine'�                c.auto_save.session = True�                # Behaviour�                 �                config.load_autoconfig()�                 �                ?border_width = subprocess.getoutput("bspc config border_width")�                !xresources = read_xresources('*')�                 �                    return props�                        props[prop] = value�                .        prop, _, value = line.partition(':\t')�                >    for line in filter(lambda l: l.startswith(prefix), lines):�                )    lines = x.stdout.decode().split('\n')�                B    x = subprocess.run(['xrdb', '-query'], stdout=subprocess.PIPE)�                    props = {}�                def read_xresources(prefix):�                 �                 �   
             home = expanduser("~")�   	             config = config�      
          c = c�      	           �                import yaml�                import subprocess�                 �                from os.path import expanduser�                5from qutebrowser.config.config import ConfigContainer�                4from qutebrowser.config.configfiles import ConfigAPI�                 #!/usr/bin/env python35��