Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Sep 2007 18:22:29 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:50421 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023213AbXIORWU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 15 Sep 2007 18:22:20 +0100
Received: from localhost (p5162-ipad25funabasi.chiba.ocn.ne.jp [220.104.83.162])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 571228D9A; Sun, 16 Sep 2007 02:20:57 +0900 (JST)
Date:	Sun, 16 Sep 2007 02:22:31 +0900 (JST)
Message-Id: <20070916.022231.74753615.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	vagabon.xyz@gmail.com, ralf@linux-mips.org
Subject: [PATCH] Implement flush_kernel_dcache_page()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
I'm just resending this with a proper subject.

diff --git a/include/asm-mips/cacheflush.h b/include/asm-mips/cacheflush.h
index 4933b49..82e734d 100644
--- a/include/asm-mips/cacheflush.h
+++ b/include/asm-mips/cacheflush.h
@@ -79,6 +79,13 @@ extern void (*flush_icache_all)(void);
 extern void (*local_flush_data_cache_page)(void * addr);
 extern void (*flush_data_cache_page)(unsigned long addr);
 
+#define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
+static inline void flush_kernel_dcache_page(struct page *page)
+{
+	if (cpu_has_dc_aliases)
+		flush_data_cache_page((unsigned long)page_address(page));
+}
+
 /*
  * This flag is used to indicate that the page pointed to by a pte
  * is dirty and requires cleaning before returning it to the user.
