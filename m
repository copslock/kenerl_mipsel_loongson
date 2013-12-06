Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Dec 2013 03:27:36 +0100 (CET)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:61673 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831300Ab3LFC0lOjeI5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Dec 2013 03:26:41 +0100
X-IronPort-AV: E=Sophos;i="4.93,838,1378882800"; 
   d="scan'208";a="218831"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw3-out.broadcom.com with ESMTP; 05 Dec 2013 18:26:02 -0800
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.1.438.0; Thu, 5 Dec 2013 18:26:25 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.1.438.0; Thu, 5 Dec 2013 18:26:25 -0800
Received: from fainelli-desktop.broadcom.com (unknown [10.12.164.252])  by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id DAC5A246A3;  Thu,  5 Dec
 2013 18:26:24 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>, <blogic@openwrt.org>, <jogo@openwrt.org>,
        <mbizon@freebox.fr>, <cernekee@gmail.com>,
        <gregkh@linuxfoundation.org>, <linux-serial@vger.kernel.org>,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 5/5] MIPS: BCM63XX: use linux/serial_bcm63xx.h
Date:   Thu, 5 Dec 2013 18:26:08 -0800
Message-ID: <1386296768-20204-6-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1386296768-20204-1-git-send-email-florian@openwrt.org>
References: <1386296768-20204-1-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38664
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

Update the early_printk code to include linux/serial_bcm63xx.h which
provides the definitions for the UART block registers. While at it,
remove the inclusion of serial_bcm63xx.h which was just there to allow
smooth transition.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/early_printk.c                  | 2 +-
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/mips/bcm63xx/early_printk.c b/arch/mips/bcm63xx/early_printk.c
index aa8f7f9..f92f1a2 100644
--- a/arch/mips/bcm63xx/early_printk.c
+++ b/arch/mips/bcm63xx/early_printk.c
@@ -8,7 +8,7 @@
 
 #include <linux/init.h>
 #include <bcm63xx_io.h>
-#include <bcm63xx_regs.h>
+#include <linux/serial_bcm63xx.h>
 
 static void wait_xfered(void)
 {
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 96a2d2c..ab427f8 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -463,13 +463,6 @@
 #define WDT_SOFTRESET_REG		0xc
 
 /*************************************************************************
- * _REG relative to RSET_UARTx
- *************************************************************************/
-
-#include <linux/serial_bcm63xx.h>
-
-
-/*************************************************************************
  * _REG relative to RSET_GPIO
  *************************************************************************/
 
-- 
1.8.3.2
