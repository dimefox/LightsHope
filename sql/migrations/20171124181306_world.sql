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

-- Move infiltrator from y=-413.32 to y=-399.5 and MovementType=2
UPDATE `creature` SET `position_x`=56.85, `position_y`=-399.5, `position_z`=64.35, `orientation`=3.2, `MovementType`=2 WHERE `guid`=42798;

-- Add a single waypoint script to change facing
REPLACE INTO `creature_movement` (`id`,`point`,`position_x`,`position_y`,`position_z`, `script_id`) VALUES (42798, 1, 56.85, -399.5, 64.35, 42798);
DELETE FROM `creature_movement_scripts` WHERE `id`=42798;
REPLACE INTO `creature_movement_scripts` (`id`,`command`,`datalong`, `o`, `comments`) VALUES
(42798, 35, 1, 6.1, 'Scarshield Infiltrator - Set Orientation'),
(42798, 20, 0, 0,   'Scarshield Infiltrator - Stop Waypoint Movement');

-- Redo events
DELETE from `creature_ai_scripts` WHERE `creature_id`=10299;

-- Kneel, idle and set phase 1 on spawn
REPLACE INTO `creature_ai_scripts` (`id`,`creature_id`,`event_type`,`event_inverse_phase_mask`,`event_chance`,
  `event_param1`,`event_param2`,`action1_type`,`action1_param1`,`action2_type`,`action2_param1`,`action3_type`,`action3_param1`,`comment`) VALUES
(1029901, 10299, 11, 0, 100, 0, 0, 22, 1, 47, 8, 48, 0, 'Scarshield Infiltrator - Kneel, idle and set phase 1 on spawn');

-- Stand, cast and set phase 2 on LOS
REPLACE INTO `creature_ai_scripts` (`id`,`creature_id`,`event_type`,`event_inverse_phase_mask`,`event_chance`,
  `event_param1`,`event_param2`,`action1_type`,`action1_param1`,`action2_type`,`action2_param1`,`action2_param2`,`action3_type`,`action3_param1`,`comment`) VALUES
(1029902, 10299, 10, 5, 100, 1, 15, 47, 0, 11, 16037, 6, 23, 1, 'Scarshield Infiltrator - Stand, cast Mind Probe and set phase 2 on LOS (Phase 1)');

-- Morph and enable waypoint
REPLACE INTO `creature_ai_scripts` (`id`,`creature_id`,`event_type`,`event_inverse_phase_mask`,`event_chance`,
  `event_param1`,`event_param2`,`action1_type`,`action1_param1`,`action2_type`,`action2_param1`,`comment`) VALUES
(1029903, 10299, 1, 3, 100, 2000, 2000, 36, 10296, 48, 2, 'Scarshield Infiltrator - Morph into Vaelan and enable waypoint (Phase 2)');

-- Talking
REPLACE INTO `creature_ai_scripts` (`id`,`creature_id`,`event_type`,`event_inverse_phase_mask`,`event_chance`,
  `event_param1`,`event_param2`,`action1_type`,`action1_param1`,`action2_type`,`action2_param1`,`comment`) VALUES
(1029904, 10299, 1, 3, 100, 4000, 4000, 1, -9, 5, 1,  'Scarshield Infiltrator - Speech part 1 (Phase 2)'),
(1029905, 10299, 1, 3, 100, 10000, 10000, 1, -10, 5, 1, 'Scarshield Infiltrator - Speech part 2 (Phase 2)');

-- End of migration.
END IF;
END??
delimiter ; 
CALL add_migration();
DROP PROCEDURE IF EXISTS add_migration;
