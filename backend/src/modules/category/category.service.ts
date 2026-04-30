import { BadRequestException, Injectable } from '@nestjs/common';
import { CreateCategoryDto } from './dto/create-category.dto';
import { UpdateCategoryDto } from './dto/update-category.dto';
import { DatabaseService } from 'src/database/database.service';

@Injectable()
export class CategoryService {
  constructor(private readonly db: DatabaseService) {}
  async addCategoryService(creatCategory: CreateCategoryDto) {
    try {
      const { MaTheLoai, TenTheLoai, MoTa } = creatCategory;
      const sql = 'CALL ThemTheLoai(?, ?, ?)';
      const params = [MaTheLoai, TenTheLoai, MoTa];
      const result = await this.db.query(sql, params);
      return {
        success: true,
        message: 'Thêm thể loại thành công!',
        data: result[0],
      };
    } catch (error) {
      throw new BadRequestException(`Lỗi từ Database: ${error.message}`);
    }
  }
  async updateCategory(
    MaTheLoai: string,
    updateCategoryDto: UpdateCategoryDto,
  ) {
    try {
      const { TenTheLoai, MoTa } = updateCategoryDto;
      const sql = 'CALL CapNhatTheLoai(?, ?, ?)';
      const params = [MaTheLoai, TenTheLoai ?? null, MoTa ?? null];
      const result = await this.db.query(sql, params);
      return {
        success: true,
        message: 'Cập nhập thể loại thành công!',
      };
    } catch (error) {
      throw new Error(`Lỗi khi cập nhật thể loại: ${error.message}`);
    }
  }
  async deleteCategory(MaTheLoai: string) {
    try {
      const sql = 'CALL XoaTheLoai(?)';
      const params = [MaTheLoai];
      const result = await this.db.query(sql, params);
      return {
        success: true,
        message: 'Xoa thể loại thành công!',
      };
    } catch (error) {
      throw new Error(`Lỗi khi xoa thể loại: ${error.message}`);
    }
  }
  async getAllcategory() {
    try {
      const sql = 'SELECT * FROM theloai';
      const result = await this.db.query(sql);
      return result;
    } catch (error) {
      throw new Error(`Lỗi khi lay tat ca thể loại: ${error.message}`);
    }
  }
}
