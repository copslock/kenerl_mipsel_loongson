Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jul 2006 17:21:46 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:39417 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S3466304AbWGDQVh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Jul 2006 17:21:37 +0100
Received: from localhost (p3208-ipad34funabasi.chiba.ocn.ne.jp [124.85.60.208])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 8EF30B45E; Wed,  5 Jul 2006 01:21:30 +0900 (JST)
Date:	Wed, 05 Jul 2006 01:22:44 +0900 (JST)
Message-Id: <20060705.012244.96686002.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] sparsemem fix
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
X-archive-position: 11906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

1. MIPS should select SPARSEMEM_STATIC since allocating bootmem in
   memory_present() will corrupt bootmap area.
2. pfn_valid() for SPARSEMEM is defined in linux/mmzone.h

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f151a7e..879a19c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1690,6 +1690,7 @@ config ARCH_DISCONTIGMEM_ENABLE
 
 config ARCH_SPARSEMEM_ENABLE
 	bool
+	select SPARSEMEM_STATIC
 
 config NUMA
 	bool "NUMA Support"
diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index 6b97744..6ed1151 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -138,16 +138,14 @@ #define __va(x)			((void *)((unsigned lo
 
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 
-#ifndef CONFIG_SPARSEMEM
-#ifndef CONFIG_NEED_MULTIPLE_NODES
-#define pfn_valid(pfn)		((pfn) < max_mapnr)
-#endif
-#endif
-
 #ifdef CONFIG_FLATMEM
 
 #define pfn_valid(pfn)		((pfn) < max_mapnr)
 
+#elif defined(CONFIG_SPARSEMEM)
+
+/* pfn_valid is defined in linux/mmzone.h */
+
 #elif defined(CONFIG_NEED_MULTIPLE_NODES)
 
 #define pfn_valid(pfn)							\
@@ -159,8 +157,6 @@ ({									\
 	            : 0);						\
 })
 
-#else
-#error Provide a definition of pfn_valid
 #endif
 
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
