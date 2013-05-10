
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

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/pbhandari/.xmobarrc"
    spawn "sh /home/pbhandari/.xmonad/autostart"
    xmonad $ defaultConfig
        { manageHook            = manageDocks <+> myManageHook
        , layoutHook            = smartBorders $ avoidStruts $ myLayout
        , modMask               = mod4Mask
        , keys                  = myKeys
        , workspaces            = myWorkspaces
        , focusFollowsMouse     = False
        , terminal              = "urxvt"
        -- more changes
        , logHook               = myLogHook xmproc
        }


--Layouts
myLayout =      Tall nmaster delta ratio
            ||| Mirror (Tall nmaster delta ratio)
            ||| Full
            ||| tabbed shrinkText myTabConfig
            {-||| Accordion-}
            {-||| renamed [Replace "Full|Accordion"]
             - combineTwoP (TwoPane 0.03 0.5) (Full) (Accordion)
                            (ClassName "Firefox")-}
            {-||| Mirror (GridRatio (1/2))-}
  where
     nmaster = 1        -- in the master pane
     ratio   = 1/2      -- proportion of screen occupied by master pane
     delta   = 3/100    -- when resizing panes, increment by this % of screen

     myTabConfig = defaultTheme {
                        inactiveBorderColor = "#FF0000"
                        , activeTextColor = "#FFFF00"
     }


--LogHook
myLogHook str = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn str
            , ppTitle  = xmobarColor "gray" "" . shorten 50
            , ppSep = " <fc=#0033FF>|</fc> "

            , ppLayout = (\x -> case x of
                    "Tall"                  -> "[:]"
                    "Mirror Tall"           -> "[-]"
                    "Full"                  -> "[•]"
                    "Accordion"             -> "[≡]"
                    "Tabbed Simplest"       -> "[¯]"
                    "Mirror GridRatio 0.5"  -> "[+]"
                    unknown                 -> shorten 10 unknown
                    )
            }


--Workspaces
wOne    = "main"
wTwo    = "net"
wThree  = "code"
wFour   = "misc"
wFive   = "video"
wSix    = "term"
wSeven  = "7"
wEight  = "8"
wNine   = "9"
wZero   = "null"

myWorkspaces :: [WorkspaceId]
myWorkspaces = [ wOne, wTwo, wThree, wFour, wFive, wSix, wSeven, wEight, wNine
               , wZero]

-- hooks
-- automaticly switching app to workspace
myManageHook :: ManageHook
myManageHook = composeAll . concat $ [ []
    , [isDialog --> doFloat]

    , [isFullscreen --> doFullFloat]

    , [className =? x --> doFloat       | x <- myCFloats]
    , [title =?     x --> doFloat       | x <- myTFloats]
    , [resource =?  x --> doFloat       | x <- myRFloats]

    , [resource =?  x --> doIgnore      | x <- myIgnores]

    , [canShift x --> doShift wOne    | x <- my1Shifts]
    , [canShift x --> doShift wTwo    | x <- my2Shifts]
    , [canShift x --> doShift wThree  | x <- my3Shifts]
    , [canShift x --> doShift wFour   | x <- my4Shifts]
    , [canShift x --> doShift wFive   | x <- my5Shifts]
    , [canShift x --> doShift wSix    | x <- my6Shifts]
    , [canShift x --> doShift wSeven  | x <- my7Shifts]
    , [canShift x --> doShift wEight  | x <- my8Shifts]
    , [canShift x --> doShift wNine   | x <- my9Shifts]
    ] where
        {-doShiftAndGo = doF . liftM2 (.) W.greedyView W.shift-}
        canShift x = className =? x <||> title =? x <||> resource =? x

        myCFloats = ["MPlayer", "Nitrogen", "XCalc", "XFontSel", "Xmessage"]
        myTFloats = ["Downloads", "Save As..."]
        myRFloats = []

        myIgnores = []

        my1Shifts = []
        my2Shifts = ["Pidgin", "Skype", "Thunderbird", "Urxvt-soc"]
        my3Shifts = []
        my4Shifts = ["Calibre-gui"]
        my5Shifts = ["MPlayer"]
        my6Shifts = []
        my7Shifts = []
        my8Shifts = []
        my9Shifts = []


-- key bindings
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $ [
    -- killing programs
      ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

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
    , (( modMask, xK_w), kill) -- to kill applications

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
    | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0])
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

    -- mod-[w,e] %! switch to twinview screen 1/2
    -- mod-shift-[w,e] %! move window to screen 1/2
    {-++-}
    {-[((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))-}
    {-| (key, sc) <- zip [xK_e, xK_w, xK_r] [0..]-}
    {-, (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]-}


