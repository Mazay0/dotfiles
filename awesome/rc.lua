-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Notification library
require("naughty")
-- scratch console
require("scratch")

home = os.getenv("HOME")
terminal = "urxvtc"
scratchterm = "urxvtc -e zsh " .. home .. "/.scripts/scratch"

-- Default modkey.
modkey = "Mod4"

-- Configure naughty
naughty.config.default_preset.position         = "top_right"
naughty.config.default_preset.fg               = '#000000'
naughty.config.default_preset.bg               = '#ffffff'
naughty.config.presets.normal.border_color     = '#ff0000'
naughty.config.default_preset.border_width     = 3
naughty.config.default_preset.timeout          = 8
naughty.config.default_preset.font             = "Inconsolata 14"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.fair,
    awful.layout.suit.max.fullscreen
}
-- }}}

-- {{{ Tags
tags = {
   names  = { "1", "2" },
   layout = { layouts[1], layouts[1] }
}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    -- music control
    awful.key({ modkey            }, "p", function() awful.util.spawn(home .. '/.scripts/music toggle') end),
    awful.key({ modkey            }, "Left", function() awful.util.spawn(home .. '/.scripts/music down') end),
    awful.key({ modkey            }, "Right", function() awful.util.spawn(home .. '/.scripts/music up') end),

    -- toggle clients
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
        
    -- toggle tags
    awful.key({ "Mod1",           }, "l", awful.tag.viewnext),

    -- toggle screens
    awful.key({ modkey            }, "l", function () awful.screen.focus_relative( 1) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "space", function () awful.client.swap.byidx(1)    end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey,           }, "c", function () awful.util.spawn('chromium-browser') end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),
    awful.key({                   }, "F12", function () scratch.drop(scratchterm, "top") end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Shift"   }, "o",      awful.client.movetoscreen                        )
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = 0,
                     border_color = "#000000",
                     focus = true,
                     keys = clientkeys }
    }
}
-- }}}
