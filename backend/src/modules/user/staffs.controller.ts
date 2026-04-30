import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { UserService } from './user.service';
import { CreateNewNhanVienDto } from './dto/create-NhanVien.Dto';
import { Roles } from '../auth/roles.decorator';
import { RolesGuard } from '../auth/roles.guard';
import { userRole } from '../auth/entities/user-role.enum';

@Controller('staffs')
@UseGuards(AuthGuard(), RolesGuard)
@Roles(userRole.ADMIN)
export class StaffsController {
  constructor(private readonly userService: UserService) {}

  // GET /staffs — Lấy danh sách nhân viên
  @Get()
  findAll() {
    return this.userService.ViewNhanVien({} as CreateNewNhanVienDto);
  }

  // GET /staffs/:id — Xem chi tiết 1 nhân viên
  @Get(':id')
  findOne(@Param('id') id: string) {
    const dto = { MaNV: id } as CreateNewNhanVienDto;
    return this.userService.ViewNhanVien(dto);
  }

  // POST /staffs — Tạo nhân viên (kèm tài khoản)
  @Post()
  create(@Body() createNhanVienDto: CreateNewNhanVienDto) {
    return this.userService.CreateNewNhanVien(createNhanVienDto);
  }

  // PATCH /staffs/:id — Cập nhật thông tin nhân viên
  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateNhanVienDto: CreateNewNhanVienDto,
  ) {
    updateNhanVienDto.MaNV = id;
    return this.userService.UpdateNhanVien(updateNhanVienDto);
  }

  // DELETE /staffs/:id — Xóa nhân viên
  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.userService.DeleteNhanVien(id);
  }
}
