Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Feb 2003 06:14:04 +0000 (GMT)
Received: from rj.SGI.COM ([IPv6:::ffff:192.82.208.96]:21676 "EHLO rj.sgi.com")
	by linux-mips.org with ESMTP id <S8225223AbTBDGOD>;
	Tue, 4 Feb 2003 06:14:03 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by rj.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h144E3G8016877
	for <@external-mail-relay.sgi.com:linux-mips@linux-mips.org>; Mon, 3 Feb 2003 20:14:06 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id RAA17449 for <linux-mips@linux-mips.org>; Tue, 4 Feb 2003 17:13:51 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h146DOMd027311
	for <linux-mips@linux-mips.org>; Tue, 4 Feb 2003 17:13:25 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h146DN4h027309
	for linux-mips@linux-mips.org; Tue, 4 Feb 2003 17:13:23 +1100
Date: Tue, 4 Feb 2003 17:13:23 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: Linux-MIPS <linux-mips@linux-mips.org>
Subject: [patch] cmdline.c rewrite
Message-ID: <20030204061323.GA27302@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

Hi all,

This patch is mainly a cleanup.  There is only one change (improvement!)
in the semantics:

Some kernel parameters are auto-generated.   eg: root= (always has been
broken).  Anyway, the old version of cmdline.c added these auto-generated
parameters unconditionally.  Now, it old adds them if there's no
collision with old parameters.  Is that Right?

Cheers,
Andrew


Index: cmdline.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/arc/cmdline.c,v
retrieving revision 1.5.2.3
diff -u -r1.5.2.3 cmdline.c
--- cmdline.c	5 Aug 2002 23:53:30 -0000	1.5.2.3
+++ cmdline.c	24 Jan 2003 06:43:57 -0000
@@ -6,6 +6,8 @@
  * cmdline.c: Kernel command line creation using ARCS argc/argv.
  *
  * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
+ * Copyright (C) 2003 Silicon Graphics, Inc.
+ *	modifications by Andrew Clausen (clausen@gnu.org)
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -16,96 +18,76 @@
 
 #undef DEBUG_CMDLINE
 
-char arcs_cmdline[CL_SIZE];
+char arcs_cmdline[CL_SIZE]; /* initialized to empty */
+static int __initdata arg_count = 0;
 
 char * __init prom_getcmdline(void)
 {
-	return &(arcs_cmdline[0]);
+	return arcs_cmdline;
 }
 
-static char *ignored[] = {
+static void __init append_translated_arg(const char* match, const char* trans)
+{
+	int len = strlen(match);
+	int i;
+
+	/* don't repeat arguments, like "root=X root=Y", unless the
+	 * replacement string "trans" is empty, in which case the user is
+	 * getting exactly what they asked for.
+	 */
+	if (strlen(trans) > 0 && strstr(arcs_cmdline, trans))
+		return;
+
+	for (i = 1; i < prom_argc; i++) {
+		if (!strncmp(prom_argv(i), match, len)) {
+			if (arg_count++)
+				strcat(arcs_cmdline, " ");
+			strcat(arcs_cmdline, trans);
+			strcat(arcs_cmdline, prom_argv(i) + len);
+			return;
+		}
+	}
+}
+
+static char __initdata *ignored_args[] = {
 	"ConsoleIn=",
 	"ConsoleOut=",
 	"SystemPartition=",
 	"OSLoader=",
 	"OSLoadPartition=",
 	"OSLoadFilename=",
-	"OSLoadOptions="
-};
-#define NENTS(foo) ((sizeof((foo)) / (sizeof((foo[0])))))
-
-static char *used_arc[][2] = {
-	{ "OSLoadPartition=", "root=" },
-	{ "OSLoadOptions=", "" }
+	"OSLoadOptions=",
+	NULL
 };
 
-static char * __init move_firmware_args(char* cp)
+static int __init is_arg_useful(const char* arg)
 {
-	char *s;
-	int actr, i;
-
-	actr = 1; /* Always ignore argv[0] */
-
-	while (actr < prom_argc) {
-		for(i = 0; i < NENTS(used_arc); i++) {
-			int len = strlen(used_arc[i][0]);
-
-			if (!strncmp(prom_argv(actr), used_arc[i][0], len)) {
-			/* Ok, we want it. First append the replacement... */
-				strcat(cp, used_arc[i][1]);
-				cp += strlen(used_arc[i][1]);
-				/* ... and now the argument */
-				s = strstr(prom_argv(actr), "=");
-				if (s) {
-					s++;
-					strcpy(cp, s);
-					cp += strlen(s);
-				}
-				*cp++ = ' ';
-				break;
-			}
-		}
-		actr++;
+	int i;
+	for (i = 0; ignored_args[i] != NULL; i++) {
+		if (!strncmp(arg, ignored_args[i], strlen(ignored_args[i]) - 1))
+			return 0;
 	}
-
-	return cp;
+	return 1;
 }
 
-
-void __init prom_init_cmdline(void)
+static void __init append_untranslated_args(void)
 {
-	char *cp;
-	int actr, i;
-
-	actr = 1; /* Always ignore argv[0] */
-
-	cp = &(arcs_cmdline[0]);
-	/*
-	 * Move ARC variables to the beginning to make sure they can be
-	 * overridden by later arguments.
-	 */
-	cp = move_firmware_args(cp);
-
-	while (actr < prom_argc) {
-		for (i = 0; i < NENTS(ignored); i++) {
-			int len = strlen(ignored[i]);
-
-			if (!strncmp(prom_argv(actr), ignored[i], len))
-				goto pic_cont;
+	int i;
+	for (i = 1; i < prom_argc; i++) {
+		if (is_arg_useful(prom_argv(i))) {
+			if (arg_count++)
+				strcat(arcs_cmdline, " ");
+			strcat(arcs_cmdline, prom_argv(i));
 		}
-		/* Ok, we want it. */
-		strcpy(cp, prom_argv(actr));
-		cp += strlen(prom_argv(actr));
-		*cp++ = ' ';
-
-	pic_cont:
-		actr++;
 	}
-	if (cp != &(arcs_cmdline[0])) /* get rid of trailing space */
-		--cp;
-	*cp = '\0';
+}
 
+void __init prom_init_cmdline(void)
+{
+	append_translated_arg("OSLoadOptions=", "");
+	append_translated_arg("OSLoadPartition=", "root=");
+	append_untranslated_args();
 #ifdef DEBUG_CMDLINE
-	prom_printf("prom_init_cmdline: %s\n", &(arcs_cmdline[0]));
+	prom_printf("prom_init_cmdline: \"%s\"\n", arcs_cmdline);
 #endif
 }
