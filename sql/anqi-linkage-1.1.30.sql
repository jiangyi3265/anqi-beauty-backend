-- Add the missing points pages without touching business records or unrelated roles.
SET NAMES utf8mb4;
INSERT INTO sys_menu(menu_id,menu_name,parent_id,order_num,path,component,is_frame,is_cache,menu_type,visible,status,perms,icon,create_by,create_time) VALUES
(3400,'积分管理',0,4,'points',NULL,1,1,'M','0','0','','gift','admin',NOW()),
(3401,'积分商品',3400,1,'rewards','anqi/rewards/index',1,0,'C','0','0','anqi:rewards:list','shopping','admin',NOW()),
(3402,'积分流水',3400,2,'ledger','anqi/ledger/index',1,0,'C','0','0','anqi:ledger:list','list','admin',NOW()),
(3403,'兑换记录',3400,3,'redemptions','anqi/redemptions/index',1,0,'C','0','0','anqi:redemptions:list','list','admin',NOW()),
(3411,'管理积分商品',3401,1,'#',NULL,1,1,'F','0','0','anqi:rewards:edit','#','admin',NOW())
ON DUPLICATE KEY UPDATE menu_name=VALUES(menu_name),parent_id=VALUES(parent_id),path=VALUES(path),component=VALUES(component),visible=VALUES(visible),status=VALUES(status),perms=VALUES(perms);
INSERT IGNORE INTO sys_role_menu(role_id,menu_id) VALUES(1,3400),(1,3401),(1,3402),(1,3403),(1,3411);
