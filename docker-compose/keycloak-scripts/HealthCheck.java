public class HealthCheck { 
    public static void main(String[] args) throws java.lang.Throwable { 
        System.exit(java.net.HttpURLConnection.HTTP_OK == ((java.net.HttpURLConnection)new java.net.URL(args[0]).openConnection()).getResponseCode() ? 0 : 1); 
    } 
}