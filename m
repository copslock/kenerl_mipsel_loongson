Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Dec 2011 19:32:29 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:46150 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903781Ab1LWS0Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Dec 2011 19:26:24 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id D6F0A23C007C;
        Fri, 23 Dec 2011 19:26:23 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>,
        mcgrof@infradead.org, Gabor Juhos <juhosg@openwrt.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org
Subject: [PATCH 15/16] USB: ehci-ath79: add device_id entry for the AR934X SoCs
Date:   Fri, 23 Dec 2011 19:25:41 +0100
Message-Id: <1324664742-3648-16-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1324664742-3648-1-git-send-email-juhosg@openwrt.org>
References: <1324664742-3648-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 32189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19103

Also make the USB_EHCI_ATH79 selectable for the AR934X SoCs.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Acked-by: Luis R. Rodriguez <mcgrof@qca.qualcomm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-usb@vger.kernel.org
---
 drivers/usb/host/Kconfig      |    2 +-
 drivers/usb/host/ehci-ath79.c |    4 ++++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 8b094b4..d5c8fb6 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -210,7 +210,7 @@ config USB_CNS3XXX_EHCI
 
 config USB_EHCI_ATH79
 	bool "EHCI support for AR7XXX/AR9XXX SoCs"
-	depends on USB_EHCI_HCD && (SOC_AR71XX || SOC_AR724X || SOC_AR913X || SOC_AR933X)
+	depends on USB_EHCI_HCD && (SOC_AR71XX || SOC_AR724X || SOC_AR913X || SOC_AR933X || SOC_AR934X)
 	select USB_EHCI_ROOT_HUB_TT
 	default y
 	---help---
diff --git a/drivers/usb/host/ehci-ath79.c b/drivers/usb/host/ehci-ath79.c
index f1424f9..2a21733 100644
--- a/drivers/usb/host/ehci-ath79.c
+++ b/drivers/usb/host/ehci-ath79.c
@@ -37,6 +37,10 @@ static const struct platform_device_id ehci_ath79_id_table[] = {
 		.driver_data	= EHCI_ATH79_IP_V2,
 	},
 	{
+		.name		= "ar934x-ehci",
+		.driver_data	= EHCI_ATH79_IP_V2,
+	},
+	{
 		/* terminating entry */
 	},
 };
-- 
1.7.2.1
