package main

// #cgo pkg-config: x11 gtk+-3.0
// #include <X11/Xlib.h>
// #include <gtk/gtk.h>
// void gtkInit() {
//    XInitThreads();
//    gtk_init(NULL, NULL);
// }
import "C"

func main() {
	C.gtkInit()
	C.gtk_main()
}
