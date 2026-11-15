CREATE TABLE `messages` (`id` text PRIMARY KEY NOT NULL, `request_id` text NOT NULL, `sender_id` text NOT NULL, `body` text NOT NULL, `created_at` text NOT NULL DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (`request_id`) REFERENCES `requests`(`id`));
--> statement-breakpoint
CREATE INDEX `messages_request_time` ON `messages` (`request_id`, `created_at`);
--> statement-breakpoint
CREATE TABLE `reviews` (`id` text PRIMARY KEY NOT NULL, `request_id` text NOT NULL, `author_id` text NOT NULL, `target_id` text NOT NULL, `rating` integer NOT NULL, `body` text NOT NULL, `created_at` text NOT NULL DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (`request_id`) REFERENCES `requests`(`id`));
--> statement-breakpoint
CREATE UNIQUE INDEX `reviews_one_per_author` ON `reviews` (`request_id`, `author_id`);
--> statement-breakpoint
CREATE INDEX `reviews_target` ON `reviews` (`target_id`);
--> statement-breakpoint
ALTER TABLE `rides` ADD `radius` integer NOT NULL DEFAULT 10;
--> statement-breakpoint
ALTER TABLE `requests` ADD `pickup` text NOT NULL DEFAULT '';
