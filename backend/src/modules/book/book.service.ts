import { Injectable } from '@nestjs/common';
import { CreateBookDto } from './dto/create-book.dto';
import { UpdateBookDto } from './dto/update-book.dto';
import { DatabaseService } from 'src/database/database.service';
import { searchBookDto } from './dto/search-book.dto';
@Injectable()
export class BookService {
  constructor(private readonly db: DatabaseService) {}
  async create(createBookDto: CreateBookDto) {
    try {
      const { MaDauSach, TenSach, MaTheLoai, TacGia, NamXB } = createBookDto;
      const sql = 'CALL ThemDauSach(?,?,?,?,?)';
      const params = [MaDauSach, TenSach, MaTheLoai, TacGia, NamXB];
      const result = await this.db.query(sql, params);
      return {
        success: true,
        message: 'Thêm Dau Sach thành công!',
        data: result,
      };
    } catch (error) {
      throw new Error(`Lỗi khi thêm Dau Sach: ${error.message}`);
    }
  }
  async update(MaDauSach: string, updateBookDto: UpdateBookDto) {
    try {
      const { TenSach, MaTheLoai, TacGia, NamXB } = updateBookDto;
      const sql = 'CALL CapNhatDauSach(?,?,?,?,?)';
      const params = [
        MaDauSach,
        TenSach ?? null,
        MaTheLoai ?? null,
        TacGia ?? null,
        NamXB ?? null,
      ];
      await this.db.query(sql, params);
      return {
        success: true,
        message: 'Sua Dau Sach thành công!',
      };
    } catch (error) {
      throw new Error(`Lỗi khi sua Dau Sach: ${error.message}`);
    }
  }

  async remove(MaDauSach: string) {
    try {
      await this.db.query(
        'DELETE FROM ct_phieumuon WHERE MaCuonSach IN (SELECT MaCuonSach FROM cuonsach WHERE MaDauSach = ?)',
        [MaDauSach],
      );

      await this.db.query('DELETE FROM cuonsach WHERE MaDauSach = ?', [
        MaDauSach,
      ]);

      await this.db.query('DELETE FROM dausach WHERE MaDauSach = ?', [
        MaDauSach,
      ]);
      return {
        success: true,
        message: 'Xoa Dau Sach thành công!',
      };
    } catch (error) {
      throw new Error(`Lỗi khi xoa Dau Sach: ${error.message}`);
    }
  }
  async findOne(searchBookDto: searchBookDto) {
    try {
      const { TenSach, TacGia, MaTheLoai } = searchBookDto;
      // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
      const result = await this.db.query('CALL TimKiemDauSach(?,?,?)', [
        TenSach ?? null,
        TacGia ?? null,
        MaTheLoai ?? null,
      ]);
      return result[0];
    } catch (error) {
      throw new Error(`Lỗi khi tim kiem Dau Sach: ${error.message}`);
    }
  }
  async findOneBook(MaDauSach: string) {
    const result = await this.db.query(
      'SELECT * FROM v_quanlysach WHERE MaDauSach = ?',
      [MaDauSach],
    );
    return result[0] ?? null;
  }
  async findInstances(MaDauSach: string) {
    const result = await this.db.query(
      'SELECT * FROM cuonsach WHERE MaDauSach = ?',
      [MaDauSach],
    );
    return result;
  }
  async addInstance(MaDauSach: string, SoLuong: number) {
    const result = await this.db.query('CALL NhapKhoCuonSach(?, ?)', [
      MaDauSach,
      SoLuong,
    ]);
    return {
      success: true,
      message: 'Them cuon Sach thành công!',
    };
  }
}
