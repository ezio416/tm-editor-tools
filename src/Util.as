const uint64 QUICKSAVE_WAIT_TIME = 2000;

uint64 g_lastQuicksave = 0;

void Cleanup() {
    trace("cleaning up...");

    SetBlockHelpers(true);
}

void NotifyHotkey(const string&in name, const VirtualKey key) {
    if (!S_HotkeysNotify) {
        return;
    }

    UI::ShowNotification(PLUGIN_TITLE, "Pressed: " + PLUGIN_COLOR + tostring(key) + "\\$g (" + name + "\\$g)");
}

bool Quicksave() {
    if (Time::Now - g_lastQuicksave < QUICKSAVE_WAIT_TIME) {
        return false;
    }

    auto App = cast<CTrackMania>(GetApp());

    auto Editor = cast<CGameCtnEditorFree>(App.Editor);
    if (false
        or Editor is null
        or Editor.PluginMapType is null
    ) {
        return false;
    }

    if (Editor.PluginMapType.MapFileName.Length > 0) {
        Editor.PluginMapType.SaveMap(Path::Join(
            Path::GetDirectoryName(Editor.PluginMapType.MapFileName),
            Editor.PluginMapType.MapName + ".Map.Gbx"
        ));
    } else {
        Editor.ButtonSaveOnClick();
    }

    g_lastQuicksave = Time::Now;

    return true;
}

VirtualKey RenderHotkeySelector(const string&in name, VirtualKey setKey) {
    if (UI::BeginCombo(name, tostring(setKey))) {
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
    auto App = cast<CTrackMania>(GetApp());

    auto Editor = cast<CGameCtnEditorFree>(App.Editor);
    if (false
        or Editor is null
        or Editor.PluginMapType is null
        or !Editor.PluginMapType.IsEditorReadyForRequest
    ) {
        return false;
    }

    switch (Editor.PluginMapType.PlaceMode) {
        case CGameEditorPluginMap::EPlaceMode::Block:
        case CGameEditorPluginMap::EPlaceMode::GhostBlock:
        case CGameEditorPluginMap::EPlaceMode::FreeBlock:
            Editor.ButtonAirBlockModeOnClick();
            trace("toggled air block mode");
            return true;
        default:
            return false;
    }
}

bool ToggleBlockHelpers() {
    S_BlockHelpers = !S_BlockHelpers;
    return SetBlockHelpers(S_BlockHelpers);
}
