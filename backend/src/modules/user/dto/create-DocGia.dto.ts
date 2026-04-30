import { TTHDDocGia } from '../entities/createDocGia.enum';

export class CreateDocGiaDto {
  MaDocGia!: string;
  HoTen!: string;
  NgaySinh!: Date;
  DiaChi!: string;
  SDT!: string;
}
