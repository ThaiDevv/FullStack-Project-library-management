import {
  Injectable,
  OnModuleInit,
  OnModuleDestroy,
  Logger,
} from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import * as mysql from 'mysql2/promise';

@Injectable()
export class DatabaseService implements OnModuleInit, OnModuleDestroy {
  private pool: mysql.Pool;
  private readonly logger = new Logger(DatabaseService.name);

  constructor(private configService: ConfigService) {}

  async onModuleInit() {
    try {
      this.pool = mysql.createPool({
        host: this.configService.get<string>('DB_HOST'),
        port: this.configService.get<number>('DB_PORT'),
        user: this.configService.get<string>('DB_USER'),
        password: this.configService.get<string>('DB_PASSWORD'),
        database: this.configService.get<string>('DB_NAME'),
        waitForConnections: true,
        connectionLimit: 10,
        queueLimit: 0,
      });

      // Bắn thử 1 câu query ảo để kiểm tra đường truyền thực tế
      await this.pool.execute('SELECT 1');
      this.logger.log('Đã kết nối thành công với MySQL!');
    } catch (error) {
      this.logger.error(
        'Lỗi kết nối Database! Vui lòng kiểm tra lại file .env',
        error,
      );
    }
  }

  async onModuleDestroy() {
    await this.pool.end();
  }

  async query(sql: string, params?: any[]): Promise<any> {
    const [rows] = await this.pool.execute(sql, params);
    return rows;
  }
}
