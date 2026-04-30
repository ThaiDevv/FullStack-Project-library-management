import { PartialType } from '@nestjs/mapped-types';
import { CreateAccountNVDto } from './create-user.dto';

export class UpdateUserDto extends PartialType(CreateAccountNVDto) {}
