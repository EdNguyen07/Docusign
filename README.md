# Docusign
Below is a sample Apex code using the DocuSign Apex Toolkit (the managed package that DocuSign provides for Salesforce). This assumes you’ve already:

Installed the DocuSign eSignature for Salesforce
.

Configured your DocuSign Account and Connect settings.

Created a DocuSign template (with roles like Customer).


dfsle.Envelope → A representation of a DocuSign envelope inside Salesforce.

dfsle.Recipient → Defines who will receive and sign the envelope.

dfsle.EnvelopeService → Provides methods like createEnvelopeFromTemplate() and sendEnvelope() to talk to DocuSign.

dfsle.EnvelopeStatus → Enum for Draft, Sent, Completed, etc.
