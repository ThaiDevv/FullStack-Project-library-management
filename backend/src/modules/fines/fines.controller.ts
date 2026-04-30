import {
  Controller,
  Get,
  Patch,
  Param,
  Query,
  UseGuards,
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { FinesService } from './fines.service';
import { SearchFineDto } from './dto/search-fine.dto';
import { Roles } from '../auth/roles.decorator';
import { RolesGuard } from '../auth/roles.guard';
import { userRole } from '../auth/entities/user-role.enum';

@Controller('fines')
@UseGuards(AuthGuard(), RolesGuard)
@Roles(userRole.ADMIN, userRole.NHANVIEN)
export class FinesController {
  constructor(private readonly finesService: FinesService) {}

  // GET /fines?MaDocGia=&MaPM= — Danh sách phiếu phạt
  @Get()
  findAll(@Query() searchDto: SearchFineDto) {
    return this.finesService.findAll(searchDto);
  }

  // PATCH /fines/:id/pay — Thanh toán tiền phạt
  @Patch(':id/pay/:MaNV')
  pay(@Param('id') id: string, @Param('MaNV') MaNV: string) {
    return this.finesService.pay(id, MaNV);
  }
}
