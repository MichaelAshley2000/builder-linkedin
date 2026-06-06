import from datetime { datetime }

obj Profile {
    has id: str;
    has name: str;
    has headline: str;
    has avatar: str;
    has banner: str;
    has location: str;
    has connections: int;
    has about: str;
    has experience: list[dict];
    has skills: list[str];
}

obj Post {
    has id: str;
    has author_name: str;
    has author_headline: str;
    has author_avatar: str;
    has content: str;
    has image: str;
    has likes: int;
    has comments: int;
    has reposts: int;
    has time_ago: str;
}

obj Connection {
    has id: str;
    has name: str;
    has headline: str;
    has avatar: str;
    has mutual: int;
}

obj Job {
    has id: str;
    has title: str;
    has company: str;
    has company_logo: str;
    has location: str;
    has job_type: str;
    has posted_ago: str;
    has applicants: int;
    has salary: str;
}

obj Message {
    has id: str;
    has sender_name: str;
    has sender_avatar: str;
    has last_message: str;
    has time_ago: str;
    has unread: bool;
}

def:pub get_profile() -> Profile {
    return Profile(
        id="1",
        name="James Bond",
        headline="Senior Software Engineer at TechCorp | Full-Stack Developer | Open Source Contributor",
        avatar="https://api.dicebear.com/9.x/avataaars/svg?seed=James",
        banner="https://images.unsplash.com/photo-1557683316-973673baf926?w=800&h=200&fit=crop",
        location="San Francisco Bay Area",
        connections=847,
        about="Passionate software engineer with 8+ years of experience building scalable web applications. I love working with modern technologies and contributing to open-source projects. Currently focused on distributed systems and cloud-native architectures.",
        experience=[
            {"title": "Senior Software Engineer", "company": "TechCorp", "duration": "2022 - Present", "logo": "https://api.dicebear.com/9.x/identicon/svg?seed=TechCorp"},
            {"title": "Software Engineer", "company": "InnovateLabs", "duration": "2019 - 2022", "logo": "https://api.dicebear.com/9.x/identicon/svg?seed=InnovateLabs"},
            {"title": "Junior Developer", "company": "StartupXYZ", "duration": "2017 - 2019", "logo": "https://api.dicebear.com/9.x/identicon/svg?seed=StartupXYZ"}
        ],
        skills=["Python", "TypeScript", "React", "Node.js", "AWS", "Docker", "Kubernetes", "GraphQL", "PostgreSQL", "Redis"]
    );
}

def:pub get_feed() -> list[Post] {
    return [
        Post(
            id="p1",
            author_name="Sarah Chen",
            author_headline="VP of Engineering at CloudScale",
            author_avatar="https://api.dicebear.com/9.x/avataaars/svg?seed=Sarah",
            content="Excited to announce that our team just shipped a major infrastructure upgrade! 🚀 We reduced latency by 40% and improved reliability to 99.99%. Proud of the incredible engineering team that made this possible. #Engineering #CloudComputing #TeamWork",
            image="https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=600&h=300&fit=crop",
            likes=234,
            comments=45,
            reposts=12,
            time_ago="2h"
        ),
        Post(
            id="p2",
            author_name="Marcus Williams",
            author_headline="AI Research Scientist at DeepMind",
            author_avatar="https://api.dicebear.com/9.x/avataaars/svg?seed=Marcus",
            content="Just published our latest paper on transformer architectures for multi-modal learning. The results are fascinating — we're seeing emergent capabilities that weren't present in single-modality models. Link in comments! 📄\n\n#AI #MachineLearning #Research",
            image="",
            likes=567,
            comments=89,
            reposts=34,
            time_ago="4h"
        ),
        Post(
            id="p3",
            author_name="Emily Rodriguez",
            author_headline="Product Designer at Figma",
            author_avatar="https://api.dicebear.com/9.x/avataaars/svg?seed=Emily",
            content="Design tip of the day: White space isn't empty space — it's breathing room for your content. The best interfaces give elements room to exist without competing for attention. Less clutter = more clarity. ✨\n\nWhat's your favorite design principle?",
            image="https://images.unsplash.com/photo-1561070791-2526d30994b5?w=600&h=300&fit=crop",
            likes=892,
            comments=156,
            reposts=67,
            time_ago="6h"
        ),
        Post(
            id="p4",
            author_name="David Park",
            author_headline="CTO at FinanceFlow | Ex-Google",
            author_avatar="https://api.dicebear.com/9.x/avataaars/svg?seed=David",
            content="Hot take: The best code is the code you don't write. Before adding a new feature, ask yourself:\n\n1. Does this solve a real user problem?\n2. Can we achieve this with existing tools?\n3. What's the maintenance cost?\n\nSimplicity scales. Complexity doesn't. 💡",
            image="",
            likes=1243,
            comments=201,
            reposts=89,
            time_ago="8h"
        ),
        Post(
            id="p5",
            author_name="Lisa Thompson",
            author_headline="Head of Talent at Stripe",
            author_avatar="https://api.dicebear.com/9.x/avataaars/svg?seed=Lisa",
            content="We're hiring! Looking for passionate engineers who want to build the future of financial infrastructure. Remote-friendly, competitive comp, and an amazing team. Check out our careers page. 🌟\n\n#Hiring #Engineering #Fintech #RemoteWork",
            image="https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=600&h=300&fit=crop",
            likes=445,
            comments=78,
            reposts=56,
            time_ago="12h"
        )
    ];
}

def:pub get_connections() -> list[Connection] {
    return [
        Connection(id="c1", name="Jennifer Liu", headline="Data Scientist at Netflix", avatar="https://api.dicebear.com/9.x/avataaars/svg?seed=Jennifer", mutual=12),
        Connection(id="c2", name="Ryan Mitchell", headline="DevOps Lead at Spotify", avatar="https://api.dicebear.com/9.x/avataaars/svg?seed=Ryan", mutual=8),
        Connection(id="c3", name="Priya Sharma", headline="Frontend Engineer at Meta", avatar="https://api.dicebear.com/9.x/avataaars/svg?seed=Priya", mutual=15),
        Connection(id="c4", name="James Wilson", headline="Startup Founder & CEO", avatar="https://api.dicebear.com/9.x/avataaars/svg?seed=James", mutual=5),
        Connection(id="c5", name="Maria Garcia", headline="UX Researcher at Apple", avatar="https://api.dicebear.com/9.x/avataaars/svg?seed=Maria", mutual=21),
        Connection(id="c6", name="Tom Anderson", headline="Cloud Architect at AWS", avatar="https://api.dicebear.com/9.x/avataaars/svg?seed=Tom", mutual=9),
        Connection(id="c7", name="Nina Patel", headline="Engineering Manager at Uber", avatar="https://api.dicebear.com/9.x/avataaars/svg?seed=Nina", mutual=17),
        Connection(id="c8", name="Chris Lee", headline="Blockchain Developer", avatar="https://api.dicebear.com/9.x/avataaars/svg?seed=Chris", mutual=3)
    ];
}

def:pub get_jobs() -> list[Job] {
    return [
        Job(id="j1", title="Senior Frontend Engineer", company="Google", company_logo="https://api.dicebear.com/9.x/identicon/svg?seed=Google", location="Mountain View, CA", job_type="Full-time", posted_ago="1d", applicants=142, salary="$180K - $250K"),
        Job(id="j2", title="Staff Software Engineer", company="Stripe", company_logo="https://api.dicebear.com/9.x/identicon/svg?seed=Stripe", location="Remote", job_type="Full-time", posted_ago="2d", applicants=89, salary="$200K - $300K"),
        Job(id="j3", title="Machine Learning Engineer", company="OpenAI", company_logo="https://api.dicebear.com/9.x/identicon/svg?seed=OpenAI", location="San Francisco, CA", job_type="Full-time", posted_ago="3d", applicants=256, salary="$220K - $350K"),
        Job(id="j4", title="Product Designer", company="Figma", company_logo="https://api.dicebear.com/9.x/identicon/svg?seed=Figma", location="New York, NY", job_type="Full-time", posted_ago="1w", applicants=67, salary="$150K - $200K"),
        Job(id="j5", title="DevOps Engineer", company="Netflix", company_logo="https://api.dicebear.com/9.x/identicon/svg?seed=Netflix", location="Los Gatos, CA", job_type="Full-time", posted_ago="4d", applicants=103, salary="$170K - $240K"),
        Job(id="j6", title="Backend Engineer", company="Airbnb", company_logo="https://api.dicebear.com/9.x/identicon/svg?seed=Airbnb", location="Remote", job_type="Full-time", posted_ago="5d", applicants=178, salary="$160K - $230K")
    ];
}

def:pub get_messages() -> list[Message] {
    return [
        Message(id="m1", sender_name="Sarah Chen", sender_avatar="https://api.dicebear.com/9.x/avataaars/svg?seed=Sarah", last_message="Hey! Would love to chat about the infrastructure project you mentioned.", time_ago="10m", unread=True),
        Message(id="m2", sender_name="Marcus Williams", sender_avatar="https://api.dicebear.com/9.x/avataaars/svg?seed=Marcus", last_message="Thanks for sharing that article! Really insightful perspective on AI.", time_ago="1h", unread=True),
        Message(id="m3", sender_name="Emily Rodriguez", sender_avatar="https://api.dicebear.com/9.x/avataaars/svg?seed=Emily", last_message="The design review is scheduled for Thursday at 2pm. See you there!", time_ago="3h", unread=False),
        Message(id="m4", sender_name="David Park", sender_avatar="https://api.dicebear.com/9.x/avataaars/svg?seed=David", last_message="Great meeting today. Let's follow up next week on the architecture proposal.", time_ago="1d", unread=False),
        Message(id="m5", sender_name="Lisa Thompson", sender_avatar="https://api.dicebear.com/9.x/avataaars/svg?seed=Lisa", last_message="I'd love to discuss the open role with you. Are you available for a quick call?", time_ago="2d", unread=False)
    ];
}

def:pub like_post(post_id: str) -> bool {
    return True;
}
