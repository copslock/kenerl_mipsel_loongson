Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Sep 2011 15:41:03 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:50296 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491870Ab1IUNke (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Sep 2011 15:40:34 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 9599E1252C2;
        Wed, 21 Sep 2011 15:40:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ch550hL02-9f; Wed, 21 Sep 2011 15:40:33 +0200 (CEST)
Received: from flexo.priv.staff.proxad.net (bobafett.staff.proxad.net [213.228.1.121])
        by zmc.proxad.net (Postfix) with ESMTPSA id 4DD8632937F;
        Wed, 21 Sep 2011 15:40:33 +0200 (CEST)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 1/3] MIPS: introduce GENERIC_DUMP_TLB
Date:   Wed, 21 Sep 2011 15:39:44 +0200
Message-Id: <1316612390-6367-2-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1316612390-6367-1-git-send-email-florian@openwrt.org>
References: <1316612390-6367-1-git-send-email-florian@openwrt.org>
X-archive-position: 31116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11650

Allows us not to duplicate more lines in arch/mips/lib/Makefile.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/Kconfig      |    4 ++++
 arch/mips/lib/Makefile |   20 +-------------------
 2 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d300c2b..9f4ade4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1803,6 +1803,10 @@ config SIBYTE_DMA_PAGEOPS
 config CPU_HAS_PREFETCH
 	bool
 
+config CPU_GENERIC_DUMP_TLB
+	bool
+	default y if !(CPU_R3000 || CPU_R6000 || CPU_R8000 || CPU_TX39XX)
+
 choice
 	prompt "MIPS MT options"
 
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index b2cad4f..d8c290c 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -8,27 +8,9 @@ lib-y	+= csum_partial.o delay.o memcpy.o memcpy-inatomic.o memset.o \
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
 
 # libgcc-style stuff needed in the kernel
 obj-y += ashldi3.o ashrdi3.o cmpdi2.o lshrdi3.o ucmpdi2.o
-- 
1.7.4.1
