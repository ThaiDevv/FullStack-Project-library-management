import { IsNotEmpty, isString, IsString } from 'class-validator';
export class ThongKeSachDto{
  @IsString()
  @IsNotEmpty()
  MaTheLoai!: string;

  @IsString()
  @IsNotEmpty()
  TenTheLoai!: string;

  @IsString()
  @IsNotEmpty()
  MoTa!: string;

  @IsString()
  @IsNotEmpty()
  SoLuongSach!:string

}