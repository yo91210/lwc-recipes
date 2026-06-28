@isTest
public with sharing class TestContactController {
    private static User getRunAsUser() {
        return [SELECT Id FROM User WHERE Profile.Name = 'System Administrator' AND IsActive = true LIMIT 1];
    }

    public static void createContacts(Integer amount) {
        List<Contact> contacts = new List<Contact>();

        for (Integer i = 1; i <= amount; i++) {
            contacts.add(
                new Contact(
                    FirstName = 'First ' + i,
                    LastName = 'Last ' + i,
                    Picture__c = 'test'
                )
            );
        }

        insert contacts;
    }

    @isTest
    static void getContactList() {
        TestContactController.createContacts(10);
        User u = getRunAsUser();

        Test.startTest();
        System.runAs(u) {
            List<Contact> conts = ContactController.getContactList();
            System.assertEquals(
                10,
                conts.size(),
                'The contact list size should be 10'
            );
        }
        Test.stopTest();
    }

    @isTest
    static void findContacts() {
        TestContactController.createContacts(10);
        User u = getRunAsUser();

        Test.startTest();
        System.runAs(u) {
            List<Contact> conts = ContactController.findContacts('Last');
            System.assertEquals(
                10,
                conts.size(),
                'The contacts retrieved by search should be 10'
            );
        }
        Test.stopTest();
    }

    @isTest
    static void testFindContacts_nullKey() {
        TestContactController.createContacts(3);
        User u = getRunAsUser();

        Test.startTest();
        System.runAs(u) {
            List<Contact> conts = ContactController.findContacts(null);
            System.assertEquals(
                0,
                conts.size(),
                'findContacts(null) should return an empty list'
            );
        }
        Test.stopTest();
    }

    @isTest
    static void testFindContacts_emptyKey() {
        TestContactController.createContacts(3);
        User u = getRunAsUser();

        Test.startTest();
        System.runAs(u) {
            List<Contact> conts = ContactController.findContacts('');
            System.assertEquals(
                0,
                conts.size(),
                'findContacts(\'\') should return an empty list'
            );
        }
        Test.stopTest();
    }

    @isTest
    static void getSingleContact() {
        TestContactController.createContacts(1);
        User u = getRunAsUser();

        Test.startTest();
        System.runAs(u) {
            Contact cont = ContactController.getSingleContact();
            System.assertEquals(
                'First 1 Last 1',
                cont.Name,
                'The contact name should be: First 1 Last 1'
            );
        }
        Test.stopTest();
    }
}
