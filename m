Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Apr 2003 11:18:51 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:31493
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225072AbTD1KSt>; Mon, 28 Apr 2003 11:18:49 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 28 Apr 2003 10:18:47 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h3SAIeNr037242;
	Mon, 28 Apr 2003 19:18:41 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Mon, 28 Apr 2003 19:25:03 +0900 (JST)
Message-Id: <20030428.192503.104027383.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Cc: nemoto@toshiba-tops.co.jp
Subject: Re: CVS Update@-mips.org: linux 
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20030424114755Z8225208-1272+1554@linux-mips.org>
References: <20030424114755Z8225208-1272+1554@linux-mips.org>
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
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 24 Apr 2003 12:47:50 +0100, ralf@linux-mips.org said:
ralf> Modified files:
ralf> 	arch/mips64/mm : Tag: linux_2_4 pg-r4k.c 

ralf> Log message:
ralf> 	Fix build for MIPS III.

It seems the .mips4 was added in wrong place (both 2.4 and 2.5).
This patch is for 2.4.  Please apply to both tree.  Thank you.

diff -u linux-mips/arch/mips64/mm/pg-r4k.c linux.new/arch/mips64/mm/
--- linux-mips-cvs/arch/mips64/mm/pg-r4k.c	Mon Apr 28 09:44:54 2003
+++ linux.new/arch/mips64/mm/pg-r4k.c	Mon Apr 28 19:15:22 2003
@@ -337,8 +337,6 @@
 	unsigned long dummy1, dummy2, reg1, reg2;
 
 	__asm__ __volatile__(
-		".set\tpush\n\t"
-		".set\tmips4\n\t"
 		".set\tnoreorder\n\t"
 		".set\tnoat\n\t"
 		"daddiu\t$1,%0,%6\n"
@@ -365,7 +363,8 @@
 		"sd\t%2,-16(%0)\n\t"
 		"bne\t$1,%0,1b\n\t"
 		" sd\t%3,-8(%0)\n\t"
-		".set\tpop"
+		".set\tat\n\t"
+		".set\treorder"
 		:"=r" (dummy1), "=r" (dummy2), "=&r" (reg1), "=&r" (reg2)
 		:"0" (to), "1" (from), "I" (PAGE_SIZE),
 		 "i" (Create_Dirty_Excl_D));
@@ -676,6 +675,8 @@
 	unsigned long dummy1, dummy2, reg1, reg2, reg3, reg4;
 
 	__asm__ __volatile__(
+		".set\tpush\n\t"
+		".set\tmips4\n\t"
 		".set\tnoreorder\n\t"
 		".set\tnoat\n\t"
 		"daddiu\t$1,%0,%8\n"
@@ -700,8 +701,7 @@
 		"sd\t%4,-16(%0)\n\t"
 		"bne\t$1,%0,1b\n\t"
 		" sd\t%5,-8(%0)\n\t"
-		".set\tat\n\t"
-		".set\treorder"
+		".set\tpop"
 		:"=r" (dummy1), "=r" (dummy2), "=&r" (reg1), "=&r" (reg2),
 		 "=&r" (reg3), "=&r" (reg4)
 		:"0" (to), "1" (from), "I" (PAGE_SIZE));
---
Atsushi Nemoto
