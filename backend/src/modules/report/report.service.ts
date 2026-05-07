import { Injectable } from '@nestjs/common';
import { DatabaseService } from 'src/database/database.service';
import { ThongKeSachDto } from './dto/ThongKe.dto';
import { ThongKeSachDangMuonDto } from './dto/ThongKeMuon.dto';
import { ThongKePhieuMuonDto } from './dto/ThongKePhieuMuonTheoThoiGian.dto';

@Injectable()
export class ReportService {
  constructor(private db: DatabaseService) {}
  async ThongKeSachTheoTheLoai(thongKeSachTheoTheLoaiDto: ThongKeSachDto) {
    const { MaTheLoai, TenTheLoai } = thongKeSachTheoTheLoaiDto;
    const sql = 'CALL sp_ThongKeSachTheoTheLoai(?,?)';
    const params = [TenTheLoai ?? null, MaTheLoai ?? null];
    const result = await this.db.query(sql, params);
    return result;
  }
  async ThongKeSachDangDuocMuon(
    thongkeSachDangDuocMuonDto: ThongKeSachDangMuonDto,
  ) {
    const { MaDocGia } = thongkeSachDangDuocMuonDto;
    const sql = 'CALL sp_ThongKeSachDangMuon()';
    const result = await this.db.query(sql);
    return result;
  }
  async ThongKePhieuMuonTheoThoiGian(thongkephieumuondto: ThongKePhieuMuonDto) {
    const { TuNgay, DenNgay } = thongkephieumuondto;
    const sql = 'CALL sp_ThongKePhieuMuonTheoThoiGian(?,?)';
    const params = [TuNgay, DenNgay];
    const result = await this.db.query(sql, params);
    return result;
  }
  async overdueTickets() {
    const result = await this.db.query(
      'SELECT * FROM quanlyphieuquahan',
    );
    return result;
  }

  async exportPhantomDemo() {
    const result = await this.db.query('CALL sp_DemoPhantomRead()');
    return {
      uiData: result[0],     
      jsonData: result[1]  
    };
  }
}
