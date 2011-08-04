Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Aug 2011 13:25:40 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:40407 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491188Ab1HDLYr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Aug 2011 13:24:47 +0200
Received: by mail-wy0-f177.google.com with SMTP id 19so1049152wyg.36
        for <multiple recipients>; Thu, 04 Aug 2011 04:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=P2IaI8EoyPhPoXNorCNoyWQyV/zqAPR4WymYgpFjxQg=;
        b=Mm52lFcKD1wxdfos3MM2ZpiwHaiZCHoPaBgtkGV7yAoNBX8vA3IEe3QWCDNw5YbWXX
         RNZ0OsckxCYWUa7GxIrcEDAwWoXABxk7wGqt1zIUMNzFM63n/1+XZaOXL6L06GBUdaAY
         Duo0ItbKIRbrIxM/BvRSN7Aucwtlvcms3kwJE=
Received: by 10.216.229.1 with SMTP id g1mr630859weq.51.1312457087441;
        Thu, 04 Aug 2011 04:24:47 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id n33sm1123258weq.36.2011.08.04.04.24.45
        (version=SSLv3 cipher=OTHER);
        Thu, 04 Aug 2011 04:24:46 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     ralf@linux-mips.org
Subject: [PATCH 3/3 v2] MIPS: introduce CPU_R4K_CACHE_TLB
Date:   Thu, 4 Aug 2011 13:28:37 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-server; KDE/4.6.2; x86_64; ; )
Cc:     linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201108041328.37455.florian@openwrt.org>
X-archive-position: 30834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3193

R4K-style CPUs having common code to support their caches and tlb have this
boolean defined by default. Allows us to remove some lines in
arch/mips/mm/Makefile.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v1:
- removed CPU_XLR already covered by CPU_R4K_CACHE_TLB
- add back CPU_R8000 to Kconfig exception list and Makefile

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 44eebc7..a250607 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1811,6 +1811,10 @@ config CPU_R4K_FPU
 	bool
 	default y if !(CPU_R3000 || CPU_R6000 || CPU_TX39XX || CPU_CAVIUM_OCTEON)
 
+config CPU_R4K_CACHE_TLB
+	bool
+	default y if !(CPU_R3000 || CPU_R8000 || CPU_SB1 || CPU_TX39XX || CPU_CAVIUM_OCTEON)
+
 choice
 	prompt "MIPS MT options"
 
diff --git a/arch/mips/mm/Makefile b/arch/mips/mm/Makefile
index 4d8c162..8e880da 100644
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -11,26 +11,12 @@ obj-$(CONFIG_64BIT)		+= pgtable-64.o
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
 
 obj-$(CONFIG_IP22_CPU_SCACHE)	+= sc-ip22.o
 obj-$(CONFIG_R5000_CPU_SCACHE)  += sc-r5k.o
-- 
1.7.4.1
