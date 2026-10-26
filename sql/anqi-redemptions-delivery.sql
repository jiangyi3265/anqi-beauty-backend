-- Allow authorized operators to confirm delivery of redeemed points gifts.
SET @menu_id = (SELECT menu_id FROM sys_menu WHERE perms='anqi:redemptions:list' LIMIT 1);
SET @edit_id = (SELECT menu_id FROM sys_menu WHERE perms='anqi:redemptions:edit' LIMIT 1);
INSERT INTO sys_menu(menu_name,parent_id,order_num,path,is_frame,is_cache,menu_type,visible,status,perms,icon,create_by,create_time)
SELECT '确认积分礼品领取',@menu_id,1,'#',1,1,'F','0','0','anqi:redemptions:edit','#','admin',NOW()
WHERE @menu_id IS NOT NULL AND @edit_id IS NULL;
SET @edit_id = (SELECT menu_id FROM sys_menu WHERE perms='anqi:redemptions:edit' LIMIT 1);
INSERT IGNORE INTO sys_role_menu(role_id,menu_id) SELECT 1,@edit_id WHERE @edit_id IS NOT NULL;
