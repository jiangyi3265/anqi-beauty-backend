-- Add the income rules menu without replacing existing menus or granting access to other roles.
SET NAMES utf8mb4;
START TRANSACTION;
SET @parent_id = (SELECT menu_id FROM sys_menu WHERE path='anqi' AND parent_id=0 LIMIT 1);
SET @earnings_id = (SELECT menu_id FROM sys_menu WHERE perms='anqi:earnings:list' LIMIT 1);
SET @earnings_id = COALESCE(@earnings_id, (SELECT GREATEST(COALESCE(MAX(menu_id),3299)+1,3300) FROM sys_menu));
INSERT INTO sys_menu(menu_id,menu_name,parent_id,order_num,path,component,is_frame,is_cache,menu_type,visible,status,perms,icon,create_by,create_time)
SELECT @earnings_id,'收益管理',@parent_id,7,'earnings','anqi/earnings/index',1,1,'C','0','0','anqi:earnings:list','money','admin',NOW() WHERE @parent_id IS NOT NULL
ON DUPLICATE KEY UPDATE menu_name=VALUES(menu_name),component=VALUES(component),visible='0';
SET @edit_id = (SELECT menu_id FROM sys_menu WHERE perms='anqi:earnings:edit' LIMIT 1);
SET @edit_id = COALESCE(@edit_id, (SELECT GREATEST(COALESCE(MAX(menu_id),3299)+1,3300) FROM sys_menu));
INSERT INTO sys_menu(menu_id,menu_name,parent_id,order_num,path,is_frame,is_cache,menu_type,visible,status,perms,create_by,create_time)
SELECT @edit_id,'配置收益规则',@earnings_id,1,'#',1,1,'F','0','0','anqi:earnings:edit','admin',NOW() WHERE @parent_id IS NOT NULL
ON DUPLICATE KEY UPDATE menu_name=VALUES(menu_name),parent_id=VALUES(parent_id);
COMMIT;
