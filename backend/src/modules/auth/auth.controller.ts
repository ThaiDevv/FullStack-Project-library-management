import { Controller, Get, Post, Body, UseGuards, Request } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { AuthService } from './auth.service';
import { loginDto } from './dto/login.dto';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('login')
  login(@Body() logindto: loginDto) {
    return this.authService.login(logindto);
  }

  @Get('me')
  @UseGuards(AuthGuard())
  getMe(@Request() req) {
    return this.authService.getMe(req.user);
  }
}
