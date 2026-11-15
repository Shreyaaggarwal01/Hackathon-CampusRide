CREATE TRIGGER `notify_request_declined` AFTER UPDATE OF `status` ON `requests`
WHEN OLD.`status`='pending' AND NEW.`status`='declined'
BEGIN
  INSERT INTO `ride_notifications` (`recipient_id`,`event_type`,`actor_name`,`ride_id`)
  SELECT NEW.`rider_id`,'request_declined',r.`driver_name`,NEW.`ride_id` FROM `rides` r
  WHERE r.`id`=NEW.`ride_id` AND NOT EXISTS (SELECT 1 FROM `user_blocks` b WHERE (b.`blocker_id`=r.`driver_id` AND b.`blocked_id`=NEW.`rider_id`) OR (b.`blocker_id`=NEW.`rider_id` AND b.`blocked_id`=r.`driver_id`));
END;
--> statement-breakpoint
CREATE TRIGGER `notify_ride_full` AFTER UPDATE OF `status` ON `requests`
WHEN OLD.`status`='pending' AND NEW.`status`='accepted' AND
 (SELECT COALESCE(SUM(q.`seats`),0) FROM `requests` q WHERE q.`ride_id`=NEW.`ride_id` AND q.`status`='accepted') >= (SELECT `seats` FROM `rides` WHERE `id`=NEW.`ride_id`)
BEGIN
  INSERT INTO `ride_notifications` (`recipient_id`,`event_type`,`actor_name`,`ride_id`)
  SELECT r.`driver_id`,'ride_full_driver',NEW.`rider_name`,r.`id` FROM `rides` r WHERE r.`id`=NEW.`ride_id`;
  INSERT INTO `ride_notifications` (`recipient_id`,`event_type`,`actor_name`,`ride_id`)
  SELECT q.`rider_id`,CASE WHEN q.`status`='accepted' THEN 'ride_full_accepted' ELSE 'ride_full_pending' END,r.`driver_name`,r.`id`
  FROM `requests` q JOIN `rides` r ON r.`id`=q.`ride_id`
  WHERE q.`ride_id`=NEW.`ride_id` AND q.`status` IN ('pending','accepted')
  AND NOT EXISTS (SELECT 1 FROM `user_blocks` b WHERE (b.`blocker_id`=r.`driver_id` AND b.`blocked_id`=q.`rider_id`) OR (b.`blocker_id`=q.`rider_id` AND b.`blocked_id`=r.`driver_id`));
END;
