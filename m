Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2003 02:18:30 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:44566
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225205AbTFPBS1>; Mon, 16 Jun 2003 02:18:27 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for [62.254.210.162]) with SMTP; 16 Jun 2003 01:18:25 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h5G1IDiY019426;
	Mon, 16 Jun 2003 10:18:14 +0900 (JST)
	(envelope-from nemoto@toshiba-tops.co.jp)
Date: Mon, 16 Jun 2003 10:19:11 +0900 (JST)
Message-Id: <20030616.101911.07647456.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux 
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20030615004718Z8225220-1272+2582@linux-mips.org>
References: <20030615004718Z8225220-1272+2582@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <nemoto@toshiba-tops.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nemoto@toshiba-tops.co.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Sun, 15 Jun 2003 01:47:13 +0100, ralf@linux-mips.org said:
> Modified files:
> 	arch/mips64    : Tag: linux_2_4 Makefile 
> 	include/asm-mips64: Tag: linux_2_4 processor.h r4kcache.h 

> Log message:
> 	Support GT64120 boards with 64-bit kernels also.

This corrupts mips64/mm/c-r4k.c.  Please apply this patch also.


diff -u linux-mips-cvs/arch/mips64/mm/c-r4k.c linux.new/arch/mips64/mm/c-r4k.c
--- linux-mips-cvs/arch/mips64/mm/c-r4k.c	Mon Apr 28 09:44:53 2003
+++ linux.new/arch/mips64/mm/c-r4k.c	Mon Jun 16 09:59:38 2003
@@ -26,7 +26,6 @@
 
 /* Primary cache parameters. */
 static unsigned long icache_size, dcache_size, scache_size;
-unsigned long icache_way_size, dcache_way_size, scache_way_size;
 static unsigned long scache_size;
 
 #include <asm/cacheops.h>
@@ -848,8 +847,8 @@
 		panic("Improper R4000SC processor configuration detected");
 
 	/* compute a couple of other cache variables */
-	icache_way_size = icache_size / c->icache.ways;
-	dcache_way_size = dcache_size / c->dcache.ways;
+	c->icache.waysize = icache_size / c->icache.ways;
+	c->dcache.waysize = dcache_size / c->dcache.ways;
 
 	c->icache.sets = icache_size / (c->icache.linesz * c->icache.ways);
 	c->dcache.sets = dcache_size / (c->dcache.linesz * c->dcache.ways);
@@ -862,7 +861,7 @@
 	 */
 	if (current_cpu_data.cputype != CPU_R10000 &&
 	    current_cpu_data.cputype != CPU_R12000)
-		if (dcache_way_size > PAGE_SIZE)
+		if (c->dcache.waysize > PAGE_SIZE)
 		        c->dcache.flags |= MIPS_CACHE_ALIASES;
 
 	if (config & 0x8)		/* VI bit */
diff -u linux-mips-cvs/arch/mips64/mm/sc-rm7k.c linux.new/arch/mips64/mm/sc-rm7k.c
--- linux-mips-cvs/arch/mips64/mm/sc-rm7k.c	Fri Apr 18 10:23:12 2003
+++ linux.new/arch/mips64/mm/sc-rm7k.c	Mon Jun 16 09:59:59 2003
@@ -20,8 +20,6 @@
 /* Secondary cache parameters. */
 #define scache_size	(256*1024)	/* Fixed to 256KiB on RM7000 */
 
-extern unsigned long icache_way_size, dcache_way_size;
-
 #include <asm/r4kcache.h>
 
 int rm7k_tcache_enabled;
---
Atsushi Nemoto
