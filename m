Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Dec 2013 08:43:58 +0100 (CET)
Received: from mail-pd0-f175.google.com ([209.85.192.175]:61078 "EHLO
        mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831298Ab3LEHluepAdX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Dec 2013 08:41:50 +0100
Received: by mail-pd0-f175.google.com with SMTP id w10so23909518pde.6
        for <multiple recipients>; Wed, 04 Dec 2013 23:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qmfRBQtiDQyTsJrsxvNe+z9aLpLMNyB4i4jo68tnfjE=;
        b=LBd7CIujhscL/traL36A50py3hcj191jQWXdqh2NqQ3yxTwgxj+b/WhJUfGo/ynx2R
         l6L9mxRRXp/AK+8xnEZO9/8Q59XPhQb26WUaSXNhfHclSTtox6Zl797BVGEW0lWK6lsR
         Lsvmglpg3vPA9Nopn3sl2U/ijnHbtFD5xPCKzjELFM+Q6n7eBO6OQvnF7y1uUtoFl8zi
         KEPKvSUuegRNogy+xD5e7p3StuyIZMqkJTWgMMjuc57M0J/vdmJiDfYQFNqgj5awMPv9
         tF5+VYYyfDlPuUkTe1FFkLkpmoyxHTucZlqL7d1rEviVMqqprQS4hEXAe183trL3vhr/
         90bA==
X-Received: by 10.66.119.105 with SMTP id kt9mr49607056pab.94.1386229304014;
        Wed, 04 Dec 2013 23:41:44 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id vk17sm9636837pab.5.2013.12.04.23.41.38
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 04 Dec 2013 23:41:43 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V14 09/12] MIPS: Loongson: Add Loongson-3 Kconfig options
Date:   Thu,  5 Dec 2013 15:39:59 +0800
Message-Id: <1386229203-15129-10-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1386229203-15129-1-git-send-email-chenhc@lemote.com>
References: <1386229203-15129-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38655
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
 arch/mips/Kconfig           |   29 ++++++++++++++++++++++++++
 arch/mips/loongson/Kconfig  |   48 +++++++++++++++++++++++++++++++++++++++++++
 arch/mips/loongson/Platform |    1 +
 3 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 17cc7ff..2c447a7 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1487,6 +1487,19 @@ config CPU_LOONGSON2
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
@@ -1513,6 +1526,11 @@ config SYS_HAS_CPU_LOONGSON2F
 	select CPU_SUPPORTS_ADDRWINCFG if 64BIT
 	select CPU_SUPPORTS_UNCACHED_ACCELERATED
 
+config SYS_HAS_CPU_LOONGSON3
+	bool
+	select CPU_SUPPORTS_CPUFREQ
+	select CPU_SUPPORTS_COHERENT_CACHE
+
 config SYS_HAS_CPU_LOONGSON1B
 	bool
 
@@ -1647,6 +1665,8 @@ config CPU_SUPPORTS_HUGEPAGES
 	bool
 config CPU_SUPPORTS_UNCACHED_ACCELERATED
 	bool
+config CPU_SUPPORTS_COHERENT_CACHE
+	bool
 config MIPS_PGD_C0_CONTEXT
 	bool
 	default y if 64BIT && CPU_MIPSR2 && !CPU_XLP
@@ -2373,6 +2393,15 @@ config PCI
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
index 263beb9..9fcf274 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -59,6 +59,34 @@ config LEMOTE_MACH2F
 
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
+	select ZONE_DMA32 if 64BIT
+	select UEFI_FIRMWARE_INTERFACE
+	help
+		Lemote Loongson 3A family machines utilize the 3A revision of
+		Loongson processor and RS780/SBX00 chipset.
 endchoice
 
 config CS5536
@@ -86,8 +114,28 @@ config LOONGSON_UART_BASE
 	default y
 	depends on EARLY_PRINTK || SERIAL_8250
 
+config IOMMU_HELPER
+	bool
+
+config NEED_SG_DMA_LENGTH
+	bool
+
+config SWIOTLB
+	bool "Soft IOMMU Support for Big Memory (>4GB)"
+	depends on CPU_LOONGSON3
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
diff --git a/arch/mips/loongson/Platform b/arch/mips/loongson/Platform
index 29692e5..6205372 100644
--- a/arch/mips/loongson/Platform
+++ b/arch/mips/loongson/Platform
@@ -30,3 +30,4 @@ platform-$(CONFIG_MACH_LOONGSON) += loongson/
 cflags-$(CONFIG_MACH_LOONGSON) += -I$(srctree)/arch/mips/include/asm/mach-loongson -mno-branch-likely
 load-$(CONFIG_LEMOTE_FULOONG2E) += 0xffffffff80100000
 load-$(CONFIG_LEMOTE_MACH2F) += 0xffffffff80200000
+load-$(CONFIG_CPU_LOONGSON3) += 0xffffffff80200000
-- 
1.7.7.3
