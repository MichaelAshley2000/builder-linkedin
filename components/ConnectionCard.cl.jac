def:pub ConnectionCard(
    name: str,
    headline: str,
    avatar: str,
    mutual: int
) -> JsxElement {
    has connected: bool = False;

    def handle_connect(e: MouseEvent) {
        connected = not connected;
    }

    btn_cls = "bg-muted text-muted-foreground hover:bg-muted/80" if connected else "border-2 border-primary text-primary hover:bg-accent";

    return <div className="bg-card rounded-xl border border-border shadow-sm overflow-hidden flex flex-col items-center text-center">
        {#* Banner *#}
        <div className="w-full h-16 bg-gradient-to-br from-primary/20 to-accent relative">
            <img
                src={avatar}
                alt={name}
                className="w-20 h-20 rounded-full border-3 border-card bg-muted absolute left-1/2 -translate-x-1/2 -bottom-10"
            />
        </div>

        {#* Info *#}
        <div className="pt-12 px-4 pb-2 flex flex-col items-center">
            <h3 className="font-semibold text-card-foreground text-sm">{name}</h3>
            <p className="text-xs text-muted-foreground mt-1 line-clamp-2 min-h-[2rem]">{headline}</p>
            <p className="text-xs text-muted-foreground mt-2 flex items-center gap-1">
                <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
                {str(mutual) + " mutual connections"}
            </p>
        </div>

        {#* Connect button *#}
        <div className="px-4 pb-4 w-full">
            <button
                onClick={handle_connect}
                className={"w-full py-1.5 px-4 rounded-full text-sm font-semibold transition-all " + btn_cls}
            >
                {"✓ Connected" if connected else "+ Connect"}
            </button>
        </div>
    </div>;
}
