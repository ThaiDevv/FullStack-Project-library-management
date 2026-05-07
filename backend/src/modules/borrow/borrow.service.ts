import { BadRequestException, Injectable } from '@nestjs/common';
import { DatabaseService } from 'src/database/database.service';
import { creatBorrowDto } from './dto/creatBorrow.dto';
import { updateBorrowDto } from './dto/updateDealine.dto';
import { add_DelBookDto } from './dto/add_DelBook.dto';
import { searchDto } from './dto/searchBorrow.dto';

@Injectable()
export class BorrowService {
  constructor(private readonly db: DatabaseService) { }

  // ================== GIỮ NGUYÊN ==================
  async creatBorrow(CreatborrowDto: creatBorrowDto) {
    try {
      const { MaDocGia, MaNV, NgayTraDuKien, DanhSach } = CreatborrowDto;
      const sql = 'CALL ThucHienMuonNhieuSach(?,?,?,?)';

      // ⚠️ FIX JSON
      const params = [
        MaDocGia,
        MaNV,
        NgayTraDuKien,
        JSON.stringify(DanhSach)
      ];

      await this.db.query(sql, params);

      return {
        success: true,
        message: 'Thêm Phiếu Mượn thành công!',
      };
    } catch (error) {
      throw new Error(`Lỗi khi thêm Phiếu Mượn: ${error.message}`);
    }
  }

  // ================== DEMO DIRTY READ ==================
  async demoBorrow(CreatborrowDto: creatBorrowDto) {
    try {
      const { MaDocGia, MaNV, NgayTraDuKien, DanhSach } = CreatborrowDto;

      const sql = 'CALL DemoMuonSach(?,?,?,?)';

      const params = [
        MaDocGia,
        MaNV,
        NgayTraDuKien,
        JSON.stringify(DanhSach) // ⚠️ bắt buộc
      ];

      await this.db.query(sql, params);

      return {
        success: true,
        message: 'Đang chạy transaction (sleep 10s để demo Dirty Read)...',
      };

    } catch (error) {
      // ⚠️ sẽ bắt SIGNAL rollback từ MySQL
      throw new BadRequestException(
        `Giao dịch bị rollback (demo dirty read): ${error.message}`
      );
    }
  }

  // ================== UPDATE ==================
  async updateDeadline(updateBorrowDto: updateBorrowDto) {
    try {
      console.log("bắt đầu chạy");

      const { MaPM, SoNgayThem } = updateBorrowDto;
      const sql = 'CALL GiaHanSach(?,?)';
      const params = [MaPM, SoNgayThem];

      await this.db.query(sql, params);

      console.log(`kết thúc chạy quá trình: ${MaPM}`);

      return {
        success: true,
        message: 'Cập nhật Phiếu Mượn thành công!',
      };
    } catch (error) {
      throw new Error(`Lỗi khi cập nhật Phiếu Mượn: ${error.message}`);
    }
  }

  // ================== DELETE ==================
  async deleteBorrow(MaPM: string) {
    try {
      const sql = 'DELETE FROM phieumuon WHERE MaPM = ?';
      await this.db.query(sql, [MaPM]);

      return {
        success: true,
        message: 'Xóa Phiếu Mượn thành công!',
      };
    } catch (error) {
      throw new Error(`Lỗi khi xóa Phiếu Mượn: ${error.message}`);
    }
  }

  // ================== SEARCH ==================
  async findAll(SearchDto: searchDto) {
    try {
      const { TenDocGia, TuNgay, DenNgay } = SearchDto;

      const sql = 'CALL TimKiemMuonSach(?,?,?)';
      const params = [TenDocGia || null, TuNgay || null, DenNgay || null];

      const result = await this.db.query(sql, params);
      return result[0];

    } catch (error) {
      throw new BadRequestException(
        `Lỗi khi Tìm Kiếm Phiếu Mượn: ${error.message}`,
      );
    }
  }

  // ================== DEMO READ ==================
  async getAllPhieuMuon() {
    try {
      const sql = 'SELECT * FROM phieumuon ORDER BY NgayMuon DESC';
      const result = await this.db.query(sql);

      return result;

    } catch (error) {
      throw new BadRequestException(error.message);
    }
  }

  // ================== ADD BOOK ==================
  async addBookinBorrow(addBookDto: add_DelBookDto) {
    try {
      const { MaPM, DanhSach } = addBookDto;

      const sql = 'CALL ThemSachVaoPhieuMuon(?,?)';
      const params = [MaPM, JSON.stringify(DanhSach)];

      await this.db.query(sql, params);

      return {
        success: true,
        message: 'Thêm sách vào Phiếu Mượn thành công!',
      };
    } catch (error) {
      throw new Error(`Lỗi khi thêm sách: ${error.message}`);
    }
  }

  // ================== DELETE BOOK ==================
  async deleteBookInBorrow(delBookDto: add_DelBookDto) {
    try {
      const { MaPM, DanhSach } = delBookDto;

      const sql = 'CALL ThucHienTraSach(?,?)';
      const params = [MaPM, JSON.stringify(DanhSach)];

      await this.db.query(sql, params);

      return {
        success: true,
        message: 'Trả sách thành công!',
      };
    } catch (error) {
      throw new Error(`Lỗi khi trả sách: ${error.message}`);
    }
  }

  // ================== FIND ONE ==================
  async findOne(MaPM: string) {
    const result = await this.db.query(
      'SELECT * FROM v_phieumuonchitiet WHERE MaPM = ?',
      [MaPM],
    );
    return result[0] ?? null;
  }

  // ================== RETURN ALL ==================
  async returnBooks(MaPM: string) {
    try {
      const sql = 'CALL TraNhieuSach(?)';
      await this.db.query(sql, [MaPM]);

      return {
        success: true,
        message: 'Trả sách thành công!',
      };
    } catch (error) {
      throw new Error(`Lỗi khi trả sách: ${error.message}`);
    }
  }
}