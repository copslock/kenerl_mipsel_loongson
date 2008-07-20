Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Jul 2008 14:04:15 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:49695 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28591776AbYGTNDw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 20 Jul 2008 14:03:52 +0100
Received: by mo.po.2iij.net (mo31) id m6KD3mbV042945; Sun, 20 Jul 2008 22:03:48 +0900 (JST)
Received: from delta (16.26.30.125.dy.iij4u.or.jp [125.30.26.16])
	by mbox.po.2iij.net (po-mbox305) id m6KD3i6j009891
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 20 Jul 2008 22:03:45 +0900
Date:	Sun, 20 Jul 2008 22:01:06 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove unused saa9730_uart.h
Message-Id: <20080720220106.bdb501a4.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Remove unused saa9730_uart.h.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/include/asm-mips/mips-boards/saa9730_uart.h linux/include/asm-mips/mips-boards/saa9730_uart.h
--- linux-orig/include/asm-mips/mips-boards/saa9730_uart.h	2008-07-18 10:53:59.448363041 +0900
+++ linux/include/asm-mips/mips-boards/saa9730_uart.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,69 +0,0 @@
-/*
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
- *
- * ########################################################################
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * ########################################################################
- *
- * Register definitions for the UART part of the Philips SAA9730 chip.
- *
- */
-
-#ifndef SAA9730_UART_H
-#define SAA9730_UART_H
-
-/* The SAA9730 UART register map, as seen via the PCI bus */
-
-#define SAA9730_UART_REGS_ADDR	0x21800
-
-struct uart_saa9730_regmap {
-	volatile unsigned char Thr_Rbr;
-	volatile unsigned char Ier;
-	volatile unsigned char Iir_Fcr;
-	volatile unsigned char Lcr;
-	volatile unsigned char Mcr;
-	volatile unsigned char Lsr;
-	volatile unsigned char Msr;
-	volatile unsigned char Scr;
-	volatile unsigned char BaudDivLsb;
-	volatile unsigned char BaudDivMsb;
-	volatile unsigned char Junk0;
-	volatile unsigned char Junk1;
-	volatile unsigned int Config;		/* 0x2180c */
-	volatile unsigned int TxStart;		/* 0x21810 */
-	volatile unsigned int TxLength;		/* 0x21814 */
-	volatile unsigned int TxCounter;	/* 0x21818 */
-	volatile unsigned int RxStart;		/* 0x2181c */
-	volatile unsigned int RxLength;		/* 0x21820 */
-	volatile unsigned int RxCounter;	/* 0x21824 */
-};
-typedef volatile struct uart_saa9730_regmap t_uart_saa9730_regmap;
-
-/*
- * Only a subset of the UART control bits are defined here,
- * enough to make the serial debug port work.
- */
-
-#define SAA9730_LCR_DATA8	0x03
-
-#define SAA9730_MCR_DTR		0x01
-#define SAA9730_MCR_RTS		0x02
-
-#define SAA9730_LSR_DR		0x01
-#define SAA9730_LSR_THRE	0x20
-
-#endif /* !(SAA9730_UART_H) */
