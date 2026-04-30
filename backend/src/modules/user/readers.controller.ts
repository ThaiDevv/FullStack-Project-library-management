import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
  UseGuards,
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { UserService } from './user.service';
import { CreateDocGiaDto } from './dto/create-DocGia.dto';
import { Roles } from '../auth/roles.decorator';
import { RolesGuard } from '../auth/roles.guard';
import { userRole } from '../auth/entities/user-role.enum';

@Controller('readers')
@UseGuards(AuthGuard(), RolesGuard)
@Roles(userRole.ADMIN, userRole.NHANVIEN)
export class ReadersController {
  constructor(private readonly userService: UserService) {}

  // GET  Tìm kiếm độc giả
  @Get()
  findAll(@Query('tukhoa') tukhoa?: string) {
    return this.userService.FindDocGia(tukhoa ?? null);
  }

  // GET /readers/:id — Xem chi tiết 1 độc giả
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.userService.findOneDocGia(id);
  }

  // POST /readers — Thêm độc giả mới
  @Post()
  create(@Body() createDocGiaDto: CreateDocGiaDto) {
    return this.userService.CreateDocGia(createDocGiaDto);
  }

  // PATCH /readers/:id — Cập nhật thông tin độc giả
  @Patch(':id')
  update(@Param('id') id: string, @Body() updateDocGiaDto: CreateDocGiaDto) {
    updateDocGiaDto.MaDocGia = id;
    return this.userService.UpdateDocGia(updateDocGiaDto);
  }

  // DELETE /readers/:id — Khóa/Xóa thẻ độc giả (soft delete)
  @Delete(':id')
  Lock(@Param('id') id: string) {
    return this.userService.LockDocGia(id);
  }

  // POST /readers/:id/unlock — Mở khóa thẻ độc giả
  @Post(':id/unlock')
  unlock(@Param('id') id: string) {
    return this.userService.unlockDocGia(id);
  }
}
