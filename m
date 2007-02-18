Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Feb 2007 16:29:07 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:6860 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039438AbXBRQ3C (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 18 Feb 2007 16:29:02 +0000
Received: from localhost (p2027-ipad11funabasi.chiba.ocn.ne.jp [219.162.37.27])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A85BAB420; Mon, 19 Feb 2007 01:27:34 +0900 (JST)
Date:	Mon, 19 Feb 2007 01:27:34 +0900 (JST)
Message-Id: <20070219.012734.21956981.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Add external declaration of pagetable_init() to pgalloc.h
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
X-archive-position: 14150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This fixes some sparse warnings.

pgtable-32.c:15:6: warning: symbol 'pgd_init' was not declared. Should it be static?
pgtable-32.c:32:13: warning: symbol 'pagetable_init' was not declared. Should it be static?

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/mm/init.c              |    2 --
 arch/mips/mm/pgtable-32.c        |    1 +
 arch/mips/mm/pgtable-64.c        |    1 +
 arch/mips/sgi-ip27/ip27-memory.c |    2 +-
 include/asm-mips/pgalloc.h       |    2 ++
 5 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 125a4a8..13a4208 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -314,8 +314,6 @@ void __init fixrange_init(unsigned long
 }
 
 #ifndef CONFIG_NEED_MULTIPLE_NODES
-extern void pagetable_init(void);
-
 static int __init page_is_ram(unsigned long pagenr)
 {
 	int i;
diff --git a/arch/mips/mm/pgtable-32.c b/arch/mips/mm/pgtable-32.c
index 4a61e62..575e401 100644
--- a/arch/mips/mm/pgtable-32.c
+++ b/arch/mips/mm/pgtable-32.c
@@ -11,6 +11,7 @@
 #include <linux/highmem.h>
 #include <asm/fixmap.h>
 #include <asm/pgtable.h>
+#include <asm/pgalloc.h>
 
 void pgd_init(unsigned long page)
 {
diff --git a/arch/mips/mm/pgtable-64.c b/arch/mips/mm/pgtable-64.c
index c46eb65..e4b565a 100644
--- a/arch/mips/mm/pgtable-64.c
+++ b/arch/mips/mm/pgtable-64.c
@@ -10,6 +10,7 @@
 #include <linux/mm.h>
 #include <asm/fixmap.h>
 #include <asm/pgtable.h>
+#include <asm/pgalloc.h>
 
 void pgd_init(unsigned long page)
 {
diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index 0e3d535..fe8a106 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -21,6 +21,7 @@
 #include <linux/pfn.h>
 #include <linux/highmem.h>
 #include <asm/page.h>
+#include <asm/pgalloc.h>
 #include <asm/sections.h>
 
 #include <asm/sn/arch.h>
@@ -503,7 +504,6 @@ void __init prom_free_prom_memory(void)
 	/* We got nothing to free here ...  */
 }
 
-extern void pagetable_init(void);
 extern unsigned long setup_zero_pages(void);
 
 void __init paging_init(void)
diff --git a/include/asm-mips/pgalloc.h b/include/asm-mips/pgalloc.h
index af121c6..5685d4f 100644
--- a/include/asm-mips/pgalloc.h
+++ b/include/asm-mips/pgalloc.h
@@ -130,4 +130,6 @@ static inline void pmd_free(pmd_t *pmd)
 
 #define check_pgt_cache()	do { } while (0)
 
+extern void pagetable_init(void);
+
 #endif /* _ASM_PGALLOC_H */
