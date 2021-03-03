-- http://projects.haskell.org/xmobar/

Config { 
    font = "xft:UbuntuMono Nerd Font:weight=bold:pixelsize=16:antialias=true:hinting=true",
    bgColor = "#292d3e",
    fgColor = "#f07178",
    lowerOnStart = True,
    hideOnStart = False,
    allDesktops = True,
    position = TopW R 100,
    persistent = True,
    commands = [ 
        Run Date "  %d %b %Y %H:%M " "date" 600,
       -- Run Com "~/.local/bin/volume" [] "volume" 10,
       -- Run Com "~/.local/bin/battery" [] "battery" 600,
       -- Run Com "~/.local/bin/brightness" [] "brightness" 10,
       -- Run Com "bash" ["-c", "checkupdates | wc -l"] "updates" 3000,
        Run Com "/home/shovanrai/.config/xmobar/trayer-padding-icon.sh" [] "trayerpad" 600,
        Run Battery [] 10,
	Run Volume "default" "Master" [] 10,
	Run UnsafeStdinReader
    ],
    alignSep = "}{",
    template = "<fc=#b303ff>   </fc>%UnsafeStdinReader% }{ \
       -- \<fc=#e1acff> %updates% </fc>\
       -- \<fc=#FFB86C> %brightness%</fc>\
        \<fc=#c3e88d> %battery%</fc>\
       -- \<fc=#82AAFF> %volume% </fc>\
        \<fc=#82AAFF> %default:Master% </fc>\
        \<fc=#8BE9FD> %date% </fc>\
        \%trayerpad%"
}
