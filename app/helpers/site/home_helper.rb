module Site::HomeHelper
    def is_active?(ad)
        @carousel.first.id == ad.id ? "active" : ""
        
    end
    
end
