CREATE TABLE "addresses" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "street_line1" varchar(255), "street_line2" varchar(255), "city" varchar(255), "state" varchar(255), "zip" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "carts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "type" varchar(255), "status" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "user_id" integer);
CREATE TABLE "items" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "qty" integer, "price" decimal, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "cart_id" integer, "product_id" integer);
CREATE TABLE "orders" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "address_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "cart_id" integer);
CREATE TABLE "products" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "price" decimal, "brand" varchar(255), "qty_in_stock" integer, "info" text, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar(255), "password_digest" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "type" varchar(255), "first_name" varchar(255), "last_name" varchar(255));
CREATE INDEX "index_orders_on_address_id" ON "orders" ("address_id");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20121004201411');

INSERT INTO schema_migrations (version) VALUES ('20121006173441');

INSERT INTO schema_migrations (version) VALUES ('20121006173914');

INSERT INTO schema_migrations (version) VALUES ('20121006180347');

INSERT INTO schema_migrations (version) VALUES ('20121006180638');

INSERT INTO schema_migrations (version) VALUES ('20121007052245');

INSERT INTO schema_migrations (version) VALUES ('20121007052551');

INSERT INTO schema_migrations (version) VALUES ('20121007210539');

INSERT INTO schema_migrations (version) VALUES ('20121008000312');

INSERT INTO schema_migrations (version) VALUES ('20121009192841');

INSERT INTO schema_migrations (version) VALUES ('20121009194934');

INSERT INTO schema_migrations (version) VALUES ('20121009200318');

INSERT INTO schema_migrations (version) VALUES ('20121012181416');

INSERT INTO schema_migrations (version) VALUES ('20121012205540');

INSERT INTO schema_migrations (version) VALUES ('20121015000538');