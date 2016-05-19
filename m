Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2016 03:43:55 +0200 (CEST)
Received: from smtpbguseast2.qq.com ([54.204.34.130]:35361 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27030392AbcESBnAAcnT0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 May 2016 03:43:00 +0200
X-QQ-mid: bizesmtp3t1463622157t763t138
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 19 May 2016 09:42:35 +0800 (CST)
X-QQ-SSF: 01100000002000F0FG70000A0000000
X-QQ-FEAT: u9yQq91qdYU73DLBSBu9VNoazd7PDXao4N0jEQ3iN8x46iHCC+ezR+VHAViH/
        020oPzAdm/Se8TyJysS8PmO9wA4o4NFDh9VSKY4ZwthEWbVNEhtIKeUe+B9FUC869B72mph
        oRi3NfEBtCrHt1lowjUUV4r6MqF8jHlF9bTP/pI4m0OOJBEyNapPa6UPYF6QT04qt2h/0+4
        PxJ5I27Cw4bin+X3RI2ekf56U1CbWMuQrzF8nCujiPitQIdGELRf42KBxGi+mAv2/eCVZAS
        ijWWtcVUaD0Q6WFMILefu5xAA=
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>, Chunbo Cui <cuichboo@163.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH RESEND v4 2/9] MIPS: Loongson: Add Loongson-1A Kconfig options
Date:   Thu, 19 May 2016 09:38:27 +0800
Message-Id: <1463621912-9883-3-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1463621912-9883-1-git-send-email-zhoubb@lemote.com>
References: <1463621912-9883-1-git-send-email-zhoubb@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53532
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

Signed-off-by: Chunbo Cui <cuichboo@163.com>
Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/Kconfig            | 11 +++++++++++
 arch/mips/loongson32/Kconfig | 16 ++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ac9bfad..dffa359 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1402,6 +1402,14 @@ config CPU_LOONGSON2F
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
@@ -1856,6 +1864,9 @@ config SYS_HAS_CPU_LOONGSON2F
 	select CPU_SUPPORTS_ADDRWINCFG if 64BIT
 	select CPU_SUPPORTS_UNCACHED_ACCELERATED
 
+config SYS_HAS_CPU_LOONGSON1A
+	bool
+
 config SYS_HAS_CPU_LOONGSON1B
 	bool
 
diff --git a/arch/mips/loongson32/Kconfig b/arch/mips/loongson32/Kconfig
index 7704f20..35effa8 100644
--- a/arch/mips/loongson32/Kconfig
+++ b/arch/mips/loongson32/Kconfig
@@ -3,6 +3,22 @@ if MACH_LOONGSON32
 choice
 	prompt "Machine Type"
 
+config LOONGSON1_LS1A
+	bool "Loongson LS1A board"
+	select CEVT_R4K
+	select CSRC_R4K
+	select SYS_HAS_CPU_LOONGSON1A
+	select DMA_NONCOHERENT
+	select BOOT_ELF32
+	select IRQ_MIPS_CPU
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
1.9.1
