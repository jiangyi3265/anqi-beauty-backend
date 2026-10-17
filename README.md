# anqi-beauty-backend

暨美丽系统的 Java 后端，负责管理认证、角色权限、系统管理及跨端业务 API 代理。

## 项目简介

基于若依 Spring Boot 多模块工程，为 `anqi-beauty-admin` 提供验证码登录、JWT 认证、菜单与权限校验、用户/角色/部门/字典/参数管理和日志能力。

美容业务接口通过 `AnqiController` 转发到 `anqi-beauty-app/server` 的 Node 服务，覆盖商品、门店、会员、订单、体验卡、预约核销、员工排班与可配置收益。Java 校验后台权限，Node 执行业务规则和事务；本仓库的 SQL 维护系统基础表与业务菜单，Node 初始化自身业务表。

## 技术栈

| 类别 | 实际使用 |
| --- | --- |
| 语言与构建 | Java（Maven 编译目标 1.8）、Maven 多模块 |
| Web 与认证 | Spring Boot 2.5.15、Spring Framework 5.3.39、Spring Security 5.7.14、JWT |
| 数据 | MySQL、MyBatis、PageHelper、Druid、Redis |
| API 文档 | Springfox / Swagger 3 |
| 保留模块 | Quartz 定时任务、Velocity 代码生成模块；当前 ruoyi-admin 未引入这两个模块 |

## 关联仓库

| 项目 | 说明 | GitHub |
| --- | --- | --- |
| anqi-beauty-backend | 后端服务 | [anqi-beauty-backend](https://github.com/jiangyi3265/anqi-beauty-backend) |
| anqi-beauty-admin | 管理后台 | [anqi-beauty-admin](https://github.com/jiangyi3265/anqi-beauty-admin) |
| anqi-beauty-app | 用户端 | [anqi-beauty-app](https://github.com/jiangyi3265/anqi-beauty-app) |

## 快速启动

准备 JDK 8 或兼容 JDK、Maven、MySQL 和 Redis。建议先启动 app 仓库的 Node 业务服务（默认 3016）。

### 1. 初始化新开发库

创建 UTF-8 数据库，再依次导入：

1. `sql/ry_20250522.sql`
2. `sql/anqi-deployment-menus.sql`
3. `sql/anqi-staff-scheduling.sql`
4. `sql/anqi-income-config.sql`

前两个是新库初始化脚本，不能覆盖现有业务数据库。管理员 `admin` 的密码初始为空，无法直接登录；请按 [SQL 说明](sql/README.md) 为符合 5–20 位长度限制的独立密码生成 BCrypt 哈希并写入管理员记录。项目不提供通用登录密码。

### 2. 配置运行环境

参考 `.env.example`，在终端、IDE 或服务管理器中设置以下环境变量。**Spring Boot 不会自动读取 `.env` 文件。**

| 变量 | 用途 |
| --- | --- |
| `DB_URL`、`DB_USERNAME`、`DB_PASSWORD` | MySQL JDBC 地址与数据库账户 |
| `TOKEN_SECRET` | JWT 签名密钥，使用独立随机值 |
| `DRUID_USERNAME`、`DRUID_PASSWORD` | Druid 控制台账户，或关闭该控制台 |
| `ANQI_BUSINESS_URL` | Node 服务地址，默认 `http://127.0.0.1:3016` |
| `ANQI_INTERNAL_SECRET` | 与 Node 的 `INTERNAL_SECRET` 相同 |
| `SPRING_REDIS_HOST`、`SPRING_REDIS_PORT`、`SPRING_REDIS_PASSWORD` | 本地 Redis 连接；默认 localhost:6379 |
| `RUOYI_PROFILE` | 设置为本机可写的上传目录，覆盖模板 Windows 路径 |

环境配置中的密码和密钥只留在本地。默认 HTTP 端口 8080，可通过 `SERVER_PORT` 覆盖。

### 3. 编译并启动

在仓库根目录执行：

```bash
mvn -pl ruoyi-admin -am package -DskipTests
java -jar ruoyi-admin/target/ruoyi-admin.jar
```

运行后，管理后台开发代理连接 `http://localhost:8080`。商品、套餐、排班和收益等业务页面需要 Node 服务同时运行，且两端内部密钥一致。

## 项目结构

```text
ruoyi-admin/       启动入口、系统控制器和 AnqiController 业务代理
ruoyi-framework/   Spring Security、认证授权、数据源等基础框架
ruoyi-system/      系统用户、角色、菜单等领域服务与 Mapper
ruoyi-common/      通用实体、工具、注解、异常和配置
ruoyi-quartz/      定时任务模块源码（当前主应用未引入）
ruoyi-generator/   代码生成模块源码（当前主应用未引入）
sql/               基础库及暨美丽菜单、排班和收益权限脚本
bin/               本地构建脚本
pom.xml            Maven 模块和依赖版本管理
```

## 协作与配置边界

参见 [三端协作开发](https://github.com/jiangyi3265/anqi-beauty-app/blob/main/docs/协作开发.md)。业务规则修改通常位于 app 仓库的 `server/`；新增后台操作时，应同步 Java 代理权限、菜单 SQL 和 admin 页面。

公开仓库保留无密钥的配置模板、初始化 SQL 和业务代码；本地配置、证书、数据库备份、上传目录、日志和 Maven 构建产物不提交。上游若依许可与归属信息见 [LICENSE](LICENSE)。

## 简历描述示例

参与 Spring Boot 美容门店系统后端开发，基于 Spring Security、JWT、MyBatis 和 Redis 构建管理员认证与权限体系，并完成商品、预约、员工排班及收益业务接口的跨服务代理和菜单权限集成。
