Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Feb 2005 14:12:16 +0000 (GMT)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:62965 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225218AbVBDOMA>; Fri, 4 Feb 2005 14:12:00 +0000
Received: from localhost (p4027-ipad30funabasi.chiba.ocn.ne.jp [221.184.79.27])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 471908412; Fri,  4 Feb 2005 23:11:56 +0900 (JST)
Date:	Fri, 04 Feb 2005 23:12:54 +0900 (JST)
Message-Id: <20050204.231254.74753794.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: c-r4k.c cleanup
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This code is wrong (should be "c->dcache.waysize > PAGE_SIZE") and
unnecessary (done correctly in probe_pcache).

diff -u -r1.96 c-r4k.c
--- arch/mips/mm/c-r4k.c	7 Dec 2004 02:33:02 -0000	1.96
+++ arch/mips/mm/c-r4k.c	4 Feb 2005 14:01:35 -0000
@@ -1213,9 +1213,6 @@
 	probe_pcache();
 	setup_scache();
 
-	if (c->dcache.sets * c->dcache.ways > PAGE_SIZE)
-		c->dcache.flags |= MIPS_CACHE_ALIASES;
-
 	r4k_blast_dcache_page_setup();
 	r4k_blast_dcache_page_indexed_setup();
 	r4k_blast_dcache_setup();


Also, some MIPS32/MIPS64 chip have physically indexed data cache so do
no suffer from aliasing.  CPU_20KC is one of them.  Others?

---
Atsushi Nemoto
