Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 07:39:19 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:51834 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010666AbaJGFb3TkTUW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 07:31:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=3/uDnzKkwzNsSiksMNXxFi6zTrcbJE9jH82ZnT7EV94=;
        b=ZcUhORLwAvPYytgCwN9Rel+43DSdDe97Sp8JAVjCwLdDIb3Tj3C/lFemM8CIIFLlBV9Zfd4Ewjp0UTLcF0t+f+4kcKvIaH5E6MRd7E9gBw/VCpxJYxUxgvoU9m6PewdK7vQmuTFlKVvb6i8GZ3xw1jnw5m5FAf98a4mlsrphUDc=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNMo-002m60-Pe
        for linux-mips@linux-mips.org; Tue, 07 Oct 2014 05:31:22 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:32913 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNL8-002bS5-PH; Tue, 07 Oct 2014 05:29:39 +0000
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
        Samuel Ortiz <sameo@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 18/44] mfd: twl4030-power: Register with kernel poweroff handler
Date:   Mon,  6 Oct 2014 22:28:20 -0700
Message-Id: <1412659726-29957-19-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=2.8
X-CTCH-PVer: 0000001
X-CTCH-Spam: Suspect
X-CTCH-VOD: Unknown
X-CTCH-Flags: 512
X-CTCH-RefID: str=0001.0A020206.54337AAB.0023,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=512,sb=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 1169
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 104
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
X-archive-position: 43024
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

Make twl4030_power_off static as it is only called from the twl4030-power
driver.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/mfd/twl4030-power.c | 25 +++++++++++++++++++++----
 include/linux/i2c/twl.h     |  1 -
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 4d3ff37..bd6b830 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -25,9 +25,10 @@
  */
 
 #include <linux/module.h>
-#include <linux/pm.h>
+#include <linux/notifier.h>
 #include <linux/i2c/twl.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 
@@ -611,7 +612,8 @@ twl4030_power_configure_resources(const struct twl4030_power_data *pdata)
  * After a successful execution, TWL shuts down the power to the SoC
  * and all peripherals connected to it.
  */
-void twl4030_power_off(void)
+static int twl4030_power_off(struct notifier_block *this, unsigned long unused1,
+			     void *unused2)
 {
 	int err;
 
@@ -619,8 +621,15 @@ void twl4030_power_off(void)
 			       TWL4030_PM_MASTER_P1_SW_EVENTS);
 	if (err)
 		pr_err("TWL4030 Unable to power off\n");
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block twl4030_poweroff_nb = {
+	.notifier_call = twl4030_power_off,
+	.priority = 64,
+};
+
 static bool twl4030_power_use_poweroff(const struct twl4030_power_data *pdata,
 					struct device_node *node)
 {
@@ -836,7 +845,7 @@ static int twl4030_power_probe(struct platform_device *pdev)
 	}
 
 	/* Board has to be wired properly to use this feature */
-	if (twl4030_power_use_poweroff(pdata, node) && !pm_power_off) {
+	if (twl4030_power_use_poweroff(pdata, node)) {
 		/* Default for SEQ_OFFSYNC is set, lets ensure this */
 		err = twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &val,
 				      TWL4030_PM_MASTER_CFG_P123_TRANSITION);
@@ -853,7 +862,13 @@ static int twl4030_power_probe(struct platform_device *pdev)
 			}
 		}
 
-		pm_power_off = twl4030_power_off;
+		err = register_poweroff_handler(&twl4030_poweroff_nb);
+		if (err) {
+			dev_err(&pdev->dev,
+				"Failed to register poweroff handler\n");
+			/* Not a fatal error */
+			err = 0;
+		}
 	}
 
 relock:
@@ -869,6 +884,8 @@ relock:
 
 static int twl4030_power_remove(struct platform_device *pdev)
 {
+	unregister_poweroff_handler(&twl4030_poweroff_nb);
+
 	return 0;
 }
 
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 8cfb50f..f8544f1 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -680,7 +680,6 @@ struct twl4030_power_data {
 };
 
 extern int twl4030_remove_script(u8 flags);
-extern void twl4030_power_off(void);
 
 struct twl4030_codec_data {
 	unsigned int digimic_delay; /* in ms */
-- 
1.9.1
