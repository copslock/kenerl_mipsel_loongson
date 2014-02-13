Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Feb 2014 13:13:16 +0100 (CET)
Received: from mail-pd0-f170.google.com ([209.85.192.170]:39145 "EHLO
        mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6868874AbaBMMMVakrw9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Feb 2014 13:12:21 +0100
Received: by mail-pd0-f170.google.com with SMTP id p10so10442968pdj.15
        for <multiple recipients>; Thu, 13 Feb 2014 04:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0bXEu7UpCYQy9KxZTye5/wkeBJb9gSEJ78lOO1L/VpM=;
        b=viMWZ+qXx6+paIr0SbNLSC0enFeurTSeBMiuEnQue33wn50Y+oAEJm0ScEFiiqeynP
         aDC7Flpr9UiCyLhelunMTIoEH/GTA6l6fX7oKl6UA6zvNR+qYAcJxqGatauxRG8h70RH
         OW6O+bEdAG2FOCoH6JDd2qYHlRKLpWc4Rl38I+tyC53nOQ/5d2Dam19GTQAMdk0EpkN2
         frG9oiaGlroBn8OpN+SFs5GaLSI1t0jxpEAYL4EZena2PUPnVgQYbIYo7Bj2ERMNsUfk
         oUVq9DHScXGyEyCHxvMQF0RfSfV24Nmm5hRCLqRJfdGm+0Hq7a/E25N4HIpaA9AHf4J8
         zCEw==
X-Received: by 10.66.141.165 with SMTP id rp5mr1383868pab.90.1392293535187;
        Thu, 13 Feb 2014 04:12:15 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id f5sm13421356pat.11.2014.02.13.04.11.47
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 13 Feb 2014 04:12:14 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V18 10/13] MIPS: Loongson: Add Loongson-3 Kconfig options
Date:   Thu, 13 Feb 2014 20:09:00 +0800
Message-Id: <1392293343-5453-11-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1392293343-5453-1-git-send-email-chenhc@lemote.com>
References: <1392293343-5453-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39294
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
CPU cache features, UEFI-like firmware interface (LEFI), HT-linked PCI,
and big memory support.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
Tested-by: Alex Smith <alex.smith@imgtec.com>
Reviewed-by: Alex Smith <alex.smith@imgtec.com>
---
 arch/mips/Kconfig           |   29 ++++++++++++++++++++++++++-
 arch/mips/loongson/Kconfig  |   46 +++++++++++++++++++++++++++++++++++++++++++
 arch/mips/loongson/Platform |    1 +
 3 files changed, 75 insertions(+), 1 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index dcae3a7..9af6e7d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1148,6 +1148,18 @@ choice
 	prompt "CPU type"
 	default CPU_R4X00
 
+config CPU_LOONGSON3
+	bool "Loongson 3 CPU"
+	depends on SYS_HAS_CPU_LOONGSON3
+	select CPU_SUPPORTS_64BIT_KERNEL
+	select CPU_SUPPORTS_HIGHMEM
+	select CPU_SUPPORTS_HUGEPAGES
+	select WEAK_ORDERING
+	select WEAK_REORDERING_BEYOND_LLSC
+	help
+		The Loongson 3 processor implements the MIPS64R2 instruction
+		set with many extensions.
+
 config CPU_LOONGSON2E
 	bool "Loongson 2E"
 	depends on SYS_HAS_CPU_LOONGSON2E
@@ -1523,6 +1535,10 @@ config CPU_BMIPS5000
 	select SYS_SUPPORTS_SMP
 	select SYS_SUPPORTS_HOTPLUG_CPU
 
+config SYS_HAS_CPU_LOONGSON3
+	bool
+	select CPU_SUPPORTS_CPUFREQ
+
 config SYS_HAS_CPU_LOONGSON2E
 	bool
 
@@ -1729,7 +1745,7 @@ choice
 
 config PAGE_SIZE_4KB
 	bool "4kB"
-	depends on !CPU_LOONGSON2
+	depends on !CPU_LOONGSON2 && !CPU_LOONGSON3
 	help
 	 This option select the standard 4kB Linux page size.  On some
 	 R3000-family processors this is the only available page size.  Using
@@ -2407,6 +2423,17 @@ config PCI
 	  your box. Other bus systems are ISA, EISA, or VESA. If you have PCI,
 	  say Y, otherwise N.
 
+config HT_PCI
+	bool "Support for HT-linked PCI"
+	default y
+	depends on CPU_LOONGSON3
+	select PCI
+	select PCI_DOMAINS
+	help
+	  Loongson family machines use Hyper-Transport bus for inter-core
+	  connection and device connection. The PCI bus is a subordinate
+	  linked at HT. Choose Y for Loongson-3 based machines.
+
 config PCI_DOMAINS
 	bool
 
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 263beb9..b55c1e8 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -59,6 +59,35 @@ config LEMOTE_MACH2F
 
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
+	select HT_PCI
+	select I8259
+	select IRQ_CPU
+	select NR_CPUS_DEFAULT_4
+	select SYS_HAS_CPU_LOONGSON3
+	select SYS_HAS_EARLY_PRINTK
+	select SYS_SUPPORTS_SMP
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_HIGHMEM
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select LOONGSON_MC146818
+	select ZONE_DMA32
+	select LEFI_FIRMWARE_INTERFACE
+	help
+		Lemote Loongson 3A family machines utilize the 3A revision of
+		Loongson processor and RS780/SBX00 chipset.
 endchoice
 
 config CS5536
@@ -86,8 +115,25 @@ config LOONGSON_UART_BASE
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
+	default y
+	depends on CPU_LOONGSON3
+	select IOMMU_HELPER
+	select NEED_SG_DMA_LENGTH
+	select NEED_DMA_MAP_STATE
+
 config LOONGSON_MC146818
 	bool
 	default n
 
+config LEFI_FIRMWARE_INTERFACE
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
