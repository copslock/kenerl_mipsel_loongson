Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Feb 2013 22:42:15 +0100 (CET)
Received: from mail-ee0-f52.google.com ([74.125.83.52]:46135 "EHLO
        mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827627Ab3BMVluJ5FQ7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Feb 2013 22:41:50 +0100
Received: by mail-ee0-f52.google.com with SMTP id b15so890561eek.25
        for <linux-mips@linux-mips.org>; Wed, 13 Feb 2013 13:41:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=e6ZDUDAfvSj5JIXH4vVLgIqrQ1yO9c9KORTPiVUweSw=;
        b=o8Sm5tBc/o+z1sOxFzner4aUPE7JV9UEJ9ixGEzrrNNTKi0u0W0W9t7aSsFTCjmNyx
         B1FFmdWHdoYPSTlE/Zf6YhdUdssiQyfR0plySDgph3Jr7rfcTsmbdtFAZiRE2/vUrE8R
         1wJadrfxm2cSBiTCuyvSHN7DXt+vU68APbcxuQC2wcXeNp/yt5091fmQndKc8NGEccqX
         fFmIk4KTUFx3Urp/QFoABZxLfWiPfZ/iXMInbX3Fp+6mLyI5ABkW/biVBXfDtPxLzLga
         GgYNY0pHEvd6732TxEFsNld8PlBm9XuYYNaAMoPYL6hXXL9wANqah6tywtOcqIY7JBog
         P6Sw==
X-Received: by 10.14.173.196 with SMTP id v44mr78848493eel.29.1360791704746;
        Wed, 13 Feb 2013 13:41:44 -0800 (PST)
Received: from localhost.localdomain ([77.70.100.51])
        by mx.google.com with ESMTPS id r4sm30921681eeo.12.2013.02.13.13.41.42
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 13:41:44 -0800 (PST)
From:   Svetoslav Neykov <svetoslav@neykov.name>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>
Cc:     linux-mips@linux-mips.org, linux-usb@vger.kernel.org,
        Svetoslav Neykov <svetoslav@neykov.name>
Subject: [PATCH 4/5] usb: chipidea: AR933x platform support for the chipidea driver
Date:   Wed, 13 Feb 2013 23:38:57 +0200
Message-Id: <1360791538-6332-5-git-send-email-svetoslav@neykov.name>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1360791538-6332-1-git-send-email-svetoslav@neykov.name>
References: <1360791538-6332-1-git-send-email-svetoslav@neykov.name>
X-Gm-Message-State: ALoCoQkIk3TYbLo3RTZYZHWMeIcWjiIEkYV6TDPzzRfUlRea91z+piMadHLQCVhsYR4Ei7U+JCgC
X-archive-position: 35744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: svetoslav@neykov.name
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

Support host and device usb modes for the chipidea controller in AR933x.
The controller doesn't support OTG functionality so the platform code
forces one of the modes based on the state of GPIO13 pin at startup.

Signed-off-by: Svetoslav Neykov <svetoslav@neykov.name>
---
 arch/mips/ath79/dev-usb.c                      |   19 ++++++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    3 +
 drivers/usb/chipidea/Makefile                  |    1 +
 drivers/usb/chipidea/ci13xxx_ar933x.c          |   73 ++++++++++++++++++++++++
 4 files changed, 96 insertions(+)
 create mode 100644 drivers/usb/chipidea/ci13xxx_ar933x.c

diff --git a/arch/mips/ath79/dev-usb.c b/arch/mips/ath79/dev-usb.c
index bd2bc10..52966b3 100644
--- a/arch/mips/ath79/dev-usb.c
+++ b/arch/mips/ath79/dev-usb.c
@@ -174,8 +174,27 @@ static void __init ar913x_usb_setup(void)
 	platform_device_register(&ath79_ehci_device);
 }
 
+static void __init ar933x_usb_setup_ctrl_config(void)
+{
+	void __iomem *usb_ctrl_base, *usb_config_reg;
+	u32 usb_config;
+
+	usb_ctrl_base = ioremap(AR71XX_USB_CTRL_BASE, AR71XX_USB_CTRL_SIZE);
+	usb_config_reg = usb_ctrl_base + AR71XX_USB_CTRL_REG_CONFIG;
+	usb_config = __raw_readl(usb_config_reg);
+	usb_config &= ~AR933X_USB_CONFIG_HOST_ONLY;
+	__raw_writel(usb_config, usb_config_reg);
+	iounmap(usb_ctrl_base);
+}
+
 static void __init ar933x_usb_setup(void)
 {
+	u32 bootstrap;
+
+	bootstrap = ath79_reset_rr(AR933X_RESET_REG_BOOTSTRAP);
+	if (!(bootstrap & AR933X_BOOTSTRAP_USB_MODE_HOST))
+		ar933x_usb_setup_ctrl_config();
+
 	ath79_device_reset_set(AR933X_RESET_USBSUS_OVERRIDE);
 	mdelay(10);
 
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index a5e0f17..13eb2d9 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -297,6 +297,7 @@
 #define AR934X_RESET_USB_PHY		BIT(4)
 #define AR934X_RESET_USBSUS_OVERRIDE	BIT(3)
 
+#define AR933X_BOOTSTRAP_USB_MODE_HOST	BIT(3)
 #define AR933X_BOOTSTRAP_REF_CLK_40	BIT(0)
 
 #define AR934X_BOOTSTRAP_SW_OPTION8	BIT(23)
@@ -315,6 +316,8 @@
 #define AR934X_BOOTSTRAP_SDRAM_DISABLED	BIT(1)
 #define AR934X_BOOTSTRAP_DDR1		BIT(0)
 
+#define AR933X_USB_CONFIG_HOST_ONLY	BIT(8)
+
 #define AR934X_PCIE_WMAC_INT_WMAC_MISC		BIT(0)
 #define AR934X_PCIE_WMAC_INT_WMAC_TX		BIT(1)
 #define AR934X_PCIE_WMAC_INT_WMAC_RXLP		BIT(2)
diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
index d92ca32..196b7b4 100644
--- a/drivers/usb/chipidea/Makefile
+++ b/drivers/usb/chipidea/Makefile
@@ -10,6 +10,7 @@ ci_hdrc-$(CONFIG_USB_CHIPIDEA_DEBUG)	+= debug.o
 # Glue/Bridge layers go here
 
 obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_msm.o
+obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_ar933x.o
 
 # PCI doesn't provide stubs, need to check
 ifneq ($(CONFIG_PCI),)
diff --git a/drivers/usb/chipidea/ci13xxx_ar933x.c b/drivers/usb/chipidea/ci13xxx_ar933x.c
new file mode 100644
index 0000000..046a4b6
--- /dev/null
+++ b/drivers/usb/chipidea/ci13xxx_ar933x.c
@@ -0,0 +1,73 @@
+/* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/usb/ulpi.h>
+#include <linux/usb/gadget.h>
+#include <linux/usb/chipidea.h>
+#include <asm/mach-ath79/ath79.h>
+#include <asm/mach-ath79/ar71xx_regs.h>
+
+#include "ci.h"
+
+static struct ci13xxx_platform_data ci13xxx_ar933x_platdata = {
+	.name			= "ci13xxx_ar933x",
+	.flags			= 0,
+	.capoffset		= DEF_CAPOFFSET
+};
+
+static int __devinit ci13xxx_ar933x_probe(struct platform_device *pdev)
+{
+	u32 bootstrap;
+	struct platform_device *plat_ci;
+
+	dev_dbg(&pdev->dev, "ci13xxx_ar933x_probe\n");
+
+	bootstrap = ath79_reset_rr(AR933X_RESET_REG_BOOTSTRAP);
+	if (bootstrap & AR933X_BOOTSTRAP_USB_MODE_HOST)
+		ci13xxx_ar933x_platdata.flags = CI13XXX_FORCE_HOST_MODE;
+	else
+		ci13xxx_ar933x_platdata.flags = CI13XXX_FORCE_DEVICE_MODE;
+
+	plat_ci = ci13xxx_add_device(&pdev->dev,
+				pdev->resource, pdev->num_resources,
+				&ci13xxx_ar933x_platdata);
+	if (IS_ERR(plat_ci)) {
+		dev_err(&pdev->dev, "ci13xxx_add_device failed!\n");
+		return PTR_ERR(plat_ci);
+	}
+
+	platform_set_drvdata(pdev, plat_ci);
+
+	pm_runtime_no_callbacks(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	return 0;
+}
+
+static int __devexit ci13xxx_ar933x_remove(struct platform_device *pdev)
+{
+	struct platform_device *plat_ci = platform_get_drvdata(pdev);
+
+	pm_runtime_disable(&pdev->dev);
+	ci13xxx_remove_device(plat_ci);
+
+	return 0;
+}
+
+static struct platform_driver ci13xxx_ar933x_driver = {
+	.probe = ci13xxx_ar933x_probe,
+	.remove = __devexit_p(ci13xxx_ar933x_remove),
+	.driver = { .name = "ehci-platform", },
+};
+
+module_platform_driver(ci13xxx_ar933x_driver);
+
+MODULE_ALIAS("platform:ar933x_hsusb");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5
