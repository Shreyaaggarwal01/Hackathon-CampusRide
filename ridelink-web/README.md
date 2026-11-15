# RideLink website

This folder contains the latest RideLink website source, separate from the earlier Expo mobile app in the repository root.

- `shared-worker/assets/`: website HTML, JavaScript, styles, and media.
- `shared-worker/worker.mjs`: server API for rides, requests, messages, reviews, and notifications.
- `drizzle/`: database migrations for the shared SQLite/D1 database.
- `dist/server/`: packaged worker used by the current hosted site. The worker bundles the website assets; edit the source in `shared-worker/` rather than the older standalone files in `dist/`.
- `shared-worker/test-worker.mjs`: server behavior tests, run from this folder with a recent Node.js version using `node shared-worker/test-worker.mjs`.

The hosted prototype depends on its hosting platform's authentication and D1 database. Payment and student/driver verification are not production integrations. Saving this code on GitHub does not change the deployed site or move its database.
