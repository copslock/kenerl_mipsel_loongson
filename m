Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2006 19:32:03 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:43236 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039278AbWI2ScB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 Sep 2006 19:32:01 +0100
Received: from localhost (p6165-ipad210funabasi.chiba.ocn.ne.jp [58.88.125.165])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id AB6A9A42C; Sat, 30 Sep 2006 03:31:55 +0900 (JST)
Date:	Sat, 30 Sep 2006 03:34:06 +0900 (JST)
Message-Id: <20060930.033406.104030456.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] fix size of zones_size and zholes_size array
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The commit f06a96844a577c43249fce25809a4fae07407f46 broke mips.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index a624778..2f346d1 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -357,10 +357,10 @@ static int __init page_is_ram(unsigned l
 
 void __init paging_init(void)
 {
-	unsigned long zones_size[] = { 0, };
+	unsigned long zones_size[MAX_NR_ZONES] = { 0, };
 	unsigned long max_dma, high, low;
 #ifndef CONFIG_FLATMEM
-	unsigned long zholes_size[] = { 0, };
+	unsigned long zholes_size[MAX_NR_ZONES] = { 0, };
 	unsigned long i, j, pfn;
 #endif
 
