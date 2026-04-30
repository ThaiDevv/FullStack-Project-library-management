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
import { BookService } from './book.service';
import { CreateBookDto } from './dto/create-book.dto';
import { UpdateBookDto } from './dto/update-book.dto';
import { searchBookDto } from './dto/search-book.dto';
import { Roles } from '../auth/roles.decorator';
import { RolesGuard } from '../auth/roles.guard';
import { userRole } from '../auth/entities/user-role.enum';

@Controller('books')
@UseGuards(AuthGuard(), RolesGuard)
@Roles(userRole.ADMIN, userRole.NHANVIEN)
export class BookController {
  constructor(private readonly bookService: BookService) {}

  // GET /books?TenSach=&TacGia=&MaTheLoai= — Lấy danh sách / tìm kiếm Đầu sách
  @Get()
  findAll(@Query() searchDto: searchBookDto) {
    return this.bookService.findOne(searchDto);
  }

  // GET /books/:id — Xem chi tiết 1 Đầu sách
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.bookService.findOneBook(id);
  }

  // POST /books — Thêm Đầu sách mới
  @Post()
  create(@Body() createBookDto: CreateBookDto) {
    return this.bookService.create(createBookDto);
  }

  // PATCH /books/:id — Cập nhật Đầu sách
  @Patch(':id')
  update(@Param('id') id: string, @Body() updateBookDto: UpdateBookDto) {
    return this.bookService.update(id, updateBookDto);
  }

  // DELETE /books/:id — Xóa Đầu sách
  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.bookService.remove(id);
  }

  // GET /books/:id/instances — Lấy danh sách Cuốn sách vật lý
  @Get(':id/instances')
  findInstances(@Param('id') id: string) {
    return this.bookService.findInstances(id);
  }

  // POST /books/:id/instances — Nhập kho (Thêm sách vật lý)
  @Post(':id/instances')
  addInstance(@Param('id') id: string, @Body('SoLuong') SoLuong: number) {
    console.log(SoLuong);
    return this.bookService.addInstance(id, SoLuong);
  }
}
