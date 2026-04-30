import { Module } from '@nestjs/common';
import { UserService } from './user.service';
import { UserController } from './user.controller';
import { StaffsController } from './staffs.controller';
import { ReadersController } from './readers.controller';
import { AuthModule } from '../auth/auth.module';

@Module({
  imports: [AuthModule],
  controllers: [UserController, StaffsController, ReadersController],
  providers: [UserService],
})
export class UserModule {}
