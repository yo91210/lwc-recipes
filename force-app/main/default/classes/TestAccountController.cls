@isTest
public class TestAccountController {
    public static void createAccounts(Integer amount) {
        List<Account> accounts = new List<Account>();

        for (Integer i = 1; i <= amount; i++) {
            accounts.add(new Account(Name = 'Name ' + i, Phone = '555-000' + i, Type = 'Customer'));
        }

        insert accounts;
    }

    @isTest
    static void getAccountList() {
        TestAccountController.createAccounts(10);

        Test.startTest();
        List<Account> accts = AccountController.getAccountList();
        Test.stopTest();

        System.assertEquals(accts.size(), 10);
        System.assertNotEquals(null, accts[0].Phone);
        System.assertEquals('555-0001', accts[0].Phone);
        System.assertNotEquals(null, accts[0].Type);
        System.assertEquals('Customer', accts[0].Type);
    }

    @isTest
    static void getSingleAccount() {
        TestAccountController.createAccounts(1);

        Test.startTest();
        Account acc = AccountController.getSingleAccount();
        Test.stopTest();

        System.assertEquals(acc.Name, 'Name 1');
    }
}
