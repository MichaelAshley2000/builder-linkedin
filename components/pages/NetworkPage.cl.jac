sv import from ...services.linkedin {
    Connection,
    get_connections
}
import from ..ConnectionCard { ConnectionCard }

def:pub NetworkPage() -> JsxElement {
    has connections: list[Connection] = [];
    has loading: bool = True;

    async can with entry {
        connections = await get_connections();
        loading = False;
    }

    if loading {
        return <div className="flex items-center justify-center py-20">
            <div className="flex flex-col items-center gap-3">
                <div className="w-8 h-8 border-3 border-primary border-t-transparent rounded-full animate-spin" />
                <p className="text-sm text-muted-foreground">{"Loading network..."}</p>
            </div>
        </div>;
    }

    return <div className="max-w-5xl mx-auto">
        {#* Header *#}
        <div className="bg-card rounded-xl border border-border shadow-sm p-6 mb-6">
            <h1 className="text-xl font-bold text-card-foreground">{"My Network"}</h1>
            <p className="text-sm text-muted-foreground mt-1">{"Manage your connections and discover new people"}</p>

            {#* Stats *#}
            <div className="grid grid-cols-2 sm:grid-cols-4 gap-4 mt-4">
                {for (i, stat) in enumerate([
                    {"label": "Connections", "value": "847", "icon": "👥"},
                    {"label": "Contacts", "value": "1.2K", "icon": "📇"},
                    {"label": "People Followed", "value": "156", "icon": "👤"},
                    {"label": "Groups", "value": "12", "icon": "🏢"}
                ]) {
                    <div key={str(i)} className="bg-muted/50 rounded-lg p-3 text-center">
                        <p className="text-2xl">{stat["icon"]}</p>
                        <p className="text-lg font-bold text-card-foreground mt-1">{stat["value"]}</p>
                        <p className="text-xs text-muted-foreground">{stat["label"]}</p>
                    </div>
                }}
            </div>
        </div>

        {#* Invitations *#}
        <div className="bg-card rounded-xl border border-border shadow-sm p-6 mb-6">
            <div className="flex items-center justify-between mb-4">
                <h2 className="text-base font-semibold text-card-foreground">{"Invitations"}</h2>
                <span className="text-xs text-muted-foreground bg-muted px-2 py-0.5 rounded-full">{"0 pending"}</span>
            </div>
            <div className="text-center py-6">
                <p className="text-3xl mb-2">{"📬"}</p>
                <p className="text-sm text-muted-foreground">{"No pending invitations"}</p>
            </div>
        </div>

        {#* People you may know *#}
        <div className="bg-card rounded-xl border border-border shadow-sm p-6">
            <div className="flex items-center justify-between mb-4">
                <h2 className="text-base font-semibold text-card-foreground">{"People you may know"}</h2>
                <button className="text-sm text-primary font-semibold hover:underline">{"See all"}</button>
            </div>
            <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
                {for c in connections {
                    if c is not None {
                        <ConnectionCard
                            key={c.id}
                            name={c.name}
                            headline={c.headline}
                            avatar={c.avatar}
                            mutual={c.mutual}
                        />
                    }
                }}
            </div>
        </div>
    </div>;
}
