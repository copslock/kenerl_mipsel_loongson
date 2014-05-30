Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2014 13:31:43 +0200 (CEST)
Received: from mail-lb0-f182.google.com ([209.85.217.182]:42676 "EHLO
        mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6830035AbaE3LbbEBbKI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 May 2014 13:31:31 +0200
Received: by mail-lb0-f182.google.com with SMTP id z11so911994lbi.41
        for <linux-mips@linux-mips.org>; Fri, 30 May 2014 04:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xuGysKWR3TH9UkYmaQ3mmey1LIO4E5V1fY9L8HQiDr8=;
        b=WvKvoMuOp6nE3CVTiMT+5TfHUxuTUYsLvdMmIB2HkADDYmMJzXtiH22iJq2LEaL5k2
         hGfM/CfNwrwugY85pKvO8BcWMCiRiwfCoVPUTV7kkkq6L19pyju6057z3QvfjFibk5XT
         ic1MK7av4Xb1VSZoo+yGey0OQ/+2o8NhZ4aWwP+yERB1fVeRirSvNBXgkx41DxEjDfGE
         JUaiTFsardOXvfeLfKEUCJwAq204MIFAElseakfjOxBNNcGhUyOQ4LFoQxen5BNThyr1
         BN9eg1MfFsZDmSsym0NmFtSy78N3gAfzHtxn3gIxq1HZo/n390nxoVkRB7Y+3OGtyqQt
         vtZQ==
X-Received: by 10.112.157.162 with SMTP id wn2mr11397173lbb.38.1401449485665;
        Fri, 30 May 2014 04:31:25 -0700 (PDT)
Received: from aberthe-MacBookAir.lan (c-d360e555.1712-24-64736c16.cust.bredbandsbolaget.se. [85.229.96.211])
        by mx.google.com with ESMTPSA id o8sm3045407laj.10.2014.05.30.04.31.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 30 May 2014 04:31:24 -0700 (PDT)
From:   abdoulaye berthe <berthe.ab@gmail.com>
To:     linus.walleij@linaro.org, gnurou@gmail.com, m@bues.ch,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
        linux-samsungsoc@vger.kernel.org, spear-devel@list.st.com,
        platform-driver-x86@vger.kernel.org, netdev@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc:     abdoulaye berthe <berthe.ab@gmail.com>
Subject: [PATCH 2/2] gpio: gpiolib: set gpiochip_remove retval to void
Date:   Fri, 30 May 2014 13:30:54 +0200
Message-Id: <1401449454-30895-2-git-send-email-berthe.ab@gmail.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1401449454-30895-1-git-send-email-berthe.ab@gmail.com>
References: <20140530094025.3b78301e@canb.auug.org.au>
 <1401449454-30895-1-git-send-email-berthe.ab@gmail.com>
Return-Path: <berthe.ab@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: berthe.ab@gmail.com
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

This avoids handling gpiochip remove error in device
remove handler.

Signed-off-by: abdoulaye berthe <berthe.ab@gmail.com>
---
 drivers/gpio/gpiolib.c      | 24 +++++++-----------------
 include/linux/gpio/driver.h |  2 +-
 2 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index f48817d..022543f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1263,10 +1263,9 @@ static void gpiochip_irqchip_remove(struct gpio_chip *gpiochip);
  *
  * A gpio_chip with any GPIOs still requested may not be removed.
  */
-int gpiochip_remove(struct gpio_chip *chip)
+void gpiochip_remove(struct gpio_chip *chip)
 {
 	unsigned long	flags;
-	int		status = 0;
 	unsigned	id;
 
 	acpi_gpiochip_remove(chip);
@@ -1278,24 +1277,15 @@ int gpiochip_remove(struct gpio_chip *chip)
 	of_gpiochip_remove(chip);
 
 	for (id = 0; id < chip->ngpio; id++) {
-		if (test_bit(FLAG_REQUESTED, &chip->desc[id].flags)) {
-			status = -EBUSY;
-			break;
-		}
-	}
-	if (status == 0) {
-		for (id = 0; id < chip->ngpio; id++)
-			chip->desc[id].chip = NULL;
-
-		list_del(&chip->list);
+		if (test_bit(FLAG_REQUESTED, &chip->desc[id].flags))
+			panic("gpio: removing gpiochip with gpios still requested\n");
 	}
+	for (id = 0; id < chip->ngpio; id++)
+		chip->desc[id].chip = NULL;
 
+	list_del(&chip->list);
 	spin_unlock_irqrestore(&gpio_lock, flags);
-
-	if (status == 0)
-		gpiochip_unexport(chip);
-
-	return status;
+	gpiochip_unexport(chip);
 }
 EXPORT_SYMBOL_GPL(gpiochip_remove);
 
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 1827b43..72ed256 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -138,7 +138,7 @@ extern const char *gpiochip_is_requested(struct gpio_chip *chip,
 
 /* add/remove chips */
 extern int gpiochip_add(struct gpio_chip *chip);
-extern int __must_check gpiochip_remove(struct gpio_chip *chip);
+void gpiochip_remove(struct gpio_chip *chip);
 extern struct gpio_chip *gpiochip_find(void *data,
 			      int (*match)(struct gpio_chip *chip, void *data));
 
-- 
1.8.3.2
