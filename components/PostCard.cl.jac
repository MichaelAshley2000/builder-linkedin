def:pub PostCard(
    author_name: str,
    author_headline: str,
    author_avatar: str,
    content: str,
    image: str,
    likes: int,
    comments: int,
    reposts: int,
    time_ago: str,
    onLike: Callable[[], None] | None = None
) -> JsxElement {
    has liked: bool = False;
    has like_count: int = likes;

    def handle_like(e: MouseEvent) {
        if not liked {
            liked = True;
            like_count = like_count + 1;
        } else {
            liked = False;
            like_count = like_count - 1;
        }
        if onLike {
            onLike();
        }
    }

    like_icon_color = "text-primary" if liked else "text-muted-foreground";

    return <article className="bg-card rounded-xl border border-border shadow-sm overflow-hidden">
        {#* Author header *#}
        <div className="p-4 pb-0">
            <div className="flex items-start gap-3">
                <img
                    src={author_avatar}
                    alt={author_name}
                    className="w-12 h-12 rounded-full bg-muted flex-shrink-0"
                />
                <div className="flex-1 min-w-0">
                    <h3 className="font-semibold text-card-foreground text-sm leading-tight">{author_name}</h3>
                    <p className="text-xs text-muted-foreground mt-0.5 truncate">{author_headline}</p>
                    <p className="text-xs text-muted-foreground mt-0.5">{time_ago + " • 🌐"}</p>
                </div>
                <button className="text-muted-foreground hover:text-foreground p-1 rounded-full hover:bg-muted transition-colors">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="12" r="1"/><circle cx="19" cy="12" r="1"/><circle cx="5" cy="12" r="1"/></svg>
                </button>
            </div>
        </div>

        {#* Content *#}
        <div className="px-4 py-3">
            <p className="text-sm text-card-foreground whitespace-pre-line leading-relaxed">{content}</p>
        </div>

        {#* Image *#}
        {if image {
            <img src={image} alt="Post image" className="w-full max-h-96 object-cover" />
        }}

        {#* Engagement stats *#}
        <div className="px-4 py-2 flex items-center justify-between text-xs text-muted-foreground border-b border-border">
            <span className="flex items-center gap-1">
                <span className="flex -space-x-1">
                    <span className="w-4 h-4 rounded-full bg-primary flex items-center justify-center text-[8px] text-primary-foreground">{"👍"}</span>
                    <span className="w-4 h-4 rounded-full bg-red-500 flex items-center justify-center text-[8px] text-white">{"❤️"}</span>
                </span>
                <span className="ml-1">{str(like_count)}</span>
            </span>
            <div className="flex gap-3">
                <span>{str(comments) + " comments"}</span>
                <span>{str(reposts) + " reposts"}</span>
            </div>
        </div>

        {#* Action buttons *#}
        <div className="px-2 py-1 flex items-center justify-around">
            <button
                onClick={handle_like}
                className={"flex items-center gap-2 px-4 py-2.5 rounded-lg hover:bg-muted transition-colors text-sm font-medium " + like_icon_color}
            >
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill={("currentColor" if liked else "none")} stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"><path d="M7 10v12"/><path d="M15 5.88 14 10h5.83a2 2 0 0 1 1.92 2.56l-2.33 8A2 2 0 0 1 17.5 22H4a2 2 0 0 1-2-2v-8a2 2 0 0 1 2-2h2.76a2 2 0 0 0 1.79-1.11L12 2a3.13 3.13 0 0 1 3 3.88Z"/></svg>
                {"Like"}
            </button>
            <button className="flex items-center gap-2 px-4 py-2.5 rounded-lg hover:bg-muted transition-colors text-sm font-medium text-muted-foreground">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>
                {"Comment"}
            </button>
            <button className="flex items-center gap-2 px-4 py-2.5 rounded-lg hover:bg-muted transition-colors text-sm font-medium text-muted-foreground">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"><path d="m17 2 4 4-4 4"/><path d="M3 11v-1a4 4 0 0 1 4-4h14"/><path d="m7 22-4-4 4-4"/><path d="M21 13v1a4 4 0 0 1-4 4H3"/></svg>
                {"Repost"}
            </button>
            <button className="flex items-center gap-2 px-4 py-2.5 rounded-lg hover:bg-muted transition-colors text-sm font-medium text-muted-foreground">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"><path d="M4 12v8a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-8"/><polyline points="16 6 12 2 8 6"/><line x1="12" x2="12" y1="2" y2="15"/></svg>
                {"Send"}
            </button>
        </div>
    </article>;
}
