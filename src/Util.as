void Cleanup() {
    SetBlockHelpers(true);
}

void HotkeyNotify(const string&in name, const VirtualKey key) {
    if (!S_HotkeyNotify) {
        return;
    }

    UI::ShowNotification(PLUGIN_TITLE, "Pressed: " + PLUGIN_COLOR + tostring(key) + "\\$g (" + name + "\\$g)");
}

bool SetBlockHelpers(const bool b) {
    auto App = cast<CTrackMania>(GetApp());

    auto Editor = cast<CGameCtnEditorFree>(App.Editor);
    if (false
        or Editor is null
        or Editor.PluginMapType is null
        or !Editor.PluginMapType.IsEditorReadyForRequest
    ) {
        return false;
    }

    Editor.PluginMapType.HideBlockHelpers = !b;

    return true;
}

bool ToggleBlockHelpers() {
    S_BlockHelpers = !S_BlockHelpers;
    return SetBlockHelpers(S_BlockHelpers);
}
