Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Oct 2006 11:49:52 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:60168 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037784AbWJAKs7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 1 Oct 2006 11:48:59 +0100
Received: by mo.po.2iij.net (mo30) id k91Amvd8011953; Sun, 1 Oct 2006 19:48:57 +0900 (JST)
Received: from localhost.localdomain (34.26.30.125.dy.iij4u.or.jp [125.30.26.34])
	by mbox.po.2iij.net (mbox30) id k91Amr4F090877
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 1 Oct 2006 19:48:53 +0900 (JST)
Date:	Sun, 1 Oct 2006 19:47:08 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 3/3] remove unused galileo-boars header files
Message-Id: <20061001194708.23bc7991.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20061001194327.02fceb06.yoichi_yuasa@tripeaks.co.jp>
References: <20061001193528.003d01d8.yoichi_yuasa@tripeaks.co.jp>
	<20061001194327.02fceb06.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has removed unused galileo-boards header files.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/galileo-boards/ev96100.h mips/include/asm-mips/galileo-boards/ev96100.h
--- mips-orig/include/asm-mips/galileo-boards/ev96100.h	2006-10-01 16:12:37.713494500 +0900
+++ mips/include/asm-mips/galileo-boards/ev96100.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,55 +0,0 @@
-/*
- *
- */
-#ifndef _MIPS_EV96100_H
-#define _MIPS_EV96100_H
-
-#include <asm/addrspace.h>
-
-/*
- *   GT64120 config space base address
- */
-#define GT64120_BASE	(KSEG1ADDR(0x14000000))
-#define MIPS_GT_BASE	GT64120_BASE
-
-/*
- *   PCI Bus allocation
- */
-#define GT_PCI_MEM_BASE    0x12000000UL
-#define GT_PCI_MEM_SIZE    0x02000000UL
-#define GT_PCI_IO_BASE     0x10000000UL
-#define GT_PCI_IO_SIZE     0x02000000UL
-#define GT_ISA_IO_BASE     PCI_IO_BASE
-
-/*
- *   Duart I/O ports.
- */
-#define EV96100_COM1_BASE_ADDR 	(0xBD000000 + 0x20)
-#define EV96100_COM2_BASE_ADDR	(0xBD000000 + 0x00)
-
-
-/*
- *   EV96100 interrupt controller register base.
- */
-#define EV96100_ICTRL_REGS_BASE	(KSEG1ADDR(0x1f000000))
-
-/*
- *   EV96100 UART register base.
- */
-#define EV96100_UART0_REGS_BASE	EV96100_COM1_BASE_ADDR
-#define EV96100_UART1_REGS_BASE	EV96100_COM2_BASE_ADDR
-#define EV96100_BASE_BAUD	( 3686400 / 16 )
-
-
-/*
- * Because of an error/peculiarity in the Galileo chip, we need to swap the
- * bytes when running bigendian.
- */
-#define __GT_READ(ofs)							\
-	(*(volatile u32 *)(GT64120_BASE+(ofs)))
-#define __GT_WRITE(ofs, data)						\
-	do { *(volatile u32 *)(GT64120_BASE+(ofs)) = (data); } while (0)
-#define GT_READ(ofs)		le32_to_cpu(__GT_READ(ofs))
-#define GT_WRITE(ofs, data)	__GT_WRITE(ofs, cpu_to_le32(data))
-
-#endif /* !(_MIPS_EV96100_H) */
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/galileo-boards/ev96100int.h mips/include/asm-mips/galileo-boards/ev96100int.h
--- mips-orig/include/asm-mips/galileo-boards/ev96100int.h	2006-10-01 16:12:37.713494500 +0900
+++ mips/include/asm-mips/galileo-boards/ev96100int.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,12 +0,0 @@
-/*
- *
- */
-#ifndef _MIPS_EV96100INT_H
-#define _MIPS_EV96100INT_H
-
-#define EV96100INT_UART_0    6     /* IP 6 */
-#define EV96100INT_TIMER     7     /* IP 7 */
-
-extern void ev96100int_init(void);
-
-#endif /* !(_MIPS_EV96100_H) */
