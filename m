Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 15:37:28 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:50156 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022188AbXCTPh0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Mar 2007 15:37:26 +0000
Received: from localhost (p1076-ipad02funabasi.chiba.ocn.ne.jp [61.214.21.76])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 578FCB570; Wed, 21 Mar 2007 00:36:05 +0900 (JST)
Date:	Wed, 21 Mar 2007 00:36:02 +0900 (JST)
Message-Id: <20070321.003602.108120515.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Select ZONE_DMA only if GENERIC_ISA_DMA selected
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
X-archive-position: 14589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/Kconfig   |    3 ++-
 arch/mips/mm/init.c |   17 +++++++----------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 0253584..eb5c01b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -10,7 +10,6 @@ menu "Machine selection"
 
 config ZONE_DMA
 	bool
-	default y
 
 choice
 	prompt "System type"
@@ -922,6 +921,7 @@ config SYS_HAS_EARLY_PRINTK
 
 config GENERIC_ISA_DMA
 	bool
+	select ZONE_DMA
 
 config I8259
 	bool
@@ -945,6 +945,7 @@ config MIPS_DISABLE_OBSOLETE_IDE
 
 config GENERIC_ISA_DMA_SUPPORT_BROKEN
 	bool
+	select ZONE_DMA
 
 #
 # Endianess selection.  Sufficiently obscure so many users don't know what to
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index f08ae71..8768ea8 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -351,18 +351,15 @@ void __init paging_init(void)
 #endif
 	kmap_coherent_init();
 
-#ifdef CONFIG_ISA
-	if (max_low_pfn >= MAX_DMA_PFN)
-		if (min_low_pfn >= MAX_DMA_PFN) {
-			zones_size[ZONE_DMA] = 0;
-			zones_size[ZONE_NORMAL] = max_low_pfn - min_low_pfn;
-		} else {
-			zones_size[ZONE_DMA] = MAX_DMA_PFN - min_low_pfn;
-			zones_size[ZONE_NORMAL] = max_low_pfn - MAX_DMA_PFN;
-		}
+#ifdef CONFIG_ZONE_DMA
+	if (min_low_pfn < MAX_DMA_PFN && MAX_DMA_PFN <= max_low_pfn) {
+		zones_size[ZONE_DMA] = MAX_DMA_PFN - min_low_pfn;
+		zones_size[ZONE_NORMAL] = max_low_pfn - MAX_DMA_PFN;
+	} else if (max_low_pfn < MAX_DMA_PFN)
+		zones_size[ZONE_DMA] = max_low_pfn - min_low_pfn;
 	else
 #endif
-	zones_size[ZONE_DMA] = max_low_pfn - min_low_pfn;
+	zones_size[ZONE_NORMAL] = max_low_pfn - min_low_pfn;
 
 #ifdef CONFIG_HIGHMEM
 	zones_size[ZONE_HIGHMEM] = highend_pfn - highstart_pfn;
