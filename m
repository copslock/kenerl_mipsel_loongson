Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 07:33:22 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:51468 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010678AbaJGFa7YQRuH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 07:30:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=jSv1A0iGDwJOZ0eAO+kS+95MK7kD4hVCLcWqbgH0MJw=;
        b=7j7oC318vobKwAczHsF3Vg58RtAEVXcAjvqEOSnLeSICwm5IfUWUWkvlgn82rZyswXHubPtyBrpvHupqdKWz28W5TcHBVJpsFNk3eP4zLEQogXWKxvGpk+QagFBjwpHid3mxWZhMOU0c8+RVQiZmx7AKFdeLcMkS4kjw9oFwJxQ=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNML-002iZC-1h
        for linux-mips@linux-mips.org; Tue, 07 Oct 2014 05:30:53 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:32918 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNLG-002bgp-US; Tue, 07 Oct 2014 05:29:47 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     adi-buildroot-devel@lists.sourceforge.net,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        lguest@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-am33-list@redhat.com,
        linux-cris-kernel@axis.com, linux-efi@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m32r-ja@ml.linux-m32r.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        openipmi-developer@lists.sourceforge.net,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 21/44] power/reset: gpio-poweroff: Register with kernel poweroff handler
Date:   Mon,  6 Oct 2014 22:28:23 -0700
Message-Id: <1412659726-29957-22-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=0.3
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020206.54337A8D.0089,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 890
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 0
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

Register with kernel poweroff handler instead of setting pm_power_off
directly. Register with a low priority value of 64 to reflect that
the original code only sets pm_power_off if it was not already set.

Other changes:

Drop note that there can not be an additional instance of this driver.
The original reason no longer applies, it should be obvious that there
can only be one instance of the driver if static variables are used to
reflect its state, and support for multiple instances can now be added
easily if needed by avoiding static variables.

Do not create an error message if another poweroff handler has already been
registered. This is perfectly normal and acceptable.

Do not display a warning traceback if the poweroff handler fails to
power off the system. There may be other poweroff handlers.

Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/power/reset/gpio-poweroff.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gpio-poweroff.c
index ce849bc..e95a7a1 100644
--- a/drivers/power/reset/gpio-poweroff.c
+++ b/drivers/power/reset/gpio-poweroff.c
@@ -14,18 +14,18 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/notifier.h>
+#include <linux/pm.h>
 #include <linux/platform_device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of_platform.h>
 #include <linux/module.h>
 
-/*
- * Hold configuration here, cannot be more than one instance of the driver
- * since pm_power_off itself is global.
- */
 static struct gpio_desc *reset_gpio;
 
-static void gpio_poweroff_do_poweroff(void)
+static int gpio_poweroff_do_poweroff(struct notifier_block *this,
+				     unsigned long unused1, void *unused2)
+
 {
 	BUG_ON(!reset_gpio);
 
@@ -42,20 +42,18 @@ static void gpio_poweroff_do_poweroff(void)
 	/* give it some time */
 	mdelay(3000);
 
-	WARN_ON(1);
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block gpio_poweroff_nb = {
+	.notifier_call = gpio_poweroff_do_poweroff,
+	.priority = 64,
+};
+
 static int gpio_poweroff_probe(struct platform_device *pdev)
 {
 	bool input = false;
-
-	/* If a pm_power_off function has already been added, leave it alone */
-	if (pm_power_off != NULL) {
-		dev_err(&pdev->dev,
-			"%s: pm_power_off function already registered",
-		       __func__);
-		return -EBUSY;
-	}
+	int err;
 
 	reset_gpio = devm_gpiod_get(&pdev->dev, NULL);
 	if (IS_ERR(reset_gpio))
@@ -77,14 +75,16 @@ static int gpio_poweroff_probe(struct platform_device *pdev)
 		}
 	}
 
-	pm_power_off = &gpio_poweroff_do_poweroff;
-	return 0;
+	err = register_poweroff_handler(&gpio_poweroff_nb);
+	if (err)
+		dev_err(&pdev->dev, "Failed to register poweroff handler\n");
+
+	return err;
 }
 
 static int gpio_poweroff_remove(struct platform_device *pdev)
 {
-	if (pm_power_off == &gpio_poweroff_do_poweroff)
-		pm_power_off = NULL;
+	unregister_poweroff_handler(&gpio_poweroff_nb);
 
 	return 0;
 }
-- 
1.9.1
