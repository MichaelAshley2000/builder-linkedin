sv import from ...services.linkedin {
    Post, Profile,
    get_feed, get_profile
}
import from ..PostCard { PostCard }
import from ..ProfileCard { ProfileCard }

def:pub FeedPage() -> JsxElement {
    has posts: list[Post] = [];
    has profile: Profile | None = None;
    has loading: bool = True;
    has new_post_text: str = "";

    async can with entry {
        posts = await get_feed();
        profile = await get_profile();
        loading = False;
    }

    def handle_input(e: ChangeEvent) {
        new_post_text = e.target.value;
    }

    if loading {
        return <div className="flex items-center justify-center py-20">
            <div className="flex flex-col items-center gap-3">
                <div className="w-8 h-8 border-3 border-primary border-t-transparent rounded-full animate-spin" />
                <p className="text-sm text-muted-foreground">{"Loading feed..."}</p>
            </div>
        </div>;
    }

    return <div className="grid grid-cols-1 lg:grid-cols-12 gap-6 max-w-5xl mx-auto">
        {#* Left sidebar *#}
        <aside className="lg:col-span-3 hidden lg:block">
            {if profile is not None {
                <ProfileCard
                    name={profile.name}
                    headline={profile.headline}
                    avatar={profile.avatar}
                    banner={profile.banner}
                    connections={profile.connections}
                    location={profile.location}
                />
            }}

            {#* Quick links *#}
            <div className="bg-card rounded-xl border border-border shadow-sm mt-4 p-3">
                <div className="flex flex-col gap-1">
                    {for item in ["Saved items", "Groups", "Events", "Newsletters"] {
                        <button key={item} className="text-xs text-muted-foreground hover:text-primary hover:bg-accent px-2 py-1.5 rounded-md text-left transition-colors font-medium">
                            {item}
                        </button>
                    }}
                </div>
            </div>
        </aside>

        {#* Main feed *#}
        <main className="lg:col-span-6">
            {#* Create post *#}
            <div className="bg-card rounded-xl border border-border shadow-sm p-4 mb-4">
                <div className="flex items-center gap-3">
                    {if profile is not None {
                        <img src={profile.avatar} alt="You" className="w-12 h-12 rounded-full bg-muted flex-shrink-0" />
                    }}
                    <input
                        type="text"
                        placeholder="Start a post..."
                        value={new_post_text}
                        onChange={handle_input}
                        className="flex-1 bg-muted/50 border border-border rounded-full px-4 py-2.5 text-sm text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-primary/30 focus:border-primary transition-all"
                    />
                </div>
                <div className="flex items-center justify-around mt-3 pt-2 border-t border-border">
                    <button className="flex items-center gap-2 text-xs font-medium text-muted-foreground hover:bg-muted px-3 py-2 rounded-lg transition-colors">
                        <span className="text-primary">{"📷"}</span>
                        {"Media"}
                    </button>
                    <button className="flex items-center gap-2 text-xs font-medium text-muted-foreground hover:bg-muted px-3 py-2 rounded-lg transition-colors">
                        <span className="text-success">{"📅"}</span>
                        {"Event"}
                    </button>
                    <button className="flex items-center gap-2 text-xs font-medium text-muted-foreground hover:bg-muted px-3 py-2 rounded-lg transition-colors">
                        <span className="text-orange-500">{"📝"}</span>
                        {"Article"}
                    </button>
                </div>
            </div>

            {#* Sort bar *#}
            <div className="flex items-center gap-2 mb-4">
                <div className="flex-1 h-px bg-border" />
                <span className="text-xs text-muted-foreground">{"Sort by: "}</span>
                <button className="text-xs font-semibold text-foreground flex items-center gap-1">
                    {"Top"}
                    <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="m6 9 6 6 6-6"/></svg>
                </button>
            </div>

            {#* Posts *#}
            <div className="flex flex-col gap-3">
                {for p in posts {
                    if p is not None {
                        <PostCard
                            key={p.id}
                            author_name={p.author_name}
                            author_headline={p.author_headline}
                            author_avatar={p.author_avatar}
                            content={p.content}
                            image={p.image}
                            likes={p.likes}
                            comments={p.comments}
                            reposts={p.reposts}
                            time_ago={p.time_ago}
                        />
                    }
                }}
            </div>
        </main>

        {#* Right sidebar *#}
        <aside className="lg:col-span-3 hidden lg:block">
            <div className="bg-card rounded-xl border border-border shadow-sm p-4">
                <h3 className="font-semibold text-sm text-card-foreground mb-3">{"LinkedIn News"}</h3>
                <div className="flex flex-col gap-2.5">
                    {for (i, news) in enumerate([
                        "Tech layoffs slow as AI hiring surges",
                        "Remote work policies evolving in 2026",
                        "Startup funding hits new quarterly high",
                        "Skills-based hiring on the rise",
                        "Green tech jobs growing 3x faster"
                    ]) {
                        <div key={str(i)} className="group cursor-pointer">
                            <div className="flex items-start gap-2">
                                <span className="text-xs text-muted-foreground mt-0.5">{"•"}</span>
                                <div>
                                    <p className="text-xs font-semibold text-card-foreground group-hover:text-primary transition-colors leading-tight">{news}</p>
                                    <p className="text-[10px] text-muted-foreground mt-0.5">{"2d ago • 1,234 readers"}</p>
                                </div>
                            </div>
                        </div>
                    }}
                </div>
            </div>

            {#* Footer *#}
            <div className="mt-4 px-2">
                <div className="flex flex-wrap gap-x-3 gap-y-1 text-[10px] text-muted-foreground">
                    {for link in ["About", "Accessibility", "Help Center", "Privacy", "Terms"] {
                        <a key={link} href="#" className="hover:text-primary hover:underline transition-colors">{link}</a>
                    }}
                </div>
                <p className="text-[10px] text-muted-foreground mt-2">{"LinkedIn Clone © 2026"}</p>
            </div>
        </aside>
    </div>;
}
