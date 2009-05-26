Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2009 20:05:45 +0100 (BST)
Received: from mail-pz0-f134.google.com ([209.85.222.134]:63697 "EHLO
	mail-pz0-f134.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024652AbZEZTFh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 May 2009 20:05:37 +0100
Received: by pzk40 with SMTP id 40so3718985pzk.22
        for <multiple recipients>; Tue, 26 May 2009 12:05:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=HVDzJfTZ0I1EvoOSLEO/q2yqMsri0zxkisWu82bAa6M=;
        b=x1psnFKJy2cY9zsauv0957+J0Um2QJGXFWYfd99taeleoUwCSGgQkh+mOCe9OBkDwA
         0/lOp5525ytekCr6aVr/6UMnki/jeKMZH4BtU4JOk5yO2Yh/KRWWi3rbaBz3i17oj1jQ
         cb2rQNiQZuS1SbZHWC4+Hve9HpVjxUsVRXpHM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fJcCvzVVh9zw61LNSr1xMbxBA52I0l6a7weMyUPg92V3ymtNerUK/dHZgcN/r2muOK
         nA/zYuFYlSKSyUOEK+giyz/qzr3sZXfRj55MCexW5qUObJRMHZzV8uJ9gX5+AnwYF2Ok
         uRHIaC+Kc0ANp63jWggEFweC3lnbZ8qY5KwXE=
Received: by 10.114.255.1 with SMTP id c1mr17963569wai.4.1243364730310;
        Tue, 26 May 2009 12:05:30 -0700 (PDT)
Received: from localhost.localdomain ([219.246.59.144])
        by mx.google.com with ESMTPS id m30sm9241030wag.53.2009.05.26.12.05.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 May 2009 12:05:28 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [loongson-PATCH-v2 07/23] clean up the early printk support for fuloong(2e)
Date:	Wed, 27 May 2009 03:05:19 +0800
Message-Id: <9f07669eb21eeb2e38c7343179c7382dc4388496.1243362545.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1243362545.git.wuzj@lemote.com>
References: <cover.1243362545.git.wuzj@lemote.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

this is originally from the lm2e-fixes branch of Philippe's
git://git.linux-cisco.org/linux-mips.git

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/fuloong-2e/Makefile       |    7 +-
 arch/mips/loongson/fuloong-2e/dbg_io.c       |  151 --------------------------
 arch/mips/loongson/fuloong-2e/early_printk.c |   28 +++++
 3 files changed, 34 insertions(+), 152 deletions(-)
 delete mode 100644 arch/mips/loongson/fuloong-2e/dbg_io.c
 create mode 100644 arch/mips/loongson/fuloong-2e/early_printk.c

diff --git a/arch/mips/loongson/fuloong-2e/Makefile b/arch/mips/loongson/fuloong-2e/Makefile
index 796e729..035e04c 100644
--- a/arch/mips/loongson/fuloong-2e/Makefile
+++ b/arch/mips/loongson/fuloong-2e/Makefile
@@ -3,6 +3,11 @@
 #
 
 obj-y += setup.o init.o cmdline.o time.o reset.o irq.o \
-	pci.o bonito-irq.o dbg_io.o mem.o misc.o
+	pci.o bonito-irq.o mem.o misc.o
+
+#
+# Early printk support
+#
+obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/loongson/fuloong-2e/dbg_io.c b/arch/mips/loongson/fuloong-2e/dbg_io.c
deleted file mode 100644
index 1ace08f..0000000
--- a/arch/mips/loongson/fuloong-2e/dbg_io.c
+++ /dev/null
@@ -1,151 +0,0 @@
-/*
- * Copyright 2001 MontaVista Software Inc.
- * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
- * Copyright (C) 2000, 2001 Ralf Baechle (ralf@gnu.org)
- *
- * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
- * Author: Fuxin Zhang, zhangfx@lemote.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-#include <linux/types.h>
-
-#include <asm/serial.h>
-
-#include <loongson.h>
-#include <machine.h>
-
-#define         UART16550_BAUD_2400             2400
-#define         UART16550_BAUD_4800             4800
-#define         UART16550_BAUD_9600             9600
-#define         UART16550_BAUD_19200            19200
-#define         UART16550_BAUD_38400            38400
-#define         UART16550_BAUD_57600            57600
-#define         UART16550_BAUD_115200           115200
-
-#define         UART16550_PARITY_NONE           0
-#define         UART16550_PARITY_ODD            0x08
-#define         UART16550_PARITY_EVEN           0x18
-#define         UART16550_PARITY_MARK           0x28
-#define         UART16550_PARITY_SPACE          0x38
-
-#define         UART16550_DATA_5BIT             0x0
-#define         UART16550_DATA_6BIT             0x1
-#define         UART16550_DATA_7BIT             0x2
-#define         UART16550_DATA_8BIT             0x3
-
-#define         UART16550_STOP_1BIT             0x0
-#define         UART16550_STOP_2BIT             0x4
-
-/* ----------------------------------------------------- */
-
-/* === CONFIG === */
-
-#define		BASE			ioremap_nocache(LOONGSON_UART_BASE, 8)
-
-#define         MAX_BAUD                BASE_BAUD
-/* === END OF CONFIG === */
-
-#define         REG_OFFSET              1
-
-/* register offset */
-#define         OFS_RCV_BUFFER          0
-#define         OFS_TRANS_HOLD          0
-#define         OFS_SEND_BUFFER         0
-#define         OFS_INTR_ENABLE         (1*REG_OFFSET)
-#define         OFS_INTR_ID             (2*REG_OFFSET)
-#define         OFS_DATA_FORMAT         (3*REG_OFFSET)
-#define         OFS_LINE_CONTROL        (3*REG_OFFSET)
-#define         OFS_MODEM_CONTROL       (4*REG_OFFSET)
-#define         OFS_RS232_OUTPUT        (4*REG_OFFSET)
-#define         OFS_LINE_STATUS         (5*REG_OFFSET)
-#define         OFS_MODEM_STATUS        (6*REG_OFFSET)
-#define         OFS_RS232_INPUT         (6*REG_OFFSET)
-#define         OFS_SCRATCH_PAD         (7*REG_OFFSET)
-
-#define         OFS_DIVISOR_LSB         (0*REG_OFFSET)
-#define         OFS_DIVISOR_MSB         (1*REG_OFFSET)
-
-/* memory-mapped read/write of the port */
-#define         UART16550_READ(y)	readb((char *)BASE + (y))
-#define         UART16550_WRITE(y, z)	writeb(z, (char *)BASE + (y))
-
-void debugInit(u32 baud, u8 data, u8 parity, u8 stop)
-{
-	u32 divisor;
-
-	/* disable interrupts */
-	UART16550_WRITE(OFS_INTR_ENABLE, 0);
-
-	/* set up buad rate */
-	/* set DIAB bit */
-	UART16550_WRITE(OFS_LINE_CONTROL, 0x80);
-
-	/* set divisor */
-	divisor = MAX_BAUD / baud;
-	UART16550_WRITE(OFS_DIVISOR_LSB, divisor & 0xff);
-	UART16550_WRITE(OFS_DIVISOR_MSB, (divisor & 0xff00) >> 8);
-
-	/* clear DIAB bit */
-	UART16550_WRITE(OFS_LINE_CONTROL, 0x0);
-
-	/* set data format */
-	UART16550_WRITE(OFS_DATA_FORMAT, data | parity | stop);
-}
-
-static int remoteDebugInitialized;
-
-u8 getDebugChar(void)
-{
-	if (!remoteDebugInitialized) {
-		remoteDebugInitialized = 1;
-		debugInit(UART16550_BAUD_115200,
-			  UART16550_DATA_8BIT,
-			  UART16550_PARITY_NONE, UART16550_STOP_1BIT);
-	}
-
-	while ((UART16550_READ(OFS_LINE_STATUS) & 0x1) == 0)
-		;
-	return UART16550_READ(OFS_RCV_BUFFER);
-}
-
-int putDebugChar(u8 byte)
-{
-	if (!remoteDebugInitialized) {
-		remoteDebugInitialized = 1;
-		/*
-		   debugInit(UART16550_BAUD_115200,
-		   UART16550_DATA_8BIT,
-		   UART16550_PARITY_NONE, UART16550_STOP_1BIT); */
-	}
-
-	while ((UART16550_READ(OFS_LINE_STATUS) & 0x20) == 0)
-		;
-	UART16550_WRITE(OFS_SEND_BUFFER, byte);
-	return 1;
-}
-
-void prom_putchar(char c)
-{
-	putDebugChar(c);
-}
diff --git a/arch/mips/loongson/fuloong-2e/early_printk.c b/arch/mips/loongson/fuloong-2e/early_printk.c
new file mode 100644
index 0000000..9f4b881
--- /dev/null
+++ b/arch/mips/loongson/fuloong-2e/early_printk.c
@@ -0,0 +1,28 @@
+/*  early printk support
+ *
+ *  Copyright (c) 2009 Philippe Vachon <philippe@cowpig.ca>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/serial_reg.h>
+
+#include <loongson.h>
+#include <machine.h>
+
+void prom_putchar(char c)
+{
+	int timeout;
+	phys_addr_t uart_base =
+	    (phys_addr_t) ioremap_nocache(LOONGSON_UART_BASE, 8);
+	char reg = readb((u8 *) (uart_base + UART_LSR)) & UART_LSR_THRE;
+
+	for (timeout = 1024; reg == 0 && timeout > 0; timeout--)
+		reg = readb((u8 *) (uart_base + UART_LSR)) & UART_LSR_THRE;
+
+	writeb(c, (u8 *) (uart_base + UART_TX));
+}
-- 
1.6.0.4
