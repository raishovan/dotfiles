Config { font = "xft:Dejavu Sans Mono:pixelsize=14"
       , bgColor = "#000000"
       , fgColor = "#ffffff"
       , border = FullB
       , borderColor = "#3579a8"
       , position = BottomW C 100
       , lowerOnStart = True
       , commands = [ Run MPD [ "-t", "<fc=#3579a8><statei></fc> <lapsed>/<length> [<fc=#3579a8><bar></fc>] <fc=#ff00ff><artist></fc> - <fc=#aaaa00><album></fc> - <fc=#00ffff><title></fc>"
                    , "-b", "."
                    , "-f", "="
                    , "--"
                    , "-P", ">>"
                    , "-S", "[]"
                    , "-Z", "||" ] 10
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "}%mpd%{"
       }
