Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Apr 2013 00:06:11 +0200 (CEST)
Received: from mail-bk0-f43.google.com ([209.85.214.43]:56115 "EHLO
        mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827575Ab3DCWGDiz4Vz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Apr 2013 00:06:03 +0200
Received: by mail-bk0-f43.google.com with SMTP id jm2so1116386bkc.16
        for <linux-mips@linux-mips.org>; Wed, 03 Apr 2013 15:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=yhbwdeFcLi37aONwwr41cIlXoyqpSGY2gnz2hswET3s=;
        b=FOy29c+reWDQbwkksMxJPqKMBZCUeydCZbWWMk29zwUtzVGMwsVLFSSa6+9NNJFfcm
         Yv67w30sciBWHeBhKmKB+KNp+JM4EfMy0LJtyCgTOn/oNL3VK4eZz1Q97a1MLzicm/30
         7WPZXtCF5B+DX4Fz0Yu6Vp2fuzD+uLrD5c+Bl25kOUPFNHgs2ObsoTxRDqLGCnZiGZkH
         Y2FXU4Xm5HkxSdzCv5FrSUFkyO4Zt5UetZQ4g2shqC/9VT4mj+3kmRagOHMVInaMe0kd
         ZIo3I+0FklmBMNj6mae4QdU/spcPqBDfR9H5fMd5YeHZbMHnw+GcumWnuk18sP0onJTX
         Kipg==
X-Received: by 10.205.137.138 with SMTP id io10mr2565810bkc.4.1365026758066;
        Wed, 03 Apr 2013 15:05:58 -0700 (PDT)
Received: from localhost.localdomain ([77.70.100.51])
        by mx.google.com with ESMTPS id fs20sm4176710bkc.8.2013.04.03.15.05.56
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 03 Apr 2013 15:05:57 -0700 (PDT)
From:   Svetoslav Neykov <svetoslav@neykov.name>
To:     linux-mips@linux-mips.org, linux-usb@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Svetoslav Neykov <svetoslav@neykov.name>
Subject: [PATCH v3 1/1] usb: chipidea: AR933x platform support for the chipidea driver
Date:   Thu,  4 Apr 2013 01:04:46 +0300
Message-Id: <1365026686-4131-2-git-send-email-svetoslav@neykov.name>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1365026686-4131-1-git-send-email-svetoslav@neykov.name>
References: <1365026686-4131-1-git-send-email-svetoslav@neykov.name>
X-Gm-Message-State: ALoCoQloQ37+l5vX78oBTrMDLFHUFLU3RD9iKmuiLGXcl3i0zV+e/itqN3vWQgPnbI3BYbtWwKh1
X-archive-position: 36010
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
 arch/mips/ath79/dev-usb.c                      |   42 ++++++++++++++++++++++++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    3 ++
 2 files changed, 45 insertions(+)

diff --git a/arch/mips/ath79/dev-usb.c b/arch/mips/ath79/dev-usb.c
index 8227265..9303bd5 100644
--- a/arch/mips/ath79/dev-usb.c
+++ b/arch/mips/ath79/dev-usb.c
@@ -19,6 +19,8 @@
 #include <linux/platform_device.h>
 #include <linux/usb/ehci_pdriver.h>
 #include <linux/usb/ohci_pdriver.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/chipidea.h>
 
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/ar71xx_regs.h>
@@ -165,6 +167,44 @@ static void __init ar913x_usb_setup(void)
 			   &ath79_ehci_pdata_v2, sizeof(ath79_ehci_pdata_v2));
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
+static void __init ar933x_ci_usb_setup(void)
+{
+	u32 bootstrap;
+	enum usb_dr_mode dr_mode;
+	struct ci13xxx_platform_data ci_pdata;
+
+	bootstrap = ath79_reset_rr(AR933X_RESET_REG_BOOTSTRAP);
+	if (bootstrap & AR933X_BOOTSTRAP_USB_MODE_HOST) {
+		dr_mode = USB_DR_MODE_HOST;
+	} else {
+		dr_mode = USB_DR_MODE_PERIPHERAL;
+		ar933x_usb_setup_ctrl_config();
+	}
+
+	memset(&ci_pdata, 0, sizeof(ci_pdata));
+	ci_pdata.name = "ci13xxx_ar933x";
+	ci_pdata.capoffset = DEF_CAPOFFSET;
+	ci_pdata.dr_mode = dr_mode;
+
+	ath79_usb_register("ci_hdrc", -1,
+			   AR933X_EHCI_BASE, AR933X_EHCI_SIZE,
+			   ATH79_CPU_IRQ(3),
+			   &ci_pdata, sizeof(ci_pdata));
+}
+
 static void __init ar933x_usb_setup(void)
 {
 	ath79_device_reset_set(AR933X_RESET_USBSUS_OVERRIDE);
@@ -180,6 +220,8 @@ static void __init ar933x_usb_setup(void)
 			   AR933X_EHCI_BASE, AR933X_EHCI_SIZE,
 			   ATH79_CPU_IRQ(3),
 			   &ath79_ehci_pdata_v2, sizeof(ath79_ehci_pdata_v2));
+
+	ar933x_ci_usb_setup();
 }
 
 static void __init ar934x_usb_setup(void)
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index b86a125..1fc9198 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -381,6 +381,7 @@
 #define AR934X_RESET_USB_PHY		BIT(4)
 #define AR934X_RESET_USBSUS_OVERRIDE	BIT(3)
 
+#define AR933X_BOOTSTRAP_USB_MODE_HOST	BIT(3)
 #define AR933X_BOOTSTRAP_REF_CLK_40	BIT(0)
 
 #define AR934X_BOOTSTRAP_SW_OPTION8	BIT(23)
@@ -401,6 +402,8 @@
 
 #define QCA955X_BOOTSTRAP_REF_CLK_40	BIT(4)
 
+#define AR933X_USB_CONFIG_HOST_ONLY	BIT(8)
+
 #define AR934X_PCIE_WMAC_INT_WMAC_MISC		BIT(0)
 #define AR934X_PCIE_WMAC_INT_WMAC_TX		BIT(1)
 #define AR934X_PCIE_WMAC_INT_WMAC_RXLP		BIT(2)
-- 
1.7.9.5
