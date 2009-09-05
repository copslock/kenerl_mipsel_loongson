Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Sep 2009 08:23:16 +0200 (CEST)
Received: from mail-px0-f174.google.com ([209.85.216.174]:38723 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491851AbZIEGXF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 5 Sep 2009 08:23:05 +0200
Received: by pxi4 with SMTP id 4so1255344pxi.21
        for <multiple recipients>; Fri, 04 Sep 2009 23:22:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=PyW0Z6+IxnNDroMSkxheBj1Iqe8X/Ckmpd1okuMdPys=;
        b=h/0DxgEX4I37Nm78vwnop/MT2UEQAz6xb0Yp9XAQbJ1NoSVBpnyak78MVjQda4DdqI
         jIdPKoMriKOtcTQu9x3S6sExxEIjXMJHG7eIo2O5wvqnW0mSTwRLUnjAq1+LoVN4giEq
         PyO77v+8Mdg4lM5SOe0SFzaZEy49nYBdEXWjg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=gww4YloPnh/xAht3RlSE36iFuiL3KcklH3cMUr9OHnRZNgr+vKOEuabiej/4kNniF7
         QGL3OymBXqacSugxojZea54JCSZUCcH48w8TXDgwycp4ICBalMGOmK0yJJG0PguU4aeN
         +LLWBiknmL1CuYjTzw9zlV0Or3fIij6Kh8Skk=
Received: by 10.115.144.7 with SMTP id w7mr11217324wan.228.1252131777932;
        Fri, 04 Sep 2009 23:22:57 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm755922pzk.1.2009.09.04.23.22.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Sep 2009 23:22:57 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, Jason Wessel <jason.wessel@windriver.com>,
	Zhang Le <r0bertz@gentoo.org>,
	Arnaud Patard <apatard@mandriva.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Wu Zhangjin <wuzj@lemote.com>
Subject: [PATCH 2/3] [loongson] kgdb: Remove out-of-date board-specific source code
Date:	Sat,  5 Sep 2009 14:22:45 +0800
Message-Id: <1252131765-30075-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

as the commit: 8854700115ecf8aa6f087aa915b7b6cf18090d39 shows, the new
mips-specific kgdb implementation not need this board-specific source
code, just remove it.

Acked-by: Jason Wessel <jason.wessel@windriver.com>
Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
---
 arch/mips/lemote/lm2e/Makefile |    2 +-
 arch/mips/lemote/lm2e/dbg_io.c |  146 ----------------------------------------
 2 files changed, 1 insertions(+), 147 deletions(-)
 delete mode 100644 arch/mips/lemote/lm2e/dbg_io.c

diff --git a/arch/mips/lemote/lm2e/Makefile b/arch/mips/lemote/lm2e/Makefile
index d34671d..b0c0339 100644
--- a/arch/mips/lemote/lm2e/Makefile
+++ b/arch/mips/lemote/lm2e/Makefile
@@ -2,6 +2,6 @@
 # Makefile for Lemote Fulong mini-PC board.
 #
 
-obj-y += setup.o prom.o reset.o irq.o pci.o bonito-irq.o dbg_io.o mem.o
+obj-y += setup.o prom.o reset.o irq.o pci.o bonito-irq.o mem.o
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/lemote/lm2e/dbg_io.c b/arch/mips/lemote/lm2e/dbg_io.c
deleted file mode 100644
index 6c95da3..0000000
--- a/arch/mips/lemote/lm2e/dbg_io.c
+++ /dev/null
@@ -1,146 +0,0 @@
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
-#include <linux/io.h>
-#include <linux/init.h>
-#include <linux/types.h>
-
-#include <asm/serial.h>
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
-#ifdef CONFIG_64BIT
-#define         BASE                    (0xffffffffbfd003f8)
-#else
-#define         BASE                    (0xbfd003f8)
-#endif
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
-- 
1.6.2.1
