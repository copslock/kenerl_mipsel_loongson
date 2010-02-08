Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2010 13:02:39 +0100 (CET)
Received: from mail-yw0-f186.google.com ([209.85.211.186]:52095 "EHLO
        mail-yw0-f186.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491098Ab0BHMCP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2010 13:02:15 +0100
Received: by ywh16 with SMTP id 16so523322ywh.25
        for <multiple recipients>; Mon, 08 Feb 2010 04:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=toRsyyfK3NJNbwu0r8axAZVHDTeeSKh5qnVNH6rvKfw=;
        b=Y0KZOelksMpLQ/1offPLYPvAgcOyzJRQwtJKXjrLI7ocZpZryPp5yx6VFzwREj0d0I
         C2/V06DAnv8mqcm6Sg9st67t2K8OmKX1iNgjVzmQX5W0AmPRhji9JYZtKrWpiPN8Gajg
         oLjKpFJN/c82wwwsxkRz3srG+CjaaJuJg0azc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        b=hiiMNQar5e2v1d34EhvCHH+d3/e6J8e+ng6mpB0PFcBTCj6/SPhnCrtUpqVF8ft3Yy
         iLZxBFXuVG6+wVQyWrItOep/Tnn4bht3KyqE4E89FZL2wCywYDPWLoADPFpxAC20nR5Z
         PGCqLt/fzsBR0tGVXmKprC/oXpbqB5hhVXYMI=
Received: by 10.91.97.14 with SMTP id z14mr444573agl.0.1265630527941;
        Mon, 08 Feb 2010 04:02:07 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 16sm2852464gxk.11.2010.02.08.04.02.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Feb 2010 04:02:06 -0800 (PST)
Date:   Mon, 8 Feb 2010 21:01:22 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH -queue v2 2/2] MIPS: Cobalt move to 8250/16550 serial early
 printk driver
Message-Id: <20100208210122.e9446803.yuasa@linux-mips.org>
In-Reply-To: <20100208205939.18497103.yuasa@linux-mips.org>
References: <20100208205939.18497103.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25897
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
