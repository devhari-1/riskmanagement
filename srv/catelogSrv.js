const cds = require('@sap/cds');

module.export = cds.service.impl( async function(){
    const {Risks, Businesspartner} = this.entities;
    const BPsrv = cds.connect.to('API_BUSINESS_PARTNER');
    this.after('READ',Risks,(data)=>{
        const risks = Array.isArray(data)?data:[data];

        risks.foreach((risk)=>{
            risk.criticality = (risk.import>=100000)?1:2;
            switch(risk.prio_code){
                case 'H':
                    risk.PrioCriticality = 1;
                    break;
            case 'M':
                risk.PrioCriticality = 2;
                break;
            case 'L':
                risk.PrioCriticality = 3;
                break;
            default:
                break;
            }
        })
    })

    this.on("READ", BusinessPartners, async (req) => {
        // The API Sandbox returns alot of business partners with empty names.
        // We don't want them in our application
        req.query.where("LastName <> '' and FirstName <> '' ");

        return await BPsrv.transaction(req).send({
            query: req.query,
            headers: {
                apikey: process.env.apikey,
            },
        });
    });
});
