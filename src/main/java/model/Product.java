package model;

public class Product {
    private int id;
    private String title;
    private String description;
    private double price;
    private int sellerId;
    private String status;
    private java.util.Date createdAt;
    private String image;
    private String categoryId; 
    
    // Getters and Setters
    public int getId() { 
    	return id; 
    }
    public void setId(int id) { 
    	this.id = id; 
    }

    public String getTitle() { 
    	return title; 
    }
    
    public void setTitle(String title) { 
    	this.title = title; 
    }

    public String getDescription() { 
    	return description; 
    }
    public void setDescription(String description) { 
    	this.description = description; 
    }

    public double getPrice() { 
    	return price; 
    }
    public void setPrice(double price) { 
    	this.price = price; 
    }

    public int getSellerId() { 
    	return sellerId; 
    }
    public void setSellerId(int sellerId) { 
    	this.sellerId = sellerId;
    }

    public String getStatus() { 
    	return status; 
    }
    public void setStatus(String status) { 
    	this.status = status; 
    }

    public java.util.Date getCreatedAt() { 
    	return createdAt;
    }
    public void setCreatedAt(java.util.Date createdAt) {
    	this.createdAt = createdAt; 
    }

    public String getImage() {
    	return image; 
    }
    public void setImage(String image) { 
    	this.image = image; 
    }

    public String getCategoryId() { 
    	return categoryId;
    }
    public void setCategoryId(String categoryId) { 
    	this.categoryId = categoryId;
    }
}
