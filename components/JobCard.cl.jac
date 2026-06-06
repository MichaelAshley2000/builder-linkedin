def:pub JobCard(
    title: str,
    company: str,
    company_logo: str,
    location: str,
    job_type: str,
    posted_ago: str,
    applicants: int,
    salary: str
) -> JsxElement {
    has saved: bool = False;

    def handle_save(e: MouseEvent) {
        saved = not saved;
    }

    return <div className="bg-card rounded-xl border border-border shadow-sm p-4 hover:shadow-md transition-shadow">
        <div className="flex gap-3">
            <img
                src={company_logo}
                alt={company}
                className="w-12 h-12 rounded-lg bg-muted flex-shrink-0 p-1"
            />
            <div className="flex-1 min-w-0">
                <h3 className="font-semibold text-primary text-sm hover:underline cursor-pointer">{title}</h3>
                <p className="text-sm text-card-foreground mt-0.5">{company}</p>
                <p className="text-xs text-muted-foreground mt-1 flex items-center gap-1">
                    <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 0 1 16 0Z"/><circle cx="12" cy="10" r="3"/></svg>
                    {location + " • " + job_type}
                </p>
                <div className="flex items-center gap-2 mt-2 flex-wrap">
                    <span className="text-xs font-medium text-success bg-success/10 px-2 py-0.5 rounded-full">{salary}</span>
                    <span className="text-xs text-muted-foreground">{"Posted " + posted_ago + " ago"}</span>
                    <span className="text-xs text-muted-foreground">{"• " + str(applicants) + " applicants"}</span>
                </div>
            </div>
            <button
                onClick={handle_save}
                className="text-muted-foreground hover:text-primary p-1 h-fit transition-colors flex-shrink-0"
            >
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill={("currentColor" if saved else "none")} stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"><path d="m19 21-7-4-7 4V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2v16z"/></svg>
            </button>
        </div>
    </div>;
}
