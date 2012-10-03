Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 11:56:26 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:50387 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6872766Ab2JDJxtr7ltz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Oct 2012 11:53:49 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 3357DA50579;
        Wed,  3 Oct 2012 17:05:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eDhxluHcpxvM; Wed,  3 Oct 2012 17:05:33 +0200 (CEST)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id EA4A7A4FA6E;
        Wed,  3 Oct 2012 17:05:33 +0200 (CEST)
From:   Florian Fainelli <florian@openwrt.org>
To:     stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, Florian Fainelli <florian@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jayachandran C <jayachandranc@netlogicmicro.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 20/25] MIPS: Netlogic: convert to use OHCI platform driver
Date:   Wed,  3 Oct 2012 17:03:16 +0200
Message-Id: <1349276601-8371-22-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1349276601-8371-1-git-send-email-florian@openwrt.org>
References: <1349276601-8371-1-git-send-email-florian@openwrt.org>
X-archive-position: 34579
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

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/netlogic/xlr/platform.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/netlogic/xlr/platform.c b/arch/mips/netlogic/xlr/platform.c
index 320b7ef..755ddcc 100644
--- a/arch/mips/netlogic/xlr/platform.c
+++ b/arch/mips/netlogic/xlr/platform.c
@@ -16,6 +16,7 @@
 #include <linux/serial_reg.h>
 #include <linux/i2c.h>
 #include <linux/usb/ehci_pdriver.h>
+#include <linux/usb/ohci_pdriver.h>
 
 #include <asm/netlogic/haldefs.h>
 #include <asm/netlogic/xlr/iomap.h>
@@ -129,6 +130,8 @@ static struct usb_ehci_pdata xls_usb_ehci_pdata = {
 	.need_io_watchdog = 1,
 };
 
+static struct usb_ohci_pdata xls_usb_ohci_pdata;
+
 static struct platform_device xls_usb_ehci_device =
 			 USB_PLATFORM_DEV("ehci-xls", 0, PIC_USB_IRQ);
 static struct platform_device xls_usb_ohci_device_0 =
@@ -183,10 +186,12 @@ int xls_platform_usb_init(void)
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
