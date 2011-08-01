Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Aug 2011 12:22:52 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:52677 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491141Ab1HAKWp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Aug 2011 12:22:45 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 13DC12F1DE3;
        Mon,  1 Aug 2011 12:22:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id h2ROvLs41vQi; Mon,  1 Aug 2011 12:22:44 +0200 (CEST)
Received: from flexo.priv.staff.proxad.net (bobafett.staff.proxad.net [213.228.1.121])
        by zmc.proxad.net (Postfix) with ESMTPSA id C54C32F1E84;
        Mon,  1 Aug 2011 12:22:44 +0200 (CEST)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 3/3] MIPS: introduce CPU_R4K_CACHE_TLB
Date:   Mon,  1 Aug 2011 12:26:22 +0200
Message-Id: <1312194382-3706-3-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1312194382-3706-1-git-send-email-florian@openwrt.org>
References: <1312194382-3706-1-git-send-email-florian@openwrt.org>
X-archive-position: 30777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 281

R4K-style CPUs having common code to support their caches and tlb have this
boolean defined by default. Allows us to save some lines in
arch/mips/mm/Makefile

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/Kconfig     |    4 ++++
 arch/mips/mm/Makefile |   16 +---------------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 44eebc7..0150745 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1811,6 +1811,10 @@ config CPU_R4K_FPU
 	bool
 	default y if !(CPU_R3000 || CPU_R6000 || CPU_TX39XX || CPU_CAVIUM_OCTEON)
 
+config CPU_R4K_CACHE_TLB
+	bool
+	default y if !(CPU_R3000 || CPU_SB1 || CPU_TX39XX || CPU_CAVIUM_OCTEON)
+
 choice
 	prompt "MIPS MT options"
 
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index 4d8c162..04ece1b5 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -11,24 +11,10 @@ obj-$(CONFIG_64BIT)		+= pgtable-64.o
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
-obj-$(CONFIG_CPU_R8000)		+= c-r4k.o cex-gen.o tlb-r8k.o
-obj-$(CONFIG_CPU_RM7000)	+= c-r4k.o cex-gen.o tlb-r4k.o
-obj-$(CONFIG_CPU_RM9000)	+= c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_SB1)		+= c-r4k.o cerr-sb1.o cex-sb1.o tlb-r4k.o
 obj-$(CONFIG_CPU_TX39XX)	+= c-tx39.o tlb-r3k.o
-obj-$(CONFIG_CPU_TX49XX)	+= c-r4k.o cex-gen.o tlb-r4k.o
-obj-$(CONFIG_CPU_VR41XX)	+= c-r4k.o cex-gen.o tlb-r4k.o
 obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= c-octeon.o cex-oct.o tlb-r4k.o
 obj-$(CONFIG_CPU_XLR)		+= c-r4k.o tlb-r4k.o cex-gen.o
 
-- 
1.7.4.1
