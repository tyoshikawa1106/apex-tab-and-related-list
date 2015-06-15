/**
 * 取引先情報タブ登録
 * © Force.com Developer
 * ----------------------------------------
 * @createdName      : Taiki,Yoshikawa
 * @lastModifiedName : Taiki,Yoshikawa
 * ----------------------------------------
 */
public with sharing class AccountTabRegisterDao {

    /**
     * コンストラクタ
     */
    public AccountTabRegisterDao() {
        
    }

    /**
     * 取引先責任者取得
     */
    public List<Contact> getContacts(Account account) {
        return [
            SELECT
                 Id
                ,LastName
                ,FirstName
                ,Salutation
                ,Department
                ,Title
                ,ReportsToId
                ,AccountId
            FROM
                Contact
            WHERE
                AccountId =: account.Id
            ORDER BY Name ASC
            LIMIT 200
        ];
    }

    /**
     * 削除対象の取引先責任者取得
     */
    public List<Contact> getDeleteContacts(Id contactId) {
        return [
            SELECT
                Id
            FROM 
                Contact
            WHERE
                Id =: contactId
            LIMIT 1
        ];
    }
}