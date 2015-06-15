/**
 * 取引先情報タブ登録
 * © Force.com Developer
 * ----------------------------------------
 * @createdName      : Taiki,Yoshikawa
 * @lastModifiedName : Taiki,Yoshikawa
 * ----------------------------------------
 */
@isTest
private class AccountTabRegisterDaoTest {

    private static AccountTabRegisterDao dao = new AccountTabRegisterDao();
    private static User testAdminUser = CommonTester.getTestUser();

    /**
     * 取引先責任者取得
     */
    static testMethod void getContactsTest1() {
        
        System.runAs(testAdminUser) {
            Test.startTest();
            
            Account account = new Account();
            
            List<Contact> results = dao.getContacts(account);
            System.assertEquals(results.isEmpty(), true);
            
            Test.stopTest();
        }
    }

    /**
     * 取引先責任者取得
     */
    static testMethod void getContactsTest2() {
        
        System.runAs(testAdminUser) {
            Test.startTest();
            
            Account account = CommonTester.createAccount(true);
            Contact contact = CommonTester.createContact(account, true);
            
            List<Contact> results = dao.getContacts(account);
            System.assertEquals(results.size(), 1);
            
            Test.stopTest();
        }
    }

    /**
     * 削除対象の取引先責任者取得
     */
    static testMethod void getDeleteContactsTest1() {
        
        System.runAs(testAdminUser) {
            Test.startTest();
            
            Id contactId = null;
            
            List<Contact> results = dao.getDeleteContacts(contactId);
            System.assertEquals(results.isEmpty(), true);
            
            Test.stopTest();
        }
    }

    /**
     * 削除対象の取引先責任者取得
     */
    static testMethod void getDeleteContactsTest2() {
        
        System.runAs(testAdminUser) {
            Test.startTest();
            
            Account account = CommonTester.createAccount(true);
            Contact contact = CommonTester.createContact(account, true);
            Id contactId = contact.Id;
            
            List<Contact> results = dao.getDeleteContacts(contactId);
            System.assertEquals(results.size(), 1);
            
            Test.stopTest();
        }
    }
}