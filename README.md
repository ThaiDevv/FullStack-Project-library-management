# 📚 Hệ Thống Quản Lý Thư Viện Chuyên Nghiệp (Library Management System)

![React](https://img.shields.io/badge/Frontend-React-blue?style=flat-square&logo=react)
![NestJS](https://img.shields.io/badge/Backend-NestJS-ea2845?style=flat-square&logo=nestjs)
![MySQL](https://img.shields.io/badge/Database-MySQL-4479A1?style=flat-square&logo=mysql)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

Hệ thống quản lý thư viện toàn diện được thiết kế với kiến trúc **Monorepo**, áp dụng các kỹ thuật xử lý dữ liệu nâng cao (Transactions, Row-level Locking, Triggers) để đảm bảo tính toàn vẹn và độ tin cậy tuyệt đối cho các nghiệp vụ mượn/trả sách và quản lý tài chính.

---

## ✨ Tính năng nổi bật (Nghiệp vụ cốt lõi)

- **Quản lý mượn/trả sách tự động:** Tự động hoàn trả tồn kho, cập nhật ngày giờ thực tế thông qua các `Trigger` ở tầng Database.
- **Xử lý tài chính & Phạt trễ hạn:** Hệ thống tự động phát hiện trễ hạn và sinh phiếu phạt. Quá trình thanh toán áp dụng kỹ thuật `FOR UPDATE` (Row-level Locking) để ngăn chặn hoàn toàn lỗi tranh chấp dữ liệu (Race Condition) và thu tiền đúp.
- **Khóa/Mở khóa thẻ Độc giả thông minh:** Tự động khóa thẻ khi độc giả nợ sách/tiền, và tự động kích hoạt lại thẻ (`Auto-Unlock`) ngay khi thanh toán dứt điểm công nợ.
- **Tối ưu hóa Truy vấn (View & Stored Procedure):** Sử dụng `GROUP_CONCAT` gộp nhóm dữ liệu hiển thị, bảo mật logic nghiệp vụ bằng Stored Procedures, hạn chế tối đa việc Backend can thiệp trực tiếp vào dữ liệu thô.

---

## 🛠 Công nghệ sử dụng

- **Frontend:** ReactJS (Vite), Axios, TailwindCSS .
- **Backend:** NestJS (TypeScript), TypeORM / MySQL2.
- **Database:** MySQL (Relational Database, Stored Procedures, Triggers, Views).
- **Quản lý source code:** Git (Monorepo Workspace) với công cụ `concurrently`.

---

## 📂 Cấu trúc thư mục (Monorepo)
```text
QuanLyThuVien/
├── backend/                # Source code NestJS (API & Services)
├── frontend/               # Source code React (UI/UX)
├── database/               # (Tùy chọn) Chứa file .sql để import CSDL
├── package.json            # Cấu hình script chạy song song cả 2 project
└── README.md
