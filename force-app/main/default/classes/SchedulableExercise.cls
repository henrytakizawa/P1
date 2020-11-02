global class SchedulableExercise implements Schedulable {
    
    global void execute(SchedulableContext sc){
        Case c = new Case();
        c.Contact.LastName = 'Scheduled Case';
        insert c;
    }

}