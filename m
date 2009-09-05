Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Sep 2009 08:23:48 +0200 (CEST)
Received: from mail-pz0-f175.google.com ([209.85.222.175]:58907 "EHLO
	mail-pz0-f175.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491990AbZIEGX3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 5 Sep 2009 08:23:29 +0200
Received: by pzk5 with SMTP id 5so1298489pzk.10
        for <multiple recipients>; Fri, 04 Sep 2009 23:23:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ZX8Rv22A/CSV0BPT4cs57LWDWRAdZmMNuoRjYsQVJ48=;
        b=XkITSgdqO+NfP4JTQxz/Rm52izIJ7qj71qCXlMnNOQF5w8c2BbxyTvbnVbmm4O6se/
         2ZGhXhuJJODFstbpjdSE7zxBiTGF7HzlMCYS1dooobKHq0vu2gJYYjD8tTlczXrvhx6D
         A5C5dGmgf+69IkGA1E5bwt/iCEA8c5e0nVmt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=d4fpaoNtkwgBYlIbC2/CL+suRhwdB+k+3Z4pseLKDuBXKBIRzQUa3aAmoD0KF/ZnQY
         wM/OLMkv8mrk3USBLEN8ddbHXkaiY7XXE1Xdc+YCjeWJ8bYfxvjxuPYq4S7PMhUMCd9o
         8V3vdItfTrQvdXBJx7liND3SlsxSDGr81P/fM=
Received: by 10.115.100.38 with SMTP id c38mr11289382wam.110.1252131800268;
        Fri, 04 Sep 2009 23:23:20 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm95112pxi.10.2009.09.04.23.23.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Sep 2009 23:23:19 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, Jason Wessel <jason.wessel@windriver.com>,
	Zhang Le <r0bertz@gentoo.org>,
	Arnaud Patard <apatard@mandriva.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Wu Zhangjin <wuzj@lemote.com>
Subject: [PATCH 3/3] [loongson] early_printk: add new implmentation
Date:	Sat,  5 Sep 2009 14:23:05 +0800
Message-Id: <1252131785-30112-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

This patch is based on the implementation in the lm2e-fixes branch of
Philippe's git://git.linux-cisco.org/linux-mips.git and the
malta-specific early_printk implementation.

Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
---
 arch/mips/lemote/lm2e/Makefile       |    5 ++++
 arch/mips/lemote/lm2e/early_printk.c |   41 ++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/lemote/lm2e/early_printk.c

diff --git a/arch/mips/lemote/lm2e/Makefile b/arch/mips/lemote/lm2e/Makefile
index b0c0339..f191732 100644
--- a/arch/mips/lemote/lm2e/Makefile
+++ b/arch/mips/lemote/lm2e/Makefile
@@ -4,4 +4,9 @@
 
 obj-y += setup.o prom.o reset.o irq.o pci.o bonito-irq.o mem.o
 
+#
+# Early printk support
+#
+obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
+
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/lemote/lm2e/early_printk.c b/arch/mips/lemote/lm2e/early_printk.c
new file mode 100644
index 0000000..0644506
--- /dev/null
+++ b/arch/mips/lemote/lm2e/early_printk.c
@@ -0,0 +1,41 @@
+/*  early printk support
+ *
+ *  Copyright (c) 2009 Philippe Vachon <philippe@cowpig.ca>
+ *  Copyright (c) 2009 Lemote Inc. & Insititute of Computing Technology
+ *  Author: Wu Zhangjin, wuzj@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/serial_reg.h>
+
+#include <asm/mips-boards/bonito64.h>
+
+#define UART_BASE (BONITO_PCIIO_BASE + 0x3f8)
+
+#define PORT(base, offset) (u8 *)(base + offset)
+
+static inline unsigned int serial_in(unsigned char *base, int offset)
+{
+	return readb(PORT(base, offset));
+}
+
+static inline void serial_out(unsigned char *base, int offset, int value)
+{
+	writeb(value, PORT(base, offset));
+}
+
+void prom_putchar(char c)
+{
+	unsigned char *uart_base =
+		(unsigned char *) ioremap_nocache(UART_BASE, 8);
+
+	while ((serial_in(uart_base, UART_LSR) & UART_LSR_THRE) == 0)
+		;
+
+	serial_out(uart_base, UART_TX, c);
+}
-- 
1.6.2.1
