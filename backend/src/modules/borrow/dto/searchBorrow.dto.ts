import { IsOptional } from "class-validator";

export class searchDto {
  @IsOptional()
  TenDocGia?: string;
  @IsOptional()
  TuNgay?: Date;
  @IsOptional()
  DenNgay?: Date;
}
