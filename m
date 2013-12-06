Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Dec 2013 03:28:34 +0100 (CET)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:19372 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6867247Ab3LFC0z5azE4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Dec 2013 03:26:55 +0100
X-IronPort-AV: E=Sophos;i="4.93,838,1378882800"; 
   d="scan'208";a="419985"
Received: from irvexchcas07.broadcom.com (HELO IRVEXCHCAS07.corp.ad.broadcom.com) ([10.9.208.55])
  by mail-gw1-out.broadcom.com with ESMTP; 05 Dec 2013 18:30:23 -0800
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP Server
 (TLS) id 14.1.438.0; Thu, 5 Dec 2013 18:26:24 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.1.438.0; Thu, 5 Dec 2013 18:26:24 -0800
Received: from fainelli-desktop.broadcom.com (unknown [10.12.164.252])  by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 73331246A4;  Thu,  5 Dec
 2013 18:26:24 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>, <blogic@openwrt.org>, <jogo@openwrt.org>,
        <mbizon@freebox.fr>, <cernekee@gmail.com>,
        <gregkh@linuxfoundation.org>, <linux-serial@vger.kernel.org>,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 1/5] tty: serial: bcm63xx_uart: remove unused inclusion
Date:   Thu, 5 Dec 2013 18:26:04 -0800
Message-ID: <1386296768-20204-2-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1386296768-20204-1-git-send-email-florian@openwrt.org>
References: <1386296768-20204-1-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38667
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

bcm63xx_irqs.h is included but we are not using anything from it, drop
that include.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 drivers/tty/serial/bcm63xx_uart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 649d512..2e72752 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -30,7 +30,6 @@
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 
-#include <bcm63xx_irq.h>
 #include <bcm63xx_regs.h>
 #include <bcm63xx_io.h>
 
-- 
1.8.3.2
