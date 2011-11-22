Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2011 15:00:48 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:45115 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903719Ab1KVOAT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Nov 2011 15:00:19 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 2F3BA3B7DE6;
        Tue, 22 Nov 2011 15:00:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HNcju1iKnkYF; Tue, 22 Nov 2011 15:00:18 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id BF39337C565;
        Tue, 22 Nov 2011 15:00:18 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 1/3 v3] MIPS: introduce GENERIC_DUMP_TLB
Date:   Tue, 22 Nov 2011 14:59:48 +0100
Message-Id: <1321970390-10887-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
X-archive-position: 31925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18593

Allows us not to duplicate more lines in arch/mips/lib/Makefile.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v2:
- rebased against mips-for-linux-next (remove XLR & XLP)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 0c55582..cc5976d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1836,6 +1836,10 @@ config SIBYTE_DMA_PAGEOPS
 config CPU_HAS_PREFETCH
 	bool
 
+config CPU_GENERIC_DUMP_TLB
+	bool
+	default y if !(CPU_R3000 || CPU_R6000 || CPU_R8000 || CPU_TX39XX)
+
 choice
 	prompt "MIPS MT options"
 
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 2a7c74f..d8c290c 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -8,28 +8,9 @@ lib-y	+= csum_partial.o delay.o memcpy.o memcpy-inatomic.o memset.o \
 obj-y			+= iomap.o
 obj-$(CONFIG_PCI)	+= iomap-pci.o
 
-obj-$(CONFIG_CPU_LOONGSON2)	+= dump_tlb.o
-obj-$(CONFIG_CPU_MIPS32)	+= dump_tlb.o
-obj-$(CONFIG_CPU_MIPS64)	+= dump_tlb.o
-obj-$(CONFIG_CPU_NEVADA)	+= dump_tlb.o
-obj-$(CONFIG_CPU_R10000)	+= dump_tlb.o
+obj-$(CONFIG_CPU_GENERIC_DUMP_TLB) += dump_tlb.o
 obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb.o
-obj-$(CONFIG_CPU_R4300)		+= dump_tlb.o
-obj-$(CONFIG_CPU_R4X00)		+= dump_tlb.o
-obj-$(CONFIG_CPU_R5000)		+= dump_tlb.o
-obj-$(CONFIG_CPU_R5432)		+= dump_tlb.o
-obj-$(CONFIG_CPU_R5500)		+= dump_tlb.o
-obj-$(CONFIG_CPU_R6000)		+=
-obj-$(CONFIG_CPU_R8000)		+=
-obj-$(CONFIG_CPU_RM7000)	+= dump_tlb.o
-obj-$(CONFIG_CPU_RM9000)	+= dump_tlb.o
-obj-$(CONFIG_CPU_SB1)		+= dump_tlb.o
 obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
-obj-$(CONFIG_CPU_TX49XX)	+= dump_tlb.o
-obj-$(CONFIG_CPU_VR41XX)	+= dump_tlb.o
-obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= dump_tlb.o
-obj-$(CONFIG_CPU_XLR)		+= dump_tlb.o
-obj-$(CONFIG_CPU_XLP)		+= dump_tlb.o
 
 # libgcc-style stuff needed in the kernel
 obj-y += ashldi3.o ashrdi3.o cmpdi2.o lshrdi3.o ucmpdi2.o
-- 
1.7.5.4
