-- Data
import Data.Monoid
import Data.Tree
import System.Exit (exitSuccess)
import System.IO (hPutStrLn)
import XMonad
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.CycleWS (nextScreen, prevScreen)
import XMonad.Actions.MouseResize
import XMonad.Actions.WithAll (sinkAll)
import XMonad.Actions.UpdatePointer

-- Hooks
import XMonad.Hooks.DynamicLog (PP (..), dynamicLogWithPP, shorten, wrap, xmobarColor, xmobarPP)
import XMonad.Hooks.EwmhDesktops
import XMonad.ManageHook
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks (ToggleStruts (..), avoidStruts, docks,  manageDocks)
import XMonad.Hooks.ManageHelpers (doFullFloat, isFullscreen)
import XMonad.Hooks.SetWMName
import XMonad.Hooks.WorkspaceHistory
import XMonad.Hooks.InsertPosition

-- Layouts
import XMonad.Layout.GridVariants (Grid (Grid))
import XMonad.Layout.LayoutModifier
--added later
--import XMonad.Layout.WindowNavigation
--import XMonad.Layout.SubLayouts
--import XMonad.Layout.SimplestFloat
--import XMonad.Layout.Simplest
import XMonad.Layout.Spiral
import XMonad.Layout.Accordion
import XMonad.Layout.LimitWindows (limitWindows)
import XMonad.Layout.MultiToggle ((??), EOT (EOT), mkToggle, single)
import qualified XMonad.Layout.MultiToggle as MT (Toggle (..))
import XMonad.Layout.MultiToggle.Instances (StdTransformers (MIRROR, NBFULL, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed (Rename (Replace), renamed)
import XMonad.Layout.ResizableTile
import XMonad.Layout.ShowWName
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns
import qualified XMonad.Layout.ToggleLayouts as T (ToggleLayout (Toggle), toggleLayouts)
import XMonad.Layout.WindowArranger (WindowArrangerMsg (..), windowArrange)
import qualified XMonad.StackSet as W

-- Utilities
import XMonad.Util.EZConfig (additionalKeysP, additionalKeys)
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.SpawnOnce
import XMonad.Util.Scratchpad
-- Added later for scratchpad
import XMonad.Util.NamedScratchpad
import XMonad.Util.Scratchpad

--Added for scratchpad
--Data
import Data.Maybe (isJust)
--Action
import XMonad.Actions.CycleWS (moveTo, shiftTo, WSType(..), nextScreen, prevScreen)

-- Use Alt key as mod1Mask in combination to Super key as mod4Mask
-- add myAltMask with same Data types as myModMask
-- altMask added after checking the Types of additionalKeys after import
-- add mykeys1 by looking at the Type of myKeys

{-# OPTIONS_GHC -Wno-deprecations #-}

myModMask = mod4Mask :: KeyMask
myAltMask = mod1Mask :: KeyMask

altMask :: XConfig a -> KeyMask
altMask additionalKeys = myAltMask

myTerminal = "alacritty" :: String

myBorderWidth = 1 :: Dimension

myNormColor = "#292d3e" :: String

myFocusColor = "#c792ea" :: String

--added later for unfocussed transparancy
myLogHook :: X ()
myLogHook = fadeInactiveLogHook fadeAmount
    where fadeAmount = 1.0

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

myStartupHook :: X ()
myStartupHook = do
    --spawnOnce "trayer --edge top  --monitor 1 --widthtype percent --width 10 --heighttype pixel --height 21 --align right --transparent true --alpha 0 --tint 0x292d3e --iconspacing 3 --distance 1 &"
    spawnOnce "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 12.8 --height 17.1 --transparent true --tint 0x292d3e"
    spawnOnce "picom --config ~/.config/picom/picom.conf -b --experimental-backends"
    spawnOnce "nitrogen --restore"
    spawnOnce "nm-applet &"
    spawnOnce "pa-applet &"
    spawnOnce "xrandr -s 1920x1200"
    spawnOnce "xrandr --output eDP --primary --below HDMI-A-0"
    setWMName "LG3D"
    spawnOnce "~/scripts/change-tab_press-super.sh"
    spawnOnce "~/.local/noip-2.1.9-1/noip2"
    spawnOnce "xmodmap ~/.Xmodmap"




mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Single window with no gaps
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Layouts definition

tall = renamed [Replace "tall"]
    $ limitWindows 12
    $ mySpacing 4
    $ ResizableTall 1 (3 / 100) (1 / 2) []

monocle = renamed [Replace "monocle"] $ limitWindows 20 Full

grid = renamed [Replace "grid"]
    $ limitWindows 12
    $ mySpacing 4
    $ mkToggle (single MIRROR)
    $ Grid (16 / 10)

threeCol = renamed [Replace "threeCol"]
    $ limitWindows 7
    $ mySpacing' 4
    $ ThreeCol 1 (3 / 100) (1 / 3)

threeColMid = renamed [Replace "threeColMid"]
    $ limitWindows 7
    $ mySpacing' 4
    $ ThreeColMid 1 (3 / 100) (3 / 4)

floats = renamed [Replace "floats"] $ limitWindows 20 simplestFloat

spirals  = renamed [Replace "spirals"]
           -- $ windowNavigation
           -- $ addTabs shrinkText myTabTheme
           -- $ subLayout [] (smartBorders Simplest)
           $ mySpacing' 2
           $ spiral (5/7)


-- Layout hook

myLayoutHook = avoidStruts
    $ smartBorders
    $ mouseResize
    $ windowArrange
    $ T.toggleLayouts floats
    $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
  where
    myDefaultLayout =
        tall
        |||noBorders monocle
        ||| spirals
        ||| Mirror tall
        ||| threeCol
        ||| grid
--	||| ThreeColMid 1 (3/100) (3/4)
        ||| threeColMid

xmobarEscape :: String -> String
xmobarEscape = concatMap doubleLts
  where
    doubleLts '<' = "<<"
    doubleLts x = [x]

myWorkspaces :: [String]
myWorkspaces = clickable . (map xmobarEscape)
--                                                                                       
    $ ["\xf269 ", "\xe795 ", "\xe235", "\xf121 ", "\xe615 ", "\xf74a ", "\xf7e8 ", "\xf03d ", "\xf827 "]
--    $ ["www", "dev", "term", "ref", "sys", "fs", "img", "vid", "misc"]
  where
    clickable l = ["<action=xdotool key super+" ++ show (i) ++ "> " ++ ws ++ "</action>" | (i, ws) <- zip [1 .. 9] l]

-- Use this exclusively with Key Bindings for Alt Key
myKeys1 :: [((KeyMask, KeySym),X())]
myKeys1 =  [((mod1Mask, xK_p), spawn "mpc toggle")
          ,((mod1Mask, xK_Right), spawn "mpc next")
          ,((mod1Mask, xK_Left), spawn "mpc prev")
          ,((mod1Mask, xK_Up), spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
          ,((mod1Mask, xK_Down), spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
          ,((mod1Mask, xK_8), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
          ,((mod1Mask, xK_a), spawn "$HOME/scripts/ada")
          ,((mod1Mask, xK_f), spawn "freetube")
          ,((mod1Mask, xK_b), spawn "brave")
          -- ,((mod1Mask, xK_c), spawn "xterm")
          ,((mod1Mask, xK_t), spawn "firefox")
          ,((mod1Mask, xK_u), spawn "urxvt")
           ]

myKeys :: [(String, X ())]
myKeys =
    [
    ------------------ Window configs ------------------

    -- Move focus to the next window
    ("M-j", windows W.focusDown),
    -- Move focus to the previous window
    ("M-k", windows W.focusUp),
    -- Swap focused window with next window
    ("M-S-j", windows W.swapDown),
    -- Swap focused window with prev window
    ("M-S-k", windows W.swapUp),
    -- Kill window
    ("M-w", kill1),
    -- Restart xmonad
    ("M-C-r", spawn "xmonad --restart"),
    -- Quit xmonad
    ("M-C-q", io exitSuccess),

    ----------------- Floating windows -----------------

    -- Toggles 'floats' layout
    ("M-f", sendMessage (T.Toggle "floats")),
    -- Push floating window back to tile
    ("M-S-f", withFocused $ windows . W.sink),
    -- Push all floating windows to tile
    ("M-C-f", sinkAll),

    ---------------------- Layouts ----------------------

    -- Switch focus to next monitor
    ("M-.", nextScreen),
    ("M-[", nextScreen),
    -- Switch focus to prev monitor
    ("M-,", prevScreen),
    -- Switch to next layout
    --("M-<Tab>", sendMessage NextLayout),
    ("M-q", sendMessage NextLayout),
    -- Switch to first layout
    --("M-S-<Tab>", sendMessage FirstLayout),
    ("M-`", sendMessage FirstLayout),
    -- Toggles noborder/full
    ("M-<Space>", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts),
    ("M-C-<Space>", sendMessage ToggleStruts),
    -- Toggles noborder
    ("M-S-n", sendMessage $ MT.Toggle NOBORDERS),
    -- Shrink horizontal window width
    ("M-S-h", sendMessage Shrink),
    -- Expand horizontal window width
    ("M-S-l", sendMessage Expand),
    -- Shrink vertical window width
    ("M-C-j", sendMessage MirrorShrink),
    -- Exoand vertical window width
    ("M-C-k", sendMessage MirrorExpand),

    -------------------- App configs --------------------

    -- Menu
    ("M-d", spawn "dmenu_run -l 15"),
    ("M-p", spawn "rofi -show drun"),
    -- Window nav
    ("M-S-p", spawn "rofi -show"),
    -- Browser
    -- ("M-t", spawn "firefox"),
    -- Scripts
    ("M-e", spawn "$HOME/scripts/dmconfig"),
    ("M-x", spawn "$HOME/scripts/dmpower"),
    ("M-s", spawn "$HOME/scripts/dmsearch"),
    -- Terminal
    ("M-<Return>", spawn myTerminal),
    -- ("M-u", spawn "urxvt"),
    -- Redshift
    ("M-r", spawn "redshift -c .config/redshift.conf"),
    ("M-S-r", spawn "redshift -x"),
    -- Scrot
--    ("M-s", spawn "scrot '%Y-%m-%d_$wx$h.png' -e 'mv $f ~/shots/'"),

    ---------------------Scratchpad--------------------

    ("M-a", namedScratchpadAction scratchpads "htop"),
    ("M-z", namedScratchpadAction scratchpads "ranger"),
    ("M-c", namedScratchpadAction scratchpads "console"),
    ("M-v", namedScratchpadAction scratchpads "vim"),
    ("M-n", namedScratchpadAction scratchpads "note"),
    ("M-b", namedScratchpadAction scratchpads "browser"),
    --("M-t", namedScratchpadAction scratchpads "test"),
    --("M-c", scratchpadSpawnActionTerminal myTerminal),
    --------------------- Hardware ---------------------

    -- Volume
    ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%"),
    ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%"),
    ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle" ),
{-    ("M-C-8", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle" ),
    ("M-C-p", spawn "mpc toggle"),
    ("M-C-]", spawn "mpc next"),
    ("M-C-[", spawn "mpc prev"),
    ("M-C-9", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%"),
    ("M-C-0", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%"),
-}
    ("<XF86AudioPrev>", spawn "mpc prev"),
    ("<XF86AudioNext>", spawn "mpc next"),
    ("<XF86AudioStop>", spawn "mpc stop"),
    ("<XF86AudioPlay>", spawn "mpc toggle"),
    -- Brightness
    ("<XF86MonBrightnessUp>", spawn "brightnessctl set +10%"),
    ("<XF86MonBrightnessDown>", spawn "brightnessctl set 10%-")
    ]
manageScratchPad :: ManageHook
manageScratchPad = scratchpadManageHook (W.RationalRect l t w h)

 where

    h = 0.1     -- terminal height, 10%
    w = 1       -- terminal width, 100%
    t = 1 - h   -- distance from top edge, 90%
    l = 1 - w   -- distance from left edge, 0%ain :: IO ()

myManageHook = composeAll
     -- using 'doShift ( myWorkspaces !! 7)' sends program to workspace 8!
     -- I'm doing it this way because otherwise I would have to write out the full
     -- name of my workspaces, and the names would very long if using clickable workspaces.
     [-- className =? "Brave-browser"     --> doShift ( myWorkspaces !! 0 )
      className =? "firefox"     --> doShift ( myWorkspaces !! 0 )
     , className =? "mpv"     --> doShift ( myWorkspaces !! 7 )
     , className =? "Gimp"    --> doShift ( myWorkspaces !! 8 )
     , className =? "Gimp"    --> doFloat
     , title =? "Oracle VM VirtualBox Manager"     --> doFloat
     , className =? "VirtualBox Manager" --> doShift  ( myWorkspaces !! 4 )
     , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
     ]

main = do
    -- Xmobar
    --xmobarLaptop <- spawnPipe "xmobar -x 0 ~/.config/xmobar/mpdbar.hs"
    --xmobarLaptop <- spawnPipe "xmobar -x 0 ~/.config/xmobar/primary.hs"
    --xmobarLaptop <- spawnPipe "xmobar -x 0 ~/.config/xmobar/secondary.hs"
    xmobarLaptop <- spawnPipe "xmobar -x 0 ~/.config/xmobar/arch.hs"
    -- xmobarMonitor <- spawnPipe "xmobar -x 1 ~/.config/xmobar/secondary.hs"
    -- Xmonad
    xmonad $ docks $ ewmh def {
        manageHook = (isFullscreen --> doFullFloat) <+> myManageHook <+>  namedScratchpadManageHook scratchpads <+> manageScratchPad<+> insertPosition Below Newer,
        modMask = myModMask,
        -- altMask = myAltMask,
        terminal = myTerminal,
        startupHook = myStartupHook,
        layoutHook = myLayoutHook,
        workspaces = myWorkspaces,
        borderWidth = myBorderWidth,
        normalBorderColor = myNormColor,
        focusedBorderColor = myFocusColor,
        -- Log hook
        logHook = myLogHook <+> workspaceHistoryHook <+> dynamicLogWithPP xmobarPP {
            ppOutput = \x -> hPutStrLn xmobarLaptop x >> hPutStrLn xmobarLaptop x,
            -- Current workspace in xmobar
            ppCurrent = xmobarColor "#c3e88d" "" . wrap "[" " ]",
            -- Visible but not current workspace
            ppVisible = xmobarColor "#c3e88d" "",
            -- Hidden workspaces in xmobar
            ppHidden = xmobarColor "#82AAFF" "" .wrap "*" "",
            -- Hidden workspaces (no windows)
            ppHiddenNoWindows = xmobarColor "#c792ea" "",
            -- Title of active window in xmobar
            ppTitle = xmobarColor "#6272a4" "" . shorten 55,
            -- Separators in xmobar
            ppSep = "<fc=#666666> | </fc>",
            -- Urgent workspace
            ppUrgent = xmobarColor "#C45500" "" . wrap "" "!",
            -- Number of windows in current workspace
            ppExtras = [windowCount],
            ppOrder = \(ws : l : t : ex) -> [ws, l] ++ ex ++ [t]
        } >> updatePointer (0.5, 0.5) (0.5, 0.5)
} `additionalKeysP`myKeys `additionalKeys` myKeys1

------SCRATCHPADS----------
--
scratchpads :: [NamedScratchpad]
scratchpads = [
         NS "console" ""(className =? "Terminator") (customFloating $ W.RationalRect (1/9) (1/9) (4/5) (4/5)),
         --NS "htop" "termite -e htop" (title =? "htop") (customFloating $ W.RationalRect (1/5) (1/5) (4/5) (4/5)),
         NS "htop" " -e glances" (title =? "glances") (customFloating $ W.RationalRect (1/5) (1/5) (4/5) (4/5)),
         -- NS "htop" "termite -e vtop" (title =? "vtop") (customFloating $ W.RationalRect (1/5) (1/5) (4/5) (4/5)),
         NS "ranger" "xterm -e ranger" (title=? "ranger") (customFloating $ W.RationalRect (1/5) (1/9) (4/5) (4/5)),
         --NS "ncmpcpp" "termite -e ncmpcpp" (title=? "ncmpcpp")  (customFloating $ W.RationalRect 0.2 0.6 0.6 0.4),
         --NS "note" "leafpad ~/copy-paste" (title=? "copy-paste")  (customFloating $ W.RationalRect 0.2 0.6 0.6 0.4),
         NS "note" "xterm ~/copy-paste" (title=? "copy-paste - /home/shovanrai - Notepadqq")  (customFloating $ W.RationalRect 0.2 0.6 0.6 0.4),
         NS "browser" "qutebrowser" (className =? "qutebrowser") (customFloating $ W.RationalRect (1/10) 0.02 (9/10) 0.9),
         --NS "test" "termite" (title =? "termite") (customFloating $ W.RationalRect 0.5 0.1 1 0.9),
         NS "vim" "kitty -e vim notes.txt" (title=? "notes.txt (~) - VIM") (customFloating $ W.RationalRect (1/9) (1/9) (4/5) (4/5))
             ]
