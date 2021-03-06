-- http://projects.haskell.org/xmobar/

Config { 
    font = "xft:UbuntuMono Nerd Font:weight=bold:pixelsize=16:antialias=true:hinting=true",
    bgColor = "#292d3e",
    fgColor = "#f07178",
    lowerOnStart = True,
    hideOnStart = False,
    allDesktops = True,
    position = TopW L 99,
    persistent = True,
    commands = [ 
        Run Date "  %d %b %Y %H:%M " "date" 600,
        Run Network "wlp2s0" ["-t", " <rx>kb  <tx>kb"] 150,
        Run Cpu ["-t", " (<total>%)","-H","50","--high","red"] 150,
        Run Memory ["-t", "  <used>M (<usedratio>%)"] 150,
        Run Com "bash" ["-c", "checkupdates | wc -l"] "updates" 3000,
-- not working
--	Run MPD ["-t", "<state>: <artist> - <track>"] 10,
	Run Weather "VNKT" ["-t","<station>: <tempC>C",
                                        "-L","18","-H","25",
                                        "--normal","green",
                                        "--high","red",
                                        "--low","lightblue"] 36000,
	Run UnsafeStdinReader
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "<fc=#b303ff>   </fc> %UnsafeStdinReader% }{ \
        \<fc=#e1acff> %updates% </fc>\
--        \<fc=#8BE9FD> %mpd% </fc>
        \<fc=#FFB86C> %cpu% </fc>\
        \<fc=#FF5555> %memory% </fc>\
        \<fc=#c3e88d> %wlp2s0% </fc>\
        \<fc=#c3e88d> %VNKT% </fc>\
        \<fc=#8BE9FD> %date% </fc>\"
	}
