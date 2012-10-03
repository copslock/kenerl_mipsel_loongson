Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 11:58:09 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:50392 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6875882Ab2JDJxuDOkrR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Oct 2012 11:53:50 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 8F660A51576;
        Wed,  3 Oct 2012 17:05:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3epWdrKYSfHd; Wed,  3 Oct 2012 17:05:52 +0200 (CEST)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 368EE9E123E;
        Wed,  3 Oct 2012 17:05:52 +0200 (CEST)
From:   Florian Fainelli <florian@openwrt.org>
To:     stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, Florian Fainelli <florian@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        "David S. Miller" <davem@davemloft.net>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 24/25] MIPS: Alchemy: use the OHCI platform driver
Date:   Wed,  3 Oct 2012 17:03:20 +0200
Message-Id: <1349276601-8371-26-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1349276601-8371-1-git-send-email-florian@openwrt.org>
References: <1349276601-8371-1-git-send-email-florian@openwrt.org>
X-archive-position: 34582
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

This also greatly simplifies the power_{on,off} callbacks and make them
work on platform device id instead of checking the OHCI controller base
address like what was done in ohci-au1xxx.c.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/alchemy/common/platform.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 57335a2..cd12458 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -18,6 +18,7 @@
 #include <linux/serial_8250.h>
 #include <linux/slab.h>
 #include <linux/usb/ehci_pdriver.h>
+#include <linux/usb/ohci_pdriver.h>
 
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
@@ -142,6 +143,34 @@ static struct usb_ehci_pdata alchemy_ehci_pdata = {
 	.power_suspend		= alchemy_ehci_power_off,
 };
 
+/* Power on callback for the ohci platform driver */
+static int alchemy_ohci_power_on(struct platform_device *pdev)
+{
+	int unit;
+
+	unit = (pdev->id == 1) ?
+		ALCHEMY_USB_OHCI1 : ALCHEMY_USB_OHCI0;
+
+	return alchemy_usb_control(unit, 1);
+}
+
+/* Power off/suspend callback for the ohci platform driver */
+static void alchemy_ohci_power_off(struct platform_device *pdev)
+{
+	int unit;
+
+	unit = (pdev->id == 1) ?
+		ALCHEMY_USB_OHCI1 : ALCHEMY_USB_OHCI0;
+
+	alchemy_usb_control(unit, 0);
+}
+
+static struct usb_ohci_pdata alchemy_ohci_pdata = {
+	.power_on		= alchemy_ohci_power_on,
+	.power_off		= alchemy_ohci_power_off,
+	.power_suspend		= alchemy_ohci_power_off,
+};
+
 static unsigned long alchemy_ohci_data[][2] __initdata = {
 	[ALCHEMY_CPU_AU1000] = { AU1000_USB_OHCI_PHYS_ADDR, AU1000_USB_HOST_INT },
 	[ALCHEMY_CPU_AU1500] = { AU1000_USB_OHCI_PHYS_ADDR, AU1500_USB_HOST_INT },
@@ -192,6 +221,7 @@ static void __init alchemy_setup_usb(int ctype)
 	pdev->name = "au1xxx-ohci";
 	pdev->id = 0;
 	pdev->dev.dma_mask = &alchemy_ohci_dmamask;
+	pdev->dev.platform_data = &alchemy_ohci_pdata;
 
 	if (platform_device_register(pdev))
 		printk(KERN_INFO "Alchemy USB: cannot add OHCI0\n");
@@ -231,6 +261,7 @@ static void __init alchemy_setup_usb(int ctype)
 		pdev->name = "au1xxx-ohci";
 		pdev->id = 1;
 		pdev->dev.dma_mask = &alchemy_ohci_dmamask;
+		pdev->dev.platform_data = &alchemy_ohci_pdata;
 
 		if (platform_device_register(pdev))
 			printk(KERN_INFO "Alchemy USB: cannot add OHCI1\n");
-- 
1.7.9.5
