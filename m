Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 17:21:58 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:43721 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6870483Ab2JDPTw0VdYF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Oct 2012 17:19:52 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 23BB4A99C09;
        Thu,  4 Oct 2012 17:19:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9VNvBmuHw7JV; Thu,  4 Oct 2012 17:19:51 +0200 (CEST)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id D0A66A31D7C;
        Thu,  4 Oct 2012 17:19:51 +0200 (CEST)
From:   Florian Fainelli <florian@openwrt.org>
To:     stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, Florian Fainelli <florian@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jayachandran C <jayachandranc@netlogicmicro.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 19/24 v2] MIPS: Netlogic: convert to use OHCI platform driver
Date:   Thu,  4 Oct 2012 17:17:47 +0200
Message-Id: <1349363872-27004-20-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1349363872-27004-1-git-send-email-florian@openwrt.org>
References: <1349363872-27004-1-git-send-email-florian@openwrt.org>
X-archive-position: 34606
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

The OHCI platform driver is suitable for use by the Netlogic XLR platform
so use this driver instead of the OHCI XLS platform driver.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v1:
- really make the code register the "ohci-platform" driver instead of "ohci-xls"

 arch/mips/netlogic/xlr/platform.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/mips/netlogic/xlr/platform.c b/arch/mips/netlogic/xlr/platform.c
index 144c5c6..507230e 100644
--- a/arch/mips/netlogic/xlr/platform.c
+++ b/arch/mips/netlogic/xlr/platform.c
@@ -16,6 +16,7 @@
 #include <linux/serial_reg.h>
 #include <linux/i2c.h>
 #include <linux/usb/ehci_pdriver.h>
+#include <linux/usb/ohci_pdriver.h>
 
 #include <asm/netlogic/haldefs.h>
 #include <asm/netlogic/xlr/iomap.h>
@@ -128,12 +129,14 @@ static struct usb_ehci_pdata xls_usb_ehci_pdata = {
 	.caps_offset	= 0,
 };
 
+static struct usb_ohci_pdata xls_usb_ohci_pdata;
+
 static struct platform_device xls_usb_ehci_device =
 			 USB_PLATFORM_DEV("ehci-platform", 0, PIC_USB_IRQ);
 static struct platform_device xls_usb_ohci_device_0 =
-			 USB_PLATFORM_DEV("ohci-xls-0", 1, PIC_USB_IRQ);
+			 USB_PLATFORM_DEV("ohci-platform", 1, PIC_USB_IRQ);
 static struct platform_device xls_usb_ohci_device_1 =
-			 USB_PLATFORM_DEV("ohci-xls-1", 2, PIC_USB_IRQ);
+			 USB_PLATFORM_DEV("ohci-platform", 2, PIC_USB_IRQ);
 
 static struct platform_device *xls_platform_devices[] = {
 	&xls_usb_ehci_device,
@@ -182,10 +185,12 @@ int xls_platform_usb_init(void)
 	memres += 0x400;
 	xls_usb_ohci_device_0.resource[0].start = memres;
 	xls_usb_ohci_device_0.resource[0].end = memres + 0x400 - 1;
+	xls_usb_ohci_device_0.dev.platform_data = &xls_usb_ohci_pdata;
 
 	memres += 0x400;
 	xls_usb_ohci_device_1.resource[0].start = memres;
 	xls_usb_ohci_device_1.resource[0].end = memres + 0x400 - 1;
+	xls_usb_ohci_device_1.dev.platform_data = &xls_usb_ohci_pdata;
 
 	return platform_add_devices(xls_platform_devices,
 				ARRAY_SIZE(xls_platform_devices));
-- 
1.7.9.5
