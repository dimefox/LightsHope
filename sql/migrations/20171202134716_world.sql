DROP PROCEDURE IF EXISTS add_migration;
delimiter ??
CREATE PROCEDURE `add_migration`()
BEGIN
DECLARE v INT DEFAULT 1;
SET v = (SELECT COUNT(*) FROM `migrations` WHERE `id`='20171202134716');
IF v=0 THEN
INSERT INTO `migrations` VALUES ('20171202134716');
-- Add your query below.

-- Two quests missing WPL category
UPDATE `quest_template` SET `ZoneOrSort`=28 WHERE `entry` IN (5504, 5524);

-- End of migration.
END IF;
END??
delimiter ; 
CALL add_migration();
DROP PROCEDURE IF EXISTS add_migration;
