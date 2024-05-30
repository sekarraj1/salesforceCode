public with sharing class CandidateSkillLinkHandler {

  /*
    Write a trigger that automates the linking of candidate and skill records.it should read skills 
    listed in a text area field on candidate, match them with existing skills, 
    and connect them using a junction object called candidate skill.
    also if a skill doesn’t then create the skill before establishing the connection.
  */
    public static void linkSkillWithCandidate(List<Candidate__c> canList) {

      Map<String,Skill__c> existingSkills = new Map<String,Skill__c>();
      Map<String,Candidate__c> candidateSkillMap = new Map<String,Candidate__c>();
      List<Skill__c> skilList = new List<Skill__c>();
      List<Candidate_skill__c> listToInsertJunction = new List<Candidate_skill__c>();

      for(Skill__c skills:[SELECT id,Name FROM Skill__c]){
        existingSkills.put(skills.Name,skills);
      }
      if(!canList.isEmpty()){
        for(Candidate__c cand:canList){
          String[] skillNames = cand.Skill_Set__c.split(',');
          for(String skillName:skillNames){
            if(!candidateSkillMap.containsKey(skillName)){
              candidateSkillMap.put(skillName,cand);
            }
            
          }
        }
        for(String skill:candidateSkillMap.keySet()){
          if(existingSkills.containsKey(skill)){
            Candidate_skill__c cs = new Candidate_skill__c();
            cs.skill__c = existingSkills.get(skill).Id;
            cs.Name = skill;
            cs.Candidate__c = candidateSkillMap.get(skill).Id;
            listToInsertJunction.add(cs);
          }
          else{
            Skill__c skc = new Skill__c();
            skc.Name = skill;
            skilList.add(skc);
          }
        }
        if(!skilList.isEmpty()){
          insert skilList;
          for(Skill__c sl:skilList){
            Candidate_Skill__c css = new Candidate_Skill__c();
            css.Skill__c = sl.Id;
            css.Name = sl.Name + 'Junction';
            css.Candidate__c = candidateSkillMap.get(sl).Id;
            listToInsertJunction.add(css);
          }
          
        }
        if(!listToInsertJunction.isEmpty()){
            insert listToInsertJunction;
        }
      }


    }
}