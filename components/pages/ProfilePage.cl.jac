sv import from ...services.linkedin {
    Profile,
    get_profile
}

def:pub ProfilePage() -> JsxElement {
    has profile: Profile | None = None;
    has loading: bool = True;
    has active_tab: str = "posts";

    async can with entry {
        profile = await get_profile();
        loading = False;
    }

    def set_tab_posts(e: MouseEvent) {
        active_tab = "posts";
    }

    def set_tab_about(e: MouseEvent) {
        active_tab = "about";
    }

    def set_tab_experience(e: MouseEvent) {
        active_tab = "experience";
    }

    def set_tab_skills(e: MouseEvent) {
        active_tab = "skills";
    }

    if loading {
        return <div className="flex items-center justify-center py-20">
            <div className="flex flex-col items-center gap-3">
                <div className="w-8 h-8 border-3 border-primary border-t-transparent rounded-full animate-spin" />
                <p className="text-sm text-muted-foreground">{"Loading profile..."}</p>
            </div>
        </div>;
    }

    if profile is None {
        return <div className="text-center py-20 text-muted-foreground">{"Profile not found"}</div>;
    }

    tab_cls = "px-4 py-3 text-sm font-semibold border-b-2 transition-colors cursor-pointer";
    active_cls = " border-primary text-primary";
    inactive_cls = " border-transparent text-muted-foreground hover:text-foreground";

    return <div className="max-w-4xl mx-auto">
        {#* Banner + Avatar *#}
        <div className="bg-card rounded-xl border border-border shadow-sm overflow-hidden">
            <div className="h-48 bg-gradient-to-r from-primary/80 to-secondary/80 relative">
                {if profile.banner {
                    <img src={profile.banner} alt="Banner" className="w-full h-full object-cover" />
                }}
            </div>
            <div className="px-6 pb-6 relative">
                <img
                    src={profile.avatar}
                    alt={profile.name}
                    className="w-32 h-32 rounded-full border-4 border-card bg-muted -mt-16 relative"
                />
                <div className="mt-3 flex flex-col sm:flex-row sm:items-start sm:justify-between gap-4">
                    <div>
                        <h1 className="text-2xl font-bold text-card-foreground">{profile.name}</h1>
                        <p className="text-sm text-muted-foreground mt-1 max-w-lg">{profile.headline}</p>
                        <p className="text-sm text-muted-foreground mt-2 flex items-center gap-1">
                            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 0 1 16 0Z"/><circle cx="12" cy="10" r="3"/></svg>
                            {profile.location}
                        </p>
                        <p className="text-sm text-primary font-semibold mt-1 cursor-pointer hover:underline">
                            {str(profile.connections) + " connections"}
                        </p>
                    </div>
                    <div className="flex gap-2 flex-shrink-0">
                        <button className="bg-primary text-primary-foreground px-6 py-2 rounded-full text-sm font-semibold hover:bg-primary/90 transition-colors">
                            {"Connect"}
                        </button>
                        <button className="border border-primary text-primary px-6 py-2 rounded-full text-sm font-semibold hover:bg-accent transition-colors">
                            {"Message"}
                        </button>
                        <button className="border border-border text-muted-foreground px-4 py-2 rounded-full text-sm font-semibold hover:bg-muted transition-colors">
                            {"More"}
                        </button>
                    </div>
                </div>
            </div>
        </div>

        {#* Tabs *#}
        <div className="bg-card rounded-xl border border-border shadow-sm mt-4 overflow-hidden">
            <div className="flex border-b border-border">
                <button onClick={set_tab_posts} className={tab_cls + (active_cls if active_tab == "posts" else inactive_cls)}>{"Posts"}</button>
                <button onClick={set_tab_about} className={tab_cls + (active_cls if active_tab == "about" else inactive_cls)}>{"About"}</button>
                <button onClick={set_tab_experience} className={tab_cls + (active_cls if active_tab == "experience" else inactive_cls)}>{"Experience"}</button>
                <button onClick={set_tab_skills} className={tab_cls + (active_cls if active_tab == "skills" else inactive_cls)}>{"Skills"}</button>
            </div>

            <div className="p-6">
                {if active_tab == "about" {
                    <div>
                        <h2 className="text-lg font-semibold text-card-foreground mb-3">{"About"}</h2>
                        <p className="text-sm text-muted-foreground leading-relaxed whitespace-pre-line">{profile.about}</p>
                    </div>
                }}

                {if active_tab == "experience" {
                    <div>
                        <h2 className="text-lg font-semibold text-card-foreground mb-4">{"Experience"}</h2>
                        <div className="flex flex-col gap-4">
                            {for (i, exp) in enumerate(profile.experience) {
                                <div key={str(i)} className="flex gap-3">
                                    <img src={exp["logo"]} alt={exp["company"]} className="w-12 h-12 rounded-lg bg-muted p-1 flex-shrink-0" />
                                    <div>
                                        <h3 className="font-semibold text-sm text-card-foreground">{exp["title"]}</h3>
                                        <p className="text-sm text-muted-foreground">{exp["company"]}</p>
                                        <p className="text-xs text-muted-foreground mt-0.5">{exp["duration"]}</p>
                                    </div>
                                </div>
                            }}
                        </div>
                    </div>
                }}

                {if active_tab == "skills" {
                    <div>
                        <h2 className="text-lg font-semibold text-card-foreground mb-4">{"Skills"}</h2>
                        <div className="flex flex-wrap gap-2">
                            {for (i, skill) in enumerate(profile.skills) {
                                <span key={str(i)} className="bg-accent text-accent-foreground px-3 py-1.5 rounded-full text-sm font-medium">
                                    {skill}
                                </span>
                            }}
                        </div>
                    </div>
                }}

                {if active_tab == "posts" {
                    <div className="text-center py-8">
                        <p className="text-4xl mb-3">{"📝"}</p>
                        <p className="text-sm text-muted-foreground">{"No posts yet. Share your thoughts with your network!"}</p>
                        <button className="mt-3 bg-primary text-primary-foreground px-6 py-2 rounded-full text-sm font-semibold hover:bg-primary/90 transition-colors">
                            {"Create a post"}
                        </button>
                    </div>
                }}
            </div>
        </div>
    </div>;
}
