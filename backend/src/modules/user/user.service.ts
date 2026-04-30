import { BadRequestException, Injectable } from '@nestjs/common';
import { CreateAccountNVDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { DatabaseService } from 'src/database/database.service';
import { userRole } from '../auth/entities/user-role.enum';
import * as bcrypt from 'bcrypt';
import { CreateDocGiaDto } from './dto/create-DocGia.dto';
import { ViewDocGiaDto } from './dto/create-ViewDocGia.dto';
import { CreateNewNhanVienDto } from './dto/create-NhanVien.Dto';
@Injectable()
export class UserService {
  constructor(private db: DatabaseService) {}
  async createAccountNV(MaNV: string, password: string, roleUser: userRole) {
    try {
      const sql = 'INSERT INTO taikhoan (MatKhau, MaNV, role) VALUES (?, ?, ?)';
      // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment, @typescript-eslint/no-unsafe-call, @typescript-eslint/no-unsafe-member-access
      const salt = await bcrypt.genSalt();
      // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment, @typescript-eslint/no-unsafe-call, @typescript-eslint/no-unsafe-member-access
      const hashPassword = await bcrypt.hash(password, salt);
      const params = [hashPassword, MaNV, roleUser];
      const result = await this.db.query(sql, params);
      return {
        success: true,
        message: 'Thêm Tai khoan thành công!',
      };
    } catch (error) {
      throw new BadRequestException(`Lỗi từ Database: ${error.message}`);
    }
  }

  async CreateDocGia(createDocGiaDto: CreateDocGiaDto) {
    try {
      const { MaDocGia, HoTen, NgaySinh, DiaChi, SDT } = createDocGiaDto;
      const sql = 'CALL ThemDocGia(?,?,?,?,?)'; //
      const params = [MaDocGia, HoTen, NgaySinh, DiaChi, SDT];
      const result = await this.db.query(sql, params);
      return {
        success: true,
        message: 'Thêm độc giả thành công!',
      };
    } catch (error) {
      throw new Error(`Lỗi khi Thêm độc giả: ${error.message}`);
    }
  }
  async UpdateDocGia(createUpdateDocGiaDto: CreateDocGiaDto) {
    try {
      const { MaDocGia, HoTen, NgaySinh, DiaChi, SDT } = createUpdateDocGiaDto;
      const sql = 'CALL CapNhatDocGia(?,?,?,?,?)';
      const params = [
        MaDocGia,
        HoTen ?? null,
        NgaySinh ?? null,
        DiaChi ?? null,
        SDT ?? null,
      ];
      const result = await this.db.query(sql, params);
      return {
        success: true,
        message: 'Cập nhật độc giả thành công!',
      };
    } catch (error) {
      throw new Error(`Lỗi khi Cập nhật độc giả: ${error.message}`);
    }
  }
  async LockDocGia(id: string) {
    try {
      const sql = "Update docgia SET TrangThai = 'Bị Khóa' where MaDocGia=?";
      const params = [id];
      const result = await this.db.query(sql, params);
      return {
        success: true,
        message: 'Khóa độc giả thành công!',
      };
    } catch (error) {
      throw new Error(`Lỗi khi Khóa độc giả: ${error.message}`);
    }
  }
  async FindDocGia(tukhoa) {
    try {
      const sql = 'CALL sp_TimKiemDocGia(?)';
      const result = await this.db.query(sql, [tukhoa]);
      return result;
    } catch (error) {
      throw new Error(`Lỗi khi Tìm kiếm độc giả: ${error.message}`);
    }
  }
  async findOneDocGia(id: string) {
    try {
      const sql = 'SELECT * FROM docgia WHERE MaDocGia = ?';
      const result = await this.db.query(sql, [id]);
      return result[0] ?? null;
    } catch (error) {
      throw new Error(`Lỗi khi Tìm kiếm độc giả: ${error.message}`);
    }
  }
  async unlockDocGia(id: string) {
    try {
      const sql =
        "UPDATE docgia SET TrangThai = 'Hoạt Động' WHERE MaDocGia = ?";
      const result = await this.db.query(sql, [id]);
      return {
        success: true,
        message: 'unlock độc giả thành công!',
      };
    } catch (error) {
      throw new Error(`Lỗi khi unlock độc giả: ${error.message}`);
    }
  }
  async CreateNewNhanVien(createNewNhanVienDto: CreateNewNhanVienDto) {
    const { MaNV, HoTen, SDT, password, vaitro } = createNewNhanVienDto;
    const sql = 'CALL ThemNhanVien(?,?,?)';
    const params = [MaNV, HoTen, SDT];
    const result = await this.db.query(sql, params);
    await this.createAccountNV(MaNV, password, vaitro);
    return result;
  }
  async UpdateNhanVien(updateNhanVienDto: CreateNewNhanVienDto) {
    const { MaNV, HoTen, SDT, password, vaitro } = updateNhanVienDto;
    const sql = 'CALL CapNhatNhanVien(?,?,?,?,?)';
    const salt = await bcrypt.genSalt();
    // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment, @typescript-eslint/no-unsafe-call, @typescript-eslint/no-unsafe-member-access
    const hashPassword = await bcrypt.hash(password, salt);
    const params = [
      MaNV,
      HoTen ?? null,
      SDT ?? null,
      hashPassword ?? null,
      vaitro ?? null,
    ];
    const result = await this.db.query(sql, params);
    return result;
  }
  async DeleteNhanVien(id: string) {
    const sql = 'DELETE from nhanvien where MaNV=?';
    const params = [id];
    const result = await this.db.query(sql, params);
    return result;
  }
  async ViewNhanVien(viewNhanVienDto: CreateNewNhanVienDto) {
    const { MaNV, HoTen, SDT } = viewNhanVienDto;
    let sql = 'SELECT * FROM v_DanhSachNhanVien WHERE 1=1';
    const params: any[] = [];

    if (MaNV) {
      sql += ' AND MaNV = ?';
      params.push(MaNV);
    }

    if (HoTen) {
      sql += ' AND HoTen LIKE ?';
      params.push(`%${HoTen}%`);
    }

    if (SDT) {
      sql += ' AND DienThoai = ?';
      params.push(SDT);
    }
    const result = await this.db.query(sql, params);
    return result;
  }
}
