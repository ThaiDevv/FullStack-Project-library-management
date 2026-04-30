import { IsString } from 'class-validator';

export class add_DelBookDto {
  @IsString()
  MaPM!: string;
  DanhSach!: string[];
}
