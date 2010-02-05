Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Feb 2010 15:32:19 +0100 (CET)
Received: from mail-bw0-f226.google.com ([209.85.218.226]:65145 "EHLO
        mail-bw0-f226.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492327Ab0BEObw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Feb 2010 15:31:52 +0100
Received: by mail-bw0-f226.google.com with SMTP id 26so2930219bwz.27
        for <multiple recipients>; Fri, 05 Feb 2010 06:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=toRsyyfK3NJNbwu0r8axAZVHDTeeSKh5qnVNH6rvKfw=;
        b=awt7HKi3ZObqsUcFYSxNpEuaArKOq//UPnnRHj+7vrMce/nJsSuLsGxY6yZNKOn9td
         ABMfebMMqL5KzYsN8cCZkv039Rq7EWOH4JpDOThMkiqTF3Il1quI5wmjockq30H6E7U8
         fBoEYA9n0Z7KJHb/aowgK4SMAcd6u+zFAbckE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        b=rQLNDnIZsHZ21r/dwkyDuLf5NVXlfKlJbvPW4mZ6I6cHUkgNaf6baHLNoIN7vixGRe
         SHA0kganF2PyR1yU+60k2McDjh2sFBKUyqvkIu8hUeH7ZM/LZoEaB+p1ZtFardcwVyXK
         S/cIon9z9VCZyGr0/gM8yLsL9IdQNP1NcCBRA=
Received: by 10.204.33.135 with SMTP id h7mr250859bkd.186.1265380312701;
        Fri, 05 Feb 2010 06:31:52 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 13sm647328bwz.6.2010.02.05.06.31.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Feb 2010 06:31:52 -0800 (PST)
Date:   Fri, 5 Feb 2010 23:30:31 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2/2] MIPS: Cobalt move to 8250/16550 serial early printk
 driver
Message-Id: <20100205233031.38c5d6be.yuasa@linux-mips.org>
In-Reply-To: <20100205232857.eb65967f.yuasa@linux-mips.org>
References: <20100205232857.eb65967f.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/Kconfig          |    1 +
 arch/mips/cobalt/Makefile  |    1 -
 arch/mips/cobalt/console.c |   20 --------------------
 arch/mips/cobalt/setup.c   |    3 +++
 4 files changed, 4 insertions(+), 21 deletions(-)
 delete mode 100644 arch/mips/cobalt/console.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 591ca0c..b848512 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -90,6 +90,7 @@ config MIPS_COBALT
 	select CSRC_R4K
 	select CEVT_GT641XX
 	select DMA_NONCOHERENT
+	select EARLY_PRINTK_8250 if EARLY_PRINTK
 	select HW_HAS_PCI
 	select I8253
 	select I8259
diff --git a/arch/mips/cobalt/Makefile b/arch/mips/cobalt/Makefile
index 2379262..5cfe90f 100644
--- a/arch/mips/cobalt/Makefile
+++ b/arch/mips/cobalt/Makefile
@@ -5,7 +5,6 @@
 obj-y := buttons.o irq.o lcd.o led.o reset.o rtc.o serial.o setup.o time.o
 
 obj-$(CONFIG_PCI)		+= pci.o
-obj-$(CONFIG_EARLY_PRINTK)	+= console.o
 obj-$(CONFIG_MTD_PHYSMAP)	+= mtd.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/cobalt/console.c b/arch/mips/cobalt/console.c
deleted file mode 100644
index d1ba701..0000000
--- a/arch/mips/cobalt/console.c
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * (C) P. Horton 2006
- */
-#include <linux/io.h>
-#include <linux/serial_reg.h>
-
-#include <cobalt.h>
-
-#define UART_BASE	((void __iomem *)CKSEG1ADDR(0x1c800000))
-
-void prom_putchar(char c)
-{
-	if (cobalt_board_id <= COBALT_BRD_ID_QUBE1)
-		return;
-
-	while (!(readb(UART_BASE + UART_LSR) & UART_LSR_THRE))
-		;
-
-	writeb(c, UART_BASE + UART_TX);
-}
diff --git a/arch/mips/cobalt/setup.c b/arch/mips/cobalt/setup.c
index ec3b2c4..9a8c2fe 100644
--- a/arch/mips/cobalt/setup.c
+++ b/arch/mips/cobalt/setup.c
@@ -17,6 +17,7 @@
 
 #include <asm/bootinfo.h>
 #include <asm/reboot.h>
+#include <asm/setup.h>
 #include <asm/gt64120.h>
 
 #include <cobalt.h>
@@ -112,6 +113,8 @@ void __init prom_init(void)
 	}
 
 	add_memory_region(0x0, memsz, BOOT_MEM_RAM);
+
+	setup_8250_early_printk_port(CKSEG1ADDR(0x1c800000), 0, 0);
 }
 
 void __init prom_free_prom_memory(void)
-- 
1.6.6.1
