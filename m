Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 18:20:02 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:58208 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904026Ab2AaRTK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2012 18:19:10 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 4DBA9434D36;
        Tue, 31 Jan 2012 18:19:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id H+McPc0RyNkL; Tue, 31 Jan 2012 18:19:09 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 88E4D447FD8;
        Tue, 31 Jan 2012 18:19:09 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 2/3 v4] MIPS: introduce CPU_R4K_FPU
Date:   Tue, 31 Jan 2012 18:18:44 +0100
Message-Id: <1328030325-21918-2-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1328030325-21918-1-git-send-email-florian@openwrt.org>
References: <1328030325-21918-1-git-send-email-florian@openwrt.org>
X-archive-position: 32367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

R4K-style CPUs have this boolean defined by default. Allows us
to remove some lines in arch/mips/kernel/Makefile.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v2/v3:
- rebased against mips-for-linux-next

Changes since v1:
- removed CPU_XLR already covered by CPU_R4K_FPU

 arch/mips/Kconfig         |    4 ++++
 arch/mips/kernel/Makefile |   19 +------------------
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 0a52846..3367ce2 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1843,6 +1843,10 @@ config CPU_GENERIC_DUMP_TLB
 	bool
 	default y if !(CPU_R3000 || CPU_R6000 || CPU_R8000 || CPU_TX39XX)
 
+config CPU_R4K_FPU
+	bool
+	default y if !(CPU_R3000 || CPU_R6000 || CPU_TX39XX || CPU_CAVIUM_OCTEON)
+
 choice
 	prompt "MIPS MT options"
 
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 0c6877e..3d33c85 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -34,28 +34,11 @@ obj-$(CONFIG_MODULES)		+= mips_ksyms.o module.o
 
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
-obj-$(CONFIG_CPU_XLP)		+= r4k_fpu.o r4k_switch.o
 
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SMP_UP)		+= smp-up.o
-- 
1.7.5.4
