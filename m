Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2003 11:57:27 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:42512
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225072AbTGPK5Z>; Wed, 16 Jul 2003 11:57:25 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 16 Jul 2003 10:57:23 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h6GAvGDV034916;
	Wed, 16 Jul 2003 19:57:16 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Wed, 16 Jul 2003 19:58:13 +0900 (JST)
Message-Id: <20030716.195813.104027327.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: cache code fix for c-tx39.c
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20030716.195514.71083728.nemoto@toshiba-tops.co.jp>
References: <20030709124821Z8225210-1272+3285@linux-mips.org>
	<20030716.195514.71083728.nemoto@toshiba-tops.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 16 Jul 2003 19:55:14 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
>> Log message: Cache code fixes.

anemo> Please fix c-tx39.c also.  This is a patch for 2.4 branch.

And this is one for trunk (2.6).

diff -ur linux-mips-cvs-2.6/arch/mips/mm/c-tx39.c linux.new-2.6/arch/mips/mm/c-tx39.c
--- linux-mips-cvs-2.6/arch/mips/mm/c-tx39.c	Wed Jul 16 19:49:27 2003
+++ linux.new-2.6/arch/mips/mm/c-tx39.c	Wed Jul 16 19:52:42 2003
@@ -25,9 +25,6 @@
 
 /* For R3000 cores with R4000 style caches */
 static unsigned long icache_size, dcache_size;		/* Size in bytes */
-static unsigned long icache_way_size, dcache_way_size;	/* Size divided by ways */
-#define scache_size 0
-#define scache_way_size 0
 
 #include <asm/r4kcache.h>
 
@@ -474,15 +471,15 @@
 		break;
 	}
 
-	icache_way_size = icache_size / current_cpu_data.icache.ways;
-	dcache_way_size = dcache_size / current_cpu_data.dcache.ways;
+	current_cpu_data.icache.waysize = icache_size / current_cpu_data.icache.ways;
+	current_cpu_data.dcache.waysize = dcache_size / current_cpu_data.dcache.ways;
 
 	current_cpu_data.icache.sets =
-		icache_way_size / current_cpu_data.icache.linesz;
+		current_cpu_data.icache.waysize / current_cpu_data.icache.linesz;
 	current_cpu_data.dcache.sets =
-		dcache_way_size / current_cpu_data.dcache.linesz;
+		current_cpu_data.dcache.waysize / current_cpu_data.dcache.linesz;
 
-	if (dcache_way_size > PAGE_SIZE)
+	if (current_cpu_data.dcache.waysize > PAGE_SIZE)
 		current_cpu_data.dcache.flags |= MIPS_CACHE_ALIASES;
 
 	current_cpu_data.icache.waybit = 0;
---
Atsushi Nemoto
