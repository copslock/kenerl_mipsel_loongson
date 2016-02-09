Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 09:16:27 +0100 (CET)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35617 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011990AbcBIIOhTpN05 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 09:14:37 +0100
Received: by mail-lf0-f65.google.com with SMTP id j99so5995431lfi.2
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 00:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I/LCWAe+1GlSM23/VcEFcCb/Xrh4VHEbKsCgWLKojqU=;
        b=F0Zm2HTPbNEGpTbUbhqPGIwht/A2Weg/yt5z/Hg7+qddzC8L/A3pnd0CQojEpK9vV/
         rjOjyPNS1jHkNTrQjPXOCZHomqUlVbSt5RJmOcJdpmVMTv6Y9EdnMzH8Lgp5BhWPphtZ
         eyjx5mGNHM4VeiKhqkIga5sMrQPDA3SFFntCHaapAW3aUJM0lSb77ZzCYP+wQb+olJoJ
         HLyQGi9sMRHtQnzpCUziWTyMXZk8fvYIQUZdiKrjFo+NaB6Ma2MZ14W5KZWtQi1DvadE
         SiCHTfNdIQfg69sMtr2wOUry7/knSWRJX4usl8o3b6dZXHlvKdAD0G4BAGrS/4s3oUZJ
         0Fkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I/LCWAe+1GlSM23/VcEFcCb/Xrh4VHEbKsCgWLKojqU=;
        b=DNm7tQEowMDpqw/uoO/thpZeOE0nJAAC4E0h//yaOIpjiEWFdMwRqZWneluMYxRjfa
         F3oNoIMpTG4QGBe4s2aa/tYeRn/y8u/aSrzK59mBPAntz6sZyRA6OongVqzBFt/S2u6a
         7URivq4XEIiVGig8girWE78RuptPrlD3t60V2tl3WMLNufcum2mHGO6mdXXk+4YWqm0t
         Xju5db7Dynpg0yJQxUv57iTct4OQrjI0l3h3X4Fuz+VawYhVtJzcLcHAzew+WO2zWRyy
         MEVSwzfANWpMDHvzCLMsIRB18zEp2+j7yQmtQICsnvjpqn2qr/M4Chk2c8hf3Ftfz+Tg
         iP4A==
X-Gm-Message-State: AG10YOStj7jDnNL6wmlqHnpl9okiROab9R5U4Nbm4kj+/i3U/TzpjRkmmnHJGe228PUdww==
X-Received: by 10.25.137.136 with SMTP id l130mr11540312lfd.158.1455005672008;
        Tue, 09 Feb 2016 00:14:32 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id v140sm212726lfd.24.2016.02.09.00.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 00:14:31 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC v5 07/15] usb: ehci: add vbus-gpio parameter
Date:   Tue,  9 Feb 2016 11:13:53 +0300
Message-Id: <1455005641-7079-8-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

This patch retrieves and configures the vbus control gpio via
the device tree.

This patch is based on a ehci-s5p.c commit fd81d59c90d38661
("USB: ehci-s5p: Add vbus setup function to the s5p ehci glue layer").

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/usb/host/ehci-platform.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index bd7082f2..0d95ced 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -28,6 +28,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_gpio.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
@@ -142,6 +143,25 @@ static struct usb_ehci_pdata ehci_platform_defaults = {
 	.power_off =		ehci_platform_power_off,
 };
 
+static void setup_vbus_gpio(struct device *dev)
+{
+	int err;
+	int gpio;
+
+	if (!dev->of_node)
+		return;
+
+	gpio = of_get_named_gpio(dev->of_node, "vbus-gpio", 0);
+	if (!gpio_is_valid(gpio))
+		return;
+
+	err = devm_gpio_request_one(dev, gpio,
+				GPIOF_OUT_INIT_HIGH | GPIOF_EXPORT_DIR_FIXED,
+				"ehci_vbus_gpio");
+	if (err)
+		dev_err(dev, "can't request ehci vbus gpio %d", gpio);
+}
+
 static int ehci_platform_probe(struct platform_device *dev)
 {
 	struct usb_hcd *hcd;
@@ -174,6 +194,8 @@ static int ehci_platform_probe(struct platform_device *dev)
 		return irq;
 	}
 
+	setup_vbus_gpio(&dev->dev);
+
 	hcd = usb_create_hcd(&ehci_platform_hc_driver, &dev->dev,
 			     dev_name(&dev->dev));
 	if (!hcd)
-- 
2.7.0
