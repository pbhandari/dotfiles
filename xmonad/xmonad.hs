
import XMonad

-- actions
import XMonad.Actions.CycleWS
import XMonad.Actions.WindowGo
import XMonad.Actions.GridSelect
import XMonad.Actions.FloatKeys
import XMonad.Actions.Submap
import qualified XMonad.Actions.Submap as SM

-- utils
import XMonad.Util.EZConfig
import XMonad.Util.Run

-- hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName

-- layouts
import XMonad.Layout.NoBorders
import XMonad.Layout.Accordion
import XMonad.Layout.ResizableTile
import XMonad.Layout.Renamed
import XMonad.Layout.Reflect
import XMonad.Layout.Tabbed
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.Grid
import XMonad.Layout.ComboP
import XMonad.Layout.Column
import XMonad.Layout.TwoPane

-- Data.Ratio for IM layout
import Data.Ratio ((%))
import Data.List (isInfixOf)
import qualified Data.Map as M

import qualified XMonad.StackSet as W

import System.IO
import System.Exit

-- Main
main = do
    -- status <- spawnPipe "/usr/bin/xmobar /home/pbhandari/.xmobarrc"
    dzenBar <- spawnPipe bar
    spawn "sh /home/pbhandari/.xmonad/autostart"
    xmonad $ withUrgencyHook NoUrgencyHook defaultConfig
        { manageHook            = manageDocks <+> myManageHook
        , layoutHook            = smartBorders $ avoidStruts $ myLayout
        , modMask               = mod4Mask
        , keys                  = myKeys
        , workspaces            = myWorkspaces
        , focusFollowsMouse     = False
        , terminal              = myTerminal
        -- more changes
        , logHook               = myLogHook dzenBar
        } where
            bar = concatMap (++ " ") [ "/usr/bin/dzen2"
                                     , "-fn Monaco:size=8.5"
                                     , "-ta l", "-w 700"
                                     , "-bg '#111'", "-fg '#999'"
                                     ]


-- my Terminal
myTerminal :: String
myTerminal = "termite"

-- modMask
myModMask :: KeyMask
myModMask = mod4Mask

--Layouts
myLayout =      Tall nmaster delta ratio
            ||| Mirror (Tall nmaster delta ratio)
            ||| Full
            ||| simpleTabbed
            {-||| Accordion-}
            {-||| renamed [Replace "Full|Accordion"]
             - combineTwoP (TwoPane 0.03 0.5) (Full) (Accordion)
                            (ClassName "Firefox")-}
            {-||| Mirror (GridRatio (1/2))-}
  where
     nmaster = 1        -- in the master pane
     ratio   = 1/2      -- proportion of screen occupied by master pane
     delta   = 3/100    -- when resizing panes, increment by this % of screen


--LogHook
myLogHook :: Handle -> X ()
myLogHook str = dynamicLogWithPP $ myDzenPP { ppOutput = hPutStrLn str}


myDzenPP :: PP
myDzenPP = defaultPP {
              ppTitle           = dzenColor "gray" "" . shorten 50
            , ppCurrent         = dzenColor "white" "" . pad
            , ppVisible         = dzenColor "gray" "" . pad
            , ppHidden          = dzenColor "lightblue" "" . pad
            , ppHiddenNoWindows = dzenColor "#777777"  "". pad
            , ppUrgent          = dzenColor "red" "" . pad
            , ppWsSep           = ""
            , ppSep             = " | "
            , ppLayout = (\x -> case x of
                    "Tall"                  -> putIcon "tall"
                    "Mirror Tall"           -> putIcon "mirror_tall"
                    "Full"                  -> putIcon "full"
                    "Accordion"             -> putIcon "accordian"
                    "Tabbed Simplest"       -> putIcon "tabbed"
                    "Mirror GridRatio 0.5"  -> putIcon "grid"
                    _                       -> shorten 10 x )
            } where
                putIcon::String -> String
                putIcon x = "^i(/home/pbhandari/.xmonad/dzen2/layout_"
                                ++ x ++ ".xbm)"

myXmobarPP :: PP
myXmobarPP = xmobarPP {
              ppTitle           = xmobarColor "gray" "" . shorten 50
            , ppCurrent         = xmobarColor "lightyellow" ""
            , ppVisible         = xmobarColor "gray" ""
            , ppHidden          = xmobarColor "lightblue" ""
            , ppHiddenNoWindows = xmobarColor "#777777"  ""
            , ppUrgent          = xmobarColor "red" ""
            , ppWsSep           = " "
            , ppSep             = " | "
            , ppLayout = (\x -> case x of
                    "Tall"                  -> "[|]"
                    "Mirror Tall"           -> "[-]"
                    "Full"                  -> "[-]"
                    "Accordion"             -> "[=]"
                    "Tabbed Simplest"       -> "[T]"
                    "Mirror GridRatio 0.5"  -> "[+]"
                    _                       -> shorten 10 x )

            }


myWorkspaces :: [WorkspaceId]
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-"]

-- hooks
-- automaticly switching app to workspace
myManageHook :: ManageHook
myManageHook = composeAll . concat $ [ []
    , [isDialog --> doFloat]            -- float all dialogs
    , [isFullscreen --> doFullFloat]    -- float all fullscreen windows
        -- float other specific windows
    , [className =? x --> doFloat       | x <- myCFloats]
    , [title =?     x --> doFloat       | x <- myTFloats]
    , [resource =?  x --> doFloat       | x <- myRFloats]
        -- Ignore these windows
    , [resource =?  x --> doIgnore      | x <- myIgnores]
        -- Shift windows to specific workspaces
    , [canShift x --> doShift (myWorkspaces!! 0) | x <- my0Shifts]
    , [canShift x --> doShift (myWorkspaces!! 1) | x <- my1Shifts]
    , [canShift x --> doShift (myWorkspaces!! 2) | x <- my2Shifts]
    , [canShift x --> doShift (myWorkspaces!! 3) | x <- my3Shifts]
    , [canShift x --> doShift (myWorkspaces!! 4) | x <- my4Shifts]
    , [canShift x --> doShift (myWorkspaces!! 5) | x <- my5Shifts]
    , [canShift x --> doShift (myWorkspaces!! 6) | x <- my6Shifts]
    , [canShift x --> doShift (myWorkspaces!! 7) | x <- my7Shifts]
    , [canShift x --> doShift (myWorkspaces!! 8) | x <- my8Shifts]
    , [canShift x --> doShift (myWorkspaces!! 9) | x <- my9Shifts]
    ] where
        {-doShiftAndGo = doF . liftM2 (.) W.greedyView W.shift-}
        canShift x = className =? x <||> title =? x <||> resource =? x

        myCFloats = ["MPlayer", "Nitrogen", "XCalc", "XFontSel", "Xmessage"]
        myTFloats = ["Downloads", "Save As..."]
        myRFloats = []

        myIgnores = []

        my0Shifts = []
        my1Shifts = ["Pidgin", "Skype", "Thunderbird", "Urxvt-soc"]
        my2Shifts = []
        my3Shifts = ["Calibre-gui"]
        my4Shifts = ["MPlayer"]
        my5Shifts = []
        my6Shifts = []
        my7Shifts = []
        my8Shifts = []
        my9Shifts = []


-- key bindings
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $ [
      ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , (( modMask .|. controlMask, xK_Return),
                spawn $ (XMonad.terminal conf) ++ " -e 'tmux new -As xmonad'")

    -- opening program launcher / search engine
    , ((modMask, xK_p), spawn "dmenu_run")

    -- layouts
    , ((modMask, xK_space ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modMask, xK_b ), sendMessage ToggleStruts)

    -- floating layer stuff
    , ((modMask, xK_t ), withFocused $ windows . W.sink)

    -- refresh'
    , ((modMask, xK_n ), refresh)

    -- focus
    , ((modMask, xK_Tab ), windows W.focusDown)
    , ((modMask .|. shiftMask, xK_Tab ), windows W.focusUp)

    , ((modMask, xK_k ), windows W.focusUp)
    , ((modMask, xK_j ), windows W.focusDown)
    , ((modMask, xK_Up ), windows W.focusUp)
    , ((modMask, xK_Down ), windows W.focusDown)
    , ((modMask, xK_m ), windows W.focusMaster)

    -- swapping
    , ((modMask .|. shiftMask, xK_k ), windows W.swapUp )
    , ((modMask .|. shiftMask, xK_j ), windows W.swapDown )
    , ((modMask .|. shiftMask, xK_Up ), windows W.swapUp )
    , ((modMask .|. shiftMask, xK_Down ), windows W.swapDown )
    , ((modMask , xK_Return), windows W.swapMaster)

    -- increase or decrease number of windows in the master area
    , ((modMask , xK_comma ), sendMessage (IncMasterN 1))
    , ((modMask , xK_period), sendMessage (IncMasterN (-1)))

    , ((modMask, xK_h ), sendMessage Shrink)
    , ((modMask, xK_l ), sendMessage Expand)
    , ((modMask, xK_Left ), sendMessage Shrink)
    , ((modMask, xK_Right ), sendMessage Expand)

    --Music mpc
    , ((modMask .|. controlMask, xK_a), spawn "mpc prev")
    , ((modMask .|. controlMask, xK_s), spawn "mpc toggle")
    , ((modMask .|. controlMask, xK_d), spawn "mpc next")
    {-, ((0 , 0x1008ff16 ), spawn "mpc prev")-}
    {-, ((0 , 0x1008ff14 ), spawn "mpc toggle")-}
    {-, ((0 , 0x1008ff17 ), spawn "mpc next")-}

    --Launching programs
    , (( modMask .|. shiftMask, xK_c), kill) -- to kill applications

    -- volume control
    , ((modMask .|. controlMask, xK_q), spawn "amixer sset Master toggle")
    , ((modMask .|. controlMask, xK_w), spawn "amixer sset Master 5%+")
    , ((modMask .|. controlMask, xK_e), spawn "amixer sset Master 5%-")
    {-, ((0 , 0x1008ff13 ), spawn "amixer sset Master 5%+")-}
    {-, ((0 , 0x1008ff11 ), spawn "amixer sset Master 5%-")-}
    {-, ((0 , 0x1008ff12 ), spawn "amixer sset Master toggle")-}

    -- brightness control
    --, ((0 , 0x1008ff03 ), spawn "xcalib -co 50 -a")
    --, ((0 , 0x1008ff02 ), spawn "xcalib -c -a")

    -- quit, or restart
    , ((modMask .|. shiftMask, xK_q ), io (exitWith ExitSuccess))
    , ((modMask , xK_q ), restart "xmonad" True)
    ]
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    ++
    [((m .|. modMask, k), windows $ f i)
    | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0] ++ [xK_grave])
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

    -- mod-[w,e] %! switch to twinview screen 1/2
    -- mod-shift-[w,e] %! move window to screen 1/2
    ++
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
    | (key, sc) <- zip [xK_e, xK_w, xK_r] [0..]
    , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


