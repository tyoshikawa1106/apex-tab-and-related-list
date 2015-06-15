@isTest
private class AccountTabRegisterHelperTest {

    private static AccountTabRegisterHelper helper = new AccountTabRegisterHelper();
    private static User testAdminUser = CommonTester.getTestUser();

    /**
     * 初期表示リスト取得
     */
    static testMethod void getContactsTest1() {
        
        System.runAs(testAdminUser) {

            List<Contact> contacts = new List<Contact>();
            System.assertEquals(contacts.size(), 0);

            Test.startTest();
            
            helper.getDefaultContactList(contacts);
            System.assertEquals(contacts.size(), 1);
            
            Test.stopTest();
        }
    }

    /**
     * 初期表示リスト取得
     */
    static testMethod void getContactsTest2() {
        
        System.runAs(testAdminUser) {

            List<Contact> contacts = new List<Contact>();
            contacts.add(new Contact());
            contacts.add(new Contact());
            System.assertEquals(contacts.size(), 2);

            Test.startTest();
            
            helper.getDefaultContactList(contacts);
            System.assertEquals(contacts.size(), 2);
            
            Test.stopTest();
        }
    }

    /**
     * 取引先IDセット
     */
    static testMethod void setAccountIdTest1() {
        
        System.runAs(testAdminUser) {

            Account account = new Account();
            List<Contact> contacts = new List<Contact>();

            Test.startTest();
            
            helper.setAccountId(account, contacts);
            System.assertEquals(contacts.isEmpty(), true);
            
            Test.stopTest();
        }
    }

    /**
     * 取引先IDセット
     */
    static testMethod void setAccountIdTest2() {
        
        System.runAs(testAdminUser) {

            Account account = CommonTester.createAccount(true);
            List<Contact> contacts = new List<Contact>();
            contacts.add(new Contact());
            contacts.add(new Contact());
            System.assertEquals(contacts.size(), 2);

            Test.startTest();
            
            helper.setAccountId(account, contacts);
            
            Test.stopTest();

            for (Contact c : contacts) {
                System.assertEquals(String.isNotEmpty(c.AccountId), true);
            }
            System.assertEquals(contacts.size(), 2);
        }
    }

    /**
     * リストから除外
     */
    static testMethod void removeContactsTest1() {
        
        System.runAs(testAdminUser) {
            
            List<Contact> contacts = new List<Contact>();
            Integer listCnt = null;
            
            Test.startTest();
            
            helper.removeContacts(contacts, listCnt);
            
            Test.stopTest();
            
            System.assertEquals(contacts.isEmpty(), true);
        }
    }
    
    /**
     * リストから除外
     */
    static testMethod void removeContactsTest2() {
        
        System.runAs(testAdminUser) {
            
            List<Contact> contacts = new List<Contact>();
            contacts.add(new Contact());
            contacts.add(new Contact());
            contacts.add(new Contact());
            System.assertEquals(contacts.size(), 3);
            
            Integer listCnt = 0;
            
            Test.startTest();
            
            helper.removeContacts(contacts, listCnt);
            System.assertEquals(contacts.size(), 2);
            
            helper.removeContacts(contacts, listCnt);
            System.assertEquals(contacts.size(), 1);
            
            helper.removeContacts(contacts, listCnt);
            System.assertEquals(contacts.size(), 0);
            
            Test.stopTest();
        }
    }
}