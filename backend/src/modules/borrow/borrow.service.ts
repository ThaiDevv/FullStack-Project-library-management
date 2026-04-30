import { BadRequestException, Injectable } from '@nestjs/common';
import { DatabaseService } from 'src/database/database.service';
import { creatBorrowDto } from './dto/creatBorrow.dto';
import { updateBorrowDto } from './dto/updateDealine.dto';
import { add_DelBookDto } from './dto/add_DelBook.dto';
import { searchDto } from './dto/searchBorrow.dto';

@Injectable()
export class BorrowService {
  constructor(private readonly db: DatabaseService) {}
  async creatBorrow(CreatborrowDto: creatBorrowDto) {
    try {
      const { MaDocGia, MaNV, NgayTraDuKien, DanhSach } = CreatborrowDto;
      const sql = 'CALL ThucHienMuonNhieuSach(?,?,?,?)';
      const params = [MaDocGia, MaNV, NgayTraDuKien, DanhSach];
      const result = await this.db.query(sql, params);
      return {
        success: true,
        message: 'Thêm Phieu Muon thành công!',
      };
    } catch (error) {
      throw new Error(`Lỗi khi thêm PHieu Muon: ${error.message}`);
    }
  }
  async updateDeadline(updateBorrowDto: updateBorrowDto) {
    try {
      const { MaPM, SoNgayThem } = updateBorrowDto;
      const sql = 'CALL GiaHanSach(?,?)';
      const params = [MaPM, SoNgayThem];
      const result = await this.db.query(sql, params);
      return {
        success: true,
        message: 'cap nhat Phieu Muon thành công!',
      };
    } catch (error) {
      throw new Error(`Lỗi khi cap nhat PHieu Muon: ${error.message}`);
    }
  }
  async deleteBorrow(MaPM: string) {
    try {
      const sql = 'DELETE FROM phieumuon WHERE phieumuon.MaPM = ?';
      const params = [MaPM];
      const result = await this.db.query(sql, params);
      return {
        success: true,
        message: 'xoa Phieu Muon thành công!',
      };
    } catch (error) {
      throw new Error(`Lỗi khi xoa PHieu Muon: ${error.message}`);
    }
  }
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
  async addBookinBorrow(addBookDto: add_DelBookDto) {
    try {
      const { MaPM, DanhSach } = addBookDto;
      const sql = 'Call ThemSachVaoPhieuMuon(?,?)';
      const params = [MaPM, DanhSach];
      const result = await this.db.query(sql, params);
      return {
        success: true,
        message: 'Them sach vao Phieu Muon thành công!',
      };
    } catch (error) {
      throw new Error(`Lỗi khi Them sach vao PHieu Muon: ${error.message}`);
    }
  }
  async deleteBookInBorrow(delBookDto: add_DelBookDto){
    try {
      const { MaPM, DanhSach } = delBookDto;
      const sql = 'Call ThucHienTraSach(?,?)';
      const params = [MaPM, DanhSach];
      const result = await this.db.query(sql, params);
      return {
        success: true,
        message: 'Trả sách thành công!',
      };
    } catch (error) {
      throw new Error(`Lỗi khi Trả sách: ${error.message}`);
    }
  }
  async findOne(MaPM: string) {
    const result = await this.db.query(
      'SELECT * FROM v_phieumuonchitiet WHERE MaPM = ?',
      [MaPM],
    );
    return result[0] ?? null;
  }
  async returnBooks(MaPM: string) {
    try {
      const sql = 'CALL TraNhieuSach(?)';
      const result = await this.db.query(sql, [MaPM]);
      return {
        success: true,
        message: 'Trả sách thành công!',
      };
    } catch (error) {
      throw new Error(`Lỗi khi trả sách: ${error.message}`);
    }
  }
}
