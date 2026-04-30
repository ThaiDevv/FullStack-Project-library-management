import { IsNotEmpty, IsString } from 'class-validator';
import { userRole } from 'src/modules/auth/entities/user-role.enum';

export class CreateNewNhanVienDto {
  @IsNotEmpty()
  @IsString()
  MaNV!: string;

  @IsNotEmpty()
  @IsString()
  HoTen!: string;

  @IsNotEmpty()
  @IsString()
  SDT!: string;

  @IsNotEmpty()
  @IsString()
  password!: string;

  @IsNotEmpty()
  @IsString()
  vaitro!: userRole;
}
