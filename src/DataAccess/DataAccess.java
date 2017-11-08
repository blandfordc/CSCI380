/*Uses amazon dynamoDB to create and add/delete from tables. */
package DataAccess;

import java.util.HashMap;
import java.util.Map;

import com.amazonaws.AmazonClientException;
import com.amazonaws.AmazonServiceException;
import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.profile.ProfileCredentialsProvider;
import com.amazonaws.regions.Region;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClient;
import com.amazonaws.services.dynamodbv2.model.AttributeDefinition;
import com.amazonaws.services.dynamodbv2.model.AttributeValue;
import com.amazonaws.services.dynamodbv2.model.ComparisonOperator;
import com.amazonaws.services.dynamodbv2.model.Condition;
import com.amazonaws.services.dynamodbv2.model.CreateTableRequest;
import com.amazonaws.services.dynamodbv2.document.DynamoDB;
import com.amazonaws.services.dynamodbv2.document.PrimaryKey;
import com.amazonaws.services.dynamodbv2.document.Table;
import com.amazonaws.services.dynamodbv2.document.UpdateItemOutcome;
import com.amazonaws.services.dynamodbv2.document.spec.DeleteItemSpec;
import com.amazonaws.services.dynamodbv2.document.spec.GetItemSpec;
import com.amazonaws.services.dynamodbv2.document.spec.UpdateItemSpec;
import com.amazonaws.services.dynamodbv2.document.utils.ValueMap;
import com.amazonaws.services.dynamodbv2.model.DescribeTableRequest;
import com.amazonaws.services.dynamodbv2.model.KeySchemaElement;
import com.amazonaws.services.dynamodbv2.model.KeyType;
import com.amazonaws.services.dynamodbv2.model.ProvisionedThroughput;
import com.amazonaws.services.dynamodbv2.model.PutItemRequest;
import com.amazonaws.services.dynamodbv2.model.PutItemResult;
import com.amazonaws.services.dynamodbv2.model.ScalarAttributeType;
import com.amazonaws.services.dynamodbv2.model.ScanRequest;
import com.amazonaws.services.dynamodbv2.model.ScanResult;
import com.amazonaws.services.dynamodbv2.model.TableDescription;
import com.amazonaws.services.dynamodbv2.util.TableUtils;



/**
 * This class contains methods that interact with an amazon Dynamodb
 * Here we will create tables, add stuff to them, fun stuff like that.
 *
 */

public class DataAccess {

/**
 * before you can run this code locally or otherwise, you will need to have your
 * valid credentials file in the correct place, mine was configured with the
 * eclipse ide when i got this to run.
 * 
 */
	
	public static void disableWarning() {
		/**
		 * annoying errors keep occurring because java 9 is dumber than
		 * java 8, so this has to be here for demonstration only
		 */
	    System.err.close();
	    System.setErr(System.out);
	}

    static AmazonDynamoDBClient dynamoDB;

    /**
     * The only information needed to create a client are security credentials
     * consisting of the AWS Access Key ID and Secret Access Key. All other
     * configuration, such as the service endpoints, are performed
     * automatically. Client parameters, such as proxies, can be specified in an
     * optional ClientConfiguration object when constructing a client.
     *
     * @see com.amazonaws.auth.BasicAWSCredentials
     * @see com.amazonaws.auth.ProfilesConfigFile
     * @see com.amazonaws.ClientConfiguration
     */
    public static void init() throws Exception {
        /**
         * Checks the credentials on the current machine
         * you need to have your credentials file in something like
         * nevermind, this ide won't let me type path names in comments
         * for some reason.
         */
        BasicAWSCredentials credentials = null;
        try {
            credentials = new BasicAWSCredentials("AKIAIRGVLVCRJULKXVPA", "bHGHuRvmXkuSKeaRuqjh8uiuTyDWkXNN3hoFKF55");
        } catch (Exception e) {
            throw new AmazonClientException(
                    "Cannot load the credentials from the credential profiles file. " +
                    "Please make sure that your credentials file is at the correct " +
                    "location (/Users/admin/.aws/credentials), and is in valid format.",
                    e);
        }
        dynamoDB = new AmazonDynamoDBClient(credentials);
        Region usWest2 = Region.getRegion(Regions.US_WEST_2);
        dynamoDB.setRegion(usWest2);

	String tableName = "organizations";
	try{
	 // Create a table with a primary hash key named 'name', which holds a string
        CreateTableRequest createTableRequest = new CreateTableRequest().withTableName(tableName)
                .withKeySchema(new KeySchemaElement().withAttributeName("name").withKeyType(KeyType.HASH))
                .withAttributeDefinitions(new AttributeDefinition().withAttributeName("name").withAttributeType(ScalarAttributeType.S))
                .withProvisionedThroughput(new ProvisionedThroughput().withReadCapacityUnits(1L).withWriteCapacityUnits(1L));
	 // Create table if it does not exist yet
         TableUtils.createTableIfNotExists(dynamoDB, createTableRequest);
         // wait for the table to move into ACTIVE state
         TableUtils.waitUntilActive(dynamoDB, tableName);
	 DescribeTableRequest describeTableRequest = new DescribeTableRequest().withTableName(tableName);
         TableDescription tableDescription = dynamoDB.describeTable(describeTableRequest).getTable();
         System.out.println("Table Description: " + tableDescription);

	 // Add an item
         Map<String, AttributeValue> item = newOrganization("Fake organization name", "coming soon, in a theater near you!", "****", "beds available", "some other stuff");
         addItem(tableName,  item);

         // Add another item
         item = newOrganization("fake organization name", "123 nonexistent avenue", "abc123", "Needle exchange", "Rehabilitation");
         addItem(tableName, item);
		
	 //get an item
         getItemByPrimaryKey(tableName, "fake organization name");
            
         //update an item
         updateItem(tableName, "fake organization name", "fake service updated!");
		
	 //delete an item
         deleteItem(tableName, "fake organization name");

         //print all the stuff in the table with tablename
         printAll(tableName);
	 } catch (AmazonServiceException ase) {
            System.out.println("Caught an AmazonServiceException, which means your request made it "
                    + "to AWS, but was rejected with an error response for some reason.");
            System.out.println("Error Message:    " + ase.getMessage());
            System.out.println("HTTP Status Code: " + ase.getStatusCode());
            System.out.println("AWS Error Code:   " + ase.getErrorCode());
            System.out.println("Error Type:       " + ase.getErrorType());
            System.out.println("Request ID:       " + ase.getRequestId());
        } catch (AmazonClientException ace) {
            System.out.println("Caught an AmazonClientException, which means the client encountered "
                    + "a serious internal problem while trying to communicate with AWS, "
                    + "such as not being able to access the network.");
            System.out.println("Error Message: " + ace.getMessage());
        }
    }

    private static Map<String, AttributeValue> newOrganization(String name, String location, String password, String... services) {
    	/**
    	 * This method creates a map of attribute name to attribute value. DynamoDB allows us to insert such maps
    	 * directly into the database with no sequel involved, how convenient! This specific one is for Organizations, and
    	 * most of the attributes will probably change before all is said and done, I'm just not sure what data 
    	 * types we will need later on. 
    	 */
        Map<String, AttributeValue> item = new HashMap<String, AttributeValue>();
        item.put("name", new AttributeValue(name));
        item.put("location", new AttributeValue(location));
        item.put("password", new AttributeValue(password));
        item.put("services", new AttributeValue().withSS(services));

        return item;
    }
    public static void printAll(String tableName) {
    	/**
    	 * This method gets all the entries from a given table name and prints them
    	 * We should probably make it return the actual table itself too, but I'm not
    	 * sure how to do that yet. 
    	 */
    	// a scan request with no filter returns all items in table.
        ScanRequest scanRequest = new ScanRequest(tableName);
        ScanResult scanResult = dynamoDB.scan(scanRequest);
        System.out.println("Result: " + scanResult);
    }
    public static void addItem(String tableName, Map<String, AttributeValue> item) {
    	/**
    	 * Adds an item to the database with the given tableName. This function can be used
    	 * for any table, because all items will be maps of strings and attribute values. 
    	 */
    		PutItemRequest putItemRequest = new PutItemRequest(tableName, item);
        PutItemResult putItemResult = dynamoDB.putItem(putItemRequest);
        System.out.println("Result: " + putItemResult);
    }
    public static void deleteItem(String tableName, String primaryKey) {
    	/**
    	 * Given a table name and a primary key, delete the item from the database
    	 * if it exists, otherwise do nothing. 
    	 */
    		DeleteItemSpec deleteItemSpec = new DeleteItemSpec()
                .withPrimaryKey(new PrimaryKey("name", primaryKey));
    		DynamoDB dynamo = new DynamoDB(dynamoDB);
    		Table table = dynamo.getTable(tableName);

            try {
                System.out.println("Attempting a conditional delete...");
                table.deleteItem(deleteItemSpec);
                System.out.println("DeleteItem succeeded");
            }
            catch (Exception e) {
                System.err.println("Unable to delete item: " + primaryKey);
                System.err.println(e.getMessage());
            }
    }
        public static void getItemByPrimaryKey(String tableName, String primaryKey) {
    	/**
    	 * Given a table and a primary key, access the item from the database
    	 * If nothing exists, don't do anything.
    	 */
    	GetItemSpec getItemSpec = new GetItemSpec()
    			.withPrimaryKey(new PrimaryKey("name", primaryKey));
    	 DynamoDB dynamo = new DynamoDB(dynamoDB);
         Table table = dynamo.getTable(tableName);
        try {
            System.out.println("Attempting to read the item...");
            Item outcome = table.getItem(getItemSpec);
            System.out.println("GetItem succeeded: " + outcome);
            
        }
        catch (Exception e) {
            System.err.println("Unable to read item: " + primaryKey);
            System.err.println(e.getMessage());
        }    	
    }
   public static void updateItem(String tableName, String primaryKey, String... service1) {
	   /**
	    * A method to update our agencies after they have been looked up by their primary key.
	    * To update agencies in real time.
	    * As long as an item exists in the table with that primary key, the item will be updated.
	    * Otherwise, a new item will be created with specified primary key and attributes.
	    */
	   
       /*UpdateItemSpec updateItemSpec = new UpdateItemSpec().withPrimaryKey(new PrimaryKey("name", primaryKey))
    	   .withUpdateExpression("set services = service1")
    	   .withValueMap(new ValueMap().withStringSet("services", service1))
           .withReturnValues(ReturnValue.UPDATED_NEW);
       DynamoDB dynamo = new DynamoDB(dynamoDB);
       Table table = dynamo.getTable(tableName);

       try {
           System.out.println("Updating the item...");
           UpdateItemOutcome outcome = table.updateItem(updateItemSpec);
           System.out.println("UpdateItem succeeded:\n" + outcome.getItem().toJSONPretty());
       }
       catch (Exception e) {
           System.err.println("Unable to update item: " + primaryKey);
           System.err.println(e.getMessage());
       }*/
   }

}

