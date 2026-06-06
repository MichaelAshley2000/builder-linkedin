# Project: Modernized LinkedIn App
## Status: DONE
## Plan
1. [x] Update global.css with LinkedIn-inspired theme
2. [x] Create services/linkedin.sv.jac with mock data endpoints
3. [x] Create leaf components (PostCard, ProfileCard, ConnectionCard, JobCard, MessageItem)
4. [x] Create pages (FeedPage, ProfilePage, NetworkPage, JobsPage, MessagingPage)
5. [x] Create Layout with navigation bar and routing
6. [x] Wire up main.jac with routing
7. [x] Validate and test - all pages render correctly
8. [x] Template cleanup - no unused files
## Files
- styles/global.css — LinkedIn blue theme tokens
- services/linkedin.sv.jac — Backend with mock profiles, posts, connections, jobs, messages
- components/PostCard.cl.jac — Post card with like/comment/repost/send actions
- components/ProfileCard.cl.jac — Profile sidebar card with avatar, banner, stats
- components/ConnectionCard.cl.jac — Connection suggestion card with connect button
- components/JobCard.cl.jac — Job listing card with save bookmark
- components/MessageItem.cl.jac — Message thread item with unread indicator
- components/Layout.cl.jac — App shell with navbar, routing, search
- components/pages/FeedPage.cl.jac — Home feed with posts, profile sidebar, news
- components/pages/ProfilePage.cl.jac — Profile with tabs (Posts/About/Experience/Skills)
- components/pages/NetworkPage.cl.jac — Network stats, invitations, people suggestions
- components/pages/JobsPage.cl.jac — Job search with filters and listings
- components/pages/MessagingPage.cl.jac — Split-pane messaging interface
- main.jac — Entry point registering all endpoints and mounting Layout
## Learnings
- `to` is a Jac keyword - escape with backtick: `to
- useLocation() returns dict-like - use ["pathname"] not .pathname
- Type narrowing doesn't work in JSX slots - extract to typed locals
