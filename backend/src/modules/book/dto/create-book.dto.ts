import { IsNotEmpty, IsNumber, IsString } from 'class-validator';

export class CreateBookDto {
  @IsNotEmpty()
  @IsString()
  MaDauSach!: string;

  @IsNotEmpty()
  @IsString()
  TenSach!: string;

  @IsNotEmpty()
  @IsString()
  MaTheLoai!: string;

  @IsString()
  @IsNotEmpty()
  TacGia!: string;

  @IsNumber()
  @IsNotEmpty()
  NamXB!: number;
}
