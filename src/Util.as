void HotkeyNotify(const string&in name, const VirtualKey key) {
    if (!S_HotkeyNotify) {
        return;
    }

    UI::ShowNotification(PLUGIN_TITLE, "Pressed: \\$0f0" + tostring(key) + "\\$g (" + name + ")", 2000);
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
