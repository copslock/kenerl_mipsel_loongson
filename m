Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2015 05:40:05 +0200 (CEST)
Received: from smtpbg298.qq.com ([184.105.67.102]:46902 "EHLO smtpbg298.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011268AbbD2DkDAptum (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Apr 2015 05:40:03 +0200
X-QQ-mid: bizesmtp2t1430278776t843t121
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 29 Apr 2015 11:39:35 +0800 (CST)
X-QQ-SSF: 01100000002000F0F212B00A0000000
X-QQ-FEAT: 0YGU8PmKZ8aYoIJ6i7tQ4PxB5NmDmhjWU8E2Kxtuitk2ZS04UUXS2NcDfVYky
        c/ouQgUEWVbwx1B4INulRM9eg04cMw+l2HrDevHXLD2d+e4s0kIDWlzE2ERFfpMk4xsVMbL
        IrPsyz43CeTxzF7fXj3lheuChkGAu39ciP54KJkyK951XrCpdu8bz77MWGopGCM5QMGRSGJ
        wXlMGDGBqaN+uZfR+K+DUVxnlfFGRmnJo4lgWuoGrB2d7VH1wn8QG
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>, Chunbo Cui <cuicb@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 2/8] MIPS: Loongson: Add Loongson-1A Kconfig options
Date:   Wed, 29 Apr 2015 11:57:21 +0800
Message-Id: <1430279847-25120-3-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1430279847-25120-1-git-send-email-zhoubb@lemote.com>
References: <1430279847-25120-1-git-send-email-zhoubb@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-FName: 1EACD0434BEA4AAC951EDAB9950C7B7C
X-QQ-LocalIP: 163.177.66.155
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhoubb@lemote.com
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

Added Kconfig options include: Loongson-1A CPU and machine definition,
CPU cache features, 32-bit kernel and early printk support.

Signed-off-by: Chunbo Cui <cuicb@lemote.com>
Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/Kconfig           | 11 +++++++++++
 arch/mips/loongson1/Kconfig | 20 ++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 1c971be..2ee1abba 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1316,6 +1316,14 @@ config CPU_LOONGSON2F
 	  have a similar programming interface with FPGA northbridge used in
 	  Loongson2E.
 
+config CPU_LOONGSON1A
+	bool "Loongson 1A"
+	depends on SYS_HAS_CPU_LOONGSON1A
+	select CPU_LOONGSON1
+	help
+	  The Loongson 1A is a 32-bit SoC, which implements the MIPS32
+	  release 2 instruction set.
+
 config CPU_LOONGSON1B
 	bool "Loongson 1B"
 	depends on SYS_HAS_CPU_LOONGSON1B
@@ -1758,6 +1766,9 @@ config SYS_HAS_CPU_LOONGSON2F
 	select CPU_SUPPORTS_ADDRWINCFG if 64BIT
 	select CPU_SUPPORTS_UNCACHED_ACCELERATED
 
+config SYS_HAS_CPU_LOONGSON1A
+	bool
+
 config SYS_HAS_CPU_LOONGSON1B
 	bool
 
diff --git a/arch/mips/loongson1/Kconfig b/arch/mips/loongson1/Kconfig
index a2b796e..7899f53 100644
--- a/arch/mips/loongson1/Kconfig
+++ b/arch/mips/loongson1/Kconfig
@@ -1,8 +1,28 @@
 if MACH_LOONGSON1
 
+config ZONE_DMA
+	prompt "Zone DMA"
+	bool
+
 choice
 	prompt "Machine Type"
 
+config LOONGSON1_LS1A
+	bool "Loongson LS1A board"
+	select CEVT_R4K
+	select CSRC_R4K
+	select SYS_HAS_CPU_LOONGSON1A
+	select DMA_NONCOHERENT
+	select BOOT_ELF32
+	select IRQ_CPU
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_HIGHMEM
+	select SYS_SUPPORTS_MIPS16
+	select SYS_HAS_EARLY_PRINTK
+	select USE_GENERIC_EARLY_PRINTK_8250
+	select COMMON_CLK
+
 config LOONGSON1_LS1B
 	bool "Loongson LS1B board"
 	select CEVT_R4K if !MIPS_EXTERNAL_TIMER
-- 
1.9.0
