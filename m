Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jan 2013 12:19:30 +0100 (CET)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:43246 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816206Ab3AULT2oKAto (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Jan 2013 12:19:28 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 036055A6CF1;
        Mon, 21 Jan 2013 13:19:28 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id 4H-b3NrZYoz4; Mon, 21 Jan 2013 13:19:27 +0200 (EET)
Received: from blackmetal.pp.htv.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp5.welho.com (Postfix) with ESMTP id 985F15BC003;
        Mon, 21 Jan 2013 13:19:27 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] MIPS: fix 64-bit kernel build
Date:   Mon, 21 Jan 2013 13:19:19 +0200
Message-Id: <1358767159-19585-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 35503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Commit d3ce88431892b703b04769566338a89eda6b0477 (MIPS: Fix modpost
error in modules attepting to use virt_addr_valid()) in 3.8-rc3 broke
the 64-bit MIPS build:

  LD      init/built-in.o
kernel/built-in.o: In function `memory_bm_free':
snapshot.c:(.text+0x3c76c): undefined reference to `__virt_addr_valid'
snapshot.c:(.text+0x3c800): undefined reference to `__virt_addr_valid'
kernel/built-in.o: In function `snapshot_write_next':
(.text+0x3e094): undefined reference to `__virt_addr_valid'
kernel/built-in.o: In function `snapshot_write_next':
(.text+0x3e468): undefined reference to `__virt_addr_valid'

Fix by providing __virt_addr_valid also when CONFIG_32BIT is not set.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/mm/Makefile  |    6 +++---
 arch/mips/mm/ioremap.c |    4 ++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index 90ceb963..cbfec8c 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -3,10 +3,10 @@
 #
 
 obj-y				+= cache.o dma-default.o extable.o fault.o \
-				   gup.o init.o mmap.o page.o page-funcs.o \
-				   tlbex.o tlbex-fault.o uasm.o
+				   gup.o init.o ioremap.o mmap.o page.o \
+				   page-funcs.o tlbex.o tlbex-fault.o uasm.o
 
-obj-$(CONFIG_32BIT)		+= ioremap.o pgtable-32.o
+obj-$(CONFIG_32BIT)		+= pgtable-32.o
 obj-$(CONFIG_64BIT)		+= pgtable-64.o
 obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
diff --git a/arch/mips/mm/ioremap.c b/arch/mips/mm/ioremap.c
index 7657fd2..a7a14e3 100644
--- a/arch/mips/mm/ioremap.c
+++ b/arch/mips/mm/ioremap.c
@@ -16,6 +16,8 @@
 #include <asm/io.h>
 #include <asm/tlbflush.h>
 
+#ifdef CONFIG_32BIT
+
 static inline void remap_area_pte(pte_t * pte, unsigned long address,
 	phys_t size, phys_t phys_addr, unsigned long flags)
 {
@@ -191,6 +193,8 @@ void __iounmap(const volatile void __iomem *addr)
 EXPORT_SYMBOL(__ioremap);
 EXPORT_SYMBOL(__iounmap);
 
+#endif /* CONFIG_32BIT */
+
 int __virt_addr_valid(const volatile void *kaddr)
 {
 	return pfn_valid(PFN_DOWN(virt_to_phys(kaddr)));
-- 
1.7.10.4
