Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2002 11:12:23 +0200 (CEST)
Received: from [129.3.11.16] ([129.3.11.16]:27611 "EHLO rocky.oswego.edu")
	by linux-mips.org with ESMTP id <S1122987AbSIQJMW>;
	Tue, 17 Sep 2002 11:12:22 +0200
Received: from localhost (wjhun@localhost)
	by rocky.oswego.edu (8.11.6+Sun/8.12.3) with ESMTP id g8H9BL424259
	for <linux-mips@linux-mips.org>; Tue, 17 Sep 2002 05:11:22 -0400 (EDT)
X-Authentication-Warning: rocky.oswego.edu: wjhun owned process doing -bs
Date: Tue, 17 Sep 2002 05:11:21 -0400 (EDT)
From: William Jhun <wjhun@Oswego.EDU>
To: <linux-mips@linux-mips.org>
Subject: [PATCH] ip22 console selection fixes
Message-ID: <Pine.SOL.4.30.0209170504320.23947-100000@rocky.oswego.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <wjhun@Oswego.EDU>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wjhun@Oswego.EDU
Precedence: bulk
X-list: linux-mips

This patch fixes some problems in selecting which console to use on the
ip22s.

- Replace unobvious ttyS with arc for the arc console device name
- If ARC var console=d*, use serial. If 'g', use Newport only. If
  neither or not set, default to ARC. Old code was disabling ARC
  console and using serial console if CONFIG_ARC_CONSOLE was set. (why?!)
- ArcGetEnvironmentVariable() can conceivably return NULL, so don't
  blindly dereference.

Thanks,
Will

Index: arch/mips/arc/arc_con.c
===================================================================
RCS file: /cvs/linux/arch/mips/arc/arc_con.c,v
retrieving revision 1.1.4.3
diff -u -r1.1.4.3 arc_con.c
--- arch/mips/arc/arc_con.c	2002/08/05 23:53:30	1.1.4.3
+++ arch/mips/arc/arc_con.c	2002/09/17 08:57:12
@@ -39,7 +39,7 @@
 }

 static struct console arc_cons = {
-	name:		"ttyS",
+	name:		"arc",
 	write:		prom_console_write,
 	device:		prom_console_device,
 	setup:		prom_console_setup,
Index: arch/mips/sgi-ip22/ip22-setup.c
===================================================================
RCS file: /cvs/linux/arch/mips/sgi-ip22/ip22-setup.c,v
retrieving revision 1.1.2.13
diff -u -r1.1.2.13 ip22-setup.c
--- arch/mips/sgi-ip22/ip22-setup.c	2002/07/23 16:39:10	1.1.2.13
+++ arch/mips/sgi-ip22/ip22-setup.c	2002/09/17 08:57:12
@@ -162,19 +162,22 @@
 	 * line and "d2" for the second serial line.
 	 */
 	ctype = ArcGetEnvironmentVariable("console");
-	if (*ctype == 'd') {
+	if (ctype && *ctype == 'd') {
 #ifdef CONFIG_SERIAL_CONSOLE
 		if(*(ctype + 1) == '2')
 			console_setup("ttyS1");
 		else
 			console_setup("ttyS0");
 #endif
-	} else {
+	}
 #ifdef CONFIG_ARC_CONSOLE
-		prom_flags &= PROM_FLAG_USE_AS_CONSOLE;
-		console_setup("ttyS0");
-#endif
+	else if (!ctype || *ctype != 'g') {
+		/* Use ARC if we don't want serial ('d') or
+		 * Newport ('g'). */
+		prom_flags |= PROM_FLAG_USE_AS_CONSOLE;
+		console_setup("arc");
 	}
+#endif

 #ifdef CONFIG_REMOTE_DEBUG
 	kgdb_ttyd = prom_getcmdline();
@@ -201,7 +204,7 @@

 #ifdef CONFIG_VT
 #ifdef CONFIG_SGI_NEWPORT_CONSOLE
-	{
+	if (ctype && *ctype == 'g'){
 		unsigned long *gfxinfo;
 		long (*__vec)(void) = (void *) *(long *)((PROMBLOCK)->pvector + 0x20);

@@ -209,29 +212,29 @@
 		sgi_gfxaddr = ((gfxinfo[1] >= 0xa0000000
 			       && gfxinfo[1] <= 0xc0000000)
 			       ? gfxinfo[1] - 0xa0000000 : 0);
+
+		/* newport addresses? */
+		if (sgi_gfxaddr == 0x1f0f0000 || sgi_gfxaddr == 0x1f4f0000) {
+			conswitchp = &newport_con;
+
+			screen_info = (struct screen_info) {
+				0, 0,		/* orig-x, orig-y */
+				0,		/* unused */
+				0,		/* orig_video_page */
+				0,		/* orig_video_mode */
+				160,		/* orig_video_cols */
+				0, 0, 0,	/* unused, ega_bx, unused */
+				64,		/* orig_video_lines */
+				0,		/* orig_video_isVGA */
+				16		/* orig_video_points */
+			};
+		}
 	}
-	/* newport addresses? */
-	if (sgi_gfxaddr == 0x1f0f0000 || sgi_gfxaddr == 0x1f4f0000) {
-		conswitchp = &newport_con;
-
-		screen_info = (struct screen_info) {
-			0, 0,		/* orig-x, orig-y */
-			0,		/* unused */
-			0,		/* orig_video_page */
-			0,		/* orig_video_mode */
-			160,		/* orig_video_cols */
-			0, 0, 0,	/* unused, ega_bx, unused */
-			64,		/* orig_video_lines */
-			0,		/* orig_video_isVGA */
-			16		/* orig_video_points */
-		};
-	} else {
-		conswitchp = &dummy_con;
-	}
-#else
-#ifdef CONFIG_DUMMY_CONSOLE
-	conswitchp = &dummy_con;
 #endif
+#ifdef CONFIG_DUMMY_CONSOLE
+	/* Either if newport console wasn't used or failed to initialize. */
+	if(conswitchp != &newport_con)
+		conswitchp = &dummy_con;
 #endif
 #endif

---

|William Y. Jhun - wjhun@oswego.edu
