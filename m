Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 07:09:34 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:11273
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133374AbVJTGJS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 07:09:18 +0100
Received: from dl2.hq2.avtrex.com (dl2.hq2.avtrex.com [127.0.0.1])
	by avtrex.com (8.13.1/8.13.1) with ESMTP id j9K69HF5001302
	for <linux-mips@linux-mips.org>; Wed, 19 Oct 2005 23:09:17 -0700
Received: (from daney@localhost)
	by dl2.hq2.avtrex.com (8.13.1/8.13.1/Submit) id j9K69HL4001299;
	Wed, 19 Oct 2005 23:09:17 -0700
From:	David Daney <ddaney@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17239.13453.275150.919351@dl2.hq2.avtrex.com>
Date:	Wed, 19 Oct 2005 23:09:17 -0700
To:	linux-mips@linux-mips.org
Subject: Patch: ATI Xilleon port 5/11 Xilleon serial port definitions
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: ddaney@avtrex.com
Return-Path: <daney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

This is the fifth part of my Xilleon port.

This patch adds definitions for the Xilleon's serial ports.

Patch against 2.6.14-rc2 from linux-mips.org

Signed-off-by: David Daney <ddaney@avtrex.com>

Add Xilleon serial port definitions.

---
commit 33019afad122415869a7a0b2f2a3600249c55704
tree 26526fc552934a5abf2b112dadac9fb9cbd2f8cb
parent 43a5e067ae126cee417017e8c69dfde18b82e670
author David Daney <daney@dl2.hq2.avtrex.com> Tue, 04 Oct 2005 13:44:30 -0700
committer David Daney <daney@dl2.hq2.avtrex.com> Tue, 04 Oct 2005 13:44:30 -0700

 include/asm-mips/serial.h |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/include/asm-mips/serial.h b/include/asm-mips/serial.h
--- a/include/asm-mips/serial.h
+++ b/include/asm-mips/serial.h
@@ -185,6 +185,28 @@
 #define AU1000_SERIAL_PORT_DEFNS
 #endif
 
+#ifdef CONFIG_ATI_XILLEON
+
+#include <asm/mach-xilleon/xilleon.h>
+#include <asm/mach-xilleon/xilleonint.h>
+#define XILLEON_SERIAL_PORT_DEFNS                  \
+	{ .baud_base = XILLEON_BASE_BAUD, \
+          .port = XILLEON_UART0_REGS_BASE, \
+          .iomem_base = (unsigned char *)XILLEON_UART0_REGS_BASE, \
+          .irq =XILLEON_UART1_INT, \
+	  .flags = STD_COM_FLAGS, \
+          .io_type = SERIAL_IO_MEM },      \
+	{ .baud_base = XILLEON_BASE_BAUD, \
+          .port = XILLEON_UART1_REGS_BASE, \
+          .iomem_base = (unsigned char *)XILLEON_UART1_REGS_BASE, \
+          .irq = XILLEON_UART2_INT, \
+	  .flags = STD_COM_FLAGS, \
+          .io_type = SERIAL_IO_MEM},
+
+#else
+#define XILLEON_SERIAL_PORT_DEFNS
+#endif
+
 #ifdef CONFIG_HAVE_STD_PC_SERIAL_PORT
 #define STD_SERIAL_PORT_DEFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
@@ -332,6 +354,7 @@
 	MOMENCO_OCELOT_C_SERIAL_PORT_DEFNS		\
 	MOMENCO_OCELOT_SERIAL_PORT_DEFNS		\
 	MOMENCO_OCELOT_3_SERIAL_PORT_DEFNS		\
-	AU1000_SERIAL_PORT_DEFNS
+	AU1000_SERIAL_PORT_DEFNS                        \
+        XILLEON_SERIAL_PORT_DEFNS
 
 #endif /* _ASM_SERIAL_H */
