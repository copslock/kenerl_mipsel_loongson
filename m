Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jan 2008 23:25:34 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:5568 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28580048AbYAKXZY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Jan 2008 23:25:24 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JDTFb-0002t5-01; Sat, 12 Jan 2008 00:25:23 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id C7B9FC2F2B; Sat, 12 Jan 2008 00:25:17 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] Cobalt Qube1 has no serial port so don't use it
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080111232517.C7B9FC2F2B@solo.franken.de>
Date:	Sat, 12 Jan 2008 00:25:17 +0100 (CET)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Because Qube1 doesn't have a serial chip waiting for transmit fifo empty
takes forever, which isn't a good idea. No prom_putchar/early console
for Qube1 fixes this.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/cobalt/console.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/cobalt/console.c b/arch/mips/cobalt/console.c
index db330e8..d1ba701 100644
--- a/arch/mips/cobalt/console.c
+++ b/arch/mips/cobalt/console.c
@@ -4,10 +4,15 @@
 #include <linux/io.h>
 #include <linux/serial_reg.h>
 
+#include <cobalt.h>
+
 #define UART_BASE	((void __iomem *)CKSEG1ADDR(0x1c800000))
 
 void prom_putchar(char c)
 {
+	if (cobalt_board_id <= COBALT_BRD_ID_QUBE1)
+		return;
+
 	while (!(readb(UART_BASE + UART_LSR) & UART_LSR_THRE))
 		;
 
