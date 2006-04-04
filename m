Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Apr 2006 09:23:26 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:47026 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133418AbWDDIXM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Apr 2006 09:23:12 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 4 Apr 2006 17:34:17 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id BA77F20552;
	Tue,  4 Apr 2006 17:34:15 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id AEAE720445;
	Tue,  4 Apr 2006 17:34:15 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k348YE4D021114;
	Tue, 4 Apr 2006 17:34:15 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 04 Apr 2006 17:34:14 +0900 (JST)
Message-Id: <20060404.173414.108982133.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] tx49_blast_icache32_page_indexed fix
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
X-archive-position: 11020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Fix an index value in tx49_blast_icache32_page_indexed().
This is a damage by 13acfa3fdef15edaa4f5444c68e28e05978afa08 commit.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 32b7f6a..c4c2084 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -154,7 +154,8 @@ static inline void blast_icache32_r4600_
 
 static inline void tx49_blast_icache32_page_indexed(unsigned long page)
 {
-	unsigned long start = page;
+	unsigned long indexmask = current_cpu_data.icache.waysize - 1;
+	unsigned long start = INDEX_BASE + (page & indexmask);
 	unsigned long end = start + PAGE_SIZE;
 	unsigned long ws_inc = 1UL << current_cpu_data.icache.waybit;
 	unsigned long ws_end = current_cpu_data.icache.ways <<
