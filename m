Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Apr 2004 20:24:30 +0100 (BST)
Received: from [IPv6:::ffff:217.157.140.228] ([IPv6:::ffff:217.157.140.228]:50251
	"EHLO brian.localnet") by linux-mips.org with ESMTP
	id <S8225438AbUDGTY3>; Wed, 7 Apr 2004 20:24:29 +0100
Received: from brm by brian.localnet with local (Exim 3.36 #1 (Debian))
	id 1BBIer-00009h-00; Wed, 07 Apr 2004 21:24:21 +0200
To: ralf@mips-linux.org
Subject: [PATCH 2.5] LASAT bootinfo machine number reversion
Cc: linux-mips@linux-mips.org
Message-Id: <E1BBIer-00009h-00@brian.localnet>
From: Brian Murphy <brm@murphy.dk>
Date: Wed, 07 Apr 2004 21:24:21 +0200
Return-Path: <brm@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@murphy.dk
Precedence: bulk
X-list: linux-mips

Hi Ralf,
	Missed the subject the last time, so here it is again.
The arbitrary change of lasat machine numbers in revision 1.70 
of bootinfo.h means the lasat machines don't get very far in the boot
process. I use this number as an index into several arrays to dynamically
set up the minor hardware differences between the two machines, 
it being off by one causes a horrible crash the first time one of the 
values is used.

Was there a good reason for the change or can you apply the following patch
to allow these systems to boot...?

/Brian

Index: include/asm-mips/bootinfo.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/bootinfo.h,v
retrieving revision 1.73
diff -u -r1.73 bootinfo.h
--- include/asm-mips/bootinfo.h	15 Mar 2004 07:55:26 -0000	1.73
+++ include/asm-mips/bootinfo.h	6 Apr 2004 19:46:13 -0000
@@ -200,8 +200,8 @@
  * Valid machtype for group LASAT
  */
 #define MACH_GROUP_LASAT       21
-#define  MACH_LASAT_100		1	/* Masquerade II/SP100/SP50/SP25 */
-#define  MACH_LASAT_200		2	/* Masquerade PRO/SP200 */
+#define  MACH_LASAT_100		0	/* Masquerade II/SP100/SP50/SP25 */
+#define  MACH_LASAT_200		1	/* Masquerade PRO/SP200 */
 
 /*
  * Valid machtype for group TITAN
