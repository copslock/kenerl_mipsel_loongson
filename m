Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jul 2007 09:24:40 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:62696 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20022063AbXGVIYi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 22 Jul 2007 09:24:38 +0100
Received: from lagash (88-106-245-10.dynamic.dsl.as9105.com [88.106.245.10])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 17C53BA50B;
	Sun, 22 Jul 2007 09:55:16 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1ICWHb-0006x0-Hj; Sun, 22 Jul 2007 08:55:15 +0100
Date:	Sun, 22 Jul 2007 08:55:15 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] bcm1480 serial build fix
Message-ID: <20070722075515.GB23747@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

The appended patch restores serial functionality for the bcm1480.

I glued this together without reading documentation, so I'm not sure if
it is fully correct. It is good enough to build a kernel and have a
working serial console.


Signed-Off-By: Thiemo Seufer <ths@networkno.de>

diff --git a/drivers/serial/sb1250-duart.c b/drivers/serial/sb1250-duart.c
index 1d9d728..e7f5c0e 100644
--- a/drivers/serial/sb1250-duart.c
+++ b/drivers/serial/sb1250-duart.c
@@ -57,6 +57,12 @@
 #define SBD_CTRLREGS(line)	A_BCM1480_DUART_CTRLREG((line), 0)
 #define SBD_INT(line)		(K_BCM1480_INT_UART_0 + (line))
 
+#define DUART_CHANREG_SPACING	BCM1480_DUART_CHANREG_SPACING
+
+#define R_DUART_IMRREG(line)	R_BCM1480_DUART_IMRREG(line)
+#define R_DUART_INCHREG(line)	R_BCM1480_DUART_INCHREG(line)
+#define R_DUART_ISRREG(line)	R_BCM1480_DUART_ISRREG(line)
+
 #elif defined(CONFIG_SIBYTE_SB1250) || defined(CONFIG_SIBYTE_BCM112X)
 #include <asm/sibyte/sb1250_regs.h>
 #include <asm/sibyte/sb1250_int.h>
diff --git a/include/asm-mips/sibyte/bcm1480_regs.h b/include/asm-mips/sibyte/bcm1480_regs.h
index 2738c13..c34d36b 100644
--- a/include/asm-mips/sibyte/bcm1480_regs.h
+++ b/include/asm-mips/sibyte/bcm1480_regs.h
@@ -227,10 +227,15 @@
 	(A_BCM1480_DUART(chan) +					\
 	 BCM1480_DUART_CHANREG_SPACING * 3 + (reg))
 
+#define DUART_IMRISR_SPACING	    0x20
+#define DUART_INCHNG_SPACING	    0x10
+
 #define R_BCM1480_DUART_IMRREG(chan)					\
 	(R_DUART_IMR_A + ((chan) & 1) * DUART_IMRISR_SPACING)
 #define R_BCM1480_DUART_ISRREG(chan)					\
 	(R_DUART_ISR_A + ((chan) & 1) * DUART_IMRISR_SPACING)
+#define R_BCM1480_DUART_INCHREG(chan)					\
+	(R_DUART_IN_CHNG_A + ((chan) & 1) * DUART_INCHNG_SPACING)
 
 #define A_BCM1480_DUART_IMRREG(chan)					\
 	(A_BCM1480_DUART_CTRLREG((chan), R_BCM1480_DUART_IMRREG(chan)))
