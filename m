Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4FMBYZ22710
	for linux-mips-outgoing; Tue, 15 May 2001 15:11:34 -0700
Received: from bvdexchange.eicon.com (firewall.i-data.com [195.24.22.194])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4FMBXF22707
	for <linux-mips@oss.sgi.com>; Tue, 15 May 2001 15:11:33 -0700
Received: from eicon.com (172.16.2.231 [172.16.2.231]) by bvdexchange.eicon.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.1960.3)
	id KVL8PZX2; Wed, 16 May 2001 00:12:18 +0200
Message-ID: <3B01A980.7C27BB9F@eicon.com>
Date: Wed, 16 May 2001 00:11:12 +0200
From: "Tommy S. Christensen" <tommy.christensen@eicon.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Exception handlers get overwritten
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

With LOADADDR set to 0x80000000, except_vec0_r4600 and
except_vec0_nevada are overwritten in trap_init() before they
get installed at KSEG0.

The fix is easy:

diff -u -r1.53 traps.c
--- arch/mips/kernel/traps.c    2001/04/08 13:24:27     1.53
+++ arch/mips/kernel/traps.c    2001/05/15 21:39:56
@@ -837,7 +837,9 @@
         * Copy the EJTAG debug exception vector handler code to it's
final
         * destination.
         */
+#ifdef WHONEEDSTLB
        memcpy((void *)(KSEG0 + 0x300), &except_vec_ejtag_debug, 0x80);
+#endif

        /*
         * Only some CPUs have the watch exceptions or a dedicated


OK, a kinder fix would be something like:

diff -u -r1.25 head.S
--- arch/mips/kernel/head.S     2001/05/04 20:43:25     1.25
+++ arch/mips/kernel/head.S     2001/05/15 21:39:40
@@ -44,7 +44,7 @@
         * FIXME: Use the initcode feature to get rid of unused handler
         * variants.
         */
-       .fill   0x280
+       .fill   0x380
 /*
  * This is space for the interrupt handlers.
  * After trap_init() they are located at virtual address KSEG0.


I wonder why this never hit anybody else ...

Regards,
Tommy Christensen
