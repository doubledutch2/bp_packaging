trigger OrderEventTrigger on Order_Event__e (after insert) {
    // Trigger for listening to Cloud_News events.
    // List to hold all cases to be created.
    List<Task> tasks = new List<Task>();
    
    // Get queue Id for case owner
    // Group queue = [SELECT Id FROM Group WHERE Name='Regional Dispatch' LIMIT 1];
       
    // Iterate through each notification.
    for (Order_Event__e event : Trigger.New) {
        if (event.Has_Shipped__c == true) {
            // Create Taks to dispatch new team.
            Task tk = new Task();
            tk.Priority = 'Medium';
            tk.Status = 'New';
            tk.Subject = 'Follow up on shipped order ' + 
                event.Order_Number__c;
            tk.OwnerId = '0050Y000001IREI';
            tasks.add(tk);
        }
   }
    
    // Insert all cases corresponding to events received.
    insert tasks;
}