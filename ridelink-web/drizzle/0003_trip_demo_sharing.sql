CREATE TABLE `trip_simulations` (`ride_id` text PRIMARY KEY NOT NULL, `stage` integer NOT NULL DEFAULT 0, `updated_at` text NOT NULL DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (`ride_id`) REFERENCES `rides`(`id`));
--> statement-breakpoint
CREATE TABLE `hidden_trips` (`user_id` text NOT NULL, `kind` text NOT NULL, `item_id` text NOT NULL, PRIMARY KEY (`user_id`,`kind`,`item_id`));
--> statement-breakpoint
CREATE TABLE `location_shares` (`id` text PRIMARY KEY NOT NULL, `owner_id` text NOT NULL, `token_hash` text NOT NULL UNIQUE, `expires_at` integer NOT NULL, `active` integer NOT NULL DEFAULT 1, `lat` real, `lng` real, `accuracy` real, `updated_at` integer);
