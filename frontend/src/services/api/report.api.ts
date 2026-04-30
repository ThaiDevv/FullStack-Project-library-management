import axiosClient from '../../config/axios';

export const reportApi = {
  booksByCategory: async () => {
    const response = await axiosClient.get('/reports/books-by-category');
    let data = response.data;
    if (Array.isArray(data) && Array.isArray(data[0])) data = data[0];
    return Array.isArray(data) ? data : [];
  },

  currentlyBorrowed: async (params?: { MaDocGia?: string; MaDauSach?: string }) => {
    const response = await axiosClient.get('/reports/currently-borrowed', { params });
    let data = response.data;
    if (Array.isArray(data) && Array.isArray(data[0])) data = data[0];
    return Array.isArray(data) ? data : [];
  },

  borrowStats: async (params?: { TuNgay?: string; DenNgay?: string }) => {
    const response = await axiosClient.get('/reports/borrow-stats', { params });
    let data = response.data;
    if (Array.isArray(data) && Array.isArray(data[0])) data = data[0];
    return Array.isArray(data) ? data : [];
  },

  overdueTickets: async () => {
    const response = await axiosClient.get('/reports/overdue-tickets');
    let data = response.data;
    if (Array.isArray(data) && Array.isArray(data[0])) data = data[0];
    return Array.isArray(data) ? data : [];
  },
};
