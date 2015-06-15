/**
 * 取引先情報タブ登録
 * © Force.com Developer
 * ----------------------------------------
 * @createdName      : Taiki,Yoshikawa
 * @lastModifiedName : Taiki,Yoshikawa
 * ----------------------------------------
 */
public with sharing class AccountTabRegisterHelper {

    /**
     * コンストラクタ
     */
    public AccountTabRegisterHelper() {
        
    }

    /**
     * 初期表示リスト取得
     */
    public void getDefaultContactList(List<Contact> contacts) {
        if (contacts.isEmpty()) {
            contacts.add(new Contact());
        }
    }

    /**
     * 取引先IDセット
     */
    public void setAccountId(Account account, List<Contact> contacts) {
        for (Contact c : contacts) {
            if (String.isEmpty(c.AccountId)) {
                c.AccountId = account.Id;
            }
        }
    }

    /**
     * リストから除外
     */
    public void removeContacts(List<Contact> contacts, Integer listCnt) {
        if (listCnt != null) {
            contacts.remove(listCnt);
        }
    }
}