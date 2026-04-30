import { Type } from "class-transformer";
import { ArrayNotEmpty, IsArray, IsDate, IsString } from "class-validator";

export class creatBorrowDto {
  @IsString()
  MaDocGia!: string;

  @IsString()
  MaNV!: string;

  @Type(() => Date)
  @IsDate()
  NgayTraDuKien!: Date;

  @IsArray()
  @ArrayNotEmpty()
  DanhSach!: string[];
}
