trigger NameContainTest on Account (Before Insert,Before Update) {

    for(Account a : Trigger.new){
        if(a.name.Contains('test')){
        a.Industry='Engineering';
        }
    
    }

}