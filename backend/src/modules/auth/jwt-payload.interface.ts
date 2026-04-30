import { userRole } from './entities/user-role.enum';

export interface JwtPayload {
  sub: string;
  role: userRole;
}
