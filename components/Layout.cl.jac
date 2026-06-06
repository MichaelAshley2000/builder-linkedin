import from "@jac/runtime" { Router, Routes, Route, Navigate, Link, useLocation }
import from .pages.FeedPage { FeedPage }
import from .pages.ProfilePage { ProfilePage }
import from .pages.NetworkPage { NetworkPage }
import from .pages.JobsPage { JobsPage }
import from .pages.MessagingPage { MessagingPage }

def:pub NavItem(`to: str, label: str, icon: JsxElement, active: bool, badge: int = 0) -> JsxElement {
    base_cls = "flex flex-col items-center gap-0.5 px-3 py-1.5 rounded-md transition-colors relative min-w-[60px]";
    active_cls = " text-foreground" if active else " text-muted-foreground hover:text-foreground";

    return <Link to={`to} className={base_cls + active_cls}>
        <div className="relative">
            {icon}
            {if badge > 0 {
                <span className="absolute -top-1 -right-2 bg-destructive text-white text-[9px] font-bold rounded-full w-4 h-4 flex items-center justify-center">
                    {str(badge)}
                </span>
            }}
        </div>
        <span className="text-[10px] font-medium">{label}</span>
        {if active {
            <span className="absolute bottom-0 left-2 right-2 h-0.5 bg-foreground rounded-full" />
        }}
    </Link>;
}

def:pub NavBar() -> JsxElement {
    loc = useLocation();
    path = loc["pathname"];

    home_icon = <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"><path d="M15 21v-8a1 1 0 0 0-1-1h-4a1 1 0 0 0-1 1v8"/><path d="M3 10a2 2 0 0 1 .709-1.528l7-5.999a2 2 0 0 1 2.582 0l7 5.999A2 2 0 0 1 21 10v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/></svg>;
    network_icon = <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>;
    jobs_icon = <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"><path d="M16 20V4a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"/><rect width="20" height="14" x="2" y="6" rx="2"/></svg>;
    msg_icon = <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>;
    profile_icon = <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="8" r="5"/><path d="M20 21a8 8 0 0 0-16 0"/></svg>;

    return <header className="bg-card border-b border-border sticky top-0 z-50 shadow-sm">
        <div className="max-w-6xl mx-auto px-4 flex items-center justify-between h-14">
            {#* Logo + Search *#}
            <div className="flex items-center gap-3">
                <div className="flex items-center gap-1.5">
                    <div className="w-8 h-8 bg-primary rounded-md flex items-center justify-center">
                        <span className="text-primary-foreground font-bold text-lg">{"in"}</span>
                    </div>
                </div>
                <div className="hidden sm:block relative">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.3-4.3"/></svg>
                    <input
                        type="text"
                        placeholder="Search"
                        className="bg-muted border-none rounded-md pl-9 pr-4 py-2 text-sm w-56 focus:outline-none focus:ring-2 focus:ring-primary/30 placeholder:text-muted-foreground text-foreground"
                    />
                </div>
            </div>

            {#* Nav items *#}
            <nav className="flex items-center gap-1">
                <NavItem to="/feed" label="Home" icon={home_icon} active={path == "/feed"} />
                <NavItem to="/network" label="Network" icon={network_icon} active={path == "/network"} badge={3} />
                <NavItem to="/jobs" label="Jobs" icon={jobs_icon} active={path == "/jobs"} />
                <NavItem to="/messaging" label="Messaging" icon={msg_icon} active={path == "/messaging"} badge={2} />
                <NavItem to="/profile" label="Me" icon={profile_icon} active={path == "/profile"} />
            </nav>
        </div>
    </header>;
}

def:pub Layout() -> JsxElement {
    return <Router>
        <div className="min-h-screen bg-background">
            <NavBar />
            <main className="px-4 py-6">
                <Routes>
                    <Route path="/" element={<Navigate to="/feed" replace={True} />} />
                    <Route path="/feed" element={<FeedPage />} />
                    <Route path="/profile" element={<ProfilePage />} />
                    <Route path="/network" element={<NetworkPage />} />
                    <Route path="/jobs" element={<JobsPage />} />
                    <Route path="/messaging" element={<MessagingPage />} />
                </Routes>
            </main>
        </div>
    </Router>;
}
