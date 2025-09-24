public class OpportunityToDocuSign {
    public static void sendOpportunityForSignature(Id opportunityId) {
        // Query the opportunity
        Opportunity opp = [
            SELECT Id, Name, Amount, CloseDate, Account.Name, Account.PersonEmail 
            FROM Opportunity 
            WHERE Id = :opportunityId
        ];

        // Create recipient (Customer)
        dfsle.Recipient customer = dfsle.Recipient.fromRoleName(
            'Customer', // Role defined in your DocuSign template
            opp.Account.PersonEmail,
            opp.Account.Name
        );

        // Merge fields (if your template has merge fields set up)
        Map<String, String> mergeFields = new Map<String, String>();
        mergeFields.put('Opportunity_Name', opp.Name);
        mergeFields.put('Opportunity_Amount', String.valueOf(opp.Amount));
        mergeFields.put('Opportunity_CloseDate', String.valueOf(opp.CloseDate));

        // Create the envelope using a template
        dfsle.Envelope myEnvelope = dfsle.EnvelopeService.getEmptyEnvelope(new dfsle.Envelope());
        myEnvelope = dfsle.EnvelopeService.createEnvelopeFromTemplate(
            'TEMPLATE_ID_HERE', // Replace with your DocuSign Template Id
            new List<dfsle.Recipient>{ customer },
            mergeFields
        );

        // Send the envelope
        myEnvelope.Status = dfsle.EnvelopeStatus.Sent;
        myEnvelope = dfsle.EnvelopeService.sendEnvelope(myEnvelope);

        System.debug('Envelope sent to DocuSign with Id: ' + myEnvelope.Id);
    }
}
