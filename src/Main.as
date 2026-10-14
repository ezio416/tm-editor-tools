const string  PLUGIN_COLOR = "\\$6af";
const string  PLUGIN_ICON  = Icons::Fire;
Meta::Plugin@ PLUGIN_META  = Meta::ExecutingPlugin();
const string  PLUGIN_TITLE = PLUGIN_COLOR + PLUGIN_ICON + "\\$g " + PLUGIN_META.Name;

void Main() {
    auto App = cast<CTrackMania>(GetApp());

    bool inEditor    = false;
    bool wasInEditor = false;

    while (true) {
        yield();

        if (!S_Enabled) {
            wasInEditor = false;
            continue;
        }

        inEditor = true
            and cast<CGameCtnEditorFree>(App.Editor) !is null
            and cast<CSmArenaClient>(App.CurrentPlayground) is null
        ;

        if (wasInEditor != inEditor) {
            wasInEditor = inEditor;

            if (inEditor) {
                trace("entered map editor");

                SetAirBlockMode(S_AirBlockMode);
                SetBlockHelpers(S_BlockHelpers);

            } else {
                trace("exited map editor");
            }
        }
    }
}

void OnDestroyed() {
    Cleanup();
}

void OnDisabled() {
    OnDestroyed();
}

void OnKeyPress(bool down, VirtualKey key) {
    if (false
        or !down
        or !S_Enabled
        or !S_Hotkeys
    ) {
        return;
    }

    auto App = cast<CTrackMania>(GetApp());

    auto Editor = cast<CGameCtnEditorFree>(App.Editor);
    if (false
        or Editor is null
        or Editor.PluginMapType is null
        or !Editor.PluginMapType.IsEditorReadyForRequest
    ) {
        return;
    }

    if (true
        and key == S_AirBlockModeHotkey
        and ToggleAirBlockMode()
    ) {
        NotifyHotkey("Toggle Air Block Mode" + (S_AirBlockMode ? "\\$0f0 On" : "\\$f00 Off"), key);
        return;
    }

    if (true
        and key == S_BlockHelpersHotkey
        and ToggleBlockHelpers()
    ) {
        NotifyHotkey("Toggle Block Helpers" + (S_BlockHelpers ? "\\$0f0 On" : "\\$f00 Off"), key);
        return;
    }
}

void RenderMenu() {
    if (UI::MenuItem(PLUGIN_TITLE, "", S_Enabled)) {
        S_Enabled = !S_Enabled;
    }
}
