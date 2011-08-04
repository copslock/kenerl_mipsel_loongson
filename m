Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Aug 2011 13:24:48 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:40407 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491076Ab1HDLYl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Aug 2011 13:24:41 +0200
Received: by wyg19 with SMTP id 19so1049152wyg.36
        for <multiple recipients>; Thu, 04 Aug 2011 04:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=Esga93hUS6iDiuPiUM6dHE0LqlOuavqjcCkML2ZqbWM=;
        b=SnN/Xegg9MGaFhEqniWnaswAjsW1xN6McTmF+oq0PvJ0syCSYxoDm1Ni72+pEP1ujg
         3y9uk9+QL0XNM6ZxXgA8Fz6F61GvxFN70nGdREKxntIH8lHLmn6F+ayeQ4j2+Oo6eF8y
         B438Hu0yCvvxJRXT3tRMbKJitOjSPNCHah7+g=
Received: by 10.227.38.13 with SMTP id z13mr604758wbd.61.1312457075634;
        Thu, 04 Aug 2011 04:24:35 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id ff6sm1410041wbb.49.2011.08.04.04.24.33
        (version=SSLv3 cipher=OTHER);
        Thu, 04 Aug 2011 04:24:34 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     ralf@linux-mips.org
Subject: [PATCH 1/3 v2] MIPS: introduce GENERIC_DUMP_TLB
Date:   Thu, 4 Aug 2011 13:28:25 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-server; KDE/4.6.2; x86_64; ; )
Cc:     linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201108041328.25230.florian@openwrt.org>
X-archive-position: 30832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3191

Allows us not to duplicate more lines in arch/mips/lib/Makefile.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
No changes since v2

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
