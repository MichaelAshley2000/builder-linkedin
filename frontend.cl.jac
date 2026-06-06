cl import ".styles.global.css";

glob BUILD_PROMPT: str = "Build a modernized linkedin app";


cl def:pub app() -> JsxElement {
    sentinel = "__JAC_BUILDER" + "_BUILD_PROMPT__";
    hasPrompt = BUILD_PROMPT != sentinel;
    inner = (
        <div className="flex flex-col items-center gap-7 max-w-xl text-center">
            <div className="flex items-center gap-2.5">
                <span className="inline-block w-2 h-2 rounded-full bg-orange-400 animate-pulse" />
                <span className="text-[11px] uppercase tracking-[0.22em] text-muted-foreground font-medium">
                    {"jac builder"}
                </span>
            </div>
            <h1 className="text-3xl sm:text-4xl font-semibold leading-tight tracking-tight">
                {"Cooking your app"}
                <span className="text-orange-400 animate-pulse">{"…"}</span>
            </h1>
            <blockquote className="border-l-2 border-orange-400/40 pl-4 py-2 text-base sm:text-lg text-muted-foreground italic text-left w-full max-h-40 line-clamp-4 overflow-hidden">
                {BUILD_PROMPT}
            </blockquote>
            <p className="text-xs text-muted-foreground/70 tracking-wide max-w-md leading-relaxed">
                {"Hang tight — JacCoder is wiring this up. The preview refreshes the moment files land."}
            </p>
        </div>
        if hasPrompt
        else
        <div className="text-center max-w-2xl flex flex-col items-center gap-6">
            <div className="text-7xl select-none" role="img" aria-label="sparkles">
                {"✨"}
            </div>
            <p className="text-2xl sm:text-3xl font-medium leading-snug text-foreground">
                {"When you start to build, changes will appear here."}
            </p>
        </div>
    );
    return <div className="w-full min-h-screen flex items-center justify-center bg-background text-foreground p-8">
        {inner}
    </div>;
}
