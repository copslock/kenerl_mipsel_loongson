Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Apr 2013 14:50:38 +0200 (CEST)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:61637 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835138Ab3DOMsLBgtvV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Apr 2013 14:48:11 +0200
Received: by mail-pa0-f41.google.com with SMTP id kx1so2544465pab.0
        for <multiple recipients>; Mon, 15 Apr 2013 05:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=C7SPd9k7u5uTgZKgmadJC2ygLxKRKBSRThq+3blRL1o=;
        b=WQgUWfZp32zqjQT9qDUTmLIKevcjuh4H0I3+iACMB8AOkSEbhwmERmN+jyv2fjVgnQ
         CD90A4beHYWtV/cK5Lk4FBodIOOyHDRwnO1gvQ+9GEuGIr3+/rqdQf9iaVkfWwEU5qXx
         /bXj0vaBUmEKCuneFvhQVpFxMyXwFowgURjZcXnY7jcqCRHbZBE72b+LkW801h4iChC0
         NYLdUAyfpwwJAWsm0BFkNt8rtkzO2vMeav4iKgwXnHjIsuS+S/cF5ShSeDIph4rvtbUE
         1C3lsQ5rk3AI/TIETtkcvBTCmoW+9e2WkPcMADRNZl8iiWcXaN/QYfFDlo0BBxYijkaj
         viaA==
X-Received: by 10.68.130.7 with SMTP id oa7mr29254132pbb.132.1366030084470;
        Mon, 15 Apr 2013 05:48:04 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id xz4sm20242580pbb.18.2013.04.15.05.48.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 05:48:03 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V10 10/13] MIPS: Loongson: Add Loongson-3 Kconfig options
Date:   Mon, 15 Apr 2013 20:47:05 +0800
Message-Id: <1366030028-5084-11-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1366030028-5084-1-git-send-email-chenhc@lemote.com>
References: <1366030028-5084-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Added Kconfig options include: Loongson-3 CPU and machine definition,
CPU cache features, UEFI-like firmware interface, HT-linked PCI, and
big memory support.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
---
 arch/mips/Kconfig          |   29 ++++++++++++++++++++++++
 arch/mips/loongson/Kconfig |   52 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a6fdd16..da0bad2 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1546,6 +1546,19 @@ config CPU_LOONGSON2
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_HUGEPAGES
 
+config CPU_LOONGSON3
+	bool "Loongson 3 CPU"
+	depends on SYS_HAS_CPU_LOONGSON3
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_64BIT_KERNEL
+	select CPU_SUPPORTS_HIGHMEM
+	select CPU_SUPPORTS_HUGEPAGES
+	select WEAK_ORDERING
+	select WEAK_REORDERING_BEYOND_LLSC
+	help
+		The Loongson 3 processor implements the MIPS III instruction set
+		with many extensions.
+
 config CPU_LOONGSON1
 	bool
 	select CPU_MIPS32
@@ -1572,6 +1585,11 @@ config SYS_HAS_CPU_LOONGSON2F
 	select CPU_SUPPORTS_ADDRWINCFG if 64BIT
 	select CPU_SUPPORTS_UNCACHED_ACCELERATED
 
+config SYS_HAS_CPU_LOONGSON3
+	bool
+	select CPU_SUPPORTS_CPUFREQ
+	select CPU_SUPPORTS_COHERENT_CACHE
+
 config SYS_HAS_CPU_LOONGSON1B
 	bool
 
@@ -1706,6 +1724,8 @@ config CPU_SUPPORTS_HUGEPAGES
 	bool
 config CPU_SUPPORTS_UNCACHED_ACCELERATED
 	bool
+config CPU_SUPPORTS_COHERENT_CACHE
+	bool
 config MIPS_PGD_C0_CONTEXT
 	bool
 	default y if 64BIT && CPU_MIPSR2 && !CPU_XLP
@@ -2394,6 +2414,15 @@ config PCI
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
