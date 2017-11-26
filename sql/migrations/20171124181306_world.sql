DROP PROCEDURE IF EXISTS add_migration;
delimiter ??
CREATE PROCEDURE `add_migration`()
BEGIN
DECLARE v INT DEFAULT 1;
SET v = (SELECT COUNT(*) FROM `migrations` WHERE `id`='20171124181306');
IF v=0 THEN
INSERT INTO `migrations` VALUES ('20171124181306');
-- Add your query below.

-- Disable Vaelan spawn
UPDATE `creature` SET `spawnFlags`=2 WHERE `guid`=42797;

-- Move infiltrator from y=-413.32 to y=-399.5 and kneel
UPDATE `creature` SET `position_x`=56.85, `position_y`=-399.5, `position_z`=64.35, `orientation`=3.14, `MovementType`=0 WHERE `guid`=42798;
REPLACE INTO `creature_addon` (`guid`,`patch`,`bytes1`) VALUES (42798, 0, 8);

-- Clean up old stuff
DELETE from `creature_ai_scripts` WHERE `creature_id`=10299;
DELETE FROM `creature_ai_texts` WHERE `entry` IN (-9, -10);
DELETE FROM `event_scripts` WHERE `id`=16037;

-- Trigger event script on LOS
REPLACE INTO `creature_ai_scripts` (`id`,`creature_id`,`event_type`,`event_inverse_phase_mask`,`event_chance`,
  `event_param1`,`event_param2`,`action1_type`,`action1_param1`,`action2_type`,`action2_param1`,`action2_param2`,`action3_type`,`action3_param1`,`comment`) VALUES
(1029901, 10299, 10, 0, 100, 1, 15, 50, 16037, 11, 16037, 6, 22, 1, 'Scarshield Infiltrator - Trigger Vaelan event on LOS'),
(1029902, 10299, 1, 1, 100, 2000, 2000, 36, 10296, 0, 0, 0, 0, 0, 'Scarshield Infiltrator - Morph into Vaelan (Phase 1)');

-- Event script
REPLACE INTO `event_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`comments`) VALUES
(16037, 0, 28, 0, 0, 0, 'Scarshield Infiltrator - Stand'),
(16037, 0, 15, 16037, 0, 0, 'Scarshield Infiltrator - Cast Mind Probe'),
(16037, 2, 35, 0, 0, 0, 'Scarshield Infiltrator - Face player'),
(16037, 4, 0, 0, 0, 5555, 'Scarshield Infiltrator - Say text 1'),
(16037, 4, 1, 1, 0, 0, 'Scarshield Infiltrator - Say emote 1'),
(16037, 10, 0, 0, 0, 5556, 'Scarshield Infiltrator - Say text 2'),
(16037, 10, 1, 1, 0, 0, 'Scarshield Infiltrator - Say emote 2');

-- End of migration.
END IF;
END??
delimiter ; 
CALL add_migration();
DROP PROCEDURE IF EXISTS add_migration;
