Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2010 13:02:15 +0100 (CET)
Received: from mail-yw0-f186.google.com ([209.85.211.186]:43699 "EHLO
        mail-yw0-f186.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491133Ab0BHMCK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2010 13:02:10 +0100
Received: by ywh16 with SMTP id 16so523252ywh.25
        for <multiple recipients>; Mon, 08 Feb 2010 04:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=biM2rjen1oz2RAHwA1L78YognwZUQUhj5xoPxnjeLz4=;
        b=DKidSaLdt7v5hiXbrIwu7UQFmxKcvtUaJ6jXN3M52PRsNo3AHCllXddGVx2pdPVaub
         iH4CTTV1Nz6QTD9cjzFNxyvePYeEJqeRsrwWj50t2F+FiL2nLLjR4WyU7H22K1wo0MKy
         +STF1Gn5PoOihjWZC4eQFluOPHb2EMEuRh/Ns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=X/yu5To12XwvAg31Jf9eaY5d1LYozW2e73JL93WSPxja5mfjc7DDwCNB9tBE9dTfj5
         s7czQGlTj+jszVOzNWEAW1CSH6QZZm6CPa/Kq/Hkp+OMcs+zjFP6L1Yaxac6Bvq3thgh
         8YGm7KBIvff3zrfplfFN0Bxrq/bPVgGvRsOEU=
Received: by 10.101.119.13 with SMTP id w13mr7901817anm.216.1265630522135;
        Mon, 08 Feb 2010 04:02:02 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 15sm2873416gxk.0.2010.02.08.04.01.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Feb 2010 04:02:01 -0800 (PST)
Date:   Mon, 8 Feb 2010 20:59:39 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH -queue v2 1/2] MIPS: add 8250/16550 serial early printk
 driver
Message-Id: <20100208205939.18497103.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/Kconfig.debug              |    8 ++++
 arch/mips/include/asm/setup.h        |    9 +++++
 arch/mips/kernel/Makefile            |    1 +
 arch/mips/kernel/early_printk_8250.c |   66 ++++++++++++++++++++++++++++++++++
 4 files changed, 84 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/kernel/early_printk_8250.c

diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
index 32a010d..0cceaad 100644
--- a/arch/mips/Kconfig.debug
+++ b/arch/mips/Kconfig.debug
@@ -20,6 +20,14 @@ config EARLY_PRINTK
 	  doesn't cooperate with an X server. You should normally say N here,
 	  unless you want to debug such a crash.
 
+config EARLY_PRINTK_8250
+	bool "8250/16550 and compatible serial early printk driver"
+	depends on EARLY_PRINTK
+	default n
+	help
+	  If you say Y here, it will be possible to use a 8250/16550 serial
+	  port as the boot console.
+
 config CMDLINE_BOOL
 	bool "Built-in kernel command line"
 	default n
diff --git a/arch/mips/include/asm/setup.h b/arch/mips/include/asm/setup.h
index 50511aa..7395b7f 100644
--- a/arch/mips/include/asm/setup.h
+++ b/arch/mips/include/asm/setup.h
@@ -5,6 +5,15 @@
 
 #ifdef  __KERNEL__
 extern void setup_early_printk(void);
+
+#ifdef CONFIG_EARLY_PRINTK_8250
+extern void setup_8250_early_printk_port(unsigned long base,
+				unsigned int reg_shift, unsigned int timeout);
+#else
+static inline void setup_8250_early_printk_port(unsigned long base,
+				unsigned int reg_shift, unsigned int timeout) {}
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif /* __SETUP_H */
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 9326af5..03fc037 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -93,6 +93,7 @@ obj-$(CONFIG_GPIO_TXX9)		+= gpio_txx9.o
 
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
+obj-$(CONFIG_EARLY_PRINTK_8250)	+= early_printk_8250.o
 
 CFLAGS_cpu-bugs64.o	= $(shell if $(CC) $(KBUILD_CFLAGS) -Wa,-mdaddi -c -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-DHAVE_AS_SET_DADDI"; fi)
 
diff --git a/arch/mips/kernel/early_printk_8250.c b/arch/mips/kernel/early_printk_8250.c
new file mode 100644
index 0000000..83cea37
--- /dev/null
+++ b/arch/mips/kernel/early_printk_8250.c
@@ -0,0 +1,66 @@
+/*
+ *  8250/16550-type serial ports prom_putchar()
+ *
+ *  Copyright (C) 2010  Yoichi Yuasa <yuasa@linux-mips.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+#include <linux/io.h>
+#include <linux/serial_core.h>
+#include <linux/serial_reg.h>
+
+static void __iomem *serial8250_base;
+static unsigned int serial8250_reg_shift;
+static unsigned int serial8250_tx_timeout;
+
+void setup_8250_early_printk_port(unsigned long base, unsigned int reg_shift,
+				  unsigned int timeout)
+{
+	serial8250_base = (void __iomem *)base;
+	serial8250_reg_shift = reg_shift;
+	serial8250_tx_timeout = timeout;
+}
+
+static inline u8 serial_in(int offset)
+{
+	return readb(serial8250_base + (offset << serial8250_reg_shift));
+}
+
+static inline void serial_out(int offset, char value)
+{
+	writeb(value, serial8250_base + (offset << serial8250_reg_shift));
+}
+
+void prom_putchar(char c)
+{
+	unsigned int timeout;
+	int status, bits;
+
+	if (!serial8250_base)
+		return;
+
+	timeout = serial8250_tx_timeout;
+	bits = UART_LSR_TEMT | UART_LSR_THRE;
+
+	do {
+		status = serial_in(UART_LSR);
+
+		if (--timeout == 0)
+			break;
+	} while ((status & bits) != bits);
+
+	if (timeout)
+		serial_out(UART_TX, c);
+}
-- 
1.6.6.1
