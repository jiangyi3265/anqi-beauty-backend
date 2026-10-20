-- Complete existing business navigation; retain all business records and role permissions.
SET NAMES utf8mb4;
UPDATE sys_menu SET visible='0' WHERE menu_id=3007 AND component='anqi/addresses/index';
UPDATE sys_menu SET visible='0',parent_id=3201,order_num=10 WHERE menu_id=3017 AND component='anqi/audit/index';
INSERT INTO sys_menu(menu_id,menu_name,parent_id,order_num,path,component,is_frame,is_cache,menu_type,visible,status,perms,icon,create_by,create_time) VALUES
(3500,'支付审计',3000,12,'paymentAudits','anqi/paymentAudits/index',1,0,'C','0','0','anqi:paymentAudits:list','list','admin',NOW())
ON DUPLICATE KEY UPDATE menu_name=VALUES(menu_name),parent_id=VALUES(parent_id),path=VALUES(path),component=VALUES(component),visible=VALUES(visible),status=VALUES(status),perms=VALUES(perms);
INSERT IGNORE INTO sys_role_menu(role_id,menu_id) VALUES(1,3500);
UPDATE sys_user SET nick_name='秀荣科技美肤管理员' WHERE user_id=1 AND nick_name='暨美丽管理员';
