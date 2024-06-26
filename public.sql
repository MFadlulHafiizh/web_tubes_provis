/*
 Navicat Premium Data Transfer

 Source Server         : PostgreLocal
 Source Server Type    : PostgreSQL
 Source Server Version : 140001
 Source Host           : localhost:5432
 Source Catalog        : db_siraja
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 140001
 File Encoding         : 65001

 Date: 20/04/2024 19:52:06
*/


-- ----------------------------
-- Type structure for jenkel_enum
-- ----------------------------
DROP TYPE IF EXISTS "public"."jenkel_enum";
CREATE TYPE "public"."jenkel_enum" AS ENUM (
  'Laki-laki',
  'Perempuan'
);
ALTER TYPE "public"."jenkel_enum" OWNER TO "postgres";

-- ----------------------------
-- Type structure for roles_enum
-- ----------------------------
DROP TYPE IF EXISTS "public"."roles_enum";
CREATE TYPE "public"."roles_enum" AS ENUM (
  'user',
  'dokter',
  'fo',
  'farmasi',
  'penunjang_medis'
);
ALTER TYPE "public"."roles_enum" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for bidang_dokter_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."bidang_dokter_id_seq";
CREATE SEQUENCE "public"."bidang_dokter_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for dokter_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."dokter_id_seq";
CREATE SEQUENCE "public"."dokter_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for failed_jobs_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."failed_jobs_id_seq";
CREATE SEQUENCE "public"."failed_jobs_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for jadwal_dokter_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."jadwal_dokter_id_seq";
CREATE SEQUENCE "public"."jadwal_dokter_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for keluhan_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."keluhan_id_seq";
CREATE SEQUENCE "public"."keluhan_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for migrations_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."migrations_id_seq";
CREATE SEQUENCE "public"."migrations_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for pasien_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."pasien_id_seq";
CREATE SEQUENCE "public"."pasien_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for personal_access_tokens_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."personal_access_tokens_id_seq";
CREATE SEQUENCE "public"."personal_access_tokens_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for ruangan_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."ruangan_id_seq";
CREATE SEQUENCE "public"."ruangan_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for users_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."users_id_seq";
CREATE SEQUENCE "public"."users_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Table structure for bidang_dokter
-- ----------------------------
DROP TABLE IF EXISTS "public"."bidang_dokter";
CREATE TABLE "public"."bidang_dokter" (
  "id" int8 NOT NULL DEFAULT nextval('bidang_dokter_id_seq'::regclass),
  "bidang" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(0),
  "updated_at" timestamp(0)
)
;

-- ----------------------------
-- Records of bidang_dokter
-- ----------------------------
INSERT INTO "public"."bidang_dokter" VALUES (1, 'Umum', NULL, NULL);
INSERT INTO "public"."bidang_dokter" VALUES (3, 'Spesialis THT', NULL, NULL);
INSERT INTO "public"."bidang_dokter" VALUES (4, 'Spesialis Jantung', NULL, NULL);
INSERT INTO "public"."bidang_dokter" VALUES (5, 'Spesialis Syaraf', NULL, NULL);
INSERT INTO "public"."bidang_dokter" VALUES (2, 'Spesialis Anak', NULL, NULL);
INSERT INTO "public"."bidang_dokter" VALUES (6, 'Spesialis Penyakit Dalam', NULL, NULL);

-- ----------------------------
-- Table structure for dokter
-- ----------------------------
DROP TABLE IF EXISTS "public"."dokter";
CREATE TABLE "public"."dokter" (
  "id" int8 NOT NULL DEFAULT nextval('dokter_id_seq'::regclass),
  "foto" text COLLATE "pg_catalog"."default",
  "nama_dokter" text COLLATE "pg_catalog"."default" NOT NULL,
  "jenkel" text COLLATE "pg_catalog"."default" NOT NULL,
  "tgl_lahir" date NOT NULL,
  "bidang_id" int8 NOT NULL,
  "created_at" timestamp(0),
  "updated_at" timestamp(0)
)
;

-- ----------------------------
-- Records of dokter
-- ----------------------------
INSERT INTO "public"."dokter" VALUES (9, 'https://hasnamedika.com/wp-content/uploads/2021/07/Irlandi-dr.jpg', 'Rendi Fajri', 'Laki-laki', '1990-11-02', 1, NULL, NULL);
INSERT INTO "public"."dokter" VALUES (1, 'https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2022/03/08055643/Cari-Dokter-Umum-Terbaik-di-Yogyakarta_-Ini-5-Rekomendasinya.jpg.webp', 'Ariliana', 'Perempuan', '1997-05-12', 1, NULL, NULL);
INSERT INTO "public"."dokter" VALUES (2, 'https://www.inilah.com/_next/image?url=https%3A%2F%2Fc.inilah.com%2Freborn%2F2023%2F08%2F1%2F0509_110616_1b9f_inilah_com_ee50ff7c0e.jpg&w=1920&q=75', 'Wijaya', 'Laki-laki', '1998-02-15', 1, NULL, NULL);
INSERT INTO "public"."dokter" VALUES (3, 'https://purimedika.com/wp-content/uploads/2020/11/Dr-Lestari-Raharjo.jpg', 'Irianto', 'Laki-laki', '1986-01-01', 3, NULL, NULL);
INSERT INTO "public"."dokter" VALUES (4, 'https://cloud.jpnn.com/photo/arsip/normal/2023/05/26/nicho-saputra-nugraha-influencer-sekaligus-dokter-ganteng-ya-fbox.jpg', 'Lukman Hajime', 'Laki-laki', '1995-08-27', 2, NULL, NULL);
INSERT INTO "public"."dokter" VALUES (5, 'https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/p2/79/2023/07/29/1-FT-A-dokter-2109212324.jpg', 'Fuji Nami', 'Perempuan', '1996-12-22', 2, NULL, NULL);

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS "public"."failed_jobs";
CREATE TABLE "public"."failed_jobs" (
  "id" int8 NOT NULL DEFAULT nextval('failed_jobs_id_seq'::regclass),
  "uuid" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "connection" text COLLATE "pg_catalog"."default" NOT NULL,
  "queue" text COLLATE "pg_catalog"."default" NOT NULL,
  "payload" text COLLATE "pg_catalog"."default" NOT NULL,
  "exception" text COLLATE "pg_catalog"."default" NOT NULL,
  "failed_at" timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for jadwal_dokter
-- ----------------------------
DROP TABLE IF EXISTS "public"."jadwal_dokter";
CREATE TABLE "public"."jadwal_dokter" (
  "id" int8 NOT NULL DEFAULT nextval('jadwal_dokter_id_seq'::regclass),
  "hari" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "jam_mulai" time(0) NOT NULL,
  "jam_berakhir" time(0) NOT NULL,
  "dokter_id" int8 NOT NULL,
  "ruang_id" int8 NOT NULL,
  "created_at" timestamp(0),
  "updated_at" timestamp(0)
)
;

-- ----------------------------
-- Records of jadwal_dokter
-- ----------------------------
INSERT INTO "public"."jadwal_dokter" VALUES (3, 'Senin', '07:00:00', '12:00:00', 9, 1, NULL, NULL);
INSERT INTO "public"."jadwal_dokter" VALUES (4, 'Kamis', '08:00:00', '13:00:00', 9, 1, NULL, NULL);
INSERT INTO "public"."jadwal_dokter" VALUES (6, 'Rabu', '13:00:00', '16:00:00', 1, 2, NULL, NULL);
INSERT INTO "public"."jadwal_dokter" VALUES (7, 'Selasa', '08:00:00', '13:00:00', 1, 3, NULL, NULL);
INSERT INTO "public"."jadwal_dokter" VALUES (9, 'Rabu', '09:00:00', '16:00:00', 3, 4, NULL, NULL);
INSERT INTO "public"."jadwal_dokter" VALUES (11, 'Jumat', '13:00:00', '17:00:00', 4, 3, NULL, NULL);
INSERT INTO "public"."jadwal_dokter" VALUES (12, 'Jumat', '06:00:00', '11:30:00', 2, 1, NULL, NULL);
INSERT INTO "public"."jadwal_dokter" VALUES (5, 'Senin', '07:00:00', '17:00:00', 1, 2, NULL, NULL);
INSERT INTO "public"."jadwal_dokter" VALUES (13, 'Senin', '07:00:00', '14:30:00', 2, 3, NULL, NULL);
INSERT INTO "public"."jadwal_dokter" VALUES (14, 'Senin', '09:00:00', '15:00:00', 3, 4, NULL, NULL);
INSERT INTO "public"."jadwal_dokter" VALUES (15, 'Sabtu', '07:00:00', '15:00:00', 1, 1, NULL, NULL);
INSERT INTO "public"."jadwal_dokter" VALUES (16, 'Sabtu', '07:00:00', '15:00:00', 2, 2, NULL, NULL);
INSERT INTO "public"."jadwal_dokter" VALUES (17, 'Sabtu', '07:00:00', '15:00:00', 9, 3, NULL, NULL);
INSERT INTO "public"."jadwal_dokter" VALUES (18, 'Minggu', '07:00:00', '15:00:00', 1, 3, NULL, NULL);
INSERT INTO "public"."jadwal_dokter" VALUES (19, 'Minggu', '07:00:00', '15:00:00', 2, 2, NULL, NULL);
INSERT INTO "public"."jadwal_dokter" VALUES (20, 'Minggu', '07:00:00', '15:00:00', 9, 1, NULL, NULL);
INSERT INTO "public"."jadwal_dokter" VALUES (22, 'Selasa', '07:00:00', '15:00:00', 5, 4, NULL, NULL);
INSERT INTO "public"."jadwal_dokter" VALUES (23, 'Rabu', '07:00:00', '13:00:00', 5, 3, NULL, NULL);
INSERT INTO "public"."jadwal_dokter" VALUES (24, 'Kamis', '08:00:00', '12:00:00', 5, 2, NULL, NULL);
INSERT INTO "public"."jadwal_dokter" VALUES (8, 'Selasa', '07:00:00', '13:00:00', 2, 1, NULL, NULL);
INSERT INTO "public"."jadwal_dokter" VALUES (10, 'Kamis', '07:00:00', '14:00:00', 3, 4, NULL, NULL);
INSERT INTO "public"."jadwal_dokter" VALUES (25, 'Kamis', '07:00:00', '17:30:00', 2, 5, NULL, NULL);

-- ----------------------------
-- Table structure for keluhan
-- ----------------------------
DROP TABLE IF EXISTS "public"."keluhan";
CREATE TABLE "public"."keluhan" (
  "id" int8 NOT NULL DEFAULT nextval('keluhan_id_seq'::regclass),
  "pasien_id" int8 NOT NULL,
  "detail_keluhan" text COLLATE "pg_catalog"."default" NOT NULL,
  "is_bpjs" bool NOT NULL,
  "jadwal_dokter_id" int8 NOT NULL,
  "nomor_tiket" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "status" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(0),
  "updated_at" timestamp(0)
)
;

-- ----------------------------
-- Records of keluhan
-- ----------------------------

-- ----------------------------
-- Table structure for kota
-- ----------------------------
DROP TABLE IF EXISTS "public"."kota";
CREATE TABLE "public"."kota" (
  "uid_kota" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "provinsi_uid" varchar(255) COLLATE "pg_catalog"."default",
  "kode_kota" varchar(255) COLLATE "pg_catalog"."default",
  "nama" varchar(255) COLLATE "pg_catalog"."default",
  "created_at" varchar(255) COLLATE "pg_catalog"."default",
  "updated_at" varchar(255) COLLATE "pg_catalog"."default",
  "created_by" varchar(255) COLLATE "pg_catalog"."default",
  "updated_by" varchar(255) COLLATE "pg_catalog"."default",
  "deleted_at" date
)
;

-- ----------------------------
-- Records of kota
-- ----------------------------
INSERT INTO "public"."kota" VALUES ('1272', '12', '1272', 'KOTA PEMATANG SIANTAR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1216', '12', '1216', 'KAB. HUMBANG HASUNDUTAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1217', '12', '1217', 'KAB. SAMOSIR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1218', '12', '1218', 'KAB. SERDANG BEDAGAI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1219', '12', '1219', 'KAB. BATU BARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1220', '12', '1220', 'KAB. PADANG LAWAS UTARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1221', '12', '1221', 'KAB. PADANG LAWAS', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1223', '12', '1223', 'KAB. LABUHANBATU UTARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1224', '12', '1224', 'KAB. NIAS UTARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1225', '12', '1225', 'KAB. NIAS BARAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1271', '12', '1271', 'KOTA MEDAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1273', '12', '1273', 'KOTA SIBOLGA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1274', '12', '1274', 'KOTA TANJUNG BALAI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1275', '12', '1275', 'KOTA BINJAI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1277', '12', '1277', 'KOTA PADANGSIDIMPUAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1278', '12', '1278', 'KOTA GUNUNGSITOLI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1301', '13', '1301', 'KAB. PESISIR SELATAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1302', '13', '1302', 'KAB. SOLOK', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1303', '13', '1303', 'KAB. SIJUNJUNG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1304', '13', '1304', 'KAB. TANAH DATAR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1306', '13', '1306', 'KAB. AGAM', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1307', '13', '1307', 'KAB. LIMA PULUH KOTA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1308', '13', '1308', 'KAB. PASAMAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1309', '13', '1309', 'KAB. KEPULAUAN MENTAWAI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1310', '13', '1310', 'KAB. DHARMASRAYA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1311', '13', '1311', 'KAB. SOLOK SELATAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1312', '13', '1312', 'KAB. PASAMAN BARAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1372', '13', '1372', 'KOTA SOLOK', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1373', '13', '1373', 'KOTA SAWAHLUNTO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1374', '13', '1374', 'KOTA PADANG PANJANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1375', '13', '1375', 'KOTA BUKITTINGGI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1376', '13', '1376', 'KOTA PAYAKUMBUH', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1377', '13', '1377', 'KOTA PARIAMAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1402', '14', '1402', 'KAB. INDRAGIRI HULU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1403', '14', '1403', 'KAB. BENGKALIS', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1404', '14', '1404', 'KAB. INDRAGIRI HILIR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1405', '14', '1405', 'KAB. PELALAWAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1406', '14', '1406', 'KAB. ROKAN HULU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1407', '14', '1407', 'KAB. ROKAN HILIR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1408', '14', '1408', 'KAB. SIAK', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1410', '14', '1410', 'KAB. KEPULAUAN MERANTI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1471', '14', '1471', 'KOTA PEKANBARU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1472', '14', '1472', 'KOTA DUMAI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1501', '15', '1501', 'KAB. KERINCI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1502', '15', '1502', 'KAB. MERANGIN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1503', '15', '1503', 'KAB. SAROLANGUN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1505', '15', '1505', 'KAB. MUARO JAMBI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1506', '15', '1506', 'KAB. TANJUNG JABUNG BARAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1507', '15', '1507', 'KAB. TANJUNG JABUNG TIMUR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1508', '15', '1508', 'KAB. BUNGO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1509', '15', '1509', 'KAB. TEBO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1571', '15', '1571', 'KOTA JAMBI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1601', '16', '1601', 'KAB. OGAN KOMERING ULU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1602', '16', '1602', 'KAB. OGAN KOMERING ILIR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1603', '16', '1603', 'KAB. MUARA ENIM', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1604', '16', '1604', 'KAB. LAHAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1605', '16', '1605', 'KAB. MUSI RAWAS', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1607', '16', '1607', 'KAB. BANYUASIN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1608', '16', '1608', 'KAB. OGAN KOMERING ULU TIMUR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1609', '16', '1609', 'KAB. OGAN KOMERING ULU SELATAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1610', '16', '1610', 'KAB. OGAN ILIR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1611', '16', '1611', 'KAB. EMPAT LAWANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1612', '16', '1612', 'KAB. PENUKAL ABAB LEMATANG ILIR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1613', '16', '1613', 'KAB. MUSI RAWAS UTARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1671', '16', '1671', 'KOTA PALEMBANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1673', '16', '1673', 'KOTA LUBUK LINGGAU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1674', '16', '1674', 'KOTA PRABUMULIH', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1701', '17', '1701', 'KAB. BENGKULU SELATAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1702', '17', '1702', 'KAB. REJANG LEBONG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1703', '17', '1703', 'KAB. BENGKULU UTARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1704', '17', '1704', 'KAB. KAUR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1706', '17', '1706', 'KAB. MUKO MUKO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1707', '17', '1707', 'KAB. LEBONG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1708', '17', '1708', 'KAB. KEPAHIANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1709', '17', '1709', 'KAB. BENGKULU TENGAH', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1771', '17', '1771', 'KOTA BENGKULU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1802', '18', '1802', 'KAB. LAMPUNG TENGAH', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1803', '18', '1803', 'KAB. LAMPUNG UTARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1804', '18', '1804', 'KAB. LAMPUNG BARAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1805', '18', '1805', 'KAB. TULANG BAWANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1806', '18', '1806', 'KAB. TANGGAMUS', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1807', '18', '1807', 'KAB. LAMPUNG TIMUR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1808', '18', '1808', 'KAB. WAY KANAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1810', '18', '1810', 'KAB. PRINGSEWU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1811', '18', '1811', 'KAB. MESUJI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1812', '18', '1812', 'KAB. TULANG BAWANG BARAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1813', '18', '1813', 'KAB. PESISIR BARAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1871', '18', '1871', 'KOTA BANDAR LAMPUNG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1902', '19', '1902', 'KAB. BELITUNG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1903', '19', '1903', 'KAB. BANGKA SELATAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1904', '19', '1904', 'KAB. BANGKA TENGAH', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1905', '19', '1905', 'KAB. BANGKA BARAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1906', '19', '1906', 'KAB. BELITUNG TIMUR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1971', '19', '1971', 'KOTA PANGKAL PINANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('2102', '21', '2102', 'KAB. KARIMUN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('2103', '21', '2103', 'KAB. NATUNA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('2104', '21', '2104', 'KAB. LINGGA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('2105', '21', '2105', 'KAB. KEPULAUAN ANAMBAS', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('2171', '21', '2171', 'KOTA BATAM', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('2172', '21', '2172', 'KOTA TANJUNG PINANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3171', '31', '3171', 'KOTA ADM. JAKARTA PUSAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3172', '31', '3172', 'KOTA ADM. JAKARTA UTARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3173', '31', '3173', 'KOTA ADM. JAKARTA BARAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3174', '31', '3174', 'KOTA ADM. JAKARTA SELATAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3175', '31', '3175', 'KOTA ADM. JAKARTA TIMUR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3201', '32', '3201', 'KAB. BOGOR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3202', '32', '3202', 'KAB. SUKABUMI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3204', '32', '3204', 'KAB. BANDUNG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3205', '32', '3205', 'KAB. GARUT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3206', '32', '3206', 'KAB. TASIKMALAYA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3207', '32', '3207', 'KAB. CIAMIS', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3208', '32', '3208', 'KAB. KUNINGAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3209', '32', '3209', 'KAB. CIREBON', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3211', '32', '3211', 'KAB. SUMEDANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3212', '32', '3212', 'KAB. INDRAMAYU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3213', '32', '3213', 'KAB. SUBANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3214', '32', '3214', 'KAB. PURWAKARTA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3215', '32', '3215', 'KAB. KARAWANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3216', '32', '3216', 'KAB. BEKASI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3218', '32', '3218', 'KAB. PANGANDARAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3271', '32', '3271', 'KOTA BOGOR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3272', '32', '3272', 'KOTA SUKABUMI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3273', '32', '3273', 'KOTA BANDUNG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3274', '32', '3274', 'KOTA CIREBON', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3275', '32', '3275', 'KOTA BEKASI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3276', '32', '3276', 'KOTA DEPOK', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3278', '32', '3278', 'KOTA TASIKMALAYA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3279', '32', '3279', 'KOTA BANJAR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3301', '33', '3301', 'KAB. CILACAP', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3302', '33', '3302', 'KAB. BANYUMAS', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3303', '33', '3303', 'KAB. PURBALINGGA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3304', '33', '3304', 'KAB. BANJARNEGARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3306', '33', '3306', 'KAB. PURWOREJO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3307', '33', '3307', 'KAB. WONOSOBO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3308', '33', '3308', 'KAB. MAGELANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3309', '33', '3309', 'KAB. BOYOLALI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3310', '33', '3310', 'KAB. KLATEN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3311', '33', '3311', 'KAB. SUKOHARJO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3313', '33', '3313', 'KAB. KARANGANYAR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3314', '33', '3314', 'KAB. SRAGEN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3315', '33', '3315', 'KAB. GROBOGAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3316', '33', '3316', 'KAB. BLORA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3317', '33', '3317', 'KAB. REMBANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3318', '33', '3318', 'KAB. PATI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3320', '33', '3320', 'KAB. JEPARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3321', '33', '3321', 'KAB. DEMAK', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3524', '35', '3524', 'KAB. LAMONGAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3525', '35', '3525', 'KAB. GRESIK', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3526', '35', '3526', 'KAB. BANGKALAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3527', '35', '3527', 'KAB. SAMPANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3529', '35', '3529', 'KAB. SUMENEP', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3571', '35', '3571', 'KOTA KEDIRI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3572', '35', '3572', 'KOTA BLITAR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3573', '35', '3573', 'KOTA MALANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3574', '35', '3574', 'KOTA PROBOLINGGO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3575', '35', '3575', 'KOTA PASURUAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3577', '35', '3577', 'KOTA MADIUN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3578', '35', '3578', 'KOTA SURABAYA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3579', '35', '3579', 'KOTA BATU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3601', '36', '3601', 'KAB. PANDEGLANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3602', '36', '3602', 'KAB. LEBAK', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3603', '36', '3603', 'KAB. TANGERANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3671', '36', '3671', 'KOTA TANGERANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3672', '36', '3672', 'KOTA CILEGON', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3673', '36', '3673', 'KOTA SERANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3674', '36', '3674', 'KOTA TANGERANG SELATAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5101', '51', '5101', 'KAB. JEMBRANA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5102', '51', '5102', 'KAB. TABANAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5104', '51', '5104', 'KAB. GIANYAR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5105', '51', '5105', 'KAB. KLUNGKUNG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5106', '51', '5106', 'KAB. BANGLI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5107', '51', '5107', 'KAB. KARANGASEM', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5108', '51', '5108', 'KAB. BULELENG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5171', '51', '5171', 'KOTA DENPASAR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5202', '52', '5202', 'KAB. LOMBOK TENGAH', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5203', '52', '5203', 'KAB. LOMBOK TIMUR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5204', '52', '5204', 'KAB. SUMBAWA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5205', '52', '5205', 'KAB. DOMPU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3403', '34', '3403', 'KAB. GUNUNG KIDUL', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3322', '33', '3322', 'KAB. SEMARANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3323', '33', '3323', 'KAB. TEMANGGUNG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3324', '33', '3324', 'KAB. KENDAL', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3325', '33', '3325', 'KAB. BATANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3326', '33', '3326', 'KAB. PEKALONGAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3327', '33', '3327', 'KAB. PEMALANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3328', '33', '3328', 'KAB. TEGAL', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3329', '33', '3329', 'KAB. BREBES', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3371', '33', '3371', 'KOTA MAGELANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3372', '33', '3372', 'KOTA SURAKARTA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3373', '33', '3373', 'KOTA SALATIGA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3374', '33', '3374', 'KOTA SEMARANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3375', '33', '3375', 'KOTA PEKALONGAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3376', '33', '3376', 'KOTA TEGAL', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3401', '34', '3401', 'KAB. KULON PROGO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3402', '34', '3402', 'KAB. BANTUL', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3404', '34', '3404', 'KAB. SLEMAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3471', '34', '3471', 'KOTA YOGYAKARTA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3501', '35', '3501', 'KAB. PACITAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3502', '35', '3502', 'KAB. PONOROGO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3503', '35', '3503', 'KAB. TRENGGALEK', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3504', '35', '3504', 'KAB. TULUNGAGUNG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3505', '35', '3505', 'KAB. BLITAR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3506', '35', '3506', 'KAB. KEDIRI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3507', '35', '3507', 'KAB. MALANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3508', '35', '3508', 'KAB. LUMAJANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3509', '35', '3509', 'KAB. JEMBER', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3510', '35', '3510', 'KAB. BANYUWANGI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3511', '35', '3511', 'KAB. BONDOWOSO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3512', '35', '3512', 'KAB. SITUBONDO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3513', '35', '3513', 'KAB. PROBOLINGGO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3514', '35', '3514', 'KAB. PASURUAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3515', '35', '3515', 'KAB. SIDOARJO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3516', '35', '3516', 'KAB. MOJOKERTO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3517', '35', '3517', 'KAB. JOMBANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3518', '35', '3518', 'KAB. NGANJUK', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3519', '35', '3519', 'KAB. MADIUN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3520', '35', '3520', 'KAB. MAGETAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3521', '35', '3521', 'KAB. NGAWI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3522', '35', '3522', 'KAB. BOJONEGORO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3523', '35', '3523', 'KAB. TUBAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3604', '36', '3604', 'KAB. SERANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5103', '51', '5103', 'KAB. BADUNG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5201', '52', '5201', 'KAB. LOMBOK BARAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5206', '52', '5206', 'KAB. BIMA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5207', '52', '5207', 'KAB. SUMBAWA BARAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5208', '52', '5208', 'KAB. LOMBOK UTARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5271', '52', '5271', 'KOTA MATARAM', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5272', '52', '5272', 'KOTA BIMA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5301', '53', '5301', 'KAB. KUPANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5302', '53', '5302', 'KAB TIMOR TENGAH SELATAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5303', '53', '5303', 'KAB. TIMOR TENGAH UTARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5304', '53', '5304', 'KAB. BELU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5305', '53', '5305', 'KAB. ALOR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5306', '53', '5306', 'KAB. FLORES TIMUR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5307', '53', '5307', 'KAB. SIKKA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5308', '53', '5308', 'KAB. ENDE', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5309', '53', '5309', 'KAB. NGADA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5310', '53', '5310', 'KAB. MANGGARAI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5311', '53', '5311', 'KAB. SUMBA TIMUR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5312', '53', '5312', 'KAB. SUMBA BARAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5313', '53', '5313', 'KAB. LEMBATA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5319', '53', '5319', 'KAB. MANGGARAI TIMUR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6105', '61', '6105', 'KAB. SINTANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6112', '61', '6112', 'KAB. KUBU RAYA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6205', '62', '6205', 'KAB. BARITO UTARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6212', '62', '6212', 'KAB. MURUNG RAYA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6305', '63', '6305', 'KAB. TAPIN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6371', '63', '6371', 'KOTA BANJARMASIN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6409', '64', '6409', 'KAB. PENAJAM PASER UTARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6504', '65', '6504', 'KAB. TANA TIDUNG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7105', '71', '7105', 'KAB. MINAHASA SELATAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7173', '71', '7173', 'KOTA TOMOHON', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7206', '72', '7206', 'KAB. MOROWALI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7212', '72', '7212', 'KAB. MOROWALI UTARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7307', '73', '7307', 'KAB. SINJAI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7311', '73', '7311', 'KAB. BARRU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7316', '73', '7316', 'KAB. ENREKANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7372', '73', '7372', 'KOTA PARE PARE', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7405', '74', '7405', 'KAB. KONAWE SELATAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7414', '74', '7414', 'KAB. BUTON TENGAH', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7504', '75', '7504', 'KAB. PAHUWATO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7604', '76', '7604', 'KAB. POLEWALI MANDAR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('8107', '81', '8107', 'KAB. KEPULAUAN ARU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('8203', '82', '8203', 'KAB. HALMAHERA UTARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5314', '53', '5314', 'KAB. ROTE NDAO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5315', '53', '5315', 'KAB. MANGGARAI BARAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5316', '53', '5316', 'KAB. NAGEKEO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5317', '53', '5317', 'KAB. SUMBA TENGAH', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5318', '53', '5318', 'KAB. SUMBA BARAT DAYA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5320', '53', '5320', 'KAB. SABU RAIJUA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5321', '53', '5321', 'KAB. MALAKA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('5371', '53', '5371', 'KOTA KUPANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6101', '61', '6101', 'KAB. SAMBAS', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6102', '61', '6102', 'KAB. MEMPAWAH', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6103', '61', '6103', 'KAB. SANGGAU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6104', '61', '6104', 'KAB. KETAPANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6106', '61', '6106', 'KAB. KAPUAS HULU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6107', '61', '6107', 'KAB. BENGKAYANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6108', '61', '6108', 'KAB. LANDAK', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6109', '61', '6109', 'KAB. SEKADAU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6110', '61', '6110', 'KAB. MELAWI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6111', '61', '6111', 'KAB. KAYONG UTARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6171', '61', '6171', 'KOTA PONTIANAK', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9109', '91', '9109', 'KAB. MIMIKA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6172', '61', '6172', 'KOTA SINGKAWANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6201', '62', '6201', 'KAB. KOTAWARINGIN BARAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6202', '62', '6202', 'KAB. KOTAWARINGIN TIMUR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6203', '62', '6203', 'KAB. KAPUAS', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6204', '62', '6204', 'KAB. BARITO SELATAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6206', '62', '6206', 'KAB. KATINGAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6207', '62', '6207', 'KAB. SERUYAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6208', '62', '6208', 'KAB. SUKAMARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6209', '62', '6209', 'KAB. LAMANDAU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6210', '62', '6210', 'KAB. GUNUNG MAS', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6211', '62', '6211', 'KAB. PULANG PISAU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6213', '62', '6213', 'KAB. BARITO TIMUR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6271', '62', '6271', 'KOTA PALANGKARAYA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6301', '63', '6301', 'KAB. TANAH LAUT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6302', '63', '6302', 'KAB. KOTABARU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6303', '63', '6303', 'KAB. BANJAR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6304', '63', '6304', 'KAB. BARITO KUALA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6306', '63', '6306', 'KAB. HULU SUNGAI SELATAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6307', '63', '6307', 'KAB. HULU SUNGAI TENGAH', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6308', '63', '6308', 'KAB. HULU SUNGAI UTARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6309', '63', '6309', 'KAB. TABALONG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6310', '63', '6310', 'KAB. TANAH BUMBU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6311', '63', '6311', 'KAB. BALANGAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6372', '63', '6372', 'KOTA BANJARBARU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6401', '64', '6401', 'KAB. PASER', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6402', '64', '6402', 'KAB. KUTAI KARTANEGARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6403', '64', '6403', 'KAB. BERAU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6407', '64', '6407', 'KAB. KUTAI BARAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6408', '64', '6408', 'KAB. KUTAI TIMUR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6411', '64', '6411', 'KAB. MAHAKAM ULU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6471', '64', '6471', 'KOTA BALIKPAPAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6472', '64', '6472', 'KOTA SAMARINDA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6474', '64', '6474', 'KOTA BONTANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6501', '65', '6501', 'KAB. BULUNGAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6502', '65', '6502', 'KAB. MALINAU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6503', '65', '6503', 'KAB. NUNUKAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('6571', '65', '6571', 'KOTA TARAKAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7101', '71', '7101', 'KAB. BOLAANG MONGONDOW', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7102', '71', '7102', 'KAB. MINAHASA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7103', '71', '7103', 'KAB. KEPULAUAN SANGIHE', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7104', '71', '7104', 'KAB. KEPULAUAN TALAUD', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7106', '71', '7106', 'KAB. MINAHASA UTARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7107', '71', '7107', 'KAB. MINAHASA TENGGARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7108', '71', '7108', 'KAB. BOLAANG MONGONDOW UTARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7109', '71', '7109', 'KAB. KEP. SIAU TAGULANDANG BIARO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7110', '71', '7110', 'KAB. BOLAANG MONGONDOW TIMUR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7111', '71', '7111', 'KAB. BOLAANG MONGONDOW SELATAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7171', '71', '7171', 'KOTA MANADO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7172', '71', '7172', 'KOTA BITUNG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7174', '71', '7174', 'KOTA KOTAMOBAGU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7201', '72', '7201', 'KAB. BANGGAI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7202', '72', '7202', 'KAB. POSO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7203', '72', '7203', 'KAB. DONGGALA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7204', '72', '7204', 'KAB. TOLI TOLI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7205', '72', '7205', 'KAB. BUOL', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7207', '72', '7207', 'KAB. BANGGAI KEPULAUAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7208', '72', '7208', 'KAB. PARIGI MOUTONG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7209', '72', '7209', 'KAB. TOJO UNA UNA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7210', '72', '7210', 'KAB. SIGI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7211', '72', '7211', 'KAB. BANGGAI LAUT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7271', '72', '7271', 'KOTA PALU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7301', '73', '7301', 'KAB. KEPULAUAN SELAYAR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7302', '73', '7302', 'KAB. BULUKUMBA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7303', '73', '7303', 'KAB. BANTAENG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7304', '73', '7304', 'KAB. JENEPONTO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7305', '73', '7305', 'KAB. TAKALAR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7306', '73', '7306', 'KAB. GOWA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7308', '73', '7308', 'KAB. BONE', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7309', '73', '7309', 'KAB. MAROS', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7310', '73', '7310', 'KAB. PANGKAJENE KEPULAUAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('8103', '81', '8103', 'KAB MALUKU TENGGARA BARAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1215', '12', '1215', 'KAB. PAKPAK BHARAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1222', '12', '1222', 'KAB. LABUHANBATU SELATAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1276', '12', '1276', 'KOTA TEBING TINGGI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1305', '13', '1305', 'KAB. PADANG PARIAMAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1371', '13', '1371', 'KOTA PADANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1401', '14', '1401', 'KAB. KAMPAR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1409', '14', '1409', 'KAB. KUANTAN SINGINGI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1504', '15', '1504', 'KAB. BATANGHARI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1572', '15', '1572', 'KOTA SUNGAI PENUH', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1606', '16', '1606', 'KAB. MUSI BANYUASIN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1672', '16', '1672', 'KOTA PAGAR ALAM', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1705', '17', '1705', 'KAB. SELUMA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1801', '18', '1801', 'KAB. LAMPUNG SELATAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1809', '18', '1809', 'KAB. PESAWARAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1872', '18', '1872', 'KOTA METRO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1901', '19', '1901', 'KAB. BANGKA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('2101', '21', '2101', 'KAB. BINTAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3101', '31', '3101', 'KAB. ADM. KEP. SERIBU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3203', '32', '3203', 'KAB. CIANJUR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3210', '32', '3210', 'KAB. MAJALENGKA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3217', '32', '3217', 'KAB. BANDUNG BARAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3277', '32', '3277', 'KOTA CIMAHI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3305', '33', '3305', 'KAB. KEBUMEN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3312', '33', '3312', 'KAB. WONOGIRI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3319', '33', '3319', 'KAB. KUDUS', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3528', '35', '3528', 'KAB. PAMEKASAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('3576', '35', '3576', 'KOTA MOJOKERTO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7312', '73', '7312', 'KAB. SOPPENG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7313', '73', '7313', 'KAB. WAJO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7314', '73', '7314', 'KAB. SIDENRENG RAPPANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7315', '73', '7315', 'KAB. PINRANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7317', '73', '7317', 'KAB. LUWU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7318', '73', '7318', 'KAB. TANA TORAJA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7322', '73', '7322', 'KAB. LUWU UTARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7324', '73', '7324', 'KAB. LUWU TIMUR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7326', '73', '7326', 'KAB. TORAJA UTARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7371', '73', '7371', 'KOTA MAKASSAR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7373', '73', '7373', 'KOTA PALOPO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7401', '74', '7401', 'KAB. KOLAKA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7402', '74', '7402', 'KAB. KONAWE', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7403', '74', '7403', 'KAB. MUNA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7404', '74', '7404', 'KAB. BUTON', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7406', '74', '7406', 'KAB. BOMBANA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7407', '74', '7407', 'KAB. WAKATOBI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7408', '74', '7408', 'KAB. KOLAKA UTARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7409', '74', '7409', 'KAB. KONAWE UTARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7410', '74', '7410', 'KAB. BUTON UTARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7411', '74', '7411', 'KAB. KOLAKA TIMUR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7412', '74', '7412', 'KAB. KONAWE KEPULAUAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7413', '74', '7413', 'KAB. MUNA BARAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7415', '74', '7415', 'KAB. BUTON SELATAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7471', '74', '7471', 'KOTA KENDARI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7472', '74', '7472', 'KOTA BAU BAU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7501', '75', '7501', 'KAB. GORONTALO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7502', '75', '7502', 'KAB. BOALEMO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7503', '75', '7503', 'KAB. BONE BOLANGO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7505', '75', '7505', 'KAB. GORONTALO UTARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7571', '75', '7571', 'KOTA GORONTALO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7601', '76', '7601', 'KAB. MAMUJU UTARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7602', '76', '7602', 'KAB. MAMUJU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7603', '76', '7603', 'KAB. MAMASA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7605', '76', '7605', 'KAB. MAJENE', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('7606', '76', '7606', 'KAB. MAMUJU TENGAH', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('8101', '81', '8101', 'KAB. MALUKU TENGAH', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('8102', '81', '8102', 'KAB. MALUKU TENGGARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('8104', '81', '8104', 'KAB. BURU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('8105', '81', '8105', 'KAB. SERAM BAGIAN TIMUR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('8106', '81', '8106', 'KAB. SERAM BAGIAN BARAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('8108', '81', '8108', 'KAB. MALUKU BARAT DAYA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('8109', '81', '8109', 'KAB. BURU SELATAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('8171', '81', '8171', 'KOTA AMBON', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('8172', '81', '8172', 'KOTA TUAL', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('8201', '82', '8201', 'KAB. HALMAHERA BARAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('8202', '82', '8202', 'KAB. HALMAHERA TENGAH', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('8204', '82', '8204', 'KAB. HALMAHERA SELATAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('8205', '82', '8205', 'KAB. KEPULAUAN SULA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('8206', '82', '8206', 'KAB. HALMAHERA TIMUR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('8207', '82', '8207', 'KAB. PULAU MOROTAI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('8208', '82', '8208', 'KAB. PULAU TALIABU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('8271', '82', '8271', 'KOTA TERNATE', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('8272', '82', '8272', 'KOTA TIDORE KEPULAUAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1101', '11', '1101', 'KAB. ACEH SELATAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1102', '11', '1102', 'KAB. ACEH TENGGARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1103', '11', '1103', 'KAB. ACEH TIMUR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1104', '11', '1104', 'KAB. ACEH TENGAH', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1105', '11', '1105', 'KAB. ACEH BARAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1106', '11', '1106', 'KAB. ACEH BESAR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1107', '11', '1107', 'KAB. PIDIE', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1108', '11', '1108', 'KAB. ACEH UTARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1109', '11', '1109', 'KAB. SIMEULUE', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1110', '11', '1110', 'KAB. ACEH SINGKIL', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1111', '11', '1111', 'KAB. BIREUEN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1112', '11', '1112', 'KAB. ACEH BARAT DAYA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1113', '11', '1113', 'KAB. GAYO LUES', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1114', '11', '1114', 'KAB. ACEH JAYA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1115', '11', '1115', 'KAB. NAGAN RAYA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1116', '11', '1116', 'KAB. ACEH TAMIANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1117', '11', '1117', 'KAB. BENER MERIAH', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1118', '11', '1118', 'KAB. PIDIE JAYA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1171', '11', '1171', 'KOTA BANDA ACEH', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1172', '11', '1172', 'KOTA SABANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1173', '11', '1173', 'KOTA LHOKSEUMAWE', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1174', '11', '1174', 'KOTA LANGSA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1175', '11', '1175', 'KOTA SUBULUSSALAM', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1201', '12', '1201', 'KAB. TAPANULI TENGAH', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1202', '12', '1202', 'KAB. TAPANULI UTARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1203', '12', '1203', 'KAB. TAPANULI SELATAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1204', '12', '1204', 'KAB. NIAS', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1205', '12', '1205', 'KAB. LANGKAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1206', '12', '1206', 'KAB. KARO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9106', '91', '9106', 'KAB. BIAK NUMFOR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9105', '91', '9105', 'KAB. KEPULAUAN YAPEN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9103', '91', '9103', 'KAB. JAYAPURA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9107', '91', '9107', 'KAB. PUNCAK JAYA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9108', '91', '9108', 'KAB. PANIAI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9110', '91', '9110', 'KAB. SARMI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9104', '91', '9104', 'KAB. NABIRE', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1207', '12', '1207', 'KAB. DELI SERDANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1208', '12', '1208', 'KAB. SIMALUNGUN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1209', '12', '1209', 'KAB. ASAHAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1210', '12', '1210', 'KAB. LABUHANBATU', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1211', '12', '1211', 'KAB. DAIRI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1212', '12', '1212', 'KAB. TOBA SAMOSIR', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1213', '12', '1213', 'KAB. MANDAILING NATAL', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('1214', '12', '1214', 'KAB. NIAS SELATAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9201', '92', '9201', 'KAB. SORONG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9202', '92', '9202', 'KAB. MANOKWARI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9203', '92', '9203', 'KAB. FAK FAK', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9204', '92', '9204', 'KAB. SORONG SELATAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9205', '92', '9205', 'KAB. RAJA AMPAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9206', '92', '9206', 'KAB. TELUK BINTUNI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9207', '92', '9207', 'KAB. TELUK WONDAMA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9208', '92', '9208', 'KAB. KAIMANA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9209', '92', '9209', 'KAB. TAMBRAUW', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9210', '92', '9210', 'KAB. MAYBRAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9211', '92', '9211', 'KAB. MANOKWARI SELATAN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9212', '92', '9212', 'KAB. PEGUNUNGAN ARFAK', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9271', '92', '9271', 'KOTA SORONG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9111', '91', '9111', 'KAB. KEEROM', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9113', '91', '9113', 'KAB. YAHUKIMO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9114', '91', '9114', 'KAB. TOLIKARA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9115', '91', '9115', 'KAB. WAROPEN', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9116', '91', '9116', 'KAB. BOVEN DIGOEL', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9117', '91', '9117', 'KAB. MAPPI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9127', '91', '9127', 'KAB. INTAN JAYA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9128', '91', '9128', 'KAB. DEIYAI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9171', '91', '9171', 'KOTA JAYAPURA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9112', '91', '9112', 'KAB PEGUNUNGAN BINTANG', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9102', '91', '9102', 'KAB. JAYAWIJAYA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9118', '91', '9118', 'KAB. ASMAT', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9119', '91', '9119', 'KAB. SUPIORI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9120', '91', '9120', 'KAB. MAMBERAMO RAYA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9121', '91', '9121', 'KAB. MAMBERAMO TENGAH', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9122', '91', '9122', 'KAB. YALIMO', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9123', '91', '9123', 'KAB. LANNY JAYA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9124', '91', '9124', 'KAB. NDUGA', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9125', '91', '9125', 'KAB. PUNCAK', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9126', '91', '9126', 'KAB. DOGIYAI', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "public"."kota" VALUES ('9101', '91', '9101', 'KAB. MERAUKE', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS "public"."migrations";
CREATE TABLE "public"."migrations" (
  "id" int4 NOT NULL DEFAULT nextval('migrations_id_seq'::regclass),
  "migration" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "batch" int4 NOT NULL
)
;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO "public"."migrations" VALUES (6, '2014_10_12_000000_create_users_table', 1);
INSERT INTO "public"."migrations" VALUES (7, '2014_10_12_100000_create_password_reset_tokens_table', 1);
INSERT INTO "public"."migrations" VALUES (8, '2019_08_19_000000_create_failed_jobs_table', 1);
INSERT INTO "public"."migrations" VALUES (9, '2019_12_14_000001_create_personal_access_tokens_table', 1);
INSERT INTO "public"."migrations" VALUES (11, '2024_04_18_040548_create_pasien_table', 2);
INSERT INTO "public"."migrations" VALUES (17, '2024_04_19_083650_create_bidang_dokter_table', 3);
INSERT INTO "public"."migrations" VALUES (18, '2024_04_19_083726_create_dokter_table', 3);
INSERT INTO "public"."migrations" VALUES (26, '2024_04_19_084434_create_ruangan_table', 4);
INSERT INTO "public"."migrations" VALUES (27, '2024_04_19_094328_create_jadwal_dokter_table', 4);
INSERT INTO "public"."migrations" VALUES (28, '2024_04_19_094907_create_keluhan_table', 4);

-- ----------------------------
-- Table structure for pasien
-- ----------------------------
DROP TABLE IF EXISTS "public"."pasien";
CREATE TABLE "public"."pasien" (
  "id" int8 NOT NULL DEFAULT nextval('pasien_id_seq'::regclass),
  "user_id" int8 NOT NULL,
  "nik" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "jenkel" "public"."jenkel_enum" NOT NULL DEFAULT 'Laki-laki'::jenkel_enum,
  "tgl_lahir" date NOT NULL,
  "tempat_lahir" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "no_telp" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "foto" text COLLATE "pg_catalog"."default",
  "file_bpjs" text COLLATE "pg_catalog"."default",
  "status" text COLLATE "pg_catalog"."default",
  "is_default" bool NOT NULL DEFAULT false,
  "created_at" timestamp(0),
  "updated_at" timestamp(0)
)
;

-- ----------------------------
-- Records of pasien
-- ----------------------------
INSERT INTO "public"."pasien" VALUES (2, 1, '3000356777988766', 'Test Pasien', 'Laki-laki', '2007-07-03', '1217', '+6289655031225', NULL, NULL, 'default', 't', NULL, NULL);
INSERT INTO "public"."pasien" VALUES (3, 1, '30001679239719', 'Fadlul Hafiizh', 'Laki-laki', '2003-05-27', '3273', '+6289655031225', 'account/user_image/5_18042024025654633d7cc6b949e.jpg', 'account/bpjs/5_18042024025654Sample Pdf.pdf', NULL, 't', '2024-04-18 14:28:48', '2024-04-19 09:15:59');

-- ----------------------------
-- Table structure for password_reset_tokens
-- ----------------------------
DROP TABLE IF EXISTS "public"."password_reset_tokens";
CREATE TABLE "public"."password_reset_tokens" (
  "email" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "token" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(0)
)
;

-- ----------------------------
-- Records of password_reset_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for personal_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS "public"."personal_access_tokens";
CREATE TABLE "public"."personal_access_tokens" (
  "id" int8 NOT NULL DEFAULT nextval('personal_access_tokens_id_seq'::regclass),
  "tokenable_type" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "tokenable_id" int8 NOT NULL,
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "token" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "abilities" text COLLATE "pg_catalog"."default",
  "last_used_at" timestamp(0),
  "expires_at" timestamp(0),
  "created_at" timestamp(0),
  "updated_at" timestamp(0)
)
;

-- ----------------------------
-- Records of personal_access_tokens
-- ----------------------------
INSERT INTO "public"."personal_access_tokens" VALUES (9, 'App\Models\User', 1, 'API_TOKEN', '73b64c3ae0c4f448bb7f402ff096b104e4e2613c019136516b7ac097e8160c8f', '["*"]', NULL, NULL, '2024-04-18 21:55:57', '2024-04-18 21:55:57');
INSERT INTO "public"."personal_access_tokens" VALUES (10, 'App\Models\User', 1, 'API_TOKEN', '507653778d0867227fbe043d2deaa9f4d2218390aa47d063a70125675f0a7bea', '["*"]', NULL, NULL, '2024-04-18 22:09:32', '2024-04-18 22:09:32');
INSERT INTO "public"."personal_access_tokens" VALUES (19, 'App\Models\User', 1, 'API_TOKEN', 'a2ceb718d73cafed5b8ff1e84e8cac53348fda32028f5e80ab5f066c6e3dd4b7', '["*"]', '2024-04-20 11:01:55', NULL, '2024-04-20 10:57:49', '2024-04-20 11:01:55');
INSERT INTO "public"."personal_access_tokens" VALUES (11, 'App\Models\User', 1, 'API_TOKEN', '35c71b150052d347b1af1a413e6369cb73ade88b11be14cdf60fcdde7866fb6b', '["*"]', '2024-04-20 08:05:05', NULL, '2024-04-19 09:03:17', '2024-04-20 08:05:05');
INSERT INTO "public"."personal_access_tokens" VALUES (13, 'App\Models\User', 1, 'API_TOKEN', '9ab546d9a7f7d04c6edf898835d410242346b1ffbb7f43c0ddf39366007829cc', '["*"]', '2024-04-19 17:32:32', NULL, '2024-04-19 16:25:18', '2024-04-19 17:32:32');
INSERT INTO "public"."personal_access_tokens" VALUES (17, 'App\Models\User', 1, 'API_TOKEN', 'e9330fe7ae5b350d0b4e010d195f65ba628ecdeb700b7232a2b469422634d261', '["*"]', '2024-04-20 06:40:56', NULL, '2024-04-20 05:21:58', '2024-04-20 06:40:56');
INSERT INTO "public"."personal_access_tokens" VALUES (15, 'App\Models\User', 1, 'API_TOKEN', '626a4e2d51a7437c5b75187270d93c9ae7afa6068d9fd32e9ebbc4976419c19d', '["*"]', '2024-04-19 17:40:06', NULL, '2024-04-19 17:22:59', '2024-04-19 17:40:06');
INSERT INTO "public"."personal_access_tokens" VALUES (16, 'App\Models\User', 1, 'API_TOKEN', '814f5147c2806535c7bf3ab275f9d9ecea7ce5fc867343664b9cbf1da8ed1335', '["*"]', NULL, NULL, '2024-04-19 18:46:26', '2024-04-19 18:46:26');
INSERT INTO "public"."personal_access_tokens" VALUES (14, 'App\Models\User', 1, 'API_TOKEN', 'dc5cd6e5ac1adad3ad5e23d53bed375945b3f0ccfc6989bb1cf0e6000c57e830', '["*"]', '2024-04-20 10:28:16', NULL, '2024-04-19 17:09:55', '2024-04-20 10:28:16');
INSERT INTO "public"."personal_access_tokens" VALUES (12, 'App\Models\User', 1, 'API_TOKEN', '4c43f7bda40bc9c7f5838c6e7d4f48d9437d8c6a76bd13a02bb91e7e5c9d8ffc', '["*"]', NULL, NULL, '2024-04-19 15:25:39', '2024-04-19 15:25:39');
INSERT INTO "public"."personal_access_tokens" VALUES (18, 'App\Models\User', 1, 'API_TOKEN', 'fe0b84d4352ce023f2443b687ce196868bf860bd4f558f1cd371dfad352a3414', '["*"]', '2024-04-20 10:49:38', NULL, '2024-04-20 10:49:12', '2024-04-20 10:49:38');

-- ----------------------------
-- Table structure for provinsi
-- ----------------------------
DROP TABLE IF EXISTS "public"."provinsi";
CREATE TABLE "public"."provinsi" (
  "uid_provinsi" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "kode_provinsi" varchar(255) COLLATE "pg_catalog"."default",
  "nama" varchar(255) COLLATE "pg_catalog"."default",
  "created_at" varchar(255) COLLATE "pg_catalog"."default",
  "updated_at" varchar(255) COLLATE "pg_catalog"."default",
  "created_by" varchar(255) COLLATE "pg_catalog"."default",
  "updated_by" varchar(255) COLLATE "pg_catalog"."default",
  "deleted_at" date
)
;

-- ----------------------------
-- Records of provinsi
-- ----------------------------
INSERT INTO "public"."provinsi" VALUES ('65', '65', 'Kalimantan Utara', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('75', '75', 'Gorontalo', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('72', '72', 'Sulawesi Tengah', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('71', '71', 'Sulawesi Utara', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('76', '76', 'Sulawesi Barat', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('73', '73', 'Sulawesi Selatan', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('74', '74', 'Sulawesi Tenggara', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('81', '81', 'Maluku', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('82', '82', 'Maluku Utara', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('52', '52', 'Nusa Tenggara Barat', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('53', '53', 'Nusa Tenggara Timur', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('91', '91', 'Papua', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('92', '92', 'Papua Barat', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('11', '11', 'Aceh', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('12', '12', 'Sumatera Utara', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('13', '13', 'Sumatera Barat', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('21', '21', 'Kepulauan Riau', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('14', '14', 'Riau', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('19', '19', 'Kepulauan Bangka Belitung', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('17', '17', 'Bengkulu', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('15', '15', 'Jambi', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('16', '16', 'Sumatera Selatan', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('61', '61', 'Kalimantan Barat', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('31', '31', 'DKI Jakarta', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('63', '63', 'Kalimantan Selatan', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('62', '62', 'Kalimantan Tengah', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('64', '64', 'Kalimantan Timur', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('32', '32', 'Jawa Barat', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('35', '35', 'Jawa Timur', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('34', '34', 'DI Yogyakarta', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('33', '33', 'Jawa Tengah', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('51', '51', 'Bali', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('18', '18', 'Lampung', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);
INSERT INTO "public"."provinsi" VALUES ('36', '36', 'Banten', '2019-03-28 13:34:20.817', '2019-03-28 13:34:20.817', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for ruangan
-- ----------------------------
DROP TABLE IF EXISTS "public"."ruangan";
CREATE TABLE "public"."ruangan" (
  "id" int8 NOT NULL DEFAULT nextval('ruangan_id_seq'::regclass),
  "nama_ruang" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "detail_ruang" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(0),
  "updated_at" timestamp(0)
)
;

-- ----------------------------
-- Records of ruangan
-- ----------------------------
INSERT INTO "public"."ruangan" VALUES (1, 'A1-2', 'Lantai 1', NULL, NULL);
INSERT INTO "public"."ruangan" VALUES (2, 'A2-15', 'Lantai 2', NULL, NULL);
INSERT INTO "public"."ruangan" VALUES (3, 'B4-1', 'Lantai 4', NULL, NULL);
INSERT INTO "public"."ruangan" VALUES (4, 'E4-2', 'Lantai 4', NULL, NULL);
INSERT INTO "public"."ruangan" VALUES (5, 'E3-13', 'Lantai 3', NULL, NULL);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS "public"."users";
CREATE TABLE "public"."users" (
  "id" int8 NOT NULL DEFAULT nextval('users_id_seq'::regclass),
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "email" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "email_verified_at" timestamp(0),
  "password" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "salt" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "role" "public"."roles_enum" NOT NULL DEFAULT 'user'::roles_enum,
  "remember_token" varchar(100) COLLATE "pg_catalog"."default",
  "created_at" timestamp(0),
  "updated_at" timestamp(0)
)
;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO "public"."users" VALUES (1, 'Test Pasien', 'dummy@gmail.com', '2024-04-18 04:47:39', '$2y$12$WH/uo0s7wNDvN9huSmpMhufrgr4sHdzM/4I2g..2/vXoabToG23am', 'secretpass', 'user', 'mTsvSGsEWx', '2024-04-18 04:47:42', '2024-04-18 04:47:42');
INSERT INTO "public"."users" VALUES (5, 'Fadlul Hafiizh', 'muh.hafiizh56@gmail.com', NULL, '$2y$12$4lPkL37t2Ak94SzNMTWMduU37JyfhMPrNRxM/2/q5ATgLpZf7Rh2C', 'secretpass', 'user', NULL, '2024-04-18 14:28:48', '2024-04-19 09:15:59');

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."bidang_dokter_id_seq"
OWNED BY "public"."bidang_dokter"."id";
SELECT setval('"public"."bidang_dokter_id_seq"', 7, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."dokter_id_seq"
OWNED BY "public"."dokter"."id";
SELECT setval('"public"."dokter_id_seq"', 10, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."failed_jobs_id_seq"
OWNED BY "public"."failed_jobs"."id";
SELECT setval('"public"."failed_jobs_id_seq"', 2, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."jadwal_dokter_id_seq"
OWNED BY "public"."jadwal_dokter"."id";
SELECT setval('"public"."jadwal_dokter_id_seq"', 26, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."keluhan_id_seq"
OWNED BY "public"."keluhan"."id";
SELECT setval('"public"."keluhan_id_seq"', 2, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."migrations_id_seq"
OWNED BY "public"."migrations"."id";
SELECT setval('"public"."migrations_id_seq"', 29, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."pasien_id_seq"
OWNED BY "public"."pasien"."id";
SELECT setval('"public"."pasien_id_seq"', 7, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."personal_access_tokens_id_seq"
OWNED BY "public"."personal_access_tokens"."id";
SELECT setval('"public"."personal_access_tokens_id_seq"', 20, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."ruangan_id_seq"
OWNED BY "public"."ruangan"."id";
SELECT setval('"public"."ruangan_id_seq"', 6, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."users_id_seq"
OWNED BY "public"."users"."id";
SELECT setval('"public"."users_id_seq"', 6, true);

-- ----------------------------
-- Primary Key structure for table bidang_dokter
-- ----------------------------
ALTER TABLE "public"."bidang_dokter" ADD CONSTRAINT "bidang_dokter_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table dokter
-- ----------------------------
ALTER TABLE "public"."dokter" ADD CONSTRAINT "dokter_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table failed_jobs
-- ----------------------------
ALTER TABLE "public"."failed_jobs" ADD CONSTRAINT "failed_jobs_uuid_unique" UNIQUE ("uuid");

-- ----------------------------
-- Primary Key structure for table failed_jobs
-- ----------------------------
ALTER TABLE "public"."failed_jobs" ADD CONSTRAINT "failed_jobs_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table jadwal_dokter
-- ----------------------------
ALTER TABLE "public"."jadwal_dokter" ADD CONSTRAINT "jadwal_dokter_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table keluhan
-- ----------------------------
ALTER TABLE "public"."keluhan" ADD CONSTRAINT "keluhan_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table kota
-- ----------------------------
ALTER TABLE "public"."kota" ADD CONSTRAINT "kota_pkey" PRIMARY KEY ("uid_kota");

-- ----------------------------
-- Primary Key structure for table migrations
-- ----------------------------
ALTER TABLE "public"."migrations" ADD CONSTRAINT "migrations_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Checks structure for table pasien
-- ----------------------------
ALTER TABLE "public"."pasien" ADD CONSTRAINT "pasien_jenkel_check" CHECK (jenkel::text = ANY (ARRAY['Laki-laki'::character varying::text, 'Perempuan'::character varying::text]));

-- ----------------------------
-- Primary Key structure for table pasien
-- ----------------------------
ALTER TABLE "public"."pasien" ADD CONSTRAINT "pasien_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table password_reset_tokens
-- ----------------------------
ALTER TABLE "public"."password_reset_tokens" ADD CONSTRAINT "password_reset_tokens_pkey" PRIMARY KEY ("email");

-- ----------------------------
-- Indexes structure for table personal_access_tokens
-- ----------------------------
CREATE INDEX "personal_access_tokens_tokenable_type_tokenable_id_index" ON "public"."personal_access_tokens" USING btree (
  "tokenable_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "tokenable_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table personal_access_tokens
-- ----------------------------
ALTER TABLE "public"."personal_access_tokens" ADD CONSTRAINT "personal_access_tokens_token_unique" UNIQUE ("token");

-- ----------------------------
-- Primary Key structure for table personal_access_tokens
-- ----------------------------
ALTER TABLE "public"."personal_access_tokens" ADD CONSTRAINT "personal_access_tokens_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table provinsi
-- ----------------------------
ALTER TABLE "public"."provinsi" ADD CONSTRAINT "provinsi_pkey" PRIMARY KEY ("uid_provinsi");

-- ----------------------------
-- Primary Key structure for table ruangan
-- ----------------------------
ALTER TABLE "public"."ruangan" ADD CONSTRAINT "ruangan_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_email_unique" UNIQUE ("email");

-- ----------------------------
-- Checks structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_role_check" CHECK (role::text = ANY (ARRAY['user'::character varying::text, 'dokter'::character varying::text, 'fo'::character varying::text, 'farmasi'::character varying::text, 'penunjang_medis'::character varying::text]));

-- ----------------------------
-- Primary Key structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Keys structure for table dokter
-- ----------------------------
ALTER TABLE "public"."dokter" ADD CONSTRAINT "dokter_bidang_id_foreign" FOREIGN KEY ("bidang_id") REFERENCES "public"."bidang_dokter" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table jadwal_dokter
-- ----------------------------
ALTER TABLE "public"."jadwal_dokter" ADD CONSTRAINT "jadwal_dokter_dokter_id_foreign" FOREIGN KEY ("dokter_id") REFERENCES "public"."dokter" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."jadwal_dokter" ADD CONSTRAINT "jadwal_dokter_ruang_id_foreign" FOREIGN KEY ("ruang_id") REFERENCES "public"."ruangan" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table pasien
-- ----------------------------
ALTER TABLE "public"."pasien" ADD CONSTRAINT "pasien_tempat_lahir_foreign" FOREIGN KEY ("tempat_lahir") REFERENCES "public"."kota" ("uid_kota") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."pasien" ADD CONSTRAINT "pasien_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
