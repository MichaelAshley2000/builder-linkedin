def:pub MessageItem(
    sender_name: str,
    sender_avatar: str,
    last_message: str,
    time_ago: str,
    unread: bool,
    is_active: bool = False,
    onClick: Callable[[], None] | None = None
) -> JsxElement {
    def handle_click(e: MouseEvent) {
        if onClick {
            onClick();
        }
    }

    bg_cls = "bg-accent" if is_active else ("bg-card hover:bg-muted/50" if not unread else "bg-accent/30 hover:bg-accent/50");

    return <button
        onClick={handle_click}
        className={"w-full flex items-center gap-3 p-3 transition-colors text-left border-b border-border " + bg_cls}
    >
        <div className="relative flex-shrink-0">
            <img
                src={sender_avatar}
                alt={sender_name}
                className="w-12 h-12 rounded-full bg-muted"
            />
            {if unread {
                <span className="absolute top-0 right-0 w-3 h-3 bg-primary rounded-full border-2 border-card" />
            }}
        </div>
        <div className="flex-1 min-w-0">
            <div className="flex items-center justify-between">
                <h4 className={"text-sm " + ("font-semibold text-card-foreground" if unread else "font-medium text-card-foreground")}>{sender_name}</h4>
                <span className={"text-xs flex-shrink-0 " + ("text-primary font-medium" if unread else "text-muted-foreground")}>{time_ago}</span>
            </div>
            <p className={"text-xs mt-0.5 truncate " + ("text-card-foreground" if unread else "text-muted-foreground")}>{last_message}</p>
        </div>
    </button>;
}
