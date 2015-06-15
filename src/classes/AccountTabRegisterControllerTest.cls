/**
 * 取引先情報タブ登録
 * © Force.com Developer
 * ----------------------------------------
 * @createdName      : Taiki,Yoshikawa
 * @lastModifiedName : Taiki,Yoshikawa
 * ----------------------------------------
 */
@isTest
private class AccountTabRegisterControllerTest {

    private static User testAdminUser = CommonTester.getTestUser();

    /**
     * 初期表示リスト取得
     */
    static testMethod void AccountTabRegisterControllerTest1() {
        
        System.runAs(testAdminUser) {

            Account account = new Account();

            Test.startTest();
            
            AccountTabRegisterController cls = new AccountTabRegisterController(new ApexPages.StandardController(account));
            System.assertEquals(String.isEmpty(cls.account.Id), true);
            
            Test.stopTest();
        }
    }

    /**
     * 初期表示リスト取得
     */
    static testMethod void AccountTabRegisterControllerTest2() {
        
        System.runAs(testAdminUser) {

            Account account = CommonTester.createAccount(true);
            Contact contact = CommonTester.createContact(account, true);

            Test.startTest();
            
            AccountTabRegisterController cls = new AccountTabRegisterController(new ApexPages.StandardController(account));
            System.assertEquals(String.isNotEmpty(cls.account.Id), true);
            System.assertEquals(cls.contacts.isEmpty(), false);
            System.assertEquals(cls.contacts[0].Id, contact.Id);
            
            Test.stopTest();
        }
    }

    /**
     * 保存ボタン処理
     */
    static testMethod void doSaveTest1() {
        
        System.runAs(testAdminUser) {

            Account account = CommonTester.createAccount(true);
            Contact contact = CommonTester.createContact(account, true);

            Test.startTest();
            
            AccountTabRegisterController cls = new AccountTabRegisterController(new ApexPages.StandardController(account));
            cls.account.Name = 'Demo Account!!';
            cls.contacts[0].LastName = 'Demo Contact!!';
            cls.doSave();
            
            Test.stopTest();

            Account resltAccount = [SELECT Name FROM Account WHERE Id =: account.Id LIMIT 1];
            Contact resltContact = [SELECT LastName FROM Contact WHERE Id =: contact.Id LIMIT 1];
            System.assertEquals(resltAccount.Name, 'Demo Account!!');
            System.assertEquals(resltContact.LastName, 'Demo Contact!!');
        }
    }

    /**
     * 行追加ボタン処理
     */
    static testMethod void doAddContactsTest1() {
        
        System.runAs(testAdminUser) {

            Account account = CommonTester.createAccount(true);
            Contact contact = CommonTester.createContact(account, true);

            // コンストラクタ
            AccountTabRegisterController cls = new AccountTabRegisterController(new ApexPages.StandardController(account));
            System.assertEquals(cls.contacts.size(), 1);

            Test.startTest();
            
            cls.doAddContacts();
            System.assertEquals(cls.contacts.size(), 2);
            cls.doAddContacts();
            System.assertEquals(cls.contacts.size(), 3);
            cls.doAddContacts();
            System.assertEquals(cls.contacts.size(), 4);
            
            Test.stopTest();
        }
    }

    /**
     * 行削除ボタン処理
     */
    static testMethod void doDeleteContactsTest1() {
        
        System.runAs(testAdminUser) {

            Account account = CommonTester.createAccount(true);
            Contact contact = CommonTester.createContact(account, true);

            // コンストラクタ
            AccountTabRegisterController cls = new AccountTabRegisterController(new ApexPages.StandardController(account));
            System.assertEquals(cls.contacts.size(), 1);

            // 削除IDセット
            PageReference pageRef = CommonTester.getPageReference();
            pageRef.getParameters().put('deleteContactId', contact.Id);
            pageRef.getParameters().put('listCnt', '0');
            Test.setCurrentPage(pageRef);

            Test.startTest();
            
            cls.doDeleteContacts();
            System.assertEquals(cls.contacts.size(), 0);
            
            Test.stopTest();

            Integer resltContactContact = [SELECT Count() FROM Contact WHERE Id =: contact.Id LIMIT 1];
            System.assertEquals(resltContactContact, 0);
        }
    }
}