/*Uses amazon dynamoDB to create and add/delete from tables. */

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


public class databaseAccessor {

    static AmazonDynamoDBClient dynamoDB;

    private static void init() throws Exception{
	/*
	* You need to have a valid credentials file in the right place for this
	* to work. it needs to be in C:/users/USER_NAME/.aws/credentials 
	* for windows users.  
	* @see com.amazonaws.auth.BasicAWSCredentials for more information
	* on this stuff. We wil obviosuly need the application to have the credentials  
	* built in at some point, but for now, this works
	*/
	AWSCredentials credentials = null;
        try {
            credentials = new ProfileCredentialsProvider().getCredentials();
        } catch (Exception e) {
            throw new AmazonClientException(
                    "Cannot load the credentials from the credential profiles file. " +
                    "Please make sure that your credentials file is at the correct " +
                    "location (~/.aws/credentials), and is in valid format.",
                    e);
        }
        dynamoDB = new AmazonDynamoDBClient(credentials);
        Region usWest2 = Region.getRegion(Regions.US_WEST_2);
        dynamoDB.setRegion(usWest2);
    }


    private static Map<String, AttributeValue> newOrganization(String name, String location, String hours, String services, String password) {
	/*
	* Creates a Dynamodb object and assigns some values to it. I'm fairly certain
	* these attributes will be insufficient for what we will need, but I'm also not 
	* sure what we will actually need so this will do for now and it gets the basic
	* idea right.  returns an "item" which is what is placed into a dynamoDb table.
	* also, I'm gonna have to remember to update this documentation as we change
	* this stuff
	*/
        Map<String, AttributeValue> item = new HashMap<String, AttributeValue>();
        item.put("name", new AttributeValue(name));//probably right
        item.put("location", new AttributeValue(location));//probably shouldn't be a string
        item.put("hours", new AttributeValue(hours));//maybe shouldn't be a string
        item.put("services", new AttributeValue(services));//definitley shouldn't be a string
        item.put("password", new AttributeValue(password));//no

        return item;
    }

    
    public static void main(String args[]) {
	/*
	* Makes a table and puts some stuff into it, probably will be changed before all is
	* said and done. Also tries to connect to a localhost server, which at this stage 
	* should be started seperately. 
	*/
	init();
	AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard()
            .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("http://localhost:8000", "us-west-2"))
            .build();

        DynamoDB dynamoDB = new DynamoDB(client);

        String tableName = "organizations";//idk what to call this, change it if you want]
	    Map<String, AttributeValue> sampleData = newOrganization("pretendPlace", "123 fake address drive", "1am-1:10am", "needle exchane", "abc123");
	try {
            System.out.println("Attempting to create table; please wait...");
            Table table = dynamoDB.createTable(tableName,
                Arrays.asList(new KeySchemaElement("name", KeyType.HASH), // Partition
                                                                          // key
                    new KeySchemaElement("location", KeyType.RANGE)), // Sort key
                Arrays.asList(new AttributeDefinition("year", ScalarAttributeType.S),
                    new AttributeDefinition("title", ScalarAttributeType.S)),
					       new AttrubuteDefinition("password", ScalarAttributeType.S),
                new ProvisionedThroughput(10L, 10L));
            table.waitForActive();
            System.out.println("Success.  Table status: " + table.getDescription().getTableStatus());

        }
        catch (Exception e) {
            System.err.println("Unable to create table: ");
            System.err.println(e.getMessage());
        }
	//add sampleData to the table
	putItemRequest = new PutItemRequest(tableName, sampleData);
	putItemResult = dynamoDB.putItem(putItemRequest);
	System.out.println("Result: " + putItemResult);

    }

}
