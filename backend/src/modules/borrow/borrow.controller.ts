import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  Query,
  UseGuards,
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { BorrowService } from './borrow.service';
import { creatBorrowDto } from './dto/creatBorrow.dto';
import { updateBorrowDto } from './dto/updateDealine.dto';
import { searchDto } from './dto/searchBorrow.dto';
import { add_DelBookDto } from './dto/add_DelBook.dto';
import { Roles } from '../auth/roles.decorator';
import { RolesGuard } from '../auth/roles.guard';
import { userRole } from '../auth/entities/user-role.enum';

@Controller('borrow-tickets')
@UseGuards(AuthGuard(), RolesGuard)
@Roles(userRole.ADMIN, userRole.NHANVIEN)
export class BorrowController {
  constructor(private readonly borrowService: BorrowService) { }

  @Get()
  findAll(@Query() search: searchDto) {
    return this.borrowService.findAll(search);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.borrowService.findOne(id);
  }

  @Post()
  create(@Body() createBorrowDto: creatBorrowDto) {
    return this.borrowService.demoBorrow(createBorrowDto)
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.borrowService.deleteBorrow(id);
  }

  @Patch(':id/deadline')
  extendDeadline(@Param('id') id: string, @Body() updateDto: updateBorrowDto) {
    updateDto.MaPM = id;
    return this.borrowService.updateDeadline(updateDto);
  }

  @Post(':id/books')
  addBook(@Param('id') id: string, @Body() addBookDto: add_DelBookDto) {
    addBookDto.MaPM = id;
    return this.borrowService.addBookinBorrow(addBookDto);
  }

  @Delete(':id/books')
  removeBook(@Param('id') id: string, @Body() dto: add_DelBookDto) {
    dto.MaPM = id;
    return this.borrowService.deleteBookInBorrow(dto);
  }

  @Post(':id/return')
  returnBooks(@Param('id') id: string) {
    return this.borrowService.returnBooks(id);
  }

  // 🔥 DEMO DIRTY READ
  @Post('demo-dirty-read')
  demoDirtyRead(@Body() createBorrowDto: creatBorrowDto) {
    return this.borrowService.demoBorrow(createBorrowDto)
  }
}