def:pub ProfileCard(
    name: str,
    headline: str,
    avatar: str,
    banner: str,
    connections: int,
    location: str
) -> JsxElement {
    return <div className="bg-card rounded-xl border border-border shadow-sm overflow-hidden">
        {#* Banner *#}
        <div className="h-16 bg-gradient-to-r from-primary/80 to-secondary/80 relative">
            {if banner {
                <img src={banner} alt="Banner" className="w-full h-full object-cover" />
            }}
        </div>

        {#* Avatar *#}
        <div className="px-4 -mt-8 relative">
            <img
                src={avatar}
                alt={name}
                className="w-16 h-16 rounded-full border-2 border-card bg-muted"
            />
        </div>

        {#* Info *#}
        <div className="p-4 pt-2">
            <h2 className="font-semibold text-card-foreground text-base">{name}</h2>
            <p className="text-xs text-muted-foreground mt-0.5 line-clamp-2">{headline}</p>
            <p className="text-xs text-muted-foreground mt-2 flex items-center gap-1">
                <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 0 1 16 0Z"/><circle cx="12" cy="10" r="3"/></svg>
                {location}
            </p>
        </div>

        {#* Stats *#}
        <div className="border-t border-border px-4 py-3">
            <div className="flex items-center justify-between text-xs">
                <span className="text-muted-foreground">{"Connections"}</span>
                <span className="text-primary font-semibold">{str(connections)}</span>
            </div>
        </div>

        {#* View Profile *#}
        <div className="border-t border-border px-4 py-2.5">
            <button className="w-full text-xs text-primary font-semibold hover:bg-accent rounded-md py-1.5 transition-colors">
                {"View Profile"}
            </button>
        </div>
    </div>;
}
