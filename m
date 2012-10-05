Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Oct 2012 18:25:04 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:36957 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6870280Ab2JEQWs407Hf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Oct 2012 18:22:48 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id A0B87A9E898;
        Fri,  5 Oct 2012 18:22:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bFxztdn1zQl8; Fri,  5 Oct 2012 18:22:47 +0200 (CEST)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 66176A9E896;
        Fri,  5 Oct 2012 18:22:47 +0200 (CEST)
From:   Florian Fainelli <florian@openwrt.org>
To:     stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, Florian Fainelli <florian@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/32 v3] MIPS: PNX8550: use OHCI platform driver
Date:   Fri,  5 Oct 2012 18:20:48 +0200
Message-Id: <1349454064-11606-17-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1349454064-11606-1-git-send-email-florian@openwrt.org>
References: <1349454064-11606-1-git-send-email-florian@openwrt.org>
X-archive-position: 34633
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Change the PNX8550 platform code to register an ohci-platform driver instead
of ohci-pnx8550 since the ohci-platform is suitable for use.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
No changes in v2 and v3

 arch/mips/pnx8550/common/platform.c |   31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/mips/pnx8550/common/platform.c b/arch/mips/pnx8550/common/platform.c
index 5264cc0..0a8faea 100644
--- a/arch/mips/pnx8550/common/platform.c
+++ b/arch/mips/pnx8550/common/platform.c
@@ -20,6 +20,7 @@
 #include <linux/serial.h>
 #include <linux/serial_pnx8xxx.h>
 #include <linux/platform_device.h>
+#include <linux/usb/ohci_pdriver.h>
 
 #include <int.h>
 #include <usb.h>
@@ -96,12 +97,40 @@ static u64 ohci_dmamask = DMA_BIT_MASK(32);
 
 static u64 uart_dmamask = DMA_BIT_MASK(32);
 
+static int pnx8550_usb_ohci_power_on(struct platform_device *pdev)
+{
+	/*
+	 * Set register CLK48CTL to enable and 48MHz
+	 */
+	outl(0x00000003, PCI_BASE | 0x0004770c);
+
+	/*
+	 * Set register CLK12CTL to enable and 48MHz
+	 */
+	outl(0x00000003, PCI_BASE | 0x00047710);
+
+	udelay(100);
+
+	return 0;
+}
+
+static void pnx8550_usb_ohci_power_off(struct platform_device *pdev)
+{
+	udelay(10);
+}
+
+static struct usb_ohci_pdata pnx8550_usb_ohci_pdata = {
+	.power_on	= pnx8550_usb_ohci_power_on,
+	.power_off	= pnx8550_usb_ohci_power_off,
+};
+
 static struct platform_device pnx8550_usb_ohci_device = {
-	.name		= "pnx8550-ohci",
+	.name		= "ohci-platform",
 	.id		= -1,
 	.dev = {
 		.dma_mask		= &ohci_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &pnx8550_usb_ohci_pdata,
 	},
 	.num_resources	= ARRAY_SIZE(pnx8550_usb_ohci_resources),
 	.resource	= pnx8550_usb_ohci_resources,
-- 
1.7.9.5
