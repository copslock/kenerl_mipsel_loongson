Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Aug 2011 13:25:14 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:40407 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491182Ab1HDLYm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Aug 2011 13:24:42 +0200
Received: by mail-wy0-f177.google.com with SMTP id 19so1049152wyg.36
        for <multiple recipients>; Thu, 04 Aug 2011 04:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=eSJR1IHSm5zwpdhu+dGEmTXTmgZY15sBFBCExYa8/3Y=;
        b=P8kufbH1VFKcPT8qKeBYJyw9X2qv1hSzVSHJE/vdZ95GQLBxrNrT8vQgLgqWcM7Toc
         Oxep3zPDmmZr8//uI9ntUZ0t8TQ5bM6WL4FbEAQKpIy5N5WsIqB9dLzs7a1WsmD/eDt5
         pbw1t0Wk6AID0nfxRn0IHcBY6Hs5tCN2Jij+A=
Received: by 10.217.2.202 with SMTP id p52mr637803wes.28.1312457081883;
        Thu, 04 Aug 2011 04:24:41 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id k9sm1130532weq.3.2011.08.04.04.24.40
        (version=SSLv3 cipher=OTHER);
        Thu, 04 Aug 2011 04:24:40 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     ralf@linux-mips.org
Subject: [PATCH 2/3 v2] MIPS: introduce CPU_R4K_FPU
Date:   Thu, 4 Aug 2011 13:28:31 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-server; KDE/4.6.2; x86_64; ; )
Cc:     linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201108041328.31484.florian@openwrt.org>
X-archive-position: 30833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3192

R4K-style CPUs have this boolean defined by default. Allows us
to remove some lines in arch/mips/kernel/Makefile.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v1:
- removed CPU_XLR already covered by CPU_R4K_FPU

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
