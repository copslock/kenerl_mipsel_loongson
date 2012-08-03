Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2012 09:10:18 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:34067 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903393Ab2HCHHZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Aug 2012 09:07:25 +0200
Received: by mail-yx0-f177.google.com with SMTP id r9so506866yen.36
        for <multiple recipients>; Fri, 03 Aug 2012 00:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=HuJdJer2ZrBGVMIeu6NwRMmqBeJVw1wLxJue5I6GaGU=;
        b=OoC8AqGkeBdNNbx03B7BSrWIicTITyDv4b5ADVro5y0a+PcYN9F3tdT7cqUZGQDmQ1
         IjJrH3qeoY87dR2YHwZH/stADEPkcBLzNXGummI4y3HQVAB9peXV/IFRNY5H7nmD9Ixe
         c/R3dBW8YwzriqRC+AH8ZO69fWwjEjzmQYIOBz6gtVFS5kpJwEUq0bx03i3zIa2bjlP9
         J3NQRExvLyrFDiyb3gIFoZzGXK7hlxWyItt8DWVIYKp8sHs8RbM3tR581ru2aV2Ji4PJ
         jEe02LPiQvFU05xiPw/3AN9KFsRj3qJ2mnLTjKlB0ysSllNhm1TqVoAatHaUnJzMkeoO
         QaMA==
Received: by 10.50.57.130 with SMTP id i2mr1607635igq.2.1343977644948;
        Fri, 03 Aug 2012 00:07:24 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id z3sm20852677igc.7.2012.08.03.00.07.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Aug 2012 00:07:24 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V4 10/16] MIPS: Loongson: Add Loongson-3 Kconfig options.
Date:   Fri,  3 Aug 2012 15:06:05 +0800
Message-Id: <1343977571-2292-11-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1343977571-2292-1-git-send-email-chenhc@lemote.com>
References: <1343977571-2292-1-git-send-email-chenhc@lemote.com>
X-archive-position: 34033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Added Kconfig options include: Loongson-3 CPU and machine definition,
UEFI-like firmware interface, HT-linked PCI, big memory support, etc.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
---
 arch/mips/Kconfig          |   22 ++++++++++++++++++
 arch/mips/loongson/Kconfig |   52 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 331d574..9e8e86c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1571,6 +1571,16 @@ config CPU_LOONGSON2
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
 
+config CPU_LOONGSON3
+	bool "Loongson 3 CPU"
+	depends on SYS_HAS_CPU_LOONGSON3
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_64BIT_KERNEL
+	select CPU_SUPPORTS_HIGHMEM
+	help
+		The Loongson 3 processor implements the MIPS III instruction set
+		with many extensions.
+
 config CPU_LOONGSON1
 	bool
 	select CPU_MIPS32
@@ -1597,6 +1607,9 @@ config SYS_HAS_CPU_LOONGSON2F
 	select CPU_SUPPORTS_ADDRWINCFG if 64BIT
 	select CPU_SUPPORTS_UNCACHED_ACCELERATED
 
+config SYS_HAS_CPU_LOONGSON3
+	bool
+
 config SYS_HAS_CPU_LOONGSON1B
 	bool
 
@@ -2399,6 +2412,15 @@ config PCI
 	  your box. Other bus systems are ISA, EISA, or VESA. If you have PCI,
 	  say Y, otherwise N.
 
+config HT_PCI
+	bool "Support for HT-linked PCI"
+	select PCI_DOMAINS
+	help
+	  Loongson family machines use Hyper-Transport bus for inter-core
+	  connection and device connection. The PCI bus is a subordinate
+	  linked at HT. Choose Y unless you are using Loongson 2E/2F based
+	  machines.
+
 config PCI_DOMAINS
 	bool
 
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 263beb9..dd951b8 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -59,6 +59,33 @@ config LEMOTE_MACH2F
 
 	  These family machines include fuloong2f mini PC, yeeloong2f notebook,
 	  LingLoong allinone PC and so forth.
+
+config LEMOTE_MACH3A
+	bool "Lemote Loongson 3A family machines"
+	select ARCH_SPARSEMEM_ENABLE
+	select GENERIC_ISA_DMA_SUPPORT_BROKEN
+	select GENERIC_HARDIRQS_NO__DO_IRQ
+	select BOOT_ELF32
+	select BOARD_SCACHE
+	select CSRC_R4K
+	select CEVT_R4K
+	select CPU_HAS_WB
+	select HW_HAS_PCI
+	select ISA
+	select I8259
+	select IRQ_CPU
+	select SYS_HAS_CPU_LOONGSON3
+	select SYS_HAS_EARLY_PRINTK
+	select SYS_SUPPORTS_SMP
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_HIGHMEM
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select LOONGSON_MC146818
+	select UEFI_FIRMWARE_INTERFACE
+	help
+		Lemote Loongson 3A family machines utilize the 3A revision of
+		Loongson processor and RS780/SBX00 chipset.
 endchoice
 
 config CS5536
@@ -86,8 +113,33 @@ config LOONGSON_UART_BASE
 	default y
 	depends on EARLY_PRINTK || SERIAL_8250
 
+config LOONGSON_BIGMEM
+	bool "Soft IOMMU Support for Big Memory (>4GB)"
+	depends on CPU_LOONGSON3
+	select SWIOTLB
+	select ZONE_DMA32
+
+config IOMMU_HELPER
+	bool
+
+config NEED_SG_DMA_LENGTH
+	bool
+
+config SWIOTLB
+	bool
+	select IOMMU_HELPER
+	select NEED_SG_DMA_LENGTH
+	select NEED_DMA_MAP_STATE
+
 config LOONGSON_MC146818
 	bool
 	default n
 
+config ARCH_SPARSEMEM_ENABLE
+	bool
+	select SPARSEMEM_STATIC
+
+config UEFI_FIRMWARE_INTERFACE
+	bool
+
 endif # MACH_LOONGSON
-- 
1.7.7.3
