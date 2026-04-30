import { IsOptional, IsNumber, IsString } from 'class-validator';

export class searchBookDto {
  @IsString()
  @IsOptional()
  TenSach!: string;

  @IsString()
  @IsOptional()
  MaTheLoai!: string;

  @IsString()
  @IsOptional()
  TacGia!: string;
}
