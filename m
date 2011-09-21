Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Sep 2011 15:40:38 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:50297 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491872Ab1IUNke (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Sep 2011 15:40:34 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id A4DCD32D63D;
        Wed, 21 Sep 2011 15:40:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8P-nRbzmofqH; Wed, 21 Sep 2011 15:40:33 +0200 (CEST)
Received: from flexo.priv.staff.proxad.net (bobafett.staff.proxad.net [213.228.1.121])
        by zmc.proxad.net (Postfix) with ESMTPSA id 56B4F32D5B9;
        Wed, 21 Sep 2011 15:40:33 +0200 (CEST)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 2/3] MIPS: introduce CPU_R4K_FPU
Date:   Wed, 21 Sep 2011 15:39:46 +0200
Message-Id: <1316612390-6367-4-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1316612390-6367-1-git-send-email-florian@openwrt.org>
References: <1316612390-6367-1-git-send-email-florian@openwrt.org>
X-archive-position: 31115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11652

R4K-style CPUs have this boolean defined by default. Allows us
to remove some lines in arch/mips/kernel/Makefile.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/Kconfig         |    4 ++++
 arch/mips/kernel/Makefile |   18 +-----------------
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9f4ade4..44eebc7 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1807,6 +1807,10 @@ config CPU_GENERIC_DUMP_TLB
 	bool
 	default y if !(CPU_R3000 || CPU_R6000 || CPU_R8000 || CPU_TX39XX)
 
+config CPU_R4K_FPU
+	bool
+	default y if !(CPU_R3000 || CPU_R6000 || CPU_TX39XX || CPU_CAVIUM_OCTEON)
+
 choice
 	prompt "MIPS MT options"
 
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 83bba33..d07c112 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -32,27 +32,11 @@ obj-$(CONFIG_MODULES)		+= mips_ksyms.o module.o
 
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
 
-obj-$(CONFIG_CPU_LOONGSON2)	+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_MIPS32)	+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_MIPS64)	+= r4k_fpu.o r4k_switch.o
+obj-$(CONFIG_CPU_R4K_FPU)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R3000)		+= r2300_fpu.o r2300_switch.o
-obj-$(CONFIG_CPU_R4300)		+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_R4X00)		+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_R5000)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R6000)		+= r6000_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_R5432)		+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_R5500)		+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_R8000)		+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_RM7000)	+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_RM9000)	+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_NEVADA)	+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_R10000)	+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_SB1)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_TX39XX)	+= r2300_fpu.o r2300_switch.o
-obj-$(CONFIG_CPU_TX49XX)	+= r4k_fpu.o r4k_switch.o
-obj-$(CONFIG_CPU_VR41XX)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= octeon_switch.o
-obj-$(CONFIG_CPU_XLR)		+= r4k_fpu.o r4k_switch.o
 
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SMP_UP)		+= smp-up.o
-- 
1.7.4.1
