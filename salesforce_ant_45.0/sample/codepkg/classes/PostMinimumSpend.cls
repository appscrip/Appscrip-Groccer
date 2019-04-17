public with sharing class PostMinimumSpend {

  /*  Public String selectedSummary {get; set;}
    Public List<SelectOption> allAvailableSummary {get; set;}
    Public List<Minimum_Spend_Preview__c> MSrecords {get; set;}
    Set<Date> summaryRecords;
    public Charge_Item__c chargeItem;
    public Integer totalEntries {get; set;}
    String statementDescription;
    List<Default_Account__c> defaultAccounts;
    String chargeRecordId;
    List<TxnChargeToTaxMapping__c> taxesMapping;
    public String postAllGUID {get; set;}
    public Boolean postAll {get; set;}
    private Static Map<Id, Schema.RecordTypeInfo> recordTypeByIdMap;
    private Map<String, List<TxnChargeToTaxMapping__c>> taxMapingMap;
    public TXN__c trans {get; set;}
    public Boolean status {get;set;}
    public Boolean referesPage {get;set;}

    public PostMinimumSpend() {
        trans = new TXN__c();
        status =false;
        String glDescription = Utility.getDefaultFGE_FGL_Desc_value('Minimum_Spend_Posting__c');
        if (glDescription != null) {
            trans.GL_description__c = glDescription;
        }
        postAllGUID = Utility.generateGuid();
        postAll = false;
        referesPage =false;
        MSrecords = new List<Minimum_Spend_Preview__c>();
        allAvailableSummary = new List<SelectOption>();
        List<Minimum_Spend_Preview__c> records = (List<Minimum_Spend_Preview__c>)Data.read(
                    'Select Id, Post_Date__c FROM Minimum_Spend_Preview__c WHERE Posted__c=:posted',
        new Map<String, Object> {
            'posted' => false
        });
        summaryRecords = new Set<Date>();
        for (Minimum_Spend_Preview__c msp : records) {
            summaryRecords.add(msp.Post_Date__c);
        }

        allAvailableSummary.add(new SelectOption('', '--None--'));
        for (Date d : summaryRecords) {
            allAvailableSummary.add(new SelectOption(d.format(), d.format()));
        }

        Minimum_Spend_Setting__c minimumSettings = Minimum_Spend_Setting__c.getOrgDefaults();
        statementDescription = 'Transaction for minimum spend';
        if (minimumSettings.Statement_Description__c != null) {
            statementDescription = minimumSettings.Statement_Description__c;
        }
        if (minimumSettings.ChargeId__c != null) {


            List<Charge_Item__c> chargesList = (List<Charge_Item__c>) Data.Read('SELECT Id, Type__c, SubType__c, Financial_Account__c '
                                               + 'FROM Charge_Item__c '
                                               + 'WHERE Id = :chargeId',
                                               new Map<String, Object> {'chargeId' => minimumSettings.ChargeId__c});

            if (chargesList.size() > 0) {
                chargeItem = chargesList.get(0);
            }
        

        defaultAccounts = (List<Default_Account__c>)Data.read('SELECT Id, Financial_Account__c '
                          + 'FROM Default_Account__c '
                          + 'WHERE Default_Type_Name__c = :defaultAccountReceivable',
                          new Map<String, Object> {'defaultAccountReceivable' => 'Accounts Receivable'});




        taxesMapping = (List<TxnChargeToTaxMapping__c>)Data.read('SELECT Type__c, Billing_Record_Type__c, Subtype__c, TaxId__c, Service_Charge_applicable__c, Service_Charge_Name__c, '
                       + 'Tax_Name_applicable_on_service_charge__c, Taxes_applicable_on_service_charge__c '
                       + ' FROM TxnChargeToTaxMapping__c '
                       + 'WHERE Type__c =:TypeName AND SubType__c =:SubtypeName AND Billing_Record_Type__c IN :billingTypes',
        new Map<String, Object> {'TypeName' => chargeItem.Type__c , 'SubtypeName' => chargeItem.SubType__c, 'billingTypes' => new List<String> {'Member', 'Guest', 'Employee', 'Non Member', 'Reciprocal Club', 'Vendor'}});

        if (taxesMapping.size() < 1) {
            taxesMapping = (List<TxnChargeToTaxMapping__c>)Data.read('SELECT Type__c, Billing_Record_Type__c, Subtype__c, TaxId__c, Service_Charge_applicable__c, Service_Charge_Name__c, '
                           + 'Tax_Name_applicable_on_service_charge__c, Taxes_applicable_on_service_charge__c '
                           + 'FROM TxnChargeToTaxMapping__c '
                           + 'WHERE Type__c = :TypeName AND SubType__c = :SubtypeName AND Billing_Record_Type__c IN :billingTypes',
            new Map<String, Object> {'TypeName' => chargeItem.Type__c , 'SubtypeName' => null, 'billingTypes' => new List<String> {'Member', 'Guest', 'Employee', 'Non Member', 'Reciprocal Club', 'Vendor'}});

        }

        taxMapingMap = new Map<String, List<TxnChargeToTaxMapping__c>>();
        for (TxnChargeToTaxMapping__c taxConfiguration : taxesMapping) {
            if (taxMapingMap.containsKey(taxConfiguration.Billing_Record_Type__c)) {
                taxMapingMap.get(taxConfiguration.Billing_Record_Type__c).add(taxConfiguration);
            } else {
                List<TxnChargeToTaxMapping__c> TaxList = new List<TxnChargeToTaxMapping__c>();
                TaxList.add(taxConfiguration);
                taxMapingMap.put(taxConfiguration.Billing_Record_Type__c, TaxList);
            }
        }
    }

    chargeRecordId = Utility.getRecordTypeId('TXN__c', 'Charge');

}
public void postCharges() {
    List<Closed_Periods__c>dateLock =Utility.getlockDateVal();
    if(!Utility.lockingPeriod(Date.parse(selectedSummary),dateLock)){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'This month has already been closed.'));
        return;
    }
    recordTypeByIdMap = Schema.SObjectType.Contact.getRecordTypeInfosById();
    List<TXN__c> transactions = new List<TXN__c>();
    List<Minimum_Spend_Preview__c> minimumPreview = new List<Minimum_Spend_Preview__c>();
    Set<Id> memberIds = new Set<Id>();
    for (Minimum_Spend_Preview__c mw : MSrecords) {
        if (mw.Posted__c == true) {
            memberIds.add(mw.Contact__c);
        }
    }

    if (defaultAccounts.size() <= 0) {
        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Default Account Receivable is not Mapped.'));
    } else {

        Decimal taxAmount = 0.00;
        TaxesAndServiceCharge TaxSc;
        List<transactionsMap> allTransactions = new List<transactionsMap>();

        String taxRecordTypeId = Utility.getRecordTypeId('TXN__c', 'Taxes');
        String debitAccount = defaultAccounts.get(0).Financial_Account__c;
        Map<Id, Contact> contactMap = new Map<Id, Contact>((List<Contact>)Data.read('SELECT Id, Bill_To_Member__c, Tax_Exempt__c, RecordTypeId '
                + 'FROM Contact '
                + 'WHERE Id in :contactIds',
                new Map<String, Object> {'contactIds' => memberIds}));

        //get tax to finacial account mapping
        Map<String, Tax_To_Account_Mapping__c> mapOfTaxesAndFinAccount = Utility.getTaxAndFinancialAccountMappings();
        List<TXN__c> taxList;
        for (Minimum_Spend_Preview__c mw : MSrecords) {
            if (mw.Posted__c == true) {
                String guid = Utility.generateGuid();
                minimumPreview.add(mw);
                TXN__c txn = new TXN__c();
                txn.Parent_Guid__c = guid;
                txn.GL_description__c = trans.GL_description__c;
                txn.Date__c = mw.Post_Date__c;
                txn.Amount__c = mw.Amount__c;
                txn.Description__c = mw.Billing_Period__c;
                txn.Charge_Item__c = mw.Charge_Item__c;
                txn.Customer__c = mw.Contact__c;
                txn.RecordTypeId = chargeRecordId;
                txn.GlobalType__c = chargeItem.Type__c;
                txn.GlobalSubType__c = chargeItem.SubType__c;
                txn.Quantity__c = 1;
                if (contactMap.get(mw.Contact__c) != null && !contactMap.get(mw.Contact__c).Tax_Exempt__c)
                    txn.Tax__c = mw.Tax_Amount__c;
                txn.Credit_Financial_Account__c = chargeItem.Financial_Account__c;
                txn.Debit_Financial_Account__c = debitAccount;
                txn.Bill_To_Member__c = mw.Contact__c;
                txn.Statement_Description__c = statementDescription;
                if (contactMap.containsKey(mw.Contact__c)) {
                    if (contactMap.get(mw.Contact__c).Bill_To_Member__c != null) {
                        txn.Bill_To_Member__c = contactMap.get(mw.Contact__c).Bill_To_Member__c;
                    }
                }

                txn.Reference__c = 'MIN';
                transactions.add(txn);
                List<TxnChargeToTaxMapping__c> mappingToget = new List<TxnChargeToTaxMapping__c>();
                String recordTypeName = recordTypeByIdMap.get(contactMap.get(mw.Contact__c).RecordTypeId).getName();
                if (taxMapingMap.containsKey(recordTypeName)) {
                    mappingToget.addAll(taxMapingMap.get(recordTypeName));
                } else {
                    if (taxMapingMap.containsKey('Member')) {
                        mappingToget.addAll(taxMapingMap.get('Member'));
                    }
                }

                TaxSc = new TaxesAndServiceCharge(chargeItem.Type__c, chargeItem.SubType__c, recordTypeByIdMap.get(contactMap.get(mw.Contact__c).RecordTypeId).getName(), txn.Amount__c, mappingToget);
                taxList = new List<TXN__c>();
                for (TaxesAndServiceCharge.Taxes Itax : TaxSc.taxesList) {
                    if (Itax.Amount != null && contactMap.get(txn.Bill_To_Member__c) != null && !contactMap.get(txn.Bill_To_Member__c).Tax_Exempt__c) {
                        TXN__c taxes = new TXN__c(RecordTypeId = taxRecordTypeId);
                        taxes.Debit_Financial_Account__c = debitAccount;
                        if (mapOfTaxesAndFinAccount.containsKey(Itax.taxName) && mapOfTaxesAndFinAccount.get(Itax.taxName).Financial_Accounts__c != null) {
                            taxes.Credit_Financial_Account__c = mapOfTaxesAndFinAccount.get(Itax.taxName).Financial_Accounts__c;
                        }
                        taxes.Bill_To_Member__c = txn.Bill_To_Member__c;
                        taxes.Customer__c = txn.Customer__c;
                        taxes.Date__c = System.today();
                        taxes.Amount__c = Itax.Amount;
                        taxes.Date__c = txn.Date__c;
                        taxes.Charge_Item__c = txn.Charge_Item__c;
                        taxes.GL_description__c = trans.GL_description__c;
                        taxes.Reference__c = 'MIN';
                        taxes.Related_Guid__c = guid;
                        taxes.Tax_Name__c = Itax.taxName;
                        taxList.add(taxes);
                    }
                }
                                
                if (!taxList.isEmpty()) {
                    transactions.addAll(taxList);
                    allTransactions.add(new transactionsMap(txn, taxList));
                }
            }
        }
        savePost(transactions, minimumPreview);
    }
}

public void postAllCharges() {
    List<Closed_Periods__c>dateLock =Utility.getlockDateVal();
    recordTypeByIdMap = Schema.SObjectType.Contact.getRecordTypeInfosById();
    List<TXN__c> transactions = new List<TXN__c>();
    List<Minimum_Spend_Preview__c> minimumPreview = new List<Minimum_Spend_Preview__c>();
    Set<Id> memberIds = new Set<Id>();
    if(!Utility.lockingPeriod(Date.parse(selectedSummary),dateLock)){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'This month has already been closed.'));
            return;
        }
    for (Minimum_Spend_Preview__c mw : MSrecords) {
        memberIds.add(mw.Contact__c);
    }

    if (defaultAccounts.size() <= 0) {
        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Default Account Receivable is not Mapped.'));
    } else {

        Decimal taxAmount = 0.00;
        TaxesAndServiceCharge TaxSc;
        List<transactionsMap> allTransactions = new List<transactionsMap>();

        String taxRecordTypeId = Utility.getRecordTypeId('TXN__c', 'Taxes');
        String debitAccount = defaultAccounts.get(0).Financial_Account__c;
        Map<Id, Contact> contactMap = new Map<Id, Contact>((List<Contact>) Data.read('SELECT Id, Bill_To_Member__c, Tax_Exempt__c, RecordTypeId '
                + 'FROM Contact '
                + 'WHERE Id in :contactIds',
                new Map<String, Object> {'contactIds' => memberIds}));
        List<TXN__c> taxList;
        for (Minimum_Spend_Preview__c mw : MSrecords) {
            String guid = Utility.generateGuid();
            mw.Posted__c = true;
            minimumPreview.add(mw);
            TXN__c txn = new TXN__c();
            txn.Parent_Guid__c = guid;
            txn.Date__c = mw.Post_Date__c;
            txn.GL_description__c = trans.GL_description__c;
            txn.Amount__c = mw.Amount__c;
            txn.Description__c = mw.Billing_Period__c;
            txn.Charge_Item__c = mw.Charge_Item__c;
            txn.Customer__c = mw.Contact__c;
            txn.RecordTypeId = chargeRecordId;
            txn.GlobalType__c = chargeItem.Type__c;
            txn.GlobalSubType__c = chargeItem.SubType__c;
            txn.Quantity__c = 1;
            if (contactMap.get(mw.Contact__c) != null && !contactMap.get(mw.Contact__c).Tax_Exempt__c)
                txn.Tax__c = mw.Tax_Amount__c;
            txn.Credit_Financial_Account__c = chargeItem.Financial_Account__c;
            txn.Debit_Financial_Account__c = debitAccount;
            txn.Bill_To_Member__c = mw.Contact__c;
            txn.Statement_Description__c = statementDescription;
            if (contactMap.containsKey(mw.Contact__c)) {
                if (contactMap.get(mw.Contact__c).Bill_To_Member__c != null) {
                    txn.Bill_To_Member__c = contactMap.get(mw.Contact__c).Bill_To_Member__c;
                }
            }

            txn.Reference__c = 'MIN';
            transactions.add(txn);

            List<TxnChargeToTaxMapping__c> mappingToget = new List<TxnChargeToTaxMapping__c>();
            String recordTypeName = recordTypeByIdMap.get(contactMap.get(mw.Contact__c).RecordTypeId).getName();
            if (taxMapingMap.containsKey(recordTypeName)) {
                mappingToget.addAll(taxMapingMap.get(recordTypeName));
            } else {
                if (taxMapingMap.containsKey('Member')) {
                    mappingToget.addAll(taxMapingMap.get('Member'));
                }
            }

            TaxSc = new TaxesAndServiceCharge(chargeItem.Type__c, chargeItem.SubType__c,  recordTypeByIdMap.get(contactMap.get(mw.Contact__c).RecordTypeId).getName(), txn.Amount__c, mappingToget);
            taxList = new List<TXN__c>();
            for (TaxesAndServiceCharge.Taxes Itax : TaxSc.taxesList) {
                if (Itax.Amount != null && contactMap.get(txn.Bill_To_Member__c) != null && !contactMap.get(txn.Bill_To_Member__c).Tax_Exempt__c) {
                    TXN__c taxes = new TXN__c(RecordTypeId = taxRecordTypeId);
                    taxes.Debit_Financial_Account__c = debitAccount;
                    taxes.Credit_Financial_Account__c = txn.Credit_Financial_Account__c;
                    taxes.Bill_To_Member__c = txn.Bill_To_Member__c;
                    taxes.Customer__c = txn.Customer__c;
                    taxes.Date__c = System.today();
                    taxes.Amount__c = Itax.Amount;
                    taxes.GL_description__c = trans.GL_description__c;
                    taxes.Date__c = txn.Date__c;
                    taxes.Charge_Item__c = txn.Charge_Item__c;
                    taxes.Reference__c = 'MIN';
                    taxes.Related_Guid__c = guid;
                    taxes.Tax_Name__c = Itax.taxName;
                    taxList.add(taxes);
                }
            }



            if (!taxList.isEmpty()) {
                transactions.addAll(taxList);
                allTransactions.add(new transactionsMap(txn, taxList));
            }
        }
        //Ensure that all one FJE is created when posting all
        Utility.assignGuidToTxns(postAllGUID, transactions);
        savePost(transactions, minimumPreview);
    }
}

private void savePost(List<TXN__c> transactions, List<Minimum_Spend_Preview__c> minimumPreview) {
    Utility.handleTxnsAsync(transactions);
    Data.modify(minimumPreview);
    status =true;
    loadSummary();
}

public void rejectCharges() {
    List<Minimum_Spend_Preview__c> minimumPreview = new List<Minimum_Spend_Preview__c>();
    Set<Id> minimumAppMap = new Set<Id>();
    for (Minimum_Spend_Preview__c mw : MSrecords) {
        if (mw.Posted__c == true) {
            minimumPreview.add(mw);
            minimumAppMap.add(mw.Minimum_Spend_Application__c);
        }
    }
    if (minimumPreview.size() > 0) {
        Date runAsDate = minimumPreview.get(0).Run_as_of__c;
        Date PeriodBeginDate = Date.newInstance(runAsDate.year(), runAsDate.month(), 1);

        List<Minimum_Spend_Application__c> minimumRecordToUpdate = new List<Minimum_Spend_Application__c>();
        List<Minimum_Spend_Application__c> minimumAppList = (List<Minimum_Spend_Application__c>)
                Data.read('Select ' + Utility.getFields('Minimum_Spend_Application__c')
                          + ' FROM Minimum_Spend_Application__c '
                          + ' WHERE Id IN :msaId',
                          new Map<String, object> {'msaId' => minimumAppMap});

        for (Minimum_Spend_Application__c minimumApp : minimumAppList) {
            Map<String, Integer> frequencyMap = new Map<String, Integer> {'Annual' => 1, 'Semi-Annual' => 2, 'Quarterly' => 4, 'Monthly' => 12, 'Custom' => (Integer)minimumApp.Period__c};
            Integer frequency = frequencyMap.get(minimumApp.Frequency__c);
            for (Integer i = 1; i <= frequency; i++) {
                String endDate = 'Period_' + String.valueOf(i) + '_End_Date__c';
                String isProcessed = 'Period_' + String.valueOf(i) + '_Charged__c';
                if (runAsDate >= (Date)minimumApp.get(endDate) && (Date)minimumApp.get(endDate) >= PeriodBeginDate) {
                    {
                        minimumApp.put(isProcessed, false);
                    }
                }
            }
            minimumRecordToUpdate.add(minimumApp);
        }
        Data.modify(minimumRecordToUpdate);
    }

    Data.remove(minimumPreview);
    loadSummary();
}
public pageReference cancelAssignment() {
    return page.FinancialLandingPage;
}
public pageReference backToMonthCLose() {
    return page.MonthCloseLandingPage;
}

public void loadSummary() {
    postAll =false;
        if (selectedSummary != null && selectedSummary != '') {
            MSrecords = (List<Minimum_Spend_Preview__c>)Data.read(
                            'Select Id, Post_Date__c, Amount__c, Posted__c, Billing_Period__c, Charge_Item__c, Contact__c, Minimum_Spend_Application__c, Run_as_of__c, Tax_Amount__c, Total_Amount__c,' + Utility.getNamespace() + 'Minimum_Spend_Application__r.' + Utility.getNamespace() + 'Minimum_Spend_Record__r.Name FROM Minimum_Spend_Preview__c' +
                            ' WHERE Post_Date__c=:postdate AND Posted__c=:posted limit 1000',
            new Map<String, object> {
                'postdate' => date.parse(selectedSummary),
                'posted' => false
            });
            totalEntries = 0;
            List<Minimum_Spend_Preview__c> TotalCounter = (List<Minimum_Spend_Preview__c>)Data.read(
                    'Select Id,Name FROM Minimum_Spend_Preview__c' +
                    '  WHERE Post_Date__c=:postdate AND Posted__c=:posted',
            new Map<String, object> {
                'postdate' => date.parse(selectedSummary),
                'posted' => false
            });

            if (TotalCounter.size() > 0) {
                totalEntries =TotalCounter.size();
            }else{
                postAll =true;
            }
        }
    }
    public PageReference renderPage(){
        PageReference pa =Page.PostMinimumSpendCharges;
        pa.setRedirect(true);
        return pa;
    }

private class transactionsMap {
    TXN__c masterTrasaction;
    List<TXN__c> taxTransactions;

    transactionsMap(TXN__c masterTrasaction, List<TXN__c> taxTransactions) {
        this.masterTrasaction = masterTrasaction;
        this.taxTransactions = taxTransactions;
    }
}  */
}