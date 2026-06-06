import from services.linkedin {
    Profile, Post, Connection, Job, Message,
    get_profile, get_feed, get_connections, get_jobs, get_messages, like_post
}

cl {
    import ".styles.global.css";
    import from .components.Layout { Layout }

    def:pub app() -> JsxElement {
        return <Layout />;
    }
}
