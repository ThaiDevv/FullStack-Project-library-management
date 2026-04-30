import { IsOptional, IsString } from 'class-validator';

export class SearchFineDto {
  @IsOptional()
  @IsString()
  MaDocGia?: string;

  @IsOptional()
  @IsString()
  MaPM?: string;
}
