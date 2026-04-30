import { IsNotEmpty, IsOptional, IsString } from 'class-validator';

export class UpdateCategoryDto {
  @IsString()
  @IsNotEmpty()
  @IsOptional()
  TenTheLoai!: string;

  @IsString()
  @IsNotEmpty()
  @IsOptional()
  MoTa!: string;
}
