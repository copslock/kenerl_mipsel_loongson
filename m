Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jan 2006 17:24:26 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:16617 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133548AbWA1RXd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 28 Jan 2006 17:23:33 +0000
Received: from localhost (p1217-ipad204funabasi.chiba.ocn.ne.jp [222.146.88.217])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id EDFE0A410; Sun, 29 Jan 2006 02:28:13 +0900 (JST)
Date:	Sun, 29 Jan 2006 02:27:51 +0900 (JST)
Message-Id: <20060129.022751.08075950.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Remove wrong __user tags.
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
X-archive-position: 10218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This fixes sparse warnings 'dereference of noderef expression'.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 422b55f..e51c38c 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -464,8 +464,8 @@ static void r4k_flush_data_cache_page(un
 }
 
 struct flush_icache_range_args {
-	unsigned long __user start;
-	unsigned long __user end;
+	unsigned long start;
+	unsigned long end;
 };
 
 static inline void local_r4k_flush_icache_range(void *args)
@@ -528,8 +528,7 @@ static inline void local_r4k_flush_icach
 	}
 }
 
-static void r4k_flush_icache_range(unsigned long __user start,
-	unsigned long __user end)
+static void r4k_flush_icache_range(unsigned long start, unsigned long end)
 {
 	struct flush_icache_range_args args;
 
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 314701a..591c22b 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -25,8 +25,7 @@ void (*flush_cache_range)(struct vm_area
 	unsigned long end);
 void (*flush_cache_page)(struct vm_area_struct *vma, unsigned long page,
 	unsigned long pfn);
-void (*flush_icache_range)(unsigned long __user start,
-	unsigned long __user end);
+void (*flush_icache_range)(unsigned long start, unsigned long end);
 void (*flush_icache_page)(struct vm_area_struct *vma, struct page *page);
 
 /* MIPS specific cache operations */
@@ -53,7 +52,7 @@ EXPORT_SYMBOL(_dma_cache_inv);
  * We could optimize the case where the cache argument is not BCACHE but
  * that seems very atypical use ...
  */
-asmlinkage int sys_cacheflush(unsigned long __user addr,
+asmlinkage int sys_cacheflush(unsigned long addr,
 	unsigned long bytes, unsigned int cache)
 {
 	if (bytes == 0)
diff --git a/include/asm-mips/cacheflush.h b/include/asm-mips/cacheflush.h
index a18ba2e..aeae9fa 100644
--- a/include/asm-mips/cacheflush.h
+++ b/include/asm-mips/cacheflush.h
@@ -49,8 +49,7 @@ static inline void flush_dcache_page(str
 
 extern void (*flush_icache_page)(struct vm_area_struct *vma,
 	struct page *page);
-extern void (*flush_icache_range)(unsigned long __user start,
-	unsigned long __user end);
+extern void (*flush_icache_range)(unsigned long start, unsigned long end);
 #define flush_cache_vmap(start, end)		flush_cache_all()
 #define flush_cache_vunmap(start, end)		flush_cache_all()
 
