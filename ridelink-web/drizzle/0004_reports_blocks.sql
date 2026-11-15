CREATE TABLE `user_blocks` (`blocker_id` text NOT NULL, `blocked_id` text NOT NULL, `created_at` text NOT NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY (`blocker_id`,`blocked_id`));
--> statement-breakpoint
CREATE TABLE `user_reports` (`id` text PRIMARY KEY NOT NULL, `request_id` text NOT NULL, `reporter_id` text NOT NULL, `reported_id` text NOT NULL, `reason` text NOT NULL, `created_at` text NOT NULL DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (`request_id`) REFERENCES `requests`(`id`));
--> statement-breakpoint
ALTER TABLE `requests` ADD `extra_miles` real NOT NULL DEFAULT 0;
--> statement-breakpoint
ALTER TABLE `requests` ADD `extra_fee` integer NOT NULL DEFAULT 0;
