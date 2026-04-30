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
import { CategoryService } from './category.service';
import { CreateCategoryDto } from './dto/create-category.dto';
import { UpdateCategoryDto } from './dto/update-category.dto';
import { RolesGuard } from '../auth/roles.guard';
import { Roles } from '../auth/roles.decorator';
import { userRole } from '../auth/entities/user-role.enum';

@Controller('categories')
@UseGuards(AuthGuard(), RolesGuard)
@Roles(userRole.ADMIN, userRole.NHANVIEN)
export class CategoryController {
  constructor(private readonly categoryService: CategoryService) {}

  // GET /categories — Lấy danh sách thể loại
  @Get()
  findAll() {
    return this.categoryService.getAllcategory();
  }

  // POST /categories — Thêm thể loại mới
  @Post()
  create(@Body() createCategoryDto: CreateCategoryDto) {
    return this.categoryService.addCategoryService(createCategoryDto);
  }

  // PATCH /categories/:id — Cập nhật thể loại
  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateCategoryDto: UpdateCategoryDto,
  ) {
    return this.categoryService.updateCategory(id, updateCategoryDto);
  }

  // DELETE /categories/:id — Xóa thể loại
  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.categoryService.deleteCategory(id);
  }
}

