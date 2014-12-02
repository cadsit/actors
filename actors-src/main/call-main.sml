(*
 *    File: call-main.sml
 *    Author: Connor Adsit
 *    Date: 2014-12-02
 *
 *    Creates the executable needed for the main function
 *)

val _ = OS.Process.exit (Main.runMain (CommandLine.name (), CommandLine.arguments ()))
