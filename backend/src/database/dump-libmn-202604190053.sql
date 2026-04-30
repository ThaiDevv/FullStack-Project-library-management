-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: libmn
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `chitietmuon`
--

DROP TABLE IF EXISTS `chitietmuon`;
/*!50001 DROP VIEW IF EXISTS `chitietmuon`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `chitietmuon` AS SELECT 
 1 AS `MaDocGia`,
 1 AS `HoTen`,
 1 AS `MaPM`,
 1 AS `NgayMuon`,
 1 AS `TenSach`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `chitietphieumuon`
--

DROP TABLE IF EXISTS `chitietphieumuon`;
/*!50001 DROP VIEW IF EXISTS `chitietphieumuon`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `chitietphieumuon` AS SELECT 
 1 AS `MaDocGia`,
 1 AS `HoTen`,
 1 AS `NgaySinh`,
 1 AS `DienThoai`,
 1 AS `MaPM`,
 1 AS `NgayMuon`,
 1 AS `MaCuonSach`,
 1 AS `TenSach`,
 1 AS `TrangThai`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `ct_phieumuon`
--

DROP TABLE IF EXISTS `ct_phieumuon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ct_phieumuon` (
  `MaPM` varchar(20) NOT NULL,
  `MaCuonSach` varchar(20) NOT NULL,
  `NgayTraThucTe` datetime DEFAULT NULL,
  `TrangThai` varchar(50) DEFAULT 'Đang mượn',
  PRIMARY KEY (`MaPM`,`MaCuonSach`),
  KEY `FK_CTPM_CuonSach` (`MaCuonSach`),
  CONSTRAINT `FK_CTPM_CuonSach` FOREIGN KEY (`MaCuonSach`) REFERENCES `cuonsach` (`MaCuonSach`) ON DELETE RESTRICT,
  CONSTRAINT `FK_CTPM_PhieuMuon` FOREIGN KEY (`MaPM`) REFERENCES `phieumuon` (`MaPM`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ct_phieumuon`
--

LOCK TABLES `ct_phieumuon` WRITE;
/*!40000 ALTER TABLE `ct_phieumuon` DISABLE KEYS */;
INSERT INTO `ct_phieumuon` VALUES ('PM01','C001',NULL,'DangMuon'),('PM01','C002',NULL,'DangMuon'),('PM02','C012',NULL,'DangMuon'),('PM03','C013',NULL,'DangMuon'),('PM04','C005','2026-04-05 00:00:00','DaTra'),('PM05','C006',NULL,'DangMuon'),('PM05','C014',NULL,'DangMuon'),('PM06','C007',NULL,'DangMuon'),('PM07','C008','2026-04-04 00:00:00','DaTra'),('PM08','C009',NULL,'DangMuon'),('PM09','C010',NULL,'DangMuon'),('PM10','C011',NULL,'DangMuon');
/*!40000 ALTER TABLE `ct_phieumuon` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `trg_MuonSach_CapNhatTrangThai` BEFORE INSERT ON `ct_phieumuon` FOR EACH ROW BEGIN

    DECLARE v_TinhTrang VARCHAR(50);



    SELECT TinhTrang INTO v_TinhTrang

    FROM CuonSach

    WHERE MaCuonSach = NEW.MaCuonSach

    LIMIT 1;



    IF v_TinhTrang IS NULL OR v_TinhTrang != 'Sẵn sàng' THEN

        SIGNAL SQLSTATE '45000'

        SET MESSAGE_TEXT = 'Lỗi: Cuốn sách này không có sẵn trong kho để cho mượn!';

    ELSE

        UPDATE CuonSach

        SET TinhTrang = 'Đang mượn'

        WHERE MaCuonSach = NEW.MaCuonSach;

    END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `trg_TraSach_HoanTonKho` AFTER UPDATE ON `ct_phieumuon` FOR EACH ROW BEGIN

    -- Chỉ chạy khi trạng thái vừa được đổi sang "Đã trả"

    IF NEW.TrangThai = 'Đã trả' AND OLD.TrangThai != 'Đã trả' THEN



        UPDATE CuonSach

        SET TinhTrang = 'Sẵn sàng'

        WHERE MaCuonSach = NEW.MaCuonSach;



    END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `cuonsach`
--

DROP TABLE IF EXISTS `cuonsach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cuonsach` (
  `MaCuonSach` varchar(20) NOT NULL,
  `MaDauSach` varchar(20) NOT NULL,
  `TinhTrang` varchar(50) NOT NULL DEFAULT 'Sẵn sàng',
  PRIMARY KEY (`MaCuonSach`),
  KEY `FK_CuonSach_DauSach` (`MaDauSach`),
  CONSTRAINT `FK_CuonSach_DauSach` FOREIGN KEY (`MaDauSach`) REFERENCES `dausach` (`MaDauSach`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuonsach`
--

LOCK TABLES `cuonsach` WRITE;
/*!40000 ALTER TABLE `cuonsach` DISABLE KEYS */;
INSERT INTO `cuonsach` VALUES ('C001','DS01','Con'),('C002','DS01','Con'),('C005','DS03','Con'),('C006','DS03','Con'),('C007','DS04','Con'),('C008','DS05','Con'),('C009','DS06','Con'),('C010','DS07','Con'),('C011','DS08','Con'),('C012','DS09','Con'),('C013','DS10','Con'),('C014','DS01','Con');
/*!40000 ALTER TABLE `cuonsach` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `danhsachnguoimuonsach2`
--

DROP TABLE IF EXISTS `danhsachnguoimuonsach2`;
/*!50001 DROP VIEW IF EXISTS `danhsachnguoimuonsach2`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `danhsachnguoimuonsach2` AS SELECT 
 1 AS `MaDocGia`,
 1 AS `HoTen`,
 1 AS `NgaySinh`,
 1 AS `DienThoai`,
 1 AS `MaPM`,
 1 AS `NgayMuon`,
 1 AS `TongSoSachMuon`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `dausach`
--

DROP TABLE IF EXISTS `dausach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dausach` (
  `MaDauSach` varchar(20) NOT NULL,
  `TenSach` varchar(255) NOT NULL,
  `TacGia` varchar(100) DEFAULT NULL,
  `NamXuatBan` smallint DEFAULT NULL,
  `MaTheLoai` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`MaDauSach`),
  KEY `FK_DauSach_TheLoai` (`MaTheLoai`),
  CONSTRAINT `FK_DauSach_TheLoai` FOREIGN KEY (`MaTheLoai`) REFERENCES `theloai` (`MaTheLoai`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dausach`
--

LOCK TABLES `dausach` WRITE;
/*!40000 ALTER TABLE `dausach` DISABLE KEYS */;
INSERT INTO `dausach` VALUES ('DS01','Lap trinh C++','Bjarne Stroustrup',2013,'TL01'),('DS03','Dac Nhan Tam','Dale Carnegie',1936,'TL05'),('DS04','Nha Gia Kim','Paulo Coelho',1988,'TL02'),('DS05','Kinh te hoc','N. Gregory Mankiw',2015,'TL03'),('DS06','AI co ban','Stuart Russell',2020,'TL01'),('DS07','Vat ly dai cuong','Halliday',2010,'TL04'),('DS08','Tu duy nhanh va cham','Daniel Kahneman',2011,'TL05'),('DS09','Lap trinh Python','Mark Lutz',2013,'TL01'),('DS10','Truyen Kieu','Nguyen Du',1820,'TL02'),('test1','test1','test1',1,'TL01');
/*!40000 ALTER TABLE `dausach` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `docgia`
--

DROP TABLE IF EXISTS `docgia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docgia` (
  `MaDocGia` varchar(20) NOT NULL,
  `HoTen` varchar(100) NOT NULL,
  `NgaySinh` date DEFAULT NULL,
  `DiaChi` varchar(255) DEFAULT NULL,
  `DienThoai` varchar(15) DEFAULT NULL,
  `TrangThai` varchar(20) DEFAULT 'HoatDong',
  PRIMARY KEY (`MaDocGia`),
  UNIQUE KEY `DienThoai` (`DienThoai`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `docgia`
--

LOCK TABLES `docgia` WRITE;
/*!40000 ALTER TABLE `docgia` DISABLE KEYS */;
INSERT INTO `docgia` VALUES ('DG01','Nguyen Van A','2000-01-01','HCM','0901','HoatDong'),('DG02','Tran Thi B','2001-02-02','HN','0902','HoatDong'),('DG03','Le Van C','1999-03-03','DN','0903','HoatDong'),('DG04','Pham Thi D','2002-04-04','HCM','0904','HoatDong'),('DG05','Hoang Van E','2000-05-05','Hue','0905','HoatDong'),('DG06','Nguyen Van F','2001-06-06','HCM','0906','HoatDong'),('DG07','Tran Thi G','2002-07-07','HN','0907','HoatDong'),('DG08','Le Van H','2003-08-08','DN','0908','HoatDong'),('DG09','Pham Thi I','2000-09-09','HCM','0909','HoatDong'),('DG10','Hoang Van K','1998-10-10','Hue','0910','HoatDong');
/*!40000 ALTER TABLE `docgia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nhanvien`
--

DROP TABLE IF EXISTS `nhanvien`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nhanvien` (
  `MaNV` varchar(10) NOT NULL,
  `HoTen` varchar(100) NOT NULL,
  `DienThoai` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`MaNV`),
  UNIQUE KEY `DienThoai` (`DienThoai`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nhanvien`
--

LOCK TABLES `nhanvien` WRITE;
/*!40000 ALTER TABLE `nhanvien` DISABLE KEYS */;
INSERT INTO `nhanvien` VALUES ('NV01','Nguyen NV1','111'),('NV02','Nguyen NV2','222'),('NV03','Nguyen NV3','333'),('NV04','Nguyen NV4','444'),('NV05','Nguyen NV5','555');
/*!40000 ALTER TABLE `nhanvien` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phieumuon`
--

DROP TABLE IF EXISTS `phieumuon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phieumuon` (
  `MaPM` varchar(20) NOT NULL,
  `MaDocGia` varchar(20) NOT NULL,
  `MaNV` varchar(10) NOT NULL,
  `NgayMuon` datetime DEFAULT CURRENT_TIMESTAMP,
  `NgayTraDuKien` datetime NOT NULL,
  `TrangThaiTongThe` varchar(50) DEFAULT 'Đang xử lý',
  PRIMARY KEY (`MaPM`),
  KEY `FK_PhieuMuon_DocGia` (`MaDocGia`),
  KEY `FK_PhieuMuon_NhanVien` (`MaNV`),
  CONSTRAINT `FK_PhieuMuon_DocGia` FOREIGN KEY (`MaDocGia`) REFERENCES `docgia` (`MaDocGia`) ON DELETE RESTRICT,
  CONSTRAINT `FK_PhieuMuon_NhanVien` FOREIGN KEY (`MaNV`) REFERENCES `nhanvien` (`MaNV`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phieumuon`
--

LOCK TABLES `phieumuon` WRITE;
/*!40000 ALTER TABLE `phieumuon` DISABLE KEYS */;
INSERT INTO `phieumuon` VALUES ('PM01','DG01','NV01','2026-04-01 00:00:00','2026-04-10 00:00:00','DangMuon'),('PM02','DG02','NV02','2026-04-02 00:00:00','2026-04-11 00:00:00','DangMuon'),('PM03','DG03','NV01','2026-04-03 00:00:00','2026-04-12 00:00:00','DangMuon'),('PM04','DG04','NV03','2026-04-01 00:00:00','2026-04-08 00:00:00','DaTra'),('PM05','DG05','NV02','2026-04-02 00:00:00','2026-04-09 00:00:00','DangMuon'),('PM06','DG06','NV04','2026-04-03 00:00:00','2026-04-10 00:00:00','DangMuon'),('PM07','DG07','NV05','2026-04-01 00:00:00','2026-04-07 00:00:00','DaTra'),('PM08','DG08','NV01','2026-04-02 00:00:00','2026-04-08 00:00:00','DangMuon'),('PM09','DG09','NV02','2026-04-03 00:00:00','2026-04-09 00:00:00','DangMuon'),('PM10','DG10','NV03','2026-04-01 00:00:00','2026-04-10 00:00:00','DangMuon');
/*!40000 ALTER TABLE `phieumuon` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER `trg_KiemTraDocGiaQuaHan` BEFORE INSERT ON `phieumuon` FOR EACH ROW BEGIN

    DECLARE v_SoPhieuQuaHan INT;



    -- Kiểm tra 1: Có phiếu quá hạn chưa trả không?

    SELECT COUNT(*) INTO v_SoPhieuQuaHan

    FROM PhieuMuon

    WHERE MaDocGia         = NEW.MaDocGia

      AND TrangThaiTongThe IN ('Đang xử lý', 'Đang mượn')

      AND NgayTraDuKien    < CURDATE();



    IF v_SoPhieuQuaHan > 0 THEN

        SIGNAL SQLSTATE '45000'

        SET MESSAGE_TEXT = 'Lỗi: Độc giả đang có sách mượn quá hạn chưa trả, không được phép mượn thêm!';

    END IF;



    -- Kiểm tra 2: Đang giữ đủ 5 cuốn rồi không?

    IF fn_DemSoSachDangMuon(NEW.MaDocGia) >= 5 THEN

        SIGNAL SQLSTATE '45000'

        SET MESSAGE_TEXT = 'Lỗi: Độc giả đã mượn đủ 5 cuốn, không được phép mượn thêm!';

    END IF;



END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `phieuphat`
--

DROP TABLE IF EXISTS `phieuphat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phieuphat` (
  `MaPhieuPhat` int NOT NULL AUTO_INCREMENT,
  `MaDocGia` varchar(20) NOT NULL,
  `MaNV` varchar(10) NOT NULL,
  `MaPM` varchar(20) DEFAULT NULL,
  `SoTien` decimal(10,2) NOT NULL,
  `LyDo` varchar(255) NOT NULL,
  `TrangThai` varchar(50) DEFAULT 'Chưa thanh toán',
  `NgayTao` datetime DEFAULT CURRENT_TIMESTAMP,
  `NgayThanhToan` datetime DEFAULT NULL,
  PRIMARY KEY (`MaPhieuPhat`),
  KEY `FK_PhieuPhat_DocGia` (`MaDocGia`),
  KEY `FK_PhieuPhat_NhanVien` (`MaNV`),
  KEY `FK_PhieuPhat_PhieuMuon` (`MaPM`),
  CONSTRAINT `FK_PhieuPhat_DocGia` FOREIGN KEY (`MaDocGia`) REFERENCES `docgia` (`MaDocGia`) ON DELETE RESTRICT,
  CONSTRAINT `FK_PhieuPhat_NhanVien` FOREIGN KEY (`MaNV`) REFERENCES `nhanvien` (`MaNV`) ON DELETE RESTRICT,
  CONSTRAINT `FK_PhieuPhat_PhieuMuon` FOREIGN KEY (`MaPM`) REFERENCES `phieumuon` (`MaPM`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phieuphat`
--

LOCK TABLES `phieuphat` WRITE;
/*!40000 ALTER TABLE `phieuphat` DISABLE KEYS */;
INSERT INTO `phieuphat` VALUES (1,'DG01','NV01','PM01',5000.00,'Trễ hạn','Chưa thanh toán','2026-04-11 00:00:00',NULL),(2,'DG02','NV02','PM02',10000.00,'Mất sách','Đã thanh toán','2026-04-12 00:00:00','2026-04-13 00:00:00'),(3,'DG03','NV01','PM03',7000.00,'Trễ hạn','Chưa thanh toán','2026-04-13 00:00:00',NULL),(4,'DG04','NV03','PM04',3000.00,'Trễ hạn','Đã thanh toán','2026-04-09 00:00:00','2026-04-10 00:00:00'),(5,'DG05','NV02','PM05',8000.00,'Hư hỏng','Chưa thanh toán','2026-04-10 00:00:00',NULL);
/*!40000 ALTER TABLE `phieuphat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `quanlyphieuquahan`
--

DROP TABLE IF EXISTS `quanlyphieuquahan`;
/*!50001 DROP VIEW IF EXISTS `quanlyphieuquahan`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `quanlyphieuquahan` AS SELECT 
 1 AS `MaPM`,
 1 AS `TenDocGia`,
 1 AS `TenNhanVien`,
 1 AS `NgayMuon`,
 1 AS `NgayTraDuKien`,
 1 AS `SoSachDangMuon`,
 1 AS `SoNgayTre`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `taikhoan`
--

DROP TABLE IF EXISTS `taikhoan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taikhoan` (
  `TenDangNhap` varchar(50) NOT NULL,
  `MatKhau` varchar(255) NOT NULL,
  `VaiTro` varchar(20) NOT NULL DEFAULT 'KhachHang',
  `TrangThai` varchar(20) NOT NULL DEFAULT 'HoatDong',
  `MaDocGia` varchar(20) DEFAULT NULL,
  `MaNV` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`TenDangNhap`),
  UNIQUE KEY `MaDocGia` (`MaDocGia`),
  UNIQUE KEY `MaNV` (`MaNV`),
  CONSTRAINT `FK_TaiKhoan_DocGia` FOREIGN KEY (`MaDocGia`) REFERENCES `docgia` (`MaDocGia`) ON DELETE CASCADE,
  CONSTRAINT `FK_TaiKhoan_NhanVien` FOREIGN KEY (`MaNV`) REFERENCES `nhanvien` (`MaNV`) ON DELETE CASCADE,
  CONSTRAINT `CHK_PhanLoaiTaiKhoan` CHECK ((((`MaDocGia` is not null) and (`MaNV` is null)) or ((`MaDocGia` is null) and (`MaNV` is not null))))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taikhoan`
--

LOCK TABLES `taikhoan` WRITE;
/*!40000 ALTER TABLE `taikhoan` DISABLE KEYS */;
INSERT INTO `taikhoan` VALUES ('admin01','123456','QuanTri','HoatDong',NULL,'NV01'),('DG01','123456','KhachHang','HoatDong','DG01',NULL),('thuthu02','123456','ThuThu','HoatDong',NULL,'NV02');
/*!40000 ALTER TABLE `taikhoan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `theloai`
--

DROP TABLE IF EXISTS `theloai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `theloai` (
  `MaTheLoai` varchar(10) NOT NULL,
  `TenTheLoai` varchar(100) NOT NULL,
  `MoTa` text,
  PRIMARY KEY (`MaTheLoai`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `theloai`
--

LOCK TABLES `theloai` WRITE;
/*!40000 ALTER TABLE `theloai` DISABLE KEYS */;
INSERT INTO `theloai` VALUES ('TL006','Trinh Tham','kich tinh'),('TL01','CNTT','Công nghệ thông tin'),('TL02','VanHoc','Văn học'),('TL03','KinhTe','Kinh tế'),('TL04','KhoaHoc','Khoa học'),('TL05','KyNang','Kỹ năng sống');
/*!40000 ALTER TABLE `theloai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `thongkesachdangmuon`
--

DROP TABLE IF EXISTS `thongkesachdangmuon`;
/*!50001 DROP VIEW IF EXISTS `thongkesachdangmuon`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `thongkesachdangmuon` AS SELECT 
 1 AS `MaDauSach`,
 1 AS `TenSach`,
 1 AS `SoLuongDangMuon`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `thongkesachtheotheloai`
--

DROP TABLE IF EXISTS `thongkesachtheotheloai`;
/*!50001 DROP VIEW IF EXISTS `thongkesachtheotheloai`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `thongkesachtheotheloai` AS SELECT 
 1 AS `MaTheLoai`,
 1 AS `TenTheLoai`,
 1 AS `TongSoSach`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_lichsumuon`
--

DROP TABLE IF EXISTS `v_lichsumuon`;
/*!50001 DROP VIEW IF EXISTS `v_lichsumuon`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_lichsumuon` AS SELECT 
 1 AS `MaPM`,
 1 AS `TenDocGia`,
 1 AS `NgaySinh`,
 1 AS `TenNhanVien`,
 1 AS `NgayMuon`,
 1 AS `NgayTraDuKien`,
 1 AS `TrangThaiTongThe`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_phieumuonchitiet`
--

DROP TABLE IF EXISTS `v_phieumuonchitiet`;
/*!50001 DROP VIEW IF EXISTS `v_phieumuonchitiet`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_phieumuonchitiet` AS SELECT 
 1 AS `MaPM`,
 1 AS `TenDocGia`,
 1 AS `NhanVienLap`,
 1 AS `TenSach`,
 1 AS `MaCuonSach`,
 1 AS `NgayMuon`,
 1 AS `NgayTraDuKien`,
 1 AS `NgayTraThucTe`,
 1 AS `TinhTrangCuonSach`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_quanlysach`
--

DROP TABLE IF EXISTS `v_quanlysach`;
/*!50001 DROP VIEW IF EXISTS `v_quanlysach`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_quanlysach` AS SELECT 
 1 AS `MaDauSach`,
 1 AS `TenSach`,
 1 AS `TacGia`,
 1 AS `NamXuatBan`,
 1 AS `TenTheLoai`,
 1 AS `TongSoCuon`,
 1 AS `SoCuonSanSang`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_sachdangmuon_docgia`
--

DROP TABLE IF EXISTS `v_sachdangmuon_docgia`;
/*!50001 DROP VIEW IF EXISTS `v_sachdangmuon_docgia`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_sachdangmuon_docgia` AS SELECT 
 1 AS `MaDocGia`,
 1 AS `HoTen`,
 1 AS `TongDangMuon`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'libmn'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_DemSoSachDangMuon` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  FUNCTION `fn_DemSoSachDangMuon`(p_MaDocGia VARCHAR(50)) RETURNS int
    READS SQL DATA
BEGIN

    DECLARE v_TongSach INT;



    SELECT COUNT(ct.MaCuonSach)

    INTO v_TongSach

    FROM PhieuMuon pm

    JOIN CT_PhieuMuon ct ON pm.MaPM = ct.MaPM

    WHERE pm.MaDocGia  = p_MaDocGia

      AND ct.TrangThai = 'Đang mượn';



    RETURN IFNULL(v_TongSach, 0);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_TinhTienPhat` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  FUNCTION `fn_TinhTienPhat`(p_NgayTraDuKien DATE, p_NgayTraThucTe DATE) RETURNS decimal(18,2)
    READS SQL DATA
BEGIN

    DECLARE v_TienPhat  DECIMAL(18,2) DEFAULT 0;

    DECLARE v_SoNgayTre INT;

    DECLARE v_NgayTra   DATE;



    -- Nếu chưa trả thì lấy ngày hiện tại để tính phạt tạm thời

    SET v_NgayTra   = IFNULL(p_NgayTraThucTe, CURDATE());

    SET v_SoNgayTre = DATEDIFF(v_NgayTra, p_NgayTraDuKien);



    IF v_SoNgayTre > 0 THEN

        SET v_TienPhat = v_SoNgayTre * 5000;

    END IF;



    RETURN v_TienPhat;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CapNhatDauSach` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `CapNhatDauSach`(

    IN p_MaDauSach VARCHAR(10),

    IN p_TenSach NVARCHAR(100),

    IN p_MaTheLoai VARCHAR(10),

    IN p_TacGia NVARCHAR(100),

    IN p_NamXB INT

)
BEGIN



    IF p_MaTheLoai IS NOT NULL THEN

        IF NOT EXISTS (SELECT 1 FROM TheLoai WHERE MaTheLoai = p_MaTheLoai) THEN

            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lỗi: Mã thể loại không tồn tại!';

        END IF;

    END IF;



    UPDATE DauSach 

    SET 

        TenSach = COALESCE(p_TenSach, TenSach),

        MaTheLoai = COALESCE(p_MaTheLoai, MaTheLoai),

        TacGia = COALESCE(p_TacGia, TacGia),

        NamXuatBan = COALESCE(p_NamXB, NamXuatBan)

    WHERE MaDauSach = p_MaDauSach;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CapNhatDocGia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `CapNhatDocGia`(

    IN MaDocGiaMoi VARCHAR(20),

    IN HoTenMoi VARCHAR(100),

    IN NgaySinhMoi DATE,

    IN DiaChiMoi VARCHAR(255),

    IN DienThoaiMoi VARCHAR(15)

)
BEGIN

    IF NOT EXISTS (SELECT 1 FROM DocGia WHERE MaDocGia = MaDocGiaMoi) THEN

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lỗi: Mã Độc Giả không tồn tại!';

    ELSE

        UPDATE DocGia

        SET HoTen = HoTenMoi, NgaySinh = NgaySinhMoi, DiaChi = DiaChiMoi, DienThoai = DienThoaiMoi

        WHERE MaDocGia = MaDocGiaMoi;

    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CapNhatNhanVien` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `CapNhatNhanVien`(

    IN MaNVMoi VARCHAR(10),

    IN HoTenMoi VARCHAR(100),

    IN DienThoaiMoi VARCHAR(15)

)
BEGIN

    IF NOT EXISTS (SELECT 1 FROM NhanVien WHERE MaNV = MaNVMoi) THEN

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lỗi: Mã Nhân Viên không tồn tại!';

    ELSE

        UPDATE NhanVien SET HoTen = HoTenMoi, DienThoai = DienThoaiMoi WHERE MaNV = MaNVMoi;

    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CapNhatTheLoai` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `CapNhatTheLoai`(

    IN MaTheLoaiMoi VARCHAR(10),

    IN TenTheLoaiMoi VARCHAR(100),

    IN MoTaMoi TEXT

)
BEGIN

    IF NOT EXISTS (SELECT 1 FROM TheLoai WHERE MaTheLoai = MaTheLoaiMoi) THEN

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lỗi: Mã Thể Loại không tồn tại!';

    ELSE

        UPDATE TheLoai 

        SET TenTheLoai = TenTheLoaiMoi, MoTa = MoTaMoi

        WHERE MaTheLoai = MaTheLoaiMoi;

    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GiaHanSach` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `GiaHanSach`(

    IN p_MaPM VARCHAR(20),

    IN p_SoNgayThem INT

)
BEGIN

    UPDATE PhieuMuon

    SET NgayTraDuKien = DATE_ADD(NgayTraDuKien, INTERVAL p_SoNgayThem DAY)

    WHERE MaPM = p_MaPM;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `KhoaTheDocGia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `KhoaTheDocGia`(

    IN MaDocGiaMoi VARCHAR(20)

)
BEGIN

    IF NOT EXISTS (SELECT 1 FROM DocGia WHERE MaDocGia = MaDocGiaMoi) THEN

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lỗi: Mã Độc Giả không tồn tại!';

    ELSE

        UPDATE DocGia SET TrangThai = 'BiKhoa' WHERE MaDocGia = MaDocGiaMoi;

    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MoKhoaTheDocGia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `MoKhoaTheDocGia`(

    IN MaDocGiaMoi VARCHAR(20)

)
BEGIN

    IF NOT EXISTS (SELECT 1 FROM DocGia WHERE MaDocGia = MaDocGiaMoi) THEN

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lỗi: Mã Độc Giả không tồn tại!';

    ELSE

        UPDATE DocGia SET TrangThai = 'HoatDong' WHERE MaDocGia = MaDocGiaMoi;

    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `NhapKhoCuonSach` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `NhapKhoCuonSach`(

    IN MaDauSachMoi VARCHAR(20),

    IN SoLuong INT

)
BEGIN

    DECLARE i INT DEFAULT 1;

    DECLARE maxID INT;

    

    IF NOT EXISTS (SELECT 1 FROM DauSach WHERE MaDauSach = MaDauSachMoi) THEN

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lỗi: Mã Đầu Sách không tồn tại!';

    ELSE

        SELECT IFNULL(MAX(CAST(SUBSTRING(MaCuonSach, 2) AS UNSIGNED)), 0) INTO maxID

        FROM CuonSach

        WHERE MaCuonSach LIKE 'C%';

        

        WHILE i <= SoLuong DO

            SET maxID = maxID + 1;

            INSERT INTO CuonSach(MaCuonSach, MaDauSach, TinhTrang)

            VALUES (CONCAT('C', LPAD(maxID, 3, '0')), MaDauSachMoi, 'Sẵn sàng');

            SET i = i + 1;

        END WHILE;

    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ThanhToanTienPhat` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `sp_ThanhToanTienPhat`(

    IN p_MaPhieuPhat INT,

    IN p_MaNV VARCHAR(10)

)
BEGIN

    DECLARE v_TrangThai VARCHAR(50);



    DECLARE EXIT HANDLER FOR SQLEXCEPTION

    BEGIN

        ROLLBACK;

        RESIGNAL;

    END;



    START TRANSACTION;

        SELECT TrangThai INTO v_TrangThai

        FROM PhieuPhat

        WHERE MaPhieuPhat = p_MaPhieuPhat

        FOR UPDATE;



        IF v_TrangThai IS NULL THEN

            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lỗi: Không tìm thấy phiếu phạt!';

        END IF;



        IF v_TrangThai = 'Đã thanh toán' THEN

            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lỗi: Phiếu phạt này đã được thanh toán trước đó!';

        END IF;



        UPDATE PhieuPhat

        SET TrangThai = 'Đã thanh toán', NgayThanhToan = CURDATE(), MaNV = p_MaNV

        WHERE MaPhieuPhat = p_MaPhieuPhat;

    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_TimKiemDocGia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `sp_TimKiemDocGia`(IN p_TuKhoa VARCHAR(100))
BEGIN

    SELECT MaDocGia, HoTen, NgaySinh, DiaChi, DienThoai

    FROM DocGia

    WHERE HoTen LIKE CONCAT('%', p_TuKhoa, '%')

       OR DienThoai LIKE CONCAT('%', p_TuKhoa, '%');

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_TraCuuPhieuMuon` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `sp_TraCuuPhieuMuon`(IN p_TuKhoa VARCHAR(100))
BEGIN

    SELECT 

        pm.MaPM, 

        dg.HoTen AS TenDocGia, 

        nv.HoTen AS TenNhanVien, 

        pm.NgayMuon, 

        pm.NgayTraDuKien, 

        pm.TrangThaiTongThe

    FROM PhieuMuon pm

    JOIN DocGia dg ON pm.MaDocGia = dg.MaDocGia

    JOIN NhanVien nv ON pm.MaNV = nv.MaNV

    WHERE pm.MaPM LIKE CONCAT('%', p_TuKhoa, '%')

       OR dg.HoTen LIKE CONCAT('%', p_TuKhoa, '%')

       OR pm.NgayMuon LIKE CONCAT('%', p_TuKhoa, '%');

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ThemDauSach` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `ThemDauSach`(

    IN MaDauSachMoi VARCHAR(20),

    IN TenSachMoi VARCHAR(100),

    IN MaTheLoaiMoi VARCHAR(10),

    IN TacGiaMoi VARCHAR(100),

    IN NamXBMoi SMALLINT

)
BEGIN

    IF EXISTS (SELECT 1 FROM DauSach WHERE MaDauSach = MaDauSachMoi) THEN

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lỗi: Mã Đầu Sách đã tồn tại!';

    ELSEIF NOT EXISTS (SELECT 1 FROM TheLoai WHERE MaTheLoai = MaTheLoaiMoi) THEN

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lỗi: Mã Thể Loại không tồn tại!';

    ELSE

        INSERT INTO DauSach(MaDauSach, TenSach, MaTheLoai, TacGia, NamXuatBan)

        VALUES (MaDauSachMoi, TenSachMoi, MaTheLoaiMoi, TacGiaMoi, NamXBMoi);

    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ThemDocGia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `ThemDocGia`(

    IN MaDocGiaMoi VARCHAR(20),

    IN HoTenMoi VARCHAR(100),

    IN NgaySinhMoi DATE,

    IN DiaChiMoi VARCHAR(255),

    IN DienThoaiMoi VARCHAR(15)

)
BEGIN

    IF EXISTS (SELECT 1 FROM DocGia WHERE MaDocGia = MaDocGiaMoi) THEN

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lỗi: Mã Độc Giả đã tồn tại!';

    ELSE

        INSERT INTO DocGia(MaDocGia, HoTen, NgaySinh, DiaChi, DienThoai, TrangThai)

        VALUES (MaDocGiaMoi, HoTenMoi, NgaySinhMoi, DiaChiMoi, DienThoaiMoi, 'HoatDong');

    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ThemNhanVien` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `ThemNhanVien`(

    IN MaNVMoi VARCHAR(10),

    IN HoTenMoi VARCHAR(100),

    IN DienThoaiMoi VARCHAR(15)

)
BEGIN

    IF EXISTS (SELECT 1 FROM NhanVien WHERE MaNV = MaNVMoi) THEN

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lỗi: Mã Nhân Viên đã tồn tại!';

    ELSE

        INSERT INTO NhanVien(MaNV, HoTen, DienThoai) VALUES (MaNVMoi, HoTenMoi, DienThoaiMoi);

    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ThemTheLoai` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `ThemTheLoai`(

    IN MaTheLoaiMoi VARCHAR(10),

    IN TenTheLoaiMoi VARCHAR(100),

    IN MoTaMoi TEXT

)
BEGIN

    IF EXISTS (

        SELECT * 

        FROM TheLoai tl 

        WHERE tl.MaTheLoai = MaTheLoaiMoi

    ) THEN

        SIGNAL SQLSTATE '45000'

        SET MESSAGE_TEXT = 'MaTheLoai da ton tai!';

    ELSE

        INSERT INTO TheLoai(MaTheLoai, TenTheLoai, MoTa)

        VALUES (MaTheLoaiMoi, TenTheLoaiMoi, MoTaMoi);

    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ThucHienMuonNhieuSach` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `ThucHienMuonNhieuSach`(

    IN p_MaDocGia VARCHAR(20),

    IN p_MaNV VARCHAR(10),

    IN p_NgayTraDuKien DATETIME,

    IN p_DanhSach JSON

)
BEGIN

    DECLARE v_MaPM VARCHAR(20);

    DECLARE i INT DEFAULT 0;

    DECLARE n INT;



    SET v_MaPM = CONCAT('PM', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'));

    SET n = JSON_LENGTH(p_DanhSach);



    START TRANSACTION;

    

    INSERT INTO PhieuMuon(MaPM, MaDocGia, MaNV, NgayTraDuKien, TrangThaiTongThe)

    VALUES (v_MaPM, p_MaDocGia, p_MaNV, p_NgayTraDuKien, 'Đang xử lý');

    

    WHILE i < n DO

        INSERT INTO CT_PhieuMuon(MaPM, MaCuonSach)

        VALUES (v_MaPM, JSON_UNQUOTE(JSON_EXTRACT(p_DanhSach, CONCAT('$[', i, ']'))));

        SET i = i + 1;

    END WHILE;



    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ThucHienTraSach` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `ThucHienTraSach`(

    IN p_MaPM VARCHAR(20),

    IN p_DanhSach JSON

)
BEGIN

    DECLARE i INT DEFAULT 0;

    DECLARE n INT;



    SET n = JSON_LENGTH(p_DanhSach);



    START TRANSACTION;



    WHILE i < n DO

        UPDATE CT_PhieuMuon

        SET NgayTraThucTe = NOW(), TrangThai = 'Đã trả'

        WHERE MaPM = p_MaPM 

          AND MaCuonSach = JSON_UNQUOTE(JSON_EXTRACT(p_DanhSach, CONCAT('$[', i, ']')));

          

        SET i = i + 1;

    END WHILE;



    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TimKiemDauSach` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `TimKiemDauSach`(

    IN p_TenSach NVARCHAR(100),

    IN p_TacGia NVARCHAR(100),

    IN p_MaTheLoai VARCHAR(10)

)
BEGIN

    SELECT 

        ds.MaDauSach, 

        ds.TenSach, 

        ds.TacGia, 

        ds.NamXuatBan,

        tl.TenTheLoai,

        ds.MaTheLoai

    FROM DauSach ds

    LEFT JOIN TheLoai tl ON ds.MaTheLoai = tl.MaTheLoai

    WHERE 

        

        (p_TenSach IS NULL OR ds.TenSach LIKE CONCAT('%', p_TenSach, '%'))

        AND 

        (p_TacGia IS NULL OR ds.TacGia LIKE CONCAT('%', p_TacGia, '%'))

        AND 

        (p_MaTheLoai IS NULL OR ds.MaTheLoai = p_MaTheLoai);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `XoaTheLoai` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `XoaTheLoai`(

    IN MaTheLoaiXoa VARCHAR(10)

)
BEGIN

    IF NOT EXISTS (SELECT 1 FROM TheLoai WHERE MaTheLoai = MaTheLoaiXoa) THEN

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lỗi: Mã Thể Loại không tồn tại!';

    ELSE

        DELETE FROM TheLoai WHERE MaTheLoai = MaTheLoaiXoa;

    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `chitietmuon`
--

/*!50001 DROP VIEW IF EXISTS `chitietmuon`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `chitietmuon` AS select `dg`.`MaDocGia` AS `MaDocGia`,`dg`.`HoTen` AS `HoTen`,`pm`.`MaPM` AS `MaPM`,`pm`.`NgayMuon` AS `NgayMuon`,`ds`.`TenSach` AS `TenSach` from ((((`docgia` `dg` join `phieumuon` `pm` on((`pm`.`MaDocGia` = `dg`.`MaDocGia`))) join `ct_phieumuon` `ct` on((`ct`.`MaPM` = `pm`.`MaPM`))) join `cuonsach` `cs` on((`cs`.`MaCuonSach` = `ct`.`MaCuonSach`))) join `dausach` `ds` on((`ds`.`MaDauSach` = `cs`.`MaDauSach`))) where (`ct`.`TrangThai` = 'Đang mượn') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `chitietphieumuon`
--

/*!50001 DROP VIEW IF EXISTS `chitietphieumuon`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `chitietphieumuon` AS select `dg`.`MaDocGia` AS `MaDocGia`,`dg`.`HoTen` AS `HoTen`,`dg`.`NgaySinh` AS `NgaySinh`,`dg`.`DienThoai` AS `DienThoai`,`pm`.`MaPM` AS `MaPM`,`pm`.`NgayMuon` AS `NgayMuon`,`ct`.`MaCuonSach` AS `MaCuonSach`,`ds`.`TenSach` AS `TenSach`,`ct`.`TrangThai` AS `TrangThai` from ((((`docgia` `dg` join `phieumuon` `pm` on((`pm`.`MaDocGia` = `dg`.`MaDocGia`))) join `ct_phieumuon` `ct` on((`ct`.`MaPM` = `pm`.`MaPM`))) join `cuonsach` `cs` on((`cs`.`MaCuonSach` = `ct`.`MaCuonSach`))) join `dausach` `ds` on((`ds`.`MaDauSach` = `cs`.`MaDauSach`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `danhsachnguoimuonsach2`
--

/*!50001 DROP VIEW IF EXISTS `danhsachnguoimuonsach2`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `danhsachnguoimuonsach2` AS select `dg`.`MaDocGia` AS `MaDocGia`,`dg`.`HoTen` AS `HoTen`,`dg`.`NgaySinh` AS `NgaySinh`,`dg`.`DienThoai` AS `DienThoai`,`pm`.`MaPM` AS `MaPM`,`pm`.`NgayMuon` AS `NgayMuon`,count(`ct`.`MaCuonSach`) AS `TongSoSachMuon` from ((`docgia` `dg` join `phieumuon` `pm` on((`pm`.`MaDocGia` = `dg`.`MaDocGia`))) join `ct_phieumuon` `ct` on((`ct`.`MaPM` = `pm`.`MaPM`))) group by `dg`.`MaDocGia`,`dg`.`HoTen`,`dg`.`NgaySinh`,`dg`.`DienThoai`,`pm`.`MaPM`,`pm`.`NgayMuon` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `quanlyphieuquahan`
--

/*!50001 DROP VIEW IF EXISTS `quanlyphieuquahan`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `quanlyphieuquahan` AS select `pm`.`MaPM` AS `MaPM`,`dg`.`HoTen` AS `TenDocGia`,`nv`.`HoTen` AS `TenNhanVien`,`pm`.`NgayMuon` AS `NgayMuon`,`pm`.`NgayTraDuKien` AS `NgayTraDuKien`,count(`ct`.`MaCuonSach`) AS `SoSachDangMuon`,(to_days(curdate()) - to_days(`pm`.`NgayTraDuKien`)) AS `SoNgayTre` from (((`phieumuon` `pm` join `docgia` `dg` on((`dg`.`MaDocGia` = `pm`.`MaDocGia`))) join `nhanvien` `nv` on((`nv`.`MaNV` = `pm`.`MaNV`))) join `ct_phieumuon` `ct` on((`ct`.`MaPM` = `pm`.`MaPM`))) where ((`pm`.`NgayTraDuKien` < curdate()) and (`ct`.`NgayTraThucTe` is null)) group by `pm`.`MaPM`,`dg`.`HoTen`,`nv`.`HoTen`,`pm`.`NgayMuon`,`pm`.`NgayTraDuKien` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `thongkesachdangmuon`
--

/*!50001 DROP VIEW IF EXISTS `thongkesachdangmuon`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `thongkesachdangmuon` AS select `ds`.`MaDauSach` AS `MaDauSach`,`ds`.`TenSach` AS `TenSach`,count(`ct`.`MaCuonSach`) AS `SoLuongDangMuon` from ((`ct_phieumuon` `ct` join `cuonsach` `cs` on((`cs`.`MaCuonSach` = `ct`.`MaCuonSach`))) join `dausach` `ds` on((`ds`.`MaDauSach` = `cs`.`MaDauSach`))) where (`ct`.`TrangThai` = 'Đang mượn') group by `ds`.`MaDauSach`,`ds`.`TenSach` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `thongkesachtheotheloai`
--

/*!50001 DROP VIEW IF EXISTS `thongkesachtheotheloai`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `thongkesachtheotheloai` AS select `tl`.`MaTheLoai` AS `MaTheLoai`,`tl`.`TenTheLoai` AS `TenTheLoai`,count(`cs`.`MaCuonSach`) AS `TongSoSach` from ((`theloai` `tl` left join `dausach` `ds` on((`ds`.`MaTheLoai` = `tl`.`MaTheLoai`))) left join `cuonsach` `cs` on((`cs`.`MaDauSach` = `ds`.`MaDauSach`))) group by `tl`.`MaTheLoai`,`tl`.`TenTheLoai` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_lichsumuon`
--

/*!50001 DROP VIEW IF EXISTS `v_lichsumuon`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `v_lichsumuon` AS select `pm`.`MaPM` AS `MaPM`,`dg`.`HoTen` AS `TenDocGia`,`dg`.`NgaySinh` AS `NgaySinh`,`nv`.`HoTen` AS `TenNhanVien`,`pm`.`NgayMuon` AS `NgayMuon`,`pm`.`NgayTraDuKien` AS `NgayTraDuKien`,`pm`.`TrangThaiTongThe` AS `TrangThaiTongThe` from ((`phieumuon` `pm` join `docgia` `dg` on((`pm`.`MaDocGia` = `dg`.`MaDocGia`))) join `nhanvien` `nv` on((`pm`.`MaNV` = `nv`.`MaNV`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_phieumuonchitiet`
--

/*!50001 DROP VIEW IF EXISTS `v_phieumuonchitiet`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `v_phieumuonchitiet` AS select `pm`.`MaPM` AS `MaPM`,`dg`.`HoTen` AS `TenDocGia`,`nv`.`HoTen` AS `NhanVienLap`,`ds`.`TenSach` AS `TenSach`,`cs`.`MaCuonSach` AS `MaCuonSach`,`pm`.`NgayMuon` AS `NgayMuon`,`pm`.`NgayTraDuKien` AS `NgayTraDuKien`,`ct`.`NgayTraThucTe` AS `NgayTraThucTe`,`ct`.`TrangThai` AS `TinhTrangCuonSach` from (((((`phieumuon` `pm` join `ct_phieumuon` `ct` on((`pm`.`MaPM` = `ct`.`MaPM`))) join `cuonsach` `cs` on((`ct`.`MaCuonSach` = `cs`.`MaCuonSach`))) join `dausach` `ds` on((`cs`.`MaDauSach` = `ds`.`MaDauSach`))) join `docgia` `dg` on((`pm`.`MaDocGia` = `dg`.`MaDocGia`))) join `nhanvien` `nv` on((`pm`.`MaNV` = `nv`.`MaNV`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_quanlysach`
--

/*!50001 DROP VIEW IF EXISTS `v_quanlysach`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `v_quanlysach` AS select `ds`.`MaDauSach` AS `MaDauSach`,`ds`.`TenSach` AS `TenSach`,`ds`.`TacGia` AS `TacGia`,`ds`.`NamXuatBan` AS `NamXuatBan`,`tl`.`TenTheLoai` AS `TenTheLoai`,count(`cs`.`MaCuonSach`) AS `TongSoCuon`,sum((case when (`cs`.`TinhTrang` = 'Sẵn sàng') then 1 else 0 end)) AS `SoCuonSanSang` from ((`dausach` `ds` join `theloai` `tl` on((`ds`.`MaTheLoai` = `tl`.`MaTheLoai`))) left join `cuonsach` `cs` on((`ds`.`MaDauSach` = `cs`.`MaDauSach`))) group by `ds`.`MaDauSach`,`ds`.`TenSach`,`ds`.`TacGia`,`ds`.`NamXuatBan`,`tl`.`TenTheLoai` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_sachdangmuon_docgia`
--

/*!50001 DROP VIEW IF EXISTS `v_sachdangmuon_docgia`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013  SQL SECURITY DEFINER */
/*!50001 VIEW `v_sachdangmuon_docgia` AS select `dg`.`MaDocGia` AS `MaDocGia`,`dg`.`HoTen` AS `HoTen`,count(`ct`.`MaCuonSach`) AS `TongDangMuon` from ((`docgia` `dg` join `phieumuon` `pm` on((`dg`.`MaDocGia` = `pm`.`MaDocGia`))) join `ct_phieumuon` `ct` on((`pm`.`MaPM` = `ct`.`MaPM`))) where (`ct`.`TrangThai` = 'Đang mượn') group by `dg`.`MaDocGia`,`dg`.`HoTen` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-19  0:53:59
