/*
 *    File: RottenTomatoesJSON.java
 *    Author: Connor Adsit
 *    Date: 2014-12-04
 */

import java.util.ArrayList;
import java.util.Random;

import java.net.URL;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.FileWriter;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.JSONArray;

/**
 *    Reads in a list of all movies currently in theaters to find
 *    the actors appearing in each
 *
 *    Usage: java RottenTomatoesJSON &lt;outfile&gt;, where outfile is the
 *    destination of the output
 *
 *    @author Connor Adsit
 */
public class RottenTomatoesJSON {

   // request string id
   private static final String url_string = 
      "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=t57c7s2r8nqahxvvacmwjgxd";

   private static Random r = new Random();

   /**
    *    Obtains a String containing a JSON object
    *    
    *    @return a JSON object string fetched from a prestored website
    */
   private static String readJSON () {
      BufferedReader br = null;
      String result = "";
      try {
         URL url = new URL(url_string);
         InputStream in = url.openStream();
         br = new BufferedReader(new InputStreamReader(in));
         while (br.ready()) {
            result += br.readLine();
         }
         br.close();
      } catch (IOException ioe) {
         System.err.println (ioe.getMessage ());
         ioe.printStackTrace ();
      } finally {
         try {br.close ();} catch (Exception e) {}
      }
         return result;
   }

   /**
    *    Parses a JSON string and prints results to a given file
    *    @param   source   the json string to parse
    *    @param   dest     the path to the file to write
    */
   private static void parseJSON (String source, String dest) {
      ArrayList<String> names = new ArrayList<> ();
      ArrayList<String> movies = new ArrayList<> ();
      ArrayList<Integer> ages = new ArrayList<> ();

      // Get actors from Rotten Tomatoes 
      JSONObject obj = (JSONObject) JSONValue.parse(source);
      JSONArray jMovies = (JSONArray) obj.get ("movies");

      for (int i = 0; i < jMovies.size (); ++i) {
         JSONObject movie = (JSONObject) jMovies.get (i);
         String title = (String) movie.get ("title");
         JSONArray jActors = (JSONArray) movie.get ("abridged_cast");
         for (int a = 0; a < jActors.size (); ++a) {
            JSONObject actor = (JSONObject) jActors.get (a);
            String name = (String) actor.get ("name");
            names.add (name);
            movies.add (title);
            ages.add (r.nextInt (90));
         } 
      }

      // write to file 
      FileWriter fw = null;
      try {
         fw = new FileWriter (dest);
         for (int n = 0; n < names.size (); ++n)
            fw.write ("name " + names.get (n) + " movie " + movies.get (n) + " age " + ages.get (n) + "\n");
      } catch (IOException ioe) {
         ioe.printStackTrace ();
         System.err.println (ioe.getMessage ());
      } finally { try { fw.close (); } catch (Exception e) {}}
   }

   /**
    *    Prints out a usage statement
    */
   private static void usage () {
      System.err.println ("Usage: java RottenTomatoesJSON <outfile>");
      System.err.println ("\t<file> output file for results");
      System.exit (0);
   }

   /**
    *    Main method. Runs the get and prints results to an output file
    *
    *    @param   args  command line arguments
    */
   public static void main(String[] args) {
      if (args.length != 1) usage ();
      String outputPath = args[0];
      String json = readJSON ();
      parseJSON (json, outputPath);
   }
}
