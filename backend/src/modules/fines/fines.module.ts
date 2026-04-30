import { Module } from '@nestjs/common';
import { FinesService } from './fines.service';
import { FinesController } from './fines.controller';
import { AuthModule } from '../auth/auth.module';

@Module({
  imports: [AuthModule],
  controllers: [FinesController],
  providers: [FinesService],
})
export class FinesModule {}
