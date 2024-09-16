
using {riskmanagement as rm} from '../db/datamodel.cds';

@path: 'service/risk'
service RiskService@(requires: 'authenticated-user'){

    entity Risks @(odata.draft.enabled : true) as projection on rm.Risks;
    annotate Risks with @(restrict : [
                        {
                            grant : 'READ',
                            to : 'RiskViewer'
                        },
                        {
                            grant : '*',
                            to : 'RiskManager'
                        }
                    ]);
    //annotate Risks with @odata.draft.enabled;

    entity Mitigations @(odata.draft.enabled : true) as projection on rm.Mitigations;

    annotate Mitigations with @(restrict : [
                        {
                            grant : 'READ',
                            to : 'RiskViewer'
                        },
                        {
                            grant : '*',
                            to : 'RiskManager'
                        }
                    ]);
    //annotate Mitigations with @odata.draft.enabled;

    // BusinessPartner will be used later
     @readonly entity BusinessPartners as projection on rm.BusinessPartners;
}