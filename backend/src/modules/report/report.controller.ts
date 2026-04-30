import {
  Controller,
  Get,
  Query,
  UseGuards,
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ReportService } from './report.service';
import { ThongKeSachDto } from './dto/ThongKe.dto';
import { ThongKeSachDangMuonDto } from './dto/ThongKeMuon.dto';
import { ThongKePhieuMuonDto } from './dto/ThongKePhieuMuonTheoThoiGian.dto';
import { Roles } from '../auth/roles.decorator';
import { RolesGuard } from '../auth/roles.guard';
import { userRole } from '../auth/entities/user-role.enum';

@Controller('reports')
@UseGuards(AuthGuard(), RolesGuard)
@Roles(userRole.ADMIN, userRole.NHANVIEN)
export class ReportController {
  constructor(private readonly reportService: ReportService) {}

  // GET /reports/books-by-category — Thống kê sách theo thể loại
  @Get('books-by-category')
  booksByCategory(@Query() dto: ThongKeSachDto) {
    return this.reportService.ThongKeSachTheoTheLoai(dto);
  }

  // GET /reports/currently-borrowed — Thống kê sách đang mượn
  @Get('currently-borrowed')
  currentlyBorrowed(@Query() dto: ThongKeSachDangMuonDto) {
    return this.reportService.ThongKeSachDangDuocMuon(dto);
  }

  // GET /reports/borrow-stats?TuNgay=&DenNgay= — Thống kê mượn trả theo thời gian
  @Get('borrow-stats')
  borrowStats(@Query() dto: ThongKePhieuMuonDto) {
    return this.reportService.ThongKePhieuMuonTheoThoiGian(dto);
  }

  // GET /reports/overdue-tickets — Báo cáo phiếu quá hạn
  @Get('overdue-tickets')
  overdueTickets() {
    return this.reportService.overdueTickets();
  }
}

