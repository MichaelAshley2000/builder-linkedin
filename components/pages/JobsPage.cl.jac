sv import from ...services.linkedin {
    Job,
    get_jobs
}
import from ..JobCard { JobCard }

def:pub JobsPage() -> JsxElement {
    has jobs: list[Job] = [];
    has loading: bool = True;
    has search_text: str = "";

    async can with entry {
        jobs = await get_jobs();
        loading = False;
    }

    def handle_search(e: ChangeEvent) {
        search_text = e.target.value;
    }

    if loading {
        return <div className="flex items-center justify-center py-20">
            <div className="flex flex-col items-center gap-3">
                <div className="w-8 h-8 border-3 border-primary border-t-transparent rounded-full animate-spin" />
                <p className="text-sm text-muted-foreground">{"Loading jobs..."}</p>
            </div>
        </div>;
    }

    filtered: list[Job] = [j for j in jobs if j is not None and (not search_text or search_text.lower() in j.title.lower() or search_text.lower() in j.company.lower())];

    return <div className="max-w-4xl mx-auto">
        {#* Search header *#}
        <div className="bg-card rounded-xl border border-border shadow-sm p-6 mb-6">
            <h1 className="text-xl font-bold text-card-foreground mb-1">{"Jobs"}</h1>
            <p className="text-sm text-muted-foreground mb-4">{"Find your next opportunity"}</p>
            <div className="flex gap-3">
                <div className="flex-1 relative">
                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.3-4.3"/></svg>
                    <input
                        type="text"
                        placeholder="Search by title, company, or keyword..."
                        value={search_text}
                        onChange={handle_search}
                        className="w-full bg-muted/50 border border-border rounded-lg pl-10 pr-4 py-2.5 text-sm text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-primary/30 focus:border-primary transition-all"
                    />
                </div>
            </div>

            {#* Quick filters *#}
            <div className="flex flex-wrap gap-2 mt-3">
                {for (i, filter_label) in enumerate(["Remote", "Full-time", "Engineering", "Design", "$150K+"]) {
                    <button key={str(i)} className="text-xs font-medium text-muted-foreground bg-muted hover:bg-accent hover:text-accent-foreground px-3 py-1.5 rounded-full transition-colors">
                        {filter_label}
                    </button>
                }}
            </div>
        </div>

        {#* Job stats *#}
        <div className="grid grid-cols-3 gap-4 mb-6">
            {for (i, stat) in enumerate([
                {"label": "Saved Jobs", "value": "14", "icon": "🔖"},
                {"label": "Applied", "value": "8", "icon": "📤"},
                {"label": "Interviews", "value": "3", "icon": "🎯"}
            ]) {
                <div key={str(i)} className="bg-card rounded-xl border border-border shadow-sm p-4 text-center">
                    <p className="text-2xl">{stat["icon"]}</p>
                    <p className="text-xl font-bold text-card-foreground mt-1">{stat["value"]}</p>
                    <p className="text-xs text-muted-foreground">{stat["label"]}</p>
                </div>
            }}
        </div>

        {#* Job listings *#}
        <div className="bg-card rounded-xl border border-border shadow-sm overflow-hidden">
            <div className="p-4 border-b border-border flex items-center justify-between">
                <h2 className="text-base font-semibold text-card-foreground">
                    {"Recommended for you"}
                </h2>
                <span className="text-xs text-muted-foreground">{str(len(filtered)) + " jobs"}</span>
            </div>
            <div className="divide-y divide-border">
                {if len(filtered) == 0 {
                    <div className="text-center py-12">
                        <p className="text-3xl mb-2">{"🔍"}</p>
                        <p className="text-sm text-muted-foreground">{"No jobs match your search"}</p>
                    </div>
                }}
                {for j in filtered {
                    if j is not None {
                        <div key={j.id} className="p-0">
                            <JobCard
                                title={j.title}
                                company={j.company}
                                company_logo={j.company_logo}
                                location={j.location}
                                job_type={j.job_type}
                                posted_ago={j.posted_ago}
                                applicants={j.applicants}
                                salary={j.salary}
                            />
                        </div>
                    }
                }}
            </div>
        </div>
    </div>;
}
