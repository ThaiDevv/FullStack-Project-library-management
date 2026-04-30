import { Controller, Post, Body } from '@nestjs/common';
import { UserService } from './user.service';
import { CreateAccountNVDto } from './dto/create-user.dto';

@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {}

  // POST /user — Tạo tài khoản đăng nhập cho nhân viên
}