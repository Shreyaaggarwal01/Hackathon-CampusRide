CREATE TABLE `account_profiles` (
  `user_id` text PRIMARY KEY NOT NULL,
  `profile_json` text NOT NULL,
  `updated_at` text NOT NULL DEFAULT CURRENT_TIMESTAMP
);
