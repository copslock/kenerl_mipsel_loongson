Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7VIIWQ25500
	for linux-mips-outgoing; Fri, 31 Aug 2001 11:18:32 -0700
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7VIIOd25496
	for <linux-mips@oss.sgi.com>; Fri, 31 Aug 2001 11:18:24 -0700
Received: from excalibur.cologne.de (pD9511A68.dip.t-dialin.net [217.81.26.104])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id UAA27092;
	Fri, 31 Aug 2001 20:18:21 +0200 (MET DST)
Received: from karsten by excalibur.cologne.de with local (Exim 3.12 #1 (Debian))
	id 15cstn-0001wp-00; Fri, 31 Aug 2001 20:20:11 +0200
Date: Fri, 31 Aug 2001 20:20:10 +0200
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@oss.sgi.com
Cc: hkoerfg@web.de
Subject: Patch to make current cvs (20010831) compile again for DECstations
Message-ID: <20010831202010.A1334@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@oss.sgi.com, hkoerfg@web.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hallo everybody,

the current Linux/MIPS cvs at oss.sgi.com is broken with respect to 
DECstations. The framebuffer drivers and the dz driver do not compile
anymore. I have attached a small patch to get a compileable kernel
again (the dz part compiles but I could not test it - I currently
have no machine with dz serial available for testing). 
Harald, could you apply the patch to the cvs?

Greetings,
Karsten 
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fb+dz-against-cvs20010831.diff"

diff -Nur linux.orig/drivers/char/dz.c linux/drivers/char/dz.c
--- linux.orig/drivers/char/dz.c	Fri Aug 31 19:58:05 2001
+++ linux/drivers/char/dz.c	Fri Aug 31 20:09:47 2001
@@ -1320,7 +1320,7 @@
 
 int __init dz_init(void)
 {
-	int i, flags, tmp;
+	int i, tmp;
 	long flags;
 	struct dz_serial *info;
 
diff -Nur linux.orig/drivers/char/dz.h linux/drivers/char/dz.h
--- linux.orig/drivers/char/dz.h	Fri Aug 31 19:58:05 2001
+++ linux/drivers/char/dz.h	Fri Aug 31 20:08:47 2001
@@ -10,6 +10,8 @@
 #ifndef DZ_SERIAL_H
 #define DZ_SERIAL_H
 
+#define SERIAL_MAGIC 0x5301
+
 /*
  * Definitions for the Control and Status Received.
  */
diff -Nur linux.orig/drivers/video/maxinefb.c linux/drivers/video/maxinefb.c
--- linux.orig/drivers/video/maxinefb.c	Fri Aug 31 19:59:10 2001
+++ linux/drivers/video/maxinefb.c	Fri Aug 31 20:08:47 2001
@@ -79,7 +79,7 @@
 };
 
 static int currcon = 0;
-struct maxinefb_par current_par;
+struct maxinefb_par maxinefb_current_par;
 
 /* Reference to machine type set in arch/mips/dec/prom/identify.c, KM */
 extern unsigned long mips_machtype;
@@ -145,7 +145,7 @@
 
 static void maxinefb_get_par(struct maxinefb_par *par)
 {
-	*par = current_par;
+	*par = maxinefb_current_par;
 }
 
 static int maxinefb_fb_update_var(int con, struct fb_info *info)
@@ -375,6 +375,11 @@
 
 	return 0;
 }
+
+void __init maxinefb_setup(char *options, int *ints)
+{
+}
+
 
 static void __exit maxinefb_exit(void)
 {
diff -Nur linux.orig/drivers/video/pmag-ba-fb.c linux/drivers/video/pmag-ba-fb.c
--- linux.orig/drivers/video/pmag-ba-fb.c	Fri Aug 31 19:59:11 2001
+++ linux/drivers/video/pmag-ba-fb.c	Fri Aug 31 20:08:47 2001
@@ -91,7 +91,7 @@
 };
 
 static int currcon = 0;
-struct pmagbafb_par current_par;
+struct pmagbafb_par pmagbafb_current_par;
 
 static void pmagbafb_encode_var(struct fb_var_screeninfo *var,
 				struct pmagbafb_par *par)
@@ -127,7 +127,7 @@
 
 static void pmagbafb_get_par(struct pmagbafb_par *par)
 {
-	*par = current_par;
+	*par = pmagbafb_current_par;
 }
 
 static int pmagba_fb_update_var(int con, struct fb_info *info)
diff -Nur linux.orig/drivers/video/pmagb-b-fb.c linux/drivers/video/pmagb-b-fb.c
--- linux.orig/drivers/video/pmagb-b-fb.c	Fri Aug 31 19:59:11 2001
+++ linux/drivers/video/pmagb-b-fb.c	Fri Aug 31 20:08:47 2001
@@ -94,7 +94,7 @@
 };
 
 static int currcon = 0;
-struct pmagbbfb_par current_par;
+struct pmagbbfb_par pmagbbfb_current_par;
 
 static void pmagbbfb_encode_var(struct fb_var_screeninfo *var,
 				struct pmagbbfb_par *par)
@@ -130,7 +130,7 @@
 
 static void pmagbbfb_get_par(struct pmagbbfb_par *par)
 {
-	*par = current_par;
+	*par = pmagbbfb_current_par;
 }
 
 static int pmagbb_fb_update_var(int con, struct fb_info *info)

--8t9RHnE3ZwKMSgU+--
