//
//  Raffle.swift
//  JackRaffit
//
//  Created by Jack on 06/06/17.
//  Copyright © 2017 Hooman. All rights reserved.
//

import UIKit

import ObjectMapper

class Raffle : Mappable {
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public required init?(map: Map) {
        
    }

    var prizesArray : [Prize]?
    var raffles : RaffleDetails?
    var ticketType : [TicketType]?
    var ticketSet : [String]?
    
    func mapping(map: Map) {
        prizesArray <- map["prizes"]
        raffles <- map["raffles"]
        ticketType <- map["ticket_types"]
        ticketSet <- map["ticket_set"]
    }
}


class RaffleDetails : Mappable{
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public required init?(map: Map) {
        
    }
    
    var address,benefit,benefit_title,caption_1,caption_2 ,caption_value_1,caption_value_2,code,contest_keyword,contest_rules,contest_rules_text,convenience_fee,cost_per_ticket,cover_image,created,description,draw_time,end_date,facebook_raffle_url,fbpage_url,id,igfollow_url,igfollow_userid,image,instagram_raffle_url,is_manual_draw,is_thankyou_email_send,jackpot_price,latitude,licence,location,longitude,max_purchase_limit,max_tickets,modified,notify_all_users,organization_name,organizer_raffle_url , winner_reveal_time : String?
    
    
    func mapping(map: Map) {
        address <- map["address"]
        benefit <- map["benefit"]
        benefit_title <- map["benefit_title"]
        caption_1 <- map["caption_1"]
        caption_2 <- map["caption_2"]
        caption_value_1 <- map["caption_value_1"]
        caption_value_2 <- map["caption_value_2"]
        code <- map["code"]
        contest_keyword <- map["contest_keyword"]
        contest_rules <- map["contest_rules"]
        contest_rules_text <- map["contest_rules_text"]
        convenience_fee <- map["convenience_fee"]
        cost_per_ticket <- map["cost_per_ticket"]
        cover_image <- map["cover_image"]
        created <- map["created"]
        description <- map["description"]
        draw_time <- map["draw_time"]
        end_date <- map["end_date"]
        facebook_raffle_url <- map["facebook_raffle_url"]
        fbpage_url <- map["fbpage_url"]
        id <- map["id"]
        igfollow_url <- map["igfollow_url"]
        igfollow_userid <- map["igfollow_userid"]
        image <- map["image"]
        instagram_raffle_url <- map["instagram_raffle_url"]
        is_manual_draw <- map["is_manual_draw"]
        is_thankyou_email_send <- map["is_thankyou_email_send"]
        jackpot_price <- map["jackpot_price"]
        latitude <- map["latitude"]
        licence <- map["licence"]
        location <- map["location"]
        longitude <- map["longitude"]
        max_purchase_limit <- map["max_purchase_limit"]
        max_tickets <- map["max_tickets"]
        modified <- map["modified"]
        notify_all_users <- map["notify_all_users"]
        organization_name <- map["organization_name"]
        organizer_raffle_url <- map["organizer_raffle_url"]
        
        winner_reveal_time <- map["winner_reveal_time"]
//        companyDetails <- map["Company"]
//        jobDescription <- map["Job"]
//        jobDetails <- map["JobDetail"]
        
        
        
//        "organization_name" = jackraffit;
//        "organizer_raffle_url" = "";
//        price = "";
//        prize = "";
//        "promo_connect" = 0;
//        public = 1;
//        "raffle_ctgry" = 2;
//        "raffle_ctgry_name" = Giveaway;
//        "raffle_date" = "";
//        "raffle_end_date" = "";
//        "raffle_initial" = "";
//        "raffle_type_id" = 6;
//        "random_ticket_number" = 602123;
//        "running_status" = 1;
//        "send_mail" = 0;
//        "send_sms" = 0;
//        "short_desc" = "";
//        "start_date" = "2017-04-26 15:30:00";
//        "start_time" = "2017-04-26 15:30:00";
//        "state_id" = "";
//        status = 1;
//        "stripe_connect" = 0;
//        "taffle_tire_id" = "";
//        "thankyou_email" = 0;
//        "ticket_type_id" = 2;
//        timezone = "";
//        "twitter_raffle_url" = "";
//        type = "";
//        "user_id" = 557;
//        "winner_payment_terms" = "";
//        "winner_reveal_time" = 10;
//        zipcode = "";
    }
}
class Prize : Mappable{
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public required init?(map: Map) {
        
    }
   
    var prize : String?
    var prize_description : String?
    var prize_image : String?
    
    
    func mapping(map: Map) {
        prize <- map["prize"]
        prize_description <- map["prize_description"]
        
        prize_image <- map["prize_image"]
        
        
    }
    
}

class TicketType : Mappable{
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public required init?(map: Map) {
        
    }
    
    var id : String?
    var price : String?
    var ticket_type_id : String?
    var tickets : String?
    
    
    func mapping(map: Map) {
        id <- map["id"]
        price <- map["price"]
        
        ticket_type_id <- map["ticket_type_id"]
        tickets <- map["tickets"]
        
        
    }
    
}











