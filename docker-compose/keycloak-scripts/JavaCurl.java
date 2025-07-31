import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;

public class JavaCurl {

    public static void main(String[] args) {
        if (args.length < 1) {
            System.out.println("Usage: java JavaCurl <URL> [OPTIONS]");
            System.out.println("Options:");
            System.out.println("  -X <METHOD>    Specify request method (GET, POST, PUT, DELETE, etc. Default: GET)");
            System.out.println("  -H <HEADER>    Pass custom header in format 'Key:Value'");
            System.out.println("  -d <DATA>      HTTP POST data");
            System.exit(1);
        }

        String urlString = args[0];
        String method = "GET";
        String requestBody = null;
        java.util.Map<String, String> headers = new java.util.HashMap<>();

        // Parse command-line arguments
        for (int i = 1; i < args.length; i++) {
            switch (args[i]) {
                case "-X":
                    if (i + 1 < args.length) {
                        method = args[++i].toUpperCase();
                    } else {
                        System.err.println("Error: -X requires a method.");
                        System.exit(1);
                    }
                    break;
                case "-H":
                    if (i + 1 < args.length) {
                        String header = args[++i];
                        String[] parts = header.split(":", 2);
                        if (parts.length == 2) {
                            headers.put(parts[0].trim(), parts[1].trim());
                        } else {
                            System.err.println("Error: Invalid header format. Use 'Key:Value'.");
                            System.exit(1);
                        }
                    } else {
                        System.err.println("Error: -H requires a header.");
                        System.exit(1);
                    }
                    break;
                case "-d":
                    if (i + 1 < args.length) {
                        requestBody = args[++i];
                    } else {
                        System.err.println("Error: -d requires data.");
                        System.exit(1);
                    }
                    break;
                default:
                    System.err.println("Warning: Unknown option: " + args[i]);
                    break;
            }
        }

        HttpURLConnection connection = null;
        try {
            URL url = new URL(urlString);
            connection = (HttpURLConnection) url.openConnection();

            // Set request method
            connection.setRequestMethod(method);

            // Set headers
            for (Map.Entry<String, String> entry : headers.entrySet()) {
                connection.setRequestProperty(entry.getKey(), entry.getValue());
            }

            // Set timeouts (optional but recommended for robustness)
            connection.setConnectTimeout(5000); // 5 seconds
            connection.setReadTimeout(10000);   // 10 seconds

            // Handle POST/PUT data
            if (requestBody != null && (method.equals("POST") || method.equals("PUT"))) {
                connection.setDoOutput(true); // Permits writing to the connection output stream
                try (OutputStream os = connection.getOutputStream()) {
                    byte[] input = requestBody.getBytes("utf-8");
                    os.write(input, 0, input.length);
                }
            }

            // Get response code
            int responseCode = connection.getResponseCode();
            System.out.println("HTTP Response Code: " + responseCode);

            // Read response body
            BufferedReader in;
            if (responseCode >= 200 && responseCode < 300) { // Success codes
                in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            } else { // Error codes
                in = new BufferedReader(new InputStreamReader(connection.getErrorStream()));
            }

            String inputLine;
            StringBuilder content = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                content.append(inputLine);
            }
            in.close();

            System.out.println("Response Body:");
            System.out.println(content.toString());

            // Exit with 0 for success (2xx codes), 1 otherwise
            System.exit((responseCode >= 200 && responseCode < 300) ? 0 : 1);

        } catch (java.net.MalformedURLException e) {
            System.err.println("Error: Malformed URL - " + urlString);
            System.exit(1);
        } catch (java.net.UnknownHostException e) {
            System.err.println("Error: Unknown host - " + e.getMessage());
            System.exit(1);
        } catch (java.net.SocketTimeoutException e) {
            System.err.println("Error: Connection timed out - " + e.getMessage());
            System.exit(1);
        } catch (java.io.IOException e) {
            System.err.println("Error: Network or I/O issue - " + e.getMessage());
            System.exit(1);
        } finally {
            if (connection != null) {
                connection.disconnect();
            }
        }
    }
}