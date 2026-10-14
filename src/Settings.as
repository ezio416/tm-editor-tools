[Setting hidden] bool       S_AirBlockMode       = false;
[Setting hidden] VirtualKey S_AirBlockModeHotkey = VirtualKey::A;
[Setting hidden] bool       S_BlockHelpers       = true;
[Setting hidden] VirtualKey S_BlockHelpersHotkey = VirtualKey::B;
[Setting hidden] bool       S_Enabled            = true;
[Setting hidden] bool       S_Hotkeys            = true;
[Setting hidden] bool       S_HotkeysNotify      = true;

[SettingsTab name="General" icon="Cogs" order=0]
void SettingsTab_General() {
    if (UI::Button("Reset to default")) {
        Meta::PluginSetting@[]@ settings = PLUGIN_META.GetSettings();
        for (uint i = settings.Length; i --> 0;) {
            settings[i].Reset();
        }

        Cleanup();
    }

    const bool enabled = UI::Checkbox("Enabled", S_Enabled);
    if (S_Enabled and !enabled) {
        Cleanup();
    }
    S_Enabled = enabled;

    if (UI::TreeNode("Tools", UI::TreeNodeFlags::Framed)) {
        const bool airBlockMode = UI::Checkbox("Air block mode", S_AirBlockMode);
        if (S_AirBlockMode != airBlockMode) {
            S_AirBlockMode = airBlockMode;
            SetAirBlockMode(S_AirBlockMode);
        }

        const bool blockHelpers = UI::Checkbox("Block helpers", S_BlockHelpers);
        if (S_BlockHelpers != blockHelpers) {
            S_BlockHelpers = blockHelpers;
            SetBlockHelpers(S_BlockHelpers);
        }

        UI::TreePop();
    }

    if (UI::TreeNode("Hotkeys", UI::TreeNodeFlags::Framed)) {
        UI::PushID("hotkeys");

        S_Hotkeys = UI::Checkbox("Enabled", S_Hotkeys);
        S_HotkeysNotify = UI::Checkbox("Notifications", S_HotkeysNotify);

        UI::Separator();

        S_AirBlockModeHotkey = RenderHotkeySelector("Air block mode", S_AirBlockModeHotkey);
        S_BlockHelpersHotkey = RenderHotkeySelector("Block helpers", S_BlockHelpersHotkey);

        UI::PopID();
        UI::TreePop();
    }
}
