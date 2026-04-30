import { Module } from '@nestjs/common';
import { BorrowService } from './borrow.service';
import { BorrowController } from './borrow.controller';
import { AuthModule } from '../auth/auth.module';

@Module({
  imports: [AuthModule],
  controllers: [BorrowController],
  providers: [BorrowService],
})
export class BorrowModule {}

