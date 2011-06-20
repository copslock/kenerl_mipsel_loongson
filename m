Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2011 21:32:34 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:35943 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491158Ab1FTT1R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Jun 2011 21:27:17 +0200
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 25C80140221;
        Mon, 20 Jun 2011 21:27:08 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 99F41140214;
        Mon, 20 Jun 2011 21:27:07 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Kathy Giori <kgiori@qca.qualcomm.com>,
        "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>,
        Gabor Juhos <juhosg@openwrt.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org
Subject: [PATCH 09/13] USB: ehci-ath79: add device_id entry for the AR933X SoCs
Date:   Mon, 20 Jun 2011 21:26:09 +0200
Message-Id: <1308597973-6037-10-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
References: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A13192BF10D | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
X-archive-position: 30464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16505

Also make the USB_EHCI_ATH79 selectable for the AR933X SoCs.

Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
The patch should be merged via the MIPS tree.
---
 drivers/usb/host/Kconfig      |    2 +-
 drivers/usb/host/ehci-ath79.c |    4 ++++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index ab085f1..aee1e0f 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -210,7 +210,7 @@ config USB_CNS3XXX_EHCI
 
 config USB_EHCI_ATH79
 	bool "EHCI support for AR7XXX/AR9XXX SoCs"
-	depends on USB_EHCI_HCD && (SOC_AR71XX || SOC_AR724X || SOC_AR913X)
+	depends on USB_EHCI_HCD && (SOC_AR71XX || SOC_AR724X || SOC_AR913X || SOC_AR933X)
 	select USB_EHCI_ROOT_HUB_TT
 	default y
 	---help---
diff --git a/drivers/usb/host/ehci-ath79.c b/drivers/usb/host/ehci-ath79.c
index 98cc8a1..2665dd5 100644
--- a/drivers/usb/host/ehci-ath79.c
+++ b/drivers/usb/host/ehci-ath79.c
@@ -33,6 +33,10 @@ static const struct platform_device_id ehci_ath79_id_table[] = {
 		.driver_data	= EHCI_ATH79_IP_V2,
 	},
 	{
+		.name		= "ar933x-ehci",
+		.driver_data	= EHCI_ATH79_IP_V2,
+	},
+	{
 		/* terminating entry */
 	},
 };
-- 
1.7.2.1
