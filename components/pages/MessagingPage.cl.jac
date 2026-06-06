sv import from ...services.linkedin {
    Message,
    get_messages
}
import from ..MessageItem { MessageItem }

def:pub MessagingPage() -> JsxElement {
    has messages: list[Message] = [];
    has loading: bool = True;
    has active_id: str = "";
    has reply_text: str = "";

    async can with entry {
        messages = await get_messages();
        loading = False;
        if len(messages) > 0 {
            active_id = messages[0].id;
        }
    }

    def handle_reply(e: ChangeEvent) {
        reply_text = e.target.value;
    }

    if loading {
        return <div className="flex items-center justify-center py-20">
            <div className="flex flex-col items-center gap-3">
                <div className="w-8 h-8 border-3 border-primary border-t-transparent rounded-full animate-spin" />
                <p className="text-sm text-muted-foreground">{"Loading messages..."}</p>
            </div>
        </div>;
    }

    has_active: bool = False;
    a_name: str = "";
    a_avatar: str = "";
    a_message: str = "";
    a_time: str = "";
    for m in messages {
        if m is not None and m.id == active_id {
            has_active = True;
            a_name = m.sender_name;
            a_avatar = m.sender_avatar;
            a_message = m.last_message;
            a_time = m.time_ago;
        }
    }

    return <div className="max-w-5xl mx-auto">
        <div className="bg-card rounded-xl border border-border shadow-sm overflow-hidden" style={{"height": "calc(100vh - 140px)", "minHeight": "500px"}}>
            <div className="flex h-full">
                {#* Message list sidebar *#}
                <div className="w-full sm:w-80 border-r border-border flex flex-col flex-shrink-0">
                    <div className="p-4 border-b border-border">
                        <div className="flex items-center justify-between mb-3">
                            <h1 className="text-lg font-bold text-card-foreground">{"Messaging"}</h1>
                            <button className="text-muted-foreground hover:text-foreground p-1 rounded-full hover:bg-muted transition-colors">
                                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M12 20h9"/><path d="M16.376 3.622a1 1 0 0 1 3.002 3.002L7.368 18.635a2 2 0 0 1-.855.506l-2.872.838a.5.5 0 0 1-.62-.62l.838-2.872a2 2 0 0 1 .506-.854z"/></svg>
                            </button>
                        </div>
                        <input
                            type="text"
                            placeholder="Search messages..."
                            className="w-full bg-muted/50 border border-border rounded-lg px-3 py-2 text-sm text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-primary/30 focus:border-primary transition-all"
                        />
                    </div>
                    <div className="flex-1 overflow-y-auto">
                        {for msg in messages {
                            if msg is not None {
                                <MessageItem
                                    key={msg.id}
                                    sender_name={msg.sender_name}
                                    sender_avatar={msg.sender_avatar}
                                    last_message={msg.last_message}
                                    time_ago={msg.time_ago}
                                    unread={msg.unread}
                                    is_active={msg.id == active_id}
                                    onClick={lambda -> None { active_id = msg.id; }}
                                />
                            }
                        }}
                    </div>
                </div>

                {#* Chat area *#}
                <div className="flex-1 flex flex-col hidden sm:flex">
                    {if has_active {
                        <div className="p-4 border-b border-border flex items-center gap-3">
                            <img src={a_avatar} alt={a_name} className="w-10 h-10 rounded-full bg-muted" />
                            <div>
                                <h2 className="font-semibold text-sm text-card-foreground">{a_name}</h2>
                                <p className="text-xs text-muted-foreground">{"Active now"}</p>
                            </div>
                        </div>

                        <div className="flex-1 p-6 overflow-y-auto flex flex-col justify-end">
                            <div className="flex flex-col gap-4">
                                <div className="flex gap-3 max-w-md">
                                    <img src={a_avatar} alt={a_name} className="w-8 h-8 rounded-full bg-muted flex-shrink-0 mt-1" />
                                    <div className="bg-muted rounded-2xl rounded-tl-sm px-4 py-2.5">
                                        <p className="text-sm text-card-foreground">{a_message}</p>
                                        <p className="text-[10px] text-muted-foreground mt-1">{a_time}</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div className="p-4 border-t border-border">
                            <div className="flex items-center gap-2">
                                <button className="text-muted-foreground hover:text-foreground p-2 rounded-full hover:bg-muted transition-colors flex-shrink-0">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="m21.44 11.05-9.19 9.19a6 6 0 0 1-8.49-8.49l8.57-8.57A4 4 0 1 1 18 8.84l-8.59 8.57a2 2 0 0 1-2.83-2.83l8.49-8.48"/></svg>
                                </button>
                                <input
                                    type="text"
                                    placeholder="Write a message..."
                                    value={reply_text}
                                    onChange={handle_reply}
                                    className="flex-1 bg-muted/50 border border-border rounded-full px-4 py-2.5 text-sm text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-primary/30 focus:border-primary transition-all"
                                />
                                <button className="bg-primary text-primary-foreground p-2.5 rounded-full hover:bg-primary/90 transition-colors flex-shrink-0">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M14.536 21.686a.5.5 0 0 0 .937-.024l6.5-19a.496.496 0 0 0-.635-.635l-19 6.5a.5.5 0 0 0-.024.937l7.93 3.18a2 2 0 0 1 1.112 1.11z"/><path d="m21.854 2.147-10.94 10.939"/></svg>
                                </button>
                            </div>
                        </div>
                    }}

                    {if not has_active {
                        <div className="flex-1 flex items-center justify-center">
                            <div className="text-center">
                                <p className="text-5xl mb-3">{"💬"}</p>
                                <p className="text-sm text-muted-foreground">{"Select a conversation to start messaging"}</p>
                            </div>
                        </div>
                    }}
                </div>
            </div>
        </div>
    </div>;
}
