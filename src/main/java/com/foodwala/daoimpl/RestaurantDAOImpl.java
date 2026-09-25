package com.foodwala.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.foodwala.dao.RestaurantDAO;
import com.foodwala.model.Restaurant;
import com.foodwala.util.DBUtil;

/** JDBC implementation of RestaurantDAO. */
public class RestaurantDAOImpl implements RestaurantDAO {

    @Override
    public List<Restaurant> getAll(String search, String cuisine) {
        List<Restaurant> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT * FROM restaurants WHERE 1=1");
        boolean hasSearch = search != null && !search.trim().isEmpty();
        boolean hasCuisine = cuisine != null && !cuisine.trim().isEmpty()
                && !"all".equalsIgnoreCase(cuisine.trim());

        if (hasSearch) {
            sql.append(" AND (name LIKE ? OR cuisines LIKE ? OR address LIKE ?)");
        }
        if (hasCuisine) {
            sql.append(" AND cuisines LIKE ?");
        }
        sql.append(" ORDER BY rating DESC, id ASC");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBUtil.getConnection();
            ps = con.prepareStatement(sql.toString());
            int idx = 1;
            if (hasSearch) {
                String like = "%" + search.trim() + "%";
                ps.setString(idx++, like);
                ps.setString(idx++, like);
                ps.setString(idx++, like);
            }
            if (hasCuisine) {
                ps.setString(idx++, "%" + cuisine.trim() + "%");
            }
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(con, ps, rs);
        }
        return list;
    }

    @Override
    public Restaurant getById(int id) {
        String sql = "SELECT * FROM restaurants WHERE id = ?";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBUtil.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            return rs.next() ? mapRow(rs) : null;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            DBUtil.close(con, ps, rs);
        }
    }

    private Restaurant mapRow(ResultSet rs) throws SQLException {
        Restaurant r = new Restaurant();
        r.setId(rs.getInt("id"));
        r.setName(rs.getString("name"));
        r.setCuisines(rs.getString("cuisines"));
        r.setAddress(rs.getString("address"));
        r.setImage(rs.getString("image"));
        r.setRating(rs.getDouble("rating"));
        r.setDeliveryTime(rs.getInt("delivery_time"));
        r.setPriceForTwo(rs.getInt("price_for_two"));
        r.setPureVeg(rs.getInt("is_pure_veg") == 1);
        return r;
    }
}
