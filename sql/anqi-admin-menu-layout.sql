-- 线上管理后台的菜单分组：日常业务 / 礼品管理 / 店铺设置，以及“商城分类”页面。
-- 线上库早期由服务器脚本 tools/simple-admin-menus.sh 写入；本文件让新库得到相同布局。
-- 新库紧接 anqi-deployment-menus.sql 执行（在员工排班、收益管理脚本之前，与线上的先后顺序一致）。已有线上库无需执行。
-- 注意：3018/3118 会从初始化时的“支付审计”改为“商城分类”，支付审计由 anqi-admin-1.1.30-fix1.sql 以 3500 重新加入。
SET NAMES utf8mb4;
INSERT INTO sys_menu(menu_id,menu_name,parent_id,order_num,path,is_frame,is_cache,menu_type,visible,status,icon,create_by,create_time)
VALUES(3200,'礼品管理',0,2,'gifts',1,1,'M','0','0','gift','admin',NOW()),(3201,'店铺设置',0,3,'shop',1,1,'M','0','0','edit','admin',NOW())
ON DUPLICATE KEY UPDATE menu_name=VALUES(menu_name),path=VALUES(path);
UPDATE sys_menu SET menu_name='日常业务',order_num=1,icon='shopping' WHERE menu_id=3000;
INSERT INTO sys_menu(menu_id,menu_name,parent_id,order_num,path,component,is_frame,is_cache,menu_type,visible,status,icon,perms,create_by,create_time) VALUES(3018,'商城分类',3000,2,'categories','anqi/categories/index',1,0,'C','0','0','list','anqi:categories:list','admin',NOW()) ON DUPLICATE KEY UPDATE menu_name=VALUES(menu_name),parent_id=VALUES(parent_id),path=VALUES(path),component=VALUES(component),perms=VALUES(perms);
INSERT INTO sys_menu(menu_id,menu_name,parent_id,order_num,path,is_frame,is_cache,menu_type,visible,status,perms,create_by,create_time) VALUES(3118,'管理商城分类',3018,1,'#',1,1,'F','0','0','anqi:categories:edit','admin',NOW()) ON DUPLICATE KEY UPDATE menu_name=VALUES(menu_name),parent_id=VALUES(parent_id),perms=VALUES(perms);
UPDATE sys_menu SET parent_id=3200 WHERE menu_id IN(3011);
UPDATE sys_menu SET parent_id=3201 WHERE menu_id IN(3012,3013,3016);
UPDATE sys_menu SET visible='1' WHERE menu_id IN(3001,3007,3015,3017);
UPDATE sys_menu SET order_num=1 WHERE menu_id IN(3005,3009,3012);
UPDATE sys_menu SET order_num=2 WHERE menu_id IN(3006,3010,3013);
UPDATE sys_menu SET order_num=3 WHERE menu_id IN(3002,3011,3016);
UPDATE sys_menu SET order_num=4 WHERE menu_id IN(3004,3008);
UPDATE sys_menu SET order_num=5 WHERE menu_id=3003;
UPDATE sys_menu SET order_num=6 WHERE menu_id=3014;
UPDATE sys_menu SET menu_name='会员邀请' WHERE menu_id=3014;
UPDATE sys_menu SET menu_name='合作商家' WHERE menu_id=3013;
