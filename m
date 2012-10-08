Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2012 15:13:28 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:41637 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6870488Ab2JHNNRzH9k0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 8 Oct 2012 15:13:17 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 4AF61AA05F8;
        Mon,  8 Oct 2012 15:13:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wK-u32ES+nRC; Mon,  8 Oct 2012 15:13:16 +0200 (CEST)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id D7A93AA05F7;
        Mon,  8 Oct 2012 15:13:16 +0200 (CEST)
From:   Florian Fainelli <florian@openwrt.org>
To:     stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, Florian Fainelli <florian@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/32 v4] MIPS: Loongson 1B: use ehci-platform instead of ehci-ls1x.
Date:   Mon,  8 Oct 2012 15:11:17 +0200
Message-Id: <1349701906-16481-4-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1349701906-16481-1-git-send-email-florian@openwrt.org>
References: <1349701906-16481-1-git-send-email-florian@openwrt.org>
X-archive-position: 34650
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

The Loongson 1B EHCI driver does nothing more than what the EHCI platform
driver already does, so use the generic implementation.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes in v4:
- rebased against greg's latest usb-next

No changes since v1

 arch/mips/configs/ls1b_defconfig      |    1 +
 arch/mips/loongson1/common/platform.c |    8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/mips/configs/ls1b_defconfig b/arch/mips/configs/ls1b_defconfig
index 80cff8b..7eb7554 100644
--- a/arch/mips/configs/ls1b_defconfig
+++ b/arch/mips/configs/ls1b_defconfig
@@ -76,6 +76,7 @@ CONFIG_HID_GENERIC=m
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_HCD_PLATFORM=y
 # CONFIG_USB_EHCI_TT_NEWSCHED is not set
 CONFIG_USB_STORAGE=m
 CONFIG_USB_SERIAL=m
diff --git a/arch/mips/loongson1/common/platform.c b/arch/mips/loongson1/common/platform.c
index e92d59c..2874bf2 100644
--- a/arch/mips/loongson1/common/platform.c
+++ b/arch/mips/loongson1/common/platform.c
@@ -13,6 +13,7 @@
 #include <linux/phy.h>
 #include <linux/serial_8250.h>
 #include <linux/stmmac.h>
+#include <linux/usb/ehci_pdriver.h>
 #include <asm-generic/sizes.h>
 
 #include <loongson1.h>
@@ -107,13 +108,18 @@ static struct resource ls1x_ehci_resources[] = {
 	},
 };
 
+static struct usb_ehci_pdata ls1x_ehci_pdata = {
+	.port_power_off	= 1,
+};
+
 struct platform_device ls1x_ehci_device = {
-	.name		= "ls1x-ehci",
+	.name		= "ehci-platform",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(ls1x_ehci_resources),
 	.resource	= ls1x_ehci_resources,
 	.dev		= {
 		.dma_mask = &ls1x_ehci_dmamask,
+		.platform_data = &ls1x_ehci_pdata,
 	},
 };
 
-- 
1.7.9.5
