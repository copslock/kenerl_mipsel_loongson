Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2012 15:13:56 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:41655 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824141Ab2JHNNWokoiJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 8 Oct 2012 15:13:22 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 524CFAA05F8;
        Mon,  8 Oct 2012 15:13:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iIsjmLdblUqr; Mon,  8 Oct 2012 15:13:21 +0200 (CEST)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id E807AAA05DD;
        Mon,  8 Oct 2012 15:13:21 +0200 (CEST)
From:   Florian Fainelli <florian@openwrt.org>
To:     stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, Florian Fainelli <florian@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jayachandran C <jayachandranc@netlogicmicro.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/32 v4] MIPS: Netlogic: use ehci-platform driver
Date:   Mon,  8 Oct 2012 15:11:19 +0200
Message-Id: <1349701906-16481-6-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1349701906-16481-1-git-send-email-florian@openwrt.org>
References: <1349701906-16481-1-git-send-email-florian@openwrt.org>
X-archive-position: 34651
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

The EHCI platform driver is suitable for use by the Netlogic XLR platform
since there is nothing specific that the EHCI XLR platform driver does.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes in v4:
- rebased against greg's latest usb-next
No changes in v3

Changes in v2:
- really change driver name to "ehci-platform"
- slightly reworded commit message

 arch/mips/netlogic/xlr/platform.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/mips/netlogic/xlr/platform.c b/arch/mips/netlogic/xlr/platform.c
index 71b44d8..144c5c6 100644
--- a/arch/mips/netlogic/xlr/platform.c
+++ b/arch/mips/netlogic/xlr/platform.c
@@ -15,6 +15,7 @@
 #include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
 #include <linux/i2c.h>
+#include <linux/usb/ehci_pdriver.h>
 
 #include <asm/netlogic/haldefs.h>
 #include <asm/netlogic/xlr/iomap.h>
@@ -123,8 +124,12 @@ static u64 xls_usb_dmamask = ~(u32)0;
 		},							\
 	}
 
+static struct usb_ehci_pdata xls_usb_ehci_pdata = {
+	.caps_offset	= 0,
+};
+
 static struct platform_device xls_usb_ehci_device =
-			 USB_PLATFORM_DEV("ehci-xls", 0, PIC_USB_IRQ);
+			 USB_PLATFORM_DEV("ehci-platform", 0, PIC_USB_IRQ);
 static struct platform_device xls_usb_ohci_device_0 =
 			 USB_PLATFORM_DEV("ohci-xls-0", 1, PIC_USB_IRQ);
 static struct platform_device xls_usb_ohci_device_1 =
@@ -172,6 +177,7 @@ int xls_platform_usb_init(void)
 	memres = CPHYSADDR((unsigned long)usb_mmio);
 	xls_usb_ehci_device.resource[0].start = memres;
 	xls_usb_ehci_device.resource[0].end = memres + 0x400 - 1;
+	xls_usb_ehci_device.dev.platform_data = &xls_usb_ehci_pdata;
 
 	memres += 0x400;
 	xls_usb_ohci_device_0.resource[0].start = memres;
-- 
1.7.9.5
