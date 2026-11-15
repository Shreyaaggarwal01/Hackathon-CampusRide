ALTER TABLE `requests` ADD `demo_payment_method` text NOT NULL DEFAULT '';
--> statement-breakpoint
ALTER TABLE `requests` ADD `demo_payment_status` text NOT NULL DEFAULT 'not_set';
