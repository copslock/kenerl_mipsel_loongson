Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2012 15:16:30 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:42032 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6870498Ab2JHNOmqoZW3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 8 Oct 2012 15:14:42 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 4F06DAA05AD;
        Mon,  8 Oct 2012 15:14:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9cFGrEroLEdr; Mon,  8 Oct 2012 15:14:41 +0200 (CEST)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id BE7AEA9E05F;
        Mon,  8 Oct 2012 15:14:41 +0200 (CEST)
From:   Florian Fainelli <florian@openwrt.org>
To:     stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, Florian Fainelli <florian@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        "David S. Miller" <davem@davemloft.net>,
        Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 24/32 v4] MIPS: Alchemy: use the OHCI platform driver
Date:   Mon,  8 Oct 2012 15:11:38 +0200
Message-Id: <1349701906-16481-25-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1349701906-16481-1-git-send-email-florian@openwrt.org>
References: <1349701906-16481-1-git-send-email-florian@openwrt.org>
X-archive-position: 34655
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

Convert the Alchemy platform to register the ohci-platform driver, now that
the ohci-platform driver properly handles the specific ohci-au1xxx resume
from suspend case.

This also greatly simplifies the power_{on,off} callbacks and make them
work on platform device id instead of checking the OHCI controller base
address like what was done in ohci-au1xxx.c.

Impacted defconfigs are also updated accordingly to select the OHCI platform
driver.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes in v4:
- rebased against greg's latest usb-next

No changes in v3

Changes in v2:
- updated defconfigs accordingly
- really instantiate "ohci-platform" instead of "ohci-au1xxx"
- rebased on top of the latest OHCI HCD changes

 arch/mips/alchemy/common/platform.c |   35 +++++++++++++++++++++++++++++++++--
 arch/mips/configs/db1000_defconfig  |    1 +
 arch/mips/configs/db1200_defconfig  |    1 +
 arch/mips/configs/db1300_defconfig  |    1 +
 arch/mips/configs/db1550_defconfig  |    1 +
 arch/mips/configs/gpr_defconfig     |    1 +
 arch/mips/configs/mtx1_defconfig    |    1 +
 arch/mips/configs/pb1100_defconfig  |    1 +
 arch/mips/configs/pb1500_defconfig  |    1 +
 arch/mips/configs/pb1550_defconfig  |    1 +
 10 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index b9a5f6d..7af941d 100644
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
 	.power_suspend	= alchemy_ehci_power_off,
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
@@ -189,9 +218,10 @@ static void __init alchemy_setup_usb(int ctype)
 	res[1].start = alchemy_ohci_data[ctype][1];
 	res[1].end = res[1].start;
 	res[1].flags = IORESOURCE_IRQ;
-	pdev->name = "au1xxx-ohci";
+	pdev->name = "ohci-platform";
 	pdev->id = 0;
 	pdev->dev.dma_mask = &alchemy_ohci_dmamask;
+	pdev->dev.platform_data = &alchemy_ohci_pdata;
 
 	if (platform_device_register(pdev))
 		printk(KERN_INFO "Alchemy USB: cannot add OHCI0\n");
@@ -228,9 +258,10 @@ static void __init alchemy_setup_usb(int ctype)
 		res[1].start = AU1300_USB_INT;
 		res[1].end = res[1].start;
 		res[1].flags = IORESOURCE_IRQ;
-		pdev->name = "au1xxx-ohci";
+		pdev->name = "ohci-platform";
 		pdev->id = 1;
 		pdev->dev.dma_mask = &alchemy_ohci_dmamask;
+		pdev->dev.platform_data = &alchemy_ohci_pdata;
 
 		if (platform_device_register(pdev))
 			printk(KERN_INFO "Alchemy USB: cannot add OHCI1\n");
diff --git a/arch/mips/configs/db1000_defconfig b/arch/mips/configs/db1000_defconfig
index 17a36c1..face9d2 100644
--- a/arch/mips/configs/db1000_defconfig
+++ b/arch/mips/configs/db1000_defconfig
@@ -233,6 +233,7 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
 CONFIG_USB_EHCI_TT_NEWSCHED=y
 CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_UHCI_HCD=y
 CONFIG_USB_STORAGE=y
 CONFIG_NEW_LEDS=y
diff --git a/arch/mips/configs/db1200_defconfig b/arch/mips/configs/db1200_defconfig
index d31ac85..e36f44a 100644
--- a/arch/mips/configs/db1200_defconfig
+++ b/arch/mips/configs/db1200_defconfig
@@ -120,6 +120,7 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
 CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_MMC=y
 # CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_AU1X=y
diff --git a/arch/mips/configs/db1300_defconfig b/arch/mips/configs/db1300_defconfig
index 717e7b2..6873443 100644
--- a/arch/mips/configs/db1300_defconfig
+++ b/arch/mips/configs/db1300_defconfig
@@ -292,6 +292,7 @@ CONFIG_USB_EHCI_HCD_PLATFORM=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
 CONFIG_USB_EHCI_TT_NEWSCHED=y
 CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
diff --git a/arch/mips/configs/db1550_defconfig b/arch/mips/configs/db1550_defconfig
index 36cda27..315fe24 100644
--- a/arch/mips/configs/db1550_defconfig
+++ b/arch/mips/configs/db1550_defconfig
@@ -187,6 +187,7 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
 CONFIG_USB_EHCI_TT_NEWSCHED=y
 CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 CONFIG_USB_UHCI_HCD=y
 CONFIG_USB_STORAGE=y
diff --git a/arch/mips/configs/gpr_defconfig b/arch/mips/configs/gpr_defconfig
index 48a40ae..fb64589 100644
--- a/arch/mips/configs/gpr_defconfig
+++ b/arch/mips/configs/gpr_defconfig
@@ -291,6 +291,7 @@ CONFIG_USB_MON=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
 CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=m
 CONFIG_USB_LIBUSUAL=y
 CONFIG_USB_SERIAL=y
diff --git a/arch/mips/configs/mtx1_defconfig b/arch/mips/configs/mtx1_defconfig
index 46c61edc..459018a 100644
--- a/arch/mips/configs/mtx1_defconfig
+++ b/arch/mips/configs/mtx1_defconfig
@@ -581,6 +581,7 @@ CONFIG_USB_MON=m
 CONFIG_USB_EHCI_HCD=m
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
 CONFIG_USB_OHCI_HCD=m
+CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_UHCI_HCD=m
 CONFIG_USB_U132_HCD=m
 CONFIG_USB_SL811_HCD=m
diff --git a/arch/mips/configs/pb1100_defconfig b/arch/mips/configs/pb1100_defconfig
index 75eb1b1..b47b1a3 100644
--- a/arch/mips/configs/pb1100_defconfig
+++ b/arch/mips/configs/pb1100_defconfig
@@ -97,6 +97,7 @@ CONFIG_USB=y
 CONFIG_USB_DYNAMIC_MINORS=y
 CONFIG_USB_SUSPEND=y
 CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_AU1XXX=y
 CONFIG_EXT2_FS=y
diff --git a/arch/mips/configs/pb1500_defconfig b/arch/mips/configs/pb1500_defconfig
index fa00487..adbc281 100644
--- a/arch/mips/configs/pb1500_defconfig
+++ b/arch/mips/configs/pb1500_defconfig
@@ -104,6 +104,7 @@ CONFIG_USB=y
 CONFIG_USB_DYNAMIC_MINORS=y
 CONFIG_USB_OTG_WHITELIST=y
 CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_AU1XXX=y
 CONFIG_EXT2_FS=y
diff --git a/arch/mips/configs/pb1550_defconfig b/arch/mips/configs/pb1550_defconfig
index e83d649..ef13bba 100644
--- a/arch/mips/configs/pb1550_defconfig
+++ b/arch/mips/configs/pb1550_defconfig
@@ -108,6 +108,7 @@ CONFIG_USB_SUSPEND=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
 CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_AU1XXX=y
 CONFIG_EXT2_FS=y
-- 
1.7.9.5
