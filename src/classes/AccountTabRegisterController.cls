/**
 * 取引先情報タブ登録
 * © Force.com Developer
 * ----------------------------------------
 * @createdName      : Taiki,Yoshikawa
 * @lastModifiedName : Taiki,Yoshikawa
 * ----------------------------------------
 */
public with sharing class AccountTabRegisterController {

    private AccountTabRegisterHelper helper = new AccountTabRegisterHelper();
    private AccountTabRegisterDao dao = new AccountTabRegisterDao();
    // 取引先
    public Account account {get; set;}
    // 取引先責任者
    public List<Contact> contacts {get; set;}

    /**
     * コンストラクタ
     */
    public AccountTabRegisterController(ApexPages.StandardController stdController) {
        try {
            // 初期化
            this.account = new Account();
            this.contacts = new List<Contact>();
            // 取引先情報取得
            this.account = (Account)stdController.getRecord();
            // 取引先責任者取得
            if (String.isNotEmpty(this.account.Id)) {
                this.contacts = this.dao.getContacts(this.account);
            }
            // 初期表示リスト取得
            this.helper.getDefaultContactList(this.contacts);
        } catch (Exception e) {
            CommonUtil.msgException(e);
            return;
        }
    }

    /**
     * 保存ボタン処理
     */
    public PageReference doSave() {
        Savepoint sp = Database.setSavepoint();
        try {
            // 取引先保存
            upsert this.account;
            // 取引先IDセット
            this.helper.setAccountId(this.account, this.contacts);
            // 取引先責任者保存
            upsert this.contacts;
        } catch (DmlException e) {
            CommonUtil.msgDmlError(e);
            return null;
        } catch (Exception e) {
            CommonUtil.msgException(e);
            return null;
        }

        return new PageReference('/' + this.account.Id);
    }

    /**
     * 行追加
     */
    public void doAddContacts() {
        this.contacts.add(new Contact());
    }

    /**
     * 行削除
     */
    public void doDeleteContacts() {
        try {
            // 削除対象ID取得
            Id deleteContactId = CommonUtil.getParametersById('deleteContactId');
            // remove対象のリスト行数取得
            Integer listCnt = CommonUtil.getParametersByInteger('listCnt');
            // 削除対象取得
            List<Contact> deleteContacts = this.dao.getDeleteContacts(deleteContactId);
            // 削除
            delete deleteContacts;
            // Remove
            this.helper.removeContacts(this.contacts, listCnt);
        } catch (DmlException e) {
            CommonUtil.msgDmlError(e);
            return;
        } catch (Exception e) {
            CommonUtil.msgException(e);
            return;
        }
    }
}