import { IsNumber, IsOptional, IsString } from "class-validator";

export class UpdateBookDto {
  @IsString()
  @IsOptional()
  TenSach!: string;

  @IsString()
  @IsOptional()
  MaTheLoai!: string;

  @IsString()
  @IsOptional()
  TacGia!: string;

  @IsNumber()
  @IsOptional()
  NamXB!: number;
}
