const string  PLUGIN_COLOR = "\\$6af";
const string  PLUGIN_ICON  = Icons::Fire;
Meta::Plugin@ PLUGIN_META  = Meta::ExecutingPlugin();
const string  PLUGIN_TITLE = PLUGIN_COLOR + PLUGIN_ICON + "\\$g " + PLUGIN_META.Name;

void Main() {
    while (true) {
        yield();

        if (!S_Enabled) {
            Cleanup();
            continue;
        }

        SetBlockHelpers(S_BlockHelpers);
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
        and key == S_BlockHelpersHotkey
        and ToggleBlockHelpers()
    ) {
        HotkeyNotify("Toggle Block Helpers" + (S_BlockHelpers ? "\\$0f0 On" : "\\$f00 Off"), key);
        return;
    }
}

void RenderMenu() {
    if (UI::MenuItem(PLUGIN_TITLE, "", S_Enabled)) {
        S_Enabled = !S_Enabled;
    }
}
