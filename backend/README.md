# 📚 Hệ thống Quản lý Thư viện (Library Management System)

![NestJS](https://img.shields.io/badge/nestjs-%23E0234E.svg?style=for-the-badge&logo=nestjs&logoColor=white)
![React](https://img.shields.io/badge/react-%2320232a.svg?style=for-the-badge&logo=react&logoColor=%2361DAFB)
![Vite](https://img.shields.io/badge/vite-%23646CFF.svg?style=for-the-badge&logo=vite&logoColor=white)
![MySQL](https://img.shields.io/badge/mysql-%2300f.svg?style=for-the-badge&logo=mysql&logoColor=white)
![TailwindCSS](https://img.shields.io/badge/tailwindcss-%2338B2AC.svg?style=for-the-badge&logo=tailwind-css&logoColor=white)

Một hệ thống quản lý thư viện toàn diện (Full-stack) được thiết kế với kiến trúc RESTful API, tập trung vào hiệu suất cao và quản lý luồng dữ liệu chặt chẽ thông qua hệ thống Stored Procedures/Views ở tầng Database.

---

## ✨ Tính năng nổi bật (Key Features)

* **📖 Quản lý Danh mục & Đầu sách:** CRUD Thể loại, Quản lý chi tiết Đầu sách. Tích hợp bộ máy tìm kiếm (Search engine) linh hoạt theo Tên sách, Tác giả và Thể loại.
* **👥 Quản lý Độc giả & Nhân viên:** Quản lý hồ sơ người dùng, phân quyền truy cập và trạng thái thẻ thư viện.
* **🔄 Nghiệp vụ Mượn - Trả sách:** * Giao diện Master-Detail xử lý mảng JSON phức tạp.
    * Quản lý theo mã vạch vật lý từng cuốn sách.
    * Tự động tính toán hạn trả và xử lý tiền phạt quá hạn.
* **📊 Thống kê & Dashboard:** Trực quan hóa dữ liệu (Pie Chart, Bar Chart) sử dụng Recharts. Báo cáo tự động danh sách sách quá hạn, top độc giả mượn nhiều thông qua MySQL Views.

---

## 🛠️ Công nghệ sử dụng (Tech Stack)

### Backend (API Server)
* **Framework:** [NestJS](https://nestjs.com/) (Node.js)
* **Database Integration:** Sử dụng `mysql2/promise` kết hợp Connection Pool để tối ưu hóa hiệu suất thay vì ORM truyền thống.
* **Validation:** `class-validator` & `class-transformer` (DTOs).

### Frontend (Client App)
* **Core:** ReactJS khởi tạo bằng Vite.
* **Styling:** Tailwind CSS cho UI/UX nhất quán, hiện đại.
* **State & Data Fetching:** Axios Client (cấu hình Interceptors xử lý Token tập trung), React Hooks.
* **Charts:** Recharts.

### Database
* **RDBMS:** MySQL.
* **Core Logic:** Tối ưu hóa xử lý nghiệp vụ nặng trực tiếp tại DB thông qua hệ thống **Stored Procedures**, **Triggers**, và **Views** (Đảm bảo tính toàn vẹn dữ liệu và giảm tải cho backend).

---

## 🚀 Hướng dẫn cài đặt (Installation & Setup)

### 1. Chuẩn bị Cơ sở dữ liệu (Database Setup)
1. Cài đặt MySQL Server.
2. Mở MySQL Workspace / DBeaver, tạo một database mới (VD: `libmn`).
3. Chạy file script SQL đính kèm trong thư mục `database/` để khởi tạo Bảng, Khóa ngoại, Views và toàn bộ Stored Procedures.

### 2. Cài đặt Backend (NestJS)
```bash
# Di chuyển vào thư mục backend
cd backend

# Cài đặt các dependencies
npm install

# Tạo file .env dựa trên .env.example
cp config/.env.example config/.env
