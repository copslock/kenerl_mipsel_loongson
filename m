Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Dec 2013 03:26:43 +0100 (CET)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:61673 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6838329Ab3LFC0dflxDc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Dec 2013 03:26:33 +0100
X-IronPort-AV: E=Sophos;i="4.93,838,1378882800"; 
   d="scan'208";a="218828"
Received: from irvexchcas06.broadcom.com (HELO IRVEXCHCAS06.corp.ad.broadcom.com) ([10.9.208.53])
  by mail-gw3-out.broadcom.com with ESMTP; 05 Dec 2013 18:26:02 -0800
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP Server
 (TLS) id 14.1.438.0; Thu, 5 Dec 2013 18:26:24 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.1.438.0; Thu, 5 Dec 2013 18:26:24 -0800
Received: from fainelli-desktop.broadcom.com (unknown [10.12.164.252])  by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 8634B246A6;  Thu,  5 Dec
 2013 18:26:24 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>, <blogic@openwrt.org>, <jogo@openwrt.org>,
        <mbizon@freebox.fr>, <cernekee@gmail.com>,
        <gregkh@linuxfoundation.org>, <linux-serial@vger.kernel.org>,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 2/5] tty: serial: bcm63xx_uart: drop bcm_{readl,writel} macros
Date:   Thu, 5 Dec 2013 18:26:05 -0800
Message-ID: <1386296768-20204-3-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1386296768-20204-1-git-send-email-florian@openwrt.org>
References: <1386296768-20204-1-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

bcm_{readl,writel} macros expand to __raw_{readl,writel}, use these
directly such that we do not rely on the platform to provide these for
us. As a result, we no longer use bcm63xx_io.h, so remove that inclusion
too.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 drivers/tty/serial/bcm63xx_uart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 2e72752..6d773a3 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -31,7 +31,6 @@
 #include <linux/serial_core.h>
 
 #include <bcm63xx_regs.h>
-#include <bcm63xx_io.h>
 
 #define BCM63XX_NR_UARTS	2
 
@@ -80,13 +79,13 @@ static struct uart_port ports[BCM63XX_NR_UARTS];
 static inline unsigned int bcm_uart_readl(struct uart_port *port,
 					 unsigned int offset)
 {
-	return bcm_readl(port->membase + offset);
+	return __raw_readl(port->membase + offset);
 }
 
 static inline void bcm_uart_writel(struct uart_port *port,
 				  unsigned int value, unsigned int offset)
 {
-	bcm_writel(value, port->membase + offset);
+	__raw_writel(value, port->membase + offset);
 }
 
 /*
-- 
1.8.3.2
