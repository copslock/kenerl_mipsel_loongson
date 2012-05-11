Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 May 2012 00:06:43 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:45752 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903700Ab2EKWFk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 May 2012 00:05:40 +0200
Received: by dadm1 with SMTP id m1so4139956dad.36
        for <linux-mips@linux-mips.org>; Fri, 11 May 2012 15:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ZbeyLsoJIcUwYH3OqnDkbGcu/+yeZ6NrP3Zp9SRI19M=;
        b=UxygDlXBFFeslrEFyHaxJ7uNG2WaVONSqTi2VK5FZr4MtR3VMUfW/IVUtWguk3+dYF
         pB8+AQBZ+AVP/aZ7mTP8NCNswSkDrW/D+Wcy/dlIRSkp4aDcWue+d/p1nw4Kuaozjf0s
         2y2eeANDXVcZb6G7zohiDa6scq5/GqAQwAMGQ9ewoFaoScZIXozwlRh9mjLdKUqBBEfg
         lcNUEHcSx82tVjB/K8KsPUbEQPTlBWuzb/rA1KZZlcJE3k7IkPAirQnMmrND1nY+GQui
         AYSkEb94alqNhj7581AG0VmzOj2xQtAAU3o8w5Pe/MBlDjxyXK9pWH7JKhhfALYEG32p
         kgsg==
Received: by 10.68.72.70 with SMTP id b6mr36464132pbv.58.1336773934590;
        Fri, 11 May 2012 15:05:34 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id kb12sm13962126pbb.15.2012.05.11.15.05.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 May 2012 15:05:33 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q4BM5V48017922;
        Fri, 11 May 2012 15:05:31 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q4BM5Vi6017921;
        Fri, 11 May 2012 15:05:31 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        spi-devel-general@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 3/3] eeprom/of: Add device tree bindings to at25.
Date:   Fri, 11 May 2012 15:05:23 -0700
Message-Id: <1336773923-17866-4-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1336773923-17866-1-git-send-email-ddaney.cavm@gmail.com>
References: <1336773923-17866-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

We can extract the "pagesize", "size" and "address-width" from the
device tree so that SPI eeproms can be fully specified in the device
tree.

Also add a MODULE_DEVICE_TABLE so the drivers can be automatically bound.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Axel Lin <axel.lin@gmail.com>
---
 drivers/misc/eeprom/at25.c |   61 +++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 01ab3c9..609ee72 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/sched.h>
+#include <linux/of.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/eeprom.h>
@@ -293,6 +294,9 @@ static int at25_probe(struct spi_device *spi)
 {
 	struct at25_data	*at25 = NULL;
 	const struct spi_eeprom *chip;
+#ifdef CONFIG_OF
+	struct spi_eeprom of_chip;
+#endif
 	int			err;
 	int			sr;
 	int			addrlen;
@@ -300,9 +304,51 @@ static int at25_probe(struct spi_device *spi)
 	/* Chip description */
 	chip = spi->dev.platform_data;
 	if (!chip) {
-		dev_dbg(&spi->dev, "no chip description\n");
-		err = -ENODEV;
-		goto fail;
+#ifdef CONFIG_OF
+		if (spi->dev.of_node) {
+			u32 val;
+			memset(&of_chip, 0, sizeof(of_chip));
+			if (of_property_read_u32(spi->dev.of_node, "pagesize", &val)) {
+				dev_dbg(&spi->dev, "no \"pagesize\" property\n");
+				err = -ENODEV;
+				goto fail;
+			}
+			of_chip.page_size = val;
+			if (of_property_read_u32(spi->dev.of_node, "size", &val)) {
+				dev_dbg(&spi->dev, "no \"size\" property\n");
+				err = -ENODEV;
+				goto fail;
+			}
+			of_chip.byte_len = val;
+			if (of_property_read_u32(spi->dev.of_node, "address-width", &val)) {
+				dev_dbg(&spi->dev, "no \"address-width\" property\n");
+				err = -ENODEV;
+				goto fail;
+			}
+			switch (val) {
+			case 8:
+				of_chip.flags |= EE_ADDR1;
+				break;
+			case 16:
+				of_chip.flags |= EE_ADDR2;
+				break;
+			case 24:
+				of_chip.flags |= EE_ADDR3;
+				break;
+			default:
+				dev_dbg(&spi->dev, "bad \"address-width\" property: %u\n", val);
+				err = -EINVAL;
+				goto fail;
+			}
+			strlcpy(of_chip.name, spi->dev.of_node->name, sizeof(of_chip.name));
+			chip = &of_chip;
+		} else
+#endif
+		{
+			dev_dbg(&spi->dev, "no chip description\n");
+			err = -ENODEV;
+			goto fail;
+		}
 	}
 
 	/* For now we only support 8/16/24 bit addressing */
@@ -396,11 +442,19 @@ static int __devexit at25_remove(struct spi_device *spi)
 
 /*-------------------------------------------------------------------------*/
 
+static const struct spi_device_id at25_id[] = {
+	{"at25", 0},
+	{"m95256", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, at25_id);
+
 static struct spi_driver at25_driver = {
 	.driver = {
 		.name		= "at25",
 		.owner		= THIS_MODULE,
 	},
+	.id_table	= at25_id,
 	.probe		= at25_probe,
 	.remove		= __devexit_p(at25_remove),
 };
@@ -410,4 +464,3 @@ module_spi_driver(at25_driver);
 MODULE_DESCRIPTION("Driver for most SPI EEPROMs");
 MODULE_AUTHOR("David Brownell");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("spi:at25");
-- 
1.7.2.3
