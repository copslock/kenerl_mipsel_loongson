Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2003 04:12:35 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:62472
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225201AbTDWDMd>; Wed, 23 Apr 2003 04:12:33 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 23 Apr 2003 03:12:31 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h3N3CLNr022559;
	Wed, 23 Apr 2003 12:12:22 +0900 (JST)
	(envelope-from nemoto@toshiba-tops.co.jp)
Date: Wed, 23 Apr 2003 12:18:36 +0900 (JST)
Message-Id: <20030423.121836.74756059.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: c-r4k.c build fix
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
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
X-archive-position: 2149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nemoto@toshiba-tops.co.jp
Precedence: bulk
X-list: linux-mips

If neither R4600_V1_HIT_CACHEOP_WAR or R4600_V2_HIT_CACHEOP_WAR were
defined (i.e. R4600_HIT_CACHEOP_WAR_DECL was empty), gcc 2.x can not
compile c-r4k.c.

c-r4k.c: In function `r4k_blast_dcache_page':
c-r4k.c:138: parse error before `static'

Here is a patch.

--- linux-mips-cvs/arch/mips/mm/c-r4k.c	Fri Apr 18 10:23:03 2003
+++ linux.new/arch/mips/mm/c-r4k.c	Wed Apr 23 12:09:58 2003
@@ -134,9 +134,9 @@
 
 static void r4k_blast_dcache_page(unsigned long addr)
 {
-	R4600_HIT_CACHEOP_WAR_DECL;
 	static void *l = &&init;
 	unsigned long dc_lsize;
+	R4600_HIT_CACHEOP_WAR_DECL;
 
 	goto *l;
 
---
Atsushi Nemoto
