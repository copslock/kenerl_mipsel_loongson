Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Oct 2006 11:49:26 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:25652 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037592AbWJAKs7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 1 Oct 2006 11:48:59 +0100
Received: by mo.po.2iij.net (mo32) id k91AmvPX014906; Sun, 1 Oct 2006 19:48:57 +0900 (JST)
Received: from localhost.localdomain (34.26.30.125.dy.iij4u.or.jp [125.30.26.34])
	by mbox.po.2iij.net (mbox30) id k91AmoO8090851
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 1 Oct 2006 19:48:50 +0900 (JST)
Date:	Sun, 1 Oct 2006 19:35:28 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 1/3] add UART IRQ number for EV64120
Message-Id: <20061001193528.003d01d8.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has added UART IRQ number for EV64120.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mach-ev64120/mach-gt64120.h mips/include/asm-mips/mach-ev64120/mach-gt64120.h
--- mips-orig/include/asm-mips/mach-ev64120/mach-gt64120.h	2006-10-01 16:12:37.741496250 +0900
+++ mips/include/asm-mips/mach-ev64120/mach-gt64120.h	2006-10-01 16:14:24.228151250 +0900
@@ -42,6 +42,7 @@ extern unsigned long gt64120_base;
 #define EV64120_UART0_REGS_BASE	(KSEG1ADDR(EV64120_COM1_BASE_ADDR))
 #define EV64120_UART1_REGS_BASE	(KSEG1ADDR(EV64120_COM2_BASE_ADDR))
 #define EV64120_BASE_BAUD ( 3686400 / 16 )
+#define EV64120_UART_IRQ	6
 
 /*
  * PCI interrupts will come in on either the INTA or INTD interrups lines,
