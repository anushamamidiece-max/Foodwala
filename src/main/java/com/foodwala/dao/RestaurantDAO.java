package com.foodwala.dao;

import java.util.List;

import com.foodwala.model.Restaurant;

/** DAO contract for restaurant operations. */
public interface RestaurantDAO {

    /**
     * Lists restaurants, optionally filtered by a free-text search
     * (name/cuisine) and/or a cuisine keyword. Pass null/empty to skip.
     */
    List<Restaurant> getAll(String search, String cuisine);

    /** Single restaurant by id, or null. */
    Restaurant getById(int id);
}
