Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Apr 2003 14:09:49 +0100 (BST)
Received: from pasmtp.tele.dk ([IPv6:::ffff:193.162.159.95]:11782 "EHLO
	pasmtp.tele.dk") by linux-mips.org with ESMTP id <S8225205AbTDGNJr>;
	Mon, 7 Apr 2003 14:09:47 +0100
Received: from ekner.info (0x83a4a968.virnxx10.adsl-dhcp.tele.dk [131.164.169.104])
	by pasmtp.tele.dk (Postfix) with ESMTP id 786FEB4E9
	for <linux-mips@linux-mips.org>; Mon,  7 Apr 2003 15:09:39 +0200 (CEST)
Message-ID: <3E917AA1.13694D03@ekner.info>
Date: Mon, 07 Apr 2003 15:18:25 +0200
From: Hartvig Ekner <hartvig@ekner.info>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-19.7.x i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Patch to include/asm-mips/processor.h
Content-Type: multipart/mixed;
 boundary="------------1F035EFA10F52EFAC87E1575"
Return-Path: <hartvig@ekner.info>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvig@ekner.info
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------1F035EFA10F52EFAC87E1575
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I have no idea whether what I did was correct, but at least it is no less incorrect than the code currently
in there, which coredumps now for some reason (I wonder why it never crashed before). The test-bit macro
expects a bit-number, and not a mask which it is given in the current code.

So while fixing this, I also used the normal cpu_data macro for the cpu_has_watch() macro, instead of
looking at CPU(0).

/Hartvig


--------------1F035EFA10F52EFAC87E1575
Content-Type: text/plain; charset=us-ascii;
 name="processor_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="processor_patch"

Index: processor.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/processor.h,v
retrieving revision 1.43.2.11
diff -u -r1.43.2.11 processor.h
--- processor.h	7 Apr 2003 02:21:05 -0000	1.43.2.11
+++ processor.h	7 Apr 2003 13:03:07 -0000
@@ -66,14 +66,9 @@
 	struct cache_desc tcache;	/* Tertiary/split secondary cache */
 } __attribute__((__aligned__(SMP_CACHE_BYTES)));
 
-/*
- * Assumption: Options of CPU 0 are a superset of all processors.
- * This is true for all known MIPS systems.
- */
-#define cpu_has_watch	(test_bit(MIPS_CPU_WATCH, cpu_data[0].options))
-
 extern struct cpuinfo_mips cpu_data[];
-#define current_cpu_data cpu_data[smp_processor_id()]
+#define current_cpu_data	cpu_data[smp_processor_id()]
+#define cpu_has_watch		(current_cpu_data.options & MIPS_CPU_WATCH)
 
 /*
  * System setup and hardware flags..

--------------1F035EFA10F52EFAC87E1575--
