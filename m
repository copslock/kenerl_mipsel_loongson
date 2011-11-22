Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2011 15:01:16 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:45118 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903720Ab1KVOAT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Nov 2011 15:00:19 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 93EE23B7EA9;
        Tue, 22 Nov 2011 15:00:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KlyPahnrhwCJ; Tue, 22 Nov 2011 15:00:18 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id D7E893B7E85;
        Tue, 22 Nov 2011 15:00:18 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 3/3 v3] MIPS: introduce CPU_R4K_CACHE_TLB
Date:   Tue, 22 Nov 2011 14:59:50 +0100
Message-Id: <1321970390-10887-3-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1321970390-10887-1-git-send-email-florian@openwrt.org>
References: <1321970390-10887-1-git-send-email-florian@openwrt.org>
X-archive-position: 31926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18594

R4K-style CPUs having common code to support their caches and tlb have this
boolean defined by default. Allows us to remove some lines in
arch/mips/mm/Makefile.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v2:
- rebased against mips-for-linux-next (remove XLP)

Changes since v1:
- removed CPU_XLR already covered by CPU_R4K_CACHE_TLB
- add back CPU_R8000 to Kconfig exception list and Makefile

 arch/mips/Kconfig     |    4 ++++
 arch/mips/mm/Makefile |   17 +----------------
 2 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index be02f74..5819325 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1844,6 +1844,10 @@ config CPU_R4K_FPU
 	bool
 	default y if !(CPU_R3000 || CPU_R6000 || CPU_TX39XX || CPU_CAVIUM_OCTEON)
 
+config CPU_R4K_CACHE_TLB
+	bool
+	default y if !(CPU_R3000 || CPU_R8000 || CPU_SB1 || CPU_TX39XX || CPU_CAVIUM_OCTEON)
+
 choice
 	prompt "MIPS MT options"
 
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index 4aa2028..29ca3df 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -11,27 +11,12 @@ obj-$(CONFIG_64BIT)		+= pgtable-64.o
 obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 
-obj-$(CONFIG_CPU_LOONGSON2)	+= c-r4k.o cex-gen.o tlb-r4k.o
-obj-$(CONFIG_CPU_MIPS32)	+= c-r4k.o cex-gen.o tlb-r4k.o
-obj-$(CONFIG_CPU_MIPS64)	+= c-r4k.o cex-gen.o tlb-r4k.o
-obj-$(CONFIG_CPU_NEVADA)	+= c-r4k.o cex-gen.o tlb-r4k.o
-obj-$(CONFIG_CPU_R10000)	+= c-r4k.o cex-gen.o tlb-r4k.o
+obj-$(CONFIG_CPU_R4K_CACHE_TLB) += c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_R3000)		+= c-r3k.o tlb-r3k.o
-obj-$(CONFIG_CPU_R4300)		+= c-r4k.o cex-gen.o tlb-r4k.o
-obj-$(CONFIG_CPU_R4X00)		+= c-r4k.o cex-gen.o tlb-r4k.o
-obj-$(CONFIG_CPU_R5000)		+= c-r4k.o cex-gen.o tlb-r4k.o
-obj-$(CONFIG_CPU_R5432)		+= c-r4k.o cex-gen.o tlb-r4k.o
-obj-$(CONFIG_CPU_R5500)		+= c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_R8000)		+= c-r4k.o cex-gen.o tlb-r8k.o
-obj-$(CONFIG_CPU_RM7000)	+= c-r4k.o cex-gen.o tlb-r4k.o
-obj-$(CONFIG_CPU_RM9000)	+= c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_SB1)		+= c-r4k.o cerr-sb1.o cex-sb1.o tlb-r4k.o
 obj-$(CONFIG_CPU_TX39XX)	+= c-tx39.o tlb-r3k.o
-obj-$(CONFIG_CPU_TX49XX)	+= c-r4k.o cex-gen.o tlb-r4k.o
-obj-$(CONFIG_CPU_VR41XX)	+= c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= c-octeon.o cex-oct.o tlb-r4k.o
-obj-$(CONFIG_CPU_XLR)		+= c-r4k.o tlb-r4k.o cex-gen.o
-obj-$(CONFIG_CPU_XLP)		+= c-r4k.o tlb-r4k.o cex-gen.o
 
 obj-$(CONFIG_IP22_CPU_SCACHE)	+= sc-ip22.o
 obj-$(CONFIG_R5000_CPU_SCACHE)  += sc-r5k.o
-- 
1.7.5.4
