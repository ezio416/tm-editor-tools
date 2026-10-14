void Cleanup() {
    trace("cleaning up...");

    SetAirBlockMode(false);
    SetBlockHelpers(true);
}

void NotifyHotkey(const string&in name, const VirtualKey key) {
    if (!S_HotkeysNotify) {
        return;
    }

    UI::ShowNotification(PLUGIN_TITLE, "Pressed: " + PLUGIN_COLOR + tostring(key) + "\\$g (" + name + "\\$g)");
}

VirtualKey RenderHotkeySelector(VirtualKey setKey, const int id) {
    if (UI::BeginCombo("hotkey##" + id, tostring(setKey))) {
        for (int i = 0; i <= VirtualKey::OemClear; i++) {
            auto key = VirtualKey(i);

            string s = tostring(key);
            if (s == tostring(i)) {
                continue;
            }

            if (UI::Selectable(s, setKey == key)) {
                setKey = key;
            }
        }

        UI::EndCombo();
    }

    return setKey;
}

bool SetAirBlockMode(const bool b) {
    auto App = cast<CTrackMania>(GetApp());

    auto Editor = cast<CGameCtnEditorFree>(App.Editor);
    if (false
        or Editor is null
        or Editor.PluginMapType is null
        or !Editor.PluginMapType.IsEditorReadyForRequest
    ) {
        return false;
    }

    if (Editor.PluginMapType.EnableAirMapping != b) {
        Editor.ButtonAirBlockModeOnClick();
    }

    trace((b ? "en" : "dis") + "abled air block mode");

    return true;
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

    trace((b ? "en" : "dis") + "abled block helpers");

    return true;
}

bool ToggleAirBlockMode() {
    S_AirBlockMode = !S_AirBlockMode;
    return SetAirBlockMode(S_AirBlockMode);
}

bool ToggleBlockHelpers() {
    S_BlockHelpers = !S_BlockHelpers;
    return SetBlockHelpers(S_BlockHelpers);
}
