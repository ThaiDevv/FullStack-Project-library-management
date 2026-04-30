import { Injectable, UnauthorizedException } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { Strategy, ExtractJwt } from 'passport-jwt';
import { JwtPayload } from './jwt-payload.interface';
import { DatabaseService } from 'src/database/database.service';
@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(private readonly db: DatabaseService) {
    super({
      secretOrKey: 'topSecret51',
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
    });
  }
  async validate(payload: JwtPayload) {
    const { sub } = payload;
    const sql = 'SELECT * FROM taikhoan WHERE MaNV = ?';
    const users = await this.db.query(sql, [sub]);
    if (!users || users.length === 0) {
      throw new UnauthorizedException('User không tồn tại');
    }
    const user = users[0];
    return user;
  }
}
