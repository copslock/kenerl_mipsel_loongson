Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3T4e7517471
	for linux-mips-outgoing; Sat, 28 Apr 2001 21:40:07 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3T4e6M17468
	for <linux-mips@oss.sgi.com>; Sat, 28 Apr 2001 21:40:06 -0700
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP
	id 0F270F1A9; Sat, 28 Apr 2001 21:39:06 -0700 (PDT)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id C2C1D1F428; Sat, 28 Apr 2001 17:46:34 -0700 (PDT)
Date: Sat, 28 Apr 2001 17:46:34 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: linux-mips@oss.sgi.com
Cc: binutils@sources.redhat.com
Subject: Obvious patch for mips64
Message-ID: <20010428174634.A833@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I need the following trivial patch to build 64-bit binaries with gas.

Index: tc-mips.c
===================================================================
RCS file: /cvs/src/src/gas/config/tc-mips.c,v
retrieving revision 1.39
diff -u -r1.39 tc-mips.c
--- gas/config/tc-mips.c	2001/04/08 05:09:21	1.39
+++ gas/config/tc-mips.c	2001/04/29 00:38:34
@@ -9140,7 +9140,9 @@
 	list = bfd_target_list ();
 	for (l = list; *l != NULL; l++)
 	  if (strcmp (*l, "elf64-bigmips") == 0
-	      || strcmp (*l, "elf64-littlemips") == 0)
+	      || strcmp (*l, "elf64-littlemips") == 0
+	      || strcmp (*l, "elf64-tradbigmips") == 0
+	      || strcmp (*l, "elf64-tradlittlemips") == 0)
 	    break;
 	if (*l == NULL)
 	  as_fatal (_("No compiled in support for 64 bit object file format"));


-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"Nothing motivates a man more than to see his boss put
	 in an honest day's work." -- The fortune file
