const string  PLUGIN_COLOR = "\\$f0a";
const string  PLUGIN_ICON  = Icons::Code;
Meta::Plugin@ PLUGIN_META  = Meta::ExecutingPlugin();
const string  PLUGIN_TITLE = PLUGIN_COLOR + PLUGIN_ICON + "\\$g " + PLUGIN_META.Name;

void Main() {
    ;
}

void Render() {
    if (false
        or !S_Enabled
        or (true
            and S_HideWithGame
            and !UI::IsGameUIVisible()
        )
        or (true
            and S_HideWithOP
            and !UI::IsOverlayShown()
        )
    ) {
        return;
    }

    if (UI::Begin(PLUGIN_TITLE + "###main-" + PLUGIN_META.ID, S_Enabled)) {
        RenderWindow();
    }
    UI::End();
}

void RenderMenu() {
    if (UI::MenuItem(PLUGIN_TITLE, "", S_Enabled)) {
        S_Enabled = !S_Enabled;
    }
}

void RenderWindow() {
    ;
}
