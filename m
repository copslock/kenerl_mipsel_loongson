Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Feb 2005 14:04:53 +0000 (GMT)
Received: from gw01.mail.saunalahti.fi ([IPv6:::ffff:195.197.172.115]:61402
	"EHLO gw01.mail.saunalahti.fi") by linux-mips.org with ESMTP
	id <S8224934AbVBNOEh>; Mon, 14 Feb 2005 14:04:37 +0000
Received: from tori.tal.org (tori.tal.org [195.16.220.82])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 1A739D90CF;
	Mon, 14 Feb 2005 16:04:37 +0200 (EET)
Date:	Mon, 14 Feb 2005 16:08:24 +0000 (Local time zone must be set--see zic manual page)
From:	Kaj-Michael Lang <milang@tal.org>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix serial console detection
Message-ID: <Pine.LNX.4.61.0502141602080.24829@tori.tal.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-Path: <milang@tal.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: milang@tal.org
Precedence: bulk
X-list: linux-mips

In ip22-setup.c the checks for serial/graphics console logic does
not check if ARCS console=g but the machine is using serial console, as
it does if no keyboard is attached.

This patch adds a check if ConsoleOut is serial. There might also be 
support for other graphics than Newport soon...

Index: arch/mips/sgi-ip22/ip22-setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip22/ip22-setup.c,v
retrieving revision 1.44
diff -u -r1.44 ip22-setup.c
--- arch/mips/sgi-ip22/ip22-setup.c	10 Dec 2004 13:31:42 -0000	1.44
+++ arch/mips/sgi-ip22/ip22-setup.c	14 Feb 2005 13:57:33 -0000
@@ -56,6 +56,7 @@
  static int __init ip22_setup(void)
  {
  	char *ctype;
+	char *cserial;

  	board_be_init = ip22_be_init;
  	ip22_time_init();
@@ -81,9 +82,14 @@
  	/* ARCS console environment variable is set to "g?" for
  	 * graphics console, it is set to "d" for the first serial
  	 * line and "d2" for the second serial line.
+	 *
+	 * Need to check if the case is 'g' but no keyboard:
+	 * (ConsoleIn/Out = serial )
  	 */
  	ctype = ArcGetEnvironmentVariable("console");
-	if (ctype && *ctype == 'd') {
+	cserial = ArcGetEnvironmentVariable("ConsoleOut");
+
+	if ( (ctype && *ctype == 'd') || (cserial && *cserial == 's')) {
  		static char options[8];
  		char *baud = ArcGetEnvironmentVariable("dbaud");
  		if (baud)
@@ -91,7 +97,7 @@
  		add_preferred_console("ttyS", *(ctype + 1) == '2' ? 1 : 0,
  				      baud ? options : NULL);
  	} else if (!ctype || *ctype != 'g') {
-		/* Use ARC if we don't want serial ('d') or Newport ('g'). */
+		/* Use ARC if we don't want serial ('d') or Graphics ('g'). */
  		prom_flags |= PROM_FLAG_USE_AS_CONSOLE;
  		add_preferred_console("arc", 0, NULL);
  	}



-- 
Kaj-Michael Lang, Turku, Finland
milang@tal.org http://www.tal.org/
