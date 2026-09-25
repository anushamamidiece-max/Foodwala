<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.foodwala.model.Restaurant" %>
<%@ include file="includes/header.jsp" %>
<%
    @SuppressWarnings("unchecked")
    List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
    String q = (String) request.getAttribute("q");
    String cuisine = (String) request.getAttribute("cuisine");
    String activeCuisine = (cuisine == null || cuisine.isEmpty() || "all".equalsIgnoreCase(cuisine)) ? "" : cuisine;
    String[] accents = {"#0e9f6e", "#ff6b35", "#0ea5e9", "#a855f7", "#e11d48", "#eab308"};
    String FALLBACK_IMG = "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=900";
%>

<section class="hero">
    <div class="hero-inner">
        <h1>Hungry? <span class="grad">Foodwala</span> has you covered.</h1>
        <p>Fresh meals from <strong>50+ restaurants</strong> across Bengaluru, delivered in minutes.</p>
        <form class="hero-search" action="<%= ctx %>/restaurants" method="get">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><circle cx="11" cy="11" r="7"/><path d="M21 21l-4.3-4.3"/></svg>
            <input type="text" name="q" value="<%= q == null ? "" : q %>" placeholder="Search for biryani, pizza, momos…">
            <button type="submit" class="btn btn-primary">Search</button>
        </form>
    </div>
</section>

<main class="container">
    <div class="chips-row">
        <a href="<%= ctx %>/restaurants" class="chip ripple <%= activeCuisine.isEmpty() ? "chip-active" : "" %>">🍽️ All</a>
        <a href="<%= ctx %>/restaurants?cuisine=Biryani" class="chip ripple <%= "Biryani".equals(activeCuisine) ? "chip-active" : "" %>">🍛 Biryani</a>
        <a href="<%= ctx %>/restaurants?cuisine=South+Indian" class="chip ripple <%= "South Indian".equals(activeCuisine) ? "chip-active" : "" %>">🥞 South Indian</a>
        <a href="<%= ctx %>/restaurants?cuisine=Pizza" class="chip ripple <%= "Pizza".equals(activeCuisine) ? "chip-active" : "" %>">🍕 Pizza</a>
        <a href="<%= ctx %>/restaurants?cuisine=Burgers" class="chip ripple <%= "Burgers".equals(activeCuisine) ? "chip-active" : "" %>">🍔 Burgers</a>
        <a href="<%= ctx %>/restaurants?cuisine=Chinese" class="chip ripple <%= "Chinese".equals(activeCuisine) ? "chip-active" : "" %>">🍜 Chinese</a>
        <a href="<%= ctx %>/restaurants?cuisine=Rolls" class="chip ripple <%= "Rolls".equals(activeCuisine) ? "chip-active" : "" %>">🌯 Rolls</a>
        <a href="<%= ctx %>/restaurants?cuisine=Kebabs" class="chip ripple <%= "Kebabs".equals(activeCuisine) ? "chip-active" : "" %>">🍢 Kebabs</a>
        <a href="<%= ctx %>/restaurants?cuisine=Healthy" class="chip ripple <%= "Healthy".equals(activeCuisine) ? "chip-active" : "" %>">🥗 Healthy</a>
        <a href="<%= ctx %>/restaurants?cuisine=Desserts" class="chip ripple <%= "Desserts".equals(activeCuisine) ? "chip-active" : "" %>">🍰 Desserts</a>
        <a href="<%= ctx %>/restaurants?cuisine=Cafe" class="chip ripple <%= "Cafe".equals(activeCuisine) ? "chip-active" : "" %>">☕ Café</a>
    </div>

    <div class="section-head">
        <h2><%= (q != null && !q.isEmpty()) ? "Results for “" + q + "”" : "Delivery Restaurants in Bengaluru" %></h2>
        <span class="count"><%= restaurants == null ? 0 : restaurants.size() %> places</span>
    </div>

    <% if (restaurants == null || restaurants.isEmpty()) { %>
        <div class="empty-state">
            <div class="empty-emoji">🍽️</div>
            <h3>No restaurants found</h3>
            <p>Try a different search or clear the filters.</p>
            <a href="<%= ctx %>/restaurants" class="btn btn-primary">Browse all restaurants</a>
        </div>
    <% } else { %>
        <div class="grid">
            <% int i = 0;
               for (Restaurant r : restaurants) { %>
                <a href="<%= ctx %>/restaurant?id=<%= r.getId() %>"
                   class="card ripple" style="--accent:<%= accents[i++ % accents.length] %>">
                    <div class="card-img-wrap">
                        <img src="<%= r.getImage() %>" alt="<%= r.getName() %>" loading="lazy"
                             onerror="this.onerror=null;this.src='<%= FALLBACK_IMG %>';">
                        <div class="card-overlay"></div>
                        <span class="rating-pill">★ <%= String.format("%.1f", r.getRating()) %></span>
                        <span class="time-pill">⏱ <%= r.getDeliveryTime() %> min</span>
                    </div>
                    <div class="card-body">
                        <div class="card-title-row">
                            <h3><%= r.getName() %></h3>
                            <% if (r.isPureVeg()) { %><span class="veg-tag" title="Pure Veg">🌱 Pure Veg</span><% } %>
                        </div>
                        <p class="cuisines"><%= r.getCuisines() %></p>
                        <div class="card-meta">
                            <span>₹<%= r.getPriceForTwo() %> for two</span>
                            <span class="dot">•</span>
                            <span class="addr"><%= r.getAddress() %></span>
                        </div>
                    </div>
                </a>
            <% } %>
        </div>
    <% } %>
</main>

<%@ include file="includes/footer.jsp" %>
