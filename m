Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Apr 2003 11:06:56 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:5665
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225072AbTD1KGx>; Mon, 28 Apr 2003 11:06:53 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 28 Apr 2003 10:06:52 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h3SA6gNr037228;
	Mon, 28 Apr 2003 19:06:43 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Mon, 28 Apr 2003 19:13:04 +0900 (JST)
Message-Id: <20030428.191304.71084037.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Cc: nemoto@toshiba-tops.co.jp
Subject: c-tx39.c build fix
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 2215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Here is a patch to fix build error of c-tx39.c.  Please apply.  Thank you.

diff -u linux-mips-cvs/arch/mips/mm/c-tx39.c linux.new/arch/mips/mm/
--- linux-mips-cvs/arch/mips/mm/c-tx39.c	Mon Apr 28 09:44:52 2003
+++ linux.new/arch/mips/mm/c-tx39.c	Mon Apr 28 19:07:45 2003
@@ -26,7 +26,8 @@
 /* For R3000 cores with R4000 style caches */
 static unsigned long icache_size, dcache_size;		/* Size in bytes */
 static unsigned long icache_way_size, dcache_way_size;	/* Size divided by ways */
-extern long scache_size;
+#define scache_size 0
+#define scache_way_size 0
 
 #include <asm/r4kcache.h>
 
---
Atsushi Nemoto
