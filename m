Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Dec 2010 15:29:15 +0100 (CET)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:36741 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491022Ab0LVO3M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Dec 2010 15:29:12 +0100
Received: by vws5 with SMTP id 5so1966273vws.36
        for <multiple recipients>; Wed, 22 Dec 2010 06:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=ziC+gyI7yK3WCyafHo2RJ1yj4XbyAfv7VfB4xVWs2CE=;
        b=aI4CYGgM+yaMKPxNbFml5HQsmEAtNQr9sVoKqPv2pG5jFMFDSAfxAKEbiJtj7FNaeT
         F0/BRAdRajLoN+3b36r2XRGTNPNyxgVe9DARL2fx9meLxXvDT2j3wa1GNVDoDtQ7rVCi
         BnOIKBKeqSoc9lmJZr0jKIcWGDqK9e90OMiqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DFBRRDdB8xY4+AEFPg1e7a6onemgbYYNhChMR8vYJLRE53ThN4eNNr4JZIVfWYiTxU
         4D8ZgrRd7Z+7q3iFTpiovbwdS/PmDL3H8YVJ5uzyyp84XzURWdVPs/lfsgIZZrrPO3dW
         iPBkbd/H2MWpVlsRUF48XG9kUepvomrBkHPD8=
Received: by 10.220.194.197 with SMTP id dz5mr1924193vcb.113.1293028139785;
        Wed, 22 Dec 2010 06:28:59 -0800 (PST)
Received: from localhost.localdomain ([59.160.135.215])
        by mx.google.com with ESMTPS id g27sm2364430vby.4.2010.12.22.06.28.53
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 22 Dec 2010 06:28:59 -0800 (PST)
From:   "Anoop P.A" <anoop.pa@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Anatolij Gustschin <agust@denx.de>,
        Anand Gadiyar <gadiyar@ti.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Sarah Sharp <sarah.a.sharp@linux.intel.com>,
        Oliver Neukum <oneukum@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Paul Mortier <mortier@btinternet.com>,
        Andiry Xu <andiry.xu@amd.com>
Cc:     Anoop P A <anoop.pa@gmail.com>
Subject: [PATCH V2 2/2] MSP onchip root hub over current quirk.
Date:   Wed, 22 Dec 2010 20:06:50 +0530
Message-Id: <1293028610-22233-1-git-send-email-anoop.pa@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <y>
References: <y>
In-Reply-To: <1292929580-5829-1-git-send-email-anoop.pa@gmail.com>
References: <1292929580-5829-1-git-send-email-anoop.pa@gmail.com>
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

From: Anoop P A <anoop.pa@gmail.com>

Adding chip specific code under quirk.

Signed-off-by: Anoop P A <anoop.pa@gmail.com>
---
 drivers/usb/core/hub.c     |   45 ++++++++++++++++++++++++++++++++++++++-----
 drivers/usb/core/quirks.c  |    3 ++
 include/linux/usb/quirks.h |    3 ++
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 27115b4..4bff994 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3377,12 +3377,45 @@ static void hub_events(void)
 			}
 			
 			if (portchange & USB_PORT_STAT_C_OVERCURRENT) {
-				dev_err (hub_dev,
-					"over-current change on port %d\n",
-					i);
-				clear_port_feature(hdev, i,
-					USB_PORT_FEAT_C_OVER_CURRENT);
-				hub_power_on(hub, true);
+				usb_detect_quirks(hdev);
+				if (hdev->quirks & USB_QUIRK_MSP_OVERCURRENT) {
+					/* clear OCC bit */
+					clear_port_feature(hdev, i,
+						USB_PORT_FEAT_C_OVER_CURRENT);
+
+					/* This step is required to toggle the
+					* PP bit to 0 and 1 (by hub_power_on)
+					* in order the CSC bit to be
+					* transitioned properly for device
+					* hotplug
+					*/
+					/* clear PP bit */
+					clear_port_feature(hdev, i,
+						USB_PORT_FEAT_POWER);
+
+					/* resume power */
+					hub_power_on(hub, true);
+
+					/* delay 100 usec */
+					udelay(100);
+
+					/* read OCA bit */
+					if (portstatus &
+					(1<<USB_PORT_FEAT_OVER_CURRENT)) {
+						/* declare overcurrent */
+						dev_err(hub_dev,
+						"over-current change \
+							on port %d\n", i);
+					}
+				} else {
+					dev_err(hub_dev,
+						"over-current change \
+							on port %d\n", i);
+					clear_port_feature(hdev, i,
+						USB_PORT_FEAT_C_OVER_CURRENT);
+					hub_power_on(hub, true);
+				}
+
 			}
 
 			if (portchange & USB_PORT_STAT_C_RESET) {
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 25719da..59843b9 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -88,6 +88,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* INTEL VALUE SSD */
 	{ USB_DEVICE(0x8086, 0xf1a5), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* PMC MSP over current quirk */
+	{ USB_DEVICE(0x1d6b, 0x0002), .driver_info = USB_QUIRK_MSP_OVERCURRENT },
+
 	{ }  /* terminating entry must be last */
 };
 
diff --git a/include/linux/usb/quirks.h b/include/linux/usb/quirks.h
index 3e93de7..97ab168 100644
--- a/include/linux/usb/quirks.h
+++ b/include/linux/usb/quirks.h
@@ -30,4 +30,7 @@
    descriptor */
 #define USB_QUIRK_DELAY_INIT		0x00000040
 
+/*MSP SoC onchip EHCI overcurrent issue */
+#define USB_QUIRK_MSP_OVERCURRENT	0x00000080
+
 #endif /* __LINUX_USB_QUIRKS_H */
-- 
1.7.0.4
