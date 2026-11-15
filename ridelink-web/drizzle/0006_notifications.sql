CREATE TABLE `ride_notifications` (`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL, `recipient_id` text NOT NULL, `event_type` text NOT NULL, `actor_name` text NOT NULL, `ride_id` text NOT NULL, `created_at` text NOT NULL DEFAULT CURRENT_TIMESTAMP, `seen` integer NOT NULL DEFAULT 0);
--> statement-breakpoint
CREATE INDEX `ride_notifications_recipient` ON `ride_notifications` (`recipient_id`, `seen`, `id`);
--> statement-breakpoint
CREATE TABLE `message_reads` (`user_id` text NOT NULL, `peer_id` text NOT NULL, `last_seen_rowid` integer NOT NULL DEFAULT 0, PRIMARY KEY (`user_id`,`peer_id`));
--> statement-breakpoint
CREATE TRIGGER `notify_new_request` AFTER INSERT ON `requests` BEGIN INSERT INTO `ride_notifications` (`recipient_id`, `event_type`, `actor_name`, `ride_id`) SELECT `driver_id`, 'ride_requested', NEW.`rider_name`, NEW.`ride_id` FROM `rides` WHERE `id`=NEW.`ride_id`; END;
--> statement-breakpoint
CREATE TRIGGER `notify_request_accepted` AFTER UPDATE OF `status` ON `requests` WHEN NEW.`status`='accepted' AND OLD.`status`!='accepted' BEGIN INSERT INTO `ride_notifications` (`recipient_id`, `event_type`, `actor_name`, `ride_id`) SELECT NEW.`rider_id`, 'request_accepted', `driver_name`, NEW.`ride_id` FROM `rides` WHERE `id`=NEW.`ride_id`; END;
