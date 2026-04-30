import { IsNotEmpty, IsString } from 'class-validator';
export class CreateCategoryDto {
  @IsString()
  @IsNotEmpty()
  MaTheLoai!: string;

  @IsString()
  @IsNotEmpty()
  TenTheLoai!: string;

  @IsString()
  @IsNotEmpty()
  MoTa!: string;
}
