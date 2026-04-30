import { IsNotEmpty, IsString } from 'class-validator';

export class CreateAccountNVDto {
  @IsNotEmpty()
  @IsString()
  MaNV!: string;
  @IsNotEmpty()
  @IsString()
  password!: string;
}
