Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 23:05:06 +0100 (BST)
Received: from mail-px0-f119.google.com ([209.85.216.119]:44588 "EHLO
	mail-px0-f119.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023334AbZEOWFB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 23:05:01 +0100
Received: by pxi17 with SMTP id 17so1365445pxi.22
        for <multiple recipients>; Fri, 15 May 2009 15:04:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=9NZ+lGCgtr7ED1YBLg46YjJ4JIaxKsVmui+5tdam75A=;
        b=tp+mga+lyQyVwv/y97oRgDyb86MKwlKkURvqbdi4nUTSFACLMTgYQV0d+GVP+1KgiX
         QN4hpOLuoJAUAa44QLT8By1s0jShmdVJFEdrixNy+03i6826ggPFQy55dqSKShRTXR2O
         FSiBQ/8xrCVjJ6/d+LUoY04M+CHfVX7TpnQM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=tdwbQBCcX+X0d2v7Xr5tJlEad8gc3V4tk4yqlG/UQeY7I7vz4jM2WgRnkJ/do56THS
         YkZVHxFw6BZ/REMvM6/ds4V5Ppx+v6jdQnl/2igHNE/eiIPZF4qIkNf3SGaRKtsle7lZ
         OxCfQAQAAH99v17Skxv+sXdBtXV8c3+j1P7J0=
Received: by 10.114.152.7 with SMTP id z7mr5551836wad.198.1242425093355;
        Fri, 15 May 2009 15:04:53 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id c26sm1975093waa.50.2009.05.15.15.04.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 15:04:52 -0700 (PDT)
Subject: [PATCH 08/30] loongson: clean up the early printk support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 16 May 2009 06:04:46 +0800
Message-Id: <1242425086.10164.148.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

>From 01a6928a3abf3c9130554c594ff1b8c0878e1fc5 Mon Sep 17 00:00:00 2001
From: Wu Zhangjin <wuzhangjin@gmail.com>
Date: Sat, 16 May 2009 00:44:11 +0800
Subject: [PATCH 08/30] loongson: clean up the early printk support of
fuloong(2e)

this is picked from the lm2e-fixes branch of
Philippe's git://git.linux-cisco.org/linux-mips.git
---
 arch/mips/loongson/fuloong-2e/Makefile       |    7 +-
 arch/mips/loongson/fuloong-2e/dbg_io.c       |  150
--------------------------
 arch/mips/loongson/fuloong-2e/early_printk.c |   28 +++++
 3 files changed, 34 insertions(+), 151 deletions(-)
 delete mode 100644 arch/mips/loongson/fuloong-2e/dbg_io.c
 create mode 100644 arch/mips/loongson/fuloong-2e/early_printk.c

diff --git a/arch/mips/loongson/fuloong-2e/Makefile
b/arch/mips/loongson/fuloong-2e/Makefile
index 796e729..88002a6 100644
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
diff --git a/arch/mips/loongson/fuloong-2e/dbg_io.c
b/arch/mips/loongson/fuloong-2e/dbg_io.c
deleted file mode 100644
index 3eab7e6..0000000
--- a/arch/mips/loongson/fuloong-2e/dbg_io.c
+++ /dev/null
@@ -1,150 +0,0 @@
-/*
- * Copyright 2001 MontaVista Software Inc.
- * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
- * Copyright (C) 2000, 2001 Ralf Baechle (ralf@gnu.org)
- *
- * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
- * Author: Fuxin Zhang, zhangfx@lemote.com
- *
- *  This program is free software; you can redistribute  it and/or
modify it
- *  under  the terms of  the GNU General  Public License as published
by the
- *  Free Software Foundation;  either version 2 of the  License, or (at
your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR
IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED
WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT,
INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES;
LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED
AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR
TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License
along
- *  with this program; if not, write  to the Free Software Foundation,
Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-#include <linux/io.h>
-#include <linux/init.h>
-#include <linux/types.h>
-
-#include <asm/serial.h>
-
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
-	while ((UART16550_READ(OFS_LINE_STATUS) & 0x1) == 0) ;
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
-	while ((UART16550_READ(OFS_LINE_STATUS) & 0x20) == 0) ;
-	UART16550_WRITE(OFS_SEND_BUFFER, byte);
-	return 1;
-}
-
-void prom_putchar(char c)
-{
-	putDebugChar(c);
-}
diff --git a/arch/mips/loongson/fuloong-2e/early_printk.c
b/arch/mips/loongson/fuloong-2e/early_printk.c
new file mode 100644
index 0000000..3f6c1db
--- /dev/null
+++ b/arch/mips/loongson/fuloong-2e/early_printk.c
@@ -0,0 +1,28 @@
+/*  early printk support 
+ *
+ *  Copyright (c) 2009 Philippe Vachon <philippe@cowpig.ca>
+ *
+ *  This program is free software; you can redistribute  it and/or
modify it
+ *  under  the terms of  the GNU General  Public License as published
by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at
your
+ *  option) any later version.
+ */
+
+#include <linux/io.h>
+#include <linux/types.h>
+#include <linux/serial_reg.h>
+
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
1.6.2.1
