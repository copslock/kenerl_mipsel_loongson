Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Aug 2016 14:37:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1982 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992695AbcHIMhRC0cN4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Aug 2016 14:37:17 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5109C3A9D1928;
        Tue,  9 Aug 2016 13:36:57 +0100 (IST)
Received: from localhost (10.100.200.230) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 9 Aug
 2016 13:37:00 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Jacek Anaszewski <j.anaszewski@samsung.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/20] MIPS: SEAD3: Use generic ns16550a earlycon support
Date:   Tue, 9 Aug 2016 13:35:29 +0100
Message-ID: <20160809123546.10190-5-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160809123546.10190-1-paul.burton@imgtec.com>
References: <20160809123546.10190-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.230]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Stop selecting SYS_HAS_EARLY_PRINTK & remove the custom support for
early output to the ns16550a UARTs, instead relying upon generic
ns16550a earlycon support. This reduces the amount of platform code
required for SEAD3 without losing any functionality.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/Kconfig                   |  1 -
 arch/mips/configs/sead3_defconfig   |  2 ++
 arch/mips/mti-sead3/Makefile        |  2 --
 arch/mips/mti-sead3/sead3-console.c | 46 -------------------------------------
 arch/mips/mti-sead3/sead3-init.c    |  6 -----
 5 files changed, 2 insertions(+), 55 deletions(-)
 delete mode 100644 arch/mips/mti-sead3/sead3-console.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2638856..45bbddf 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -513,7 +513,6 @@ config MIPS_SEAD3
 	select SYS_HAS_CPU_MIPS32_R2
 	select SYS_HAS_CPU_MIPS32_R6
 	select SYS_HAS_CPU_MIPS64_R1
-	select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
diff --git a/arch/mips/configs/sead3_defconfig b/arch/mips/configs/sead3_defconfig
index deb48fb..23cce81 100644
--- a/arch/mips/configs/sead3_defconfig
+++ b/arch/mips/configs/sead3_defconfig
@@ -15,6 +15,8 @@ CONFIG_PROFILING=y
 CONFIG_OPROFILE=y
 CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="earlycon"
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/mips/mti-sead3/Makefile b/arch/mips/mti-sead3/Makefile
index aad67aa..a58b6d9 100644
--- a/arch/mips/mti-sead3/Makefile
+++ b/arch/mips/mti-sead3/Makefile
@@ -17,5 +17,3 @@ obj-y += sead3-platform.o
 obj-y += sead3-reset.o
 obj-y += sead3-setup.o
 obj-y += sead3-time.o
-
-obj-$(CONFIG_EARLY_PRINTK)	+= sead3-console.o
diff --git a/arch/mips/mti-sead3/sead3-console.c b/arch/mips/mti-sead3/sead3-console.c
deleted file mode 100644
index 031f47d..0000000
--- a/arch/mips/mti-sead3/sead3-console.c
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
- */
-#include <linux/init.h>
-#include <linux/console.h>
-#include <linux/serial_reg.h>
-#include <linux/io.h>
-
-#define SEAD_UART1_REGS_BASE	0xbf000800   /* ttyS1 = DB9 port */
-#define SEAD_UART0_REGS_BASE	0xbf000900   /* ttyS0 = USB port   */
-#define PORT(base_addr, offset) ((unsigned int __iomem *)(base_addr+(offset)*4))
-
-static char console_port = 1;
-
-static inline unsigned int serial_in(int offset, unsigned int base_addr)
-{
-	return __raw_readl(PORT(base_addr, offset)) & 0xff;
-}
-
-static inline void serial_out(int offset, int value, unsigned int base_addr)
-{
-	__raw_writel(value, PORT(base_addr, offset));
-}
-
-void __init fw_init_early_console(char port)
-{
-	console_port = port;
-}
-
-int prom_putchar(char c)
-{
-	unsigned int base_addr;
-
-	base_addr = console_port ? SEAD_UART1_REGS_BASE : SEAD_UART0_REGS_BASE;
-
-	while ((serial_in(UART_LSR, base_addr) & UART_LSR_THRE) == 0)
-		;
-
-	serial_out(UART_TX, c, base_addr);
-
-	return 1;
-}
diff --git a/arch/mips/mti-sead3/sead3-init.c b/arch/mips/mti-sead3/sead3-init.c
index e81f5b7..50f3fcb 100644
--- a/arch/mips/mti-sead3/sead3-init.c
+++ b/arch/mips/mti-sead3/sead3-init.c
@@ -93,12 +93,6 @@ void __init prom_init(void)
 	board_ejtag_handler_setup = mips_ejtag_setup;
 
 	fw_init_cmdline();
-#ifdef CONFIG_EARLY_PRINTK
-	if ((strstr(fw_getcmdline(), "console=ttyS0")) != NULL)
-		fw_init_early_console(0);
-	else if ((strstr(fw_getcmdline(), "console=ttyS1")) != NULL)
-		fw_init_early_console(1);
-#endif
 }
 
 void __init prom_free_prom_memory(void)
-- 
2.9.2
