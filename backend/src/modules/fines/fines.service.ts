import { Injectable } from '@nestjs/common';
import { DatabaseService } from 'src/database/database.service';
import { SearchFineDto } from './dto/search-fine.dto';

@Injectable()
export class FinesService {
  constructor(private readonly db: DatabaseService) {}

  async findAll(searchDto: SearchFineDto) {
    const { MaDocGia, MaPM } = searchDto;
    let sql = 'SELECT * FROM phieuphat WHERE 1=1';
    const params: any[] = [];
    if (MaDocGia) {
      sql += ' AND MaDocGia = ?';
      params.push(MaDocGia);
    }
    if (MaPM) {
      sql += ' AND MaPM = ?';
      params.push(MaPM);
    }
    const result = await this.db.query(sql, params);
    return result;
  }

  async pay(id: string, MaNV: string) {
    const result = await this.db.query('CALL sp_ThanhToanTienPhat(?,?)', [id,MaNV]);
    return {
      success: true,
      message: 'Thanh toán tiền phạt thành công!',
      data: result,
    };
  }
}
