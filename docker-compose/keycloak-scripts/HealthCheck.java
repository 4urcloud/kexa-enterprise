public class HealthCheck {
    public static void main(String[] args) throws java.lang.Throwable {
        // Construct URI first, then convert to URL to avoid deprecation warning
        java.net.URI uri = new java.net.URI(args[0]);
        java.net.URL url = uri.toURL();

        System.exit(java.net.HttpURLConnection.HTTP_OK == ((java.net.HttpURLConnection)url.openConnection()).getResponseCode() ? 0 : 1);
    }
}