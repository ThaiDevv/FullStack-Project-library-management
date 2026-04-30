import { IsNotEmpty, IsString, MaxLength, MinLength } from "class-validator";
export class loginDto {
  @IsString()
  @IsNotEmpty()
  MaNV!: string;
  @IsString()
  @IsNotEmpty()
  @MaxLength(32)
  @MinLength(8)
  password!: string;
}
