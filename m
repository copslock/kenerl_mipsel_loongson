Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 11:55:17 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:50388 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6872761Ab2JDJxtpTvdC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Oct 2012 11:53:49 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 07E3CA4512B;
        Wed,  3 Oct 2012 17:04:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Nlf+hQm6Er50; Wed,  3 Oct 2012 17:04:34 +0200 (CEST)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id B9D659F1A94;
        Wed,  3 Oct 2012 17:04:34 +0200 (CEST)
From:   Florian Fainelli <florian@openwrt.org>
To:     stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, Florian Fainelli <florian@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jayachandran C <jayachandranc@netlogicmicro.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/25] MIPS: Netlogic: use ehci-platform driver
Date:   Wed,  3 Oct 2012 17:02:59 +0200
Message-Id: <1349276601-8371-5-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1349276601-8371-1-git-send-email-florian@openwrt.org>
References: <1349276601-8371-1-git-send-email-florian@openwrt.org>
X-archive-position: 34577
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
 arch/mips/netlogic/xlr/platform.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/netlogic/xlr/platform.c b/arch/mips/netlogic/xlr/platform.c
index 71b44d8..1731dfd 100644
--- a/arch/mips/netlogic/xlr/platform.c
+++ b/arch/mips/netlogic/xlr/platform.c
@@ -15,6 +15,7 @@
 #include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
 #include <linux/i2c.h>
+#include <linux/usb/ehci_pdriver.h>
 
 #include <asm/netlogic/haldefs.h>
 #include <asm/netlogic/xlr/iomap.h>
@@ -123,6 +124,10 @@ static u64 xls_usb_dmamask = ~(u32)0;
 		},							\
 	}
 
+static struct usb_ehci_pdata xls_usb_ehci_pdata = {
+	.caps_offset	= 0,
+};
+
 static struct platform_device xls_usb_ehci_device =
 			 USB_PLATFORM_DEV("ehci-xls", 0, PIC_USB_IRQ);
 static struct platform_device xls_usb_ohci_device_0 =
@@ -172,6 +177,7 @@ int xls_platform_usb_init(void)
 	memres = CPHYSADDR((unsigned long)usb_mmio);
 	xls_usb_ehci_device.resource[0].start = memres;
 	xls_usb_ehci_device.resource[0].end = memres + 0x400 - 1;
+	xls_usb_ehci_device.dev.platform_data = &xls_usb_ehci_pdata;
 
 	memres += 0x400;
 	xls_usb_ohci_device_0.resource[0].start = memres;
-- 
1.7.9.5
