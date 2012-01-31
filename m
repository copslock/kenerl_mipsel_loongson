Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 18:19:40 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:58204 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904020Ab2AaRTK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2012 18:19:10 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id E571D448589;
        Tue, 31 Jan 2012 18:19:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id s8E6qLNAvTnj; Tue, 31 Jan 2012 18:19:09 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 7E0A9447ED0;
        Tue, 31 Jan 2012 18:19:09 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 1/3 v4] MIPS: introduce CPU_GENERIC_DUMP_TLB
Date:   Tue, 31 Jan 2012 18:18:43 +0100
Message-Id: <1328030325-21918-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
X-archive-position: 32366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Allows us not to duplicate more lines in arch/mips/lib/Makefile.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v3:
- change patch subjet to match introduced Kconfig symbol

Changes since v2:
- rebased against mips-for-linux-next (remove XLR & XLP)

 arch/mips/Kconfig      |    4 ++++
 arch/mips/lib/Makefile |   21 +--------------------
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c4c1312..0a52846 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1839,6 +1839,10 @@ config SIBYTE_DMA_PAGEOPS
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
