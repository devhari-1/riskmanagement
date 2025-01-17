
namespace riskmanagement;


// using an external service from SAP S/4HANA Cloud
using { API_BUSINESS_PARTNER as external } from '../srv/external/API_BUSINESS_PARTNER.csn';




using {
        managed,
        cuid,
        User,
        sap.common.CodeList
} from '@sap/cds/common';

entity Risks : cuid, managed {
        title                    : String(100);
        owner                    : String;
        prio                     : Association to Priority;
        descr                    : String;
        miti                     : Association to Mitigations;
        impact                   : Integer;
         bp : Association to BusinessPartners;
        virtual criticality      : Integer;
        virtual PrioCriticality : Integer;
}

entity Mitigations : cuid, managed {
        descr    : String;
        owner    : String;
        timeline : String;
        risks    : Association to many Risks on risks.miti = $self;
        //risks    : Association to many Risks on risks.miti.cuid = ;
}

entity Priority : CodeList {
        key code : String enum {
                    high   = 'H';
                    medium = 'M';
                    low    = 'L';
            };
}

entity BusinessPartners as projection on external.A_BusinessPartner {
   key BusinessPartner,
   BusinessPartnerFullName as FullName,
}










































































// entity Employees {
//   key ID : Integer;

//   // managed backlinks
//   //addresses : Association to many Addresses on addresses.owner = $self;

//   // unmanaged backlinks
//   addresses : Association to many Addresses
//     on addresses.owner.ID = ID;
// }

// entity Addresses {

//   // unmanaged assocation  
//   //owner : Association to Employees on owner.ID = eid;  //> the backlink
//   //eid : Integer
//     owner : Association to Employees;
// }