Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 07:35:36 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:51655 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010683AbaJGFbMqSpkk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 07:31:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=S43PgswNqqxpYh10AHneJ6OTl/IqMCEOwGzzM9XPqeE=;
        b=xDRleZJseO9wHZTRBrs1e1nGRQ+PBTrmmCD7/iCfWaMsu47lTKMSoU9zwSWVT8K0iHom5GmgbWa4xEZcnG6c5saWbfmJsUUfyrtrLoEPir/mdRk+rq2gR+nenrzKdV7uQ3sGQfVUbT5V4oY2O3QbrRlZjbGCt15fClpc1HciN7E=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNMY-002kDE-DL
        for linux-mips@linux-mips.org; Tue, 07 Oct 2014 05:31:06 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:32904 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNKo-002aNb-P6; Tue, 07 Oct 2014 05:29:19 +0000
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
Subject: [PATCH 09/44] mfd: palmas: Register with kernel poweroff handler
Date:   Mon,  6 Oct 2014 22:28:11 -0700
Message-Id: <1412659726-29957-10-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=2.8
X-CTCH-PVer: 0000001
X-CTCH-Spam: Suspect
X-CTCH-VOD: Unknown
X-CTCH-Flags: 512
X-CTCH-RefID: str=0001.0A020207.54337A9A.00E3,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=512,sb=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 1033
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 39
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
X-archive-position: 43011
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

Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/mfd/palmas.c       | 30 +++++++++++++++++-------------
 include/linux/mfd/palmas.h |  3 +++
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index 28cb048..4d78847 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -19,6 +19,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/err.h>
 #include <linux/mfd/core.h>
@@ -425,20 +426,18 @@ static void palmas_dt_to_pdata(struct i2c_client *i2c,
 			"ti,system-power-controller");
 }
 
-static struct palmas *palmas_dev;
-static void palmas_power_off(void)
+static int palmas_power_off(struct notifier_block *this, unsigned long unused1,
+			    void *unused2)
 {
+	struct palmas *palmas = container_of(this, struct palmas, poweroff_nb);
 	unsigned int addr;
 	int ret, slave;
 
-	if (!palmas_dev)
-		return;
-
 	slave = PALMAS_BASE_TO_SLAVE(PALMAS_PMU_CONTROL_BASE);
 	addr = PALMAS_BASE_TO_REG(PALMAS_PMU_CONTROL_BASE, PALMAS_DEV_CTRL);
 
 	ret = regmap_update_bits(
-			palmas_dev->regmap[slave],
+			palmas->regmap[slave],
 			addr,
 			PALMAS_DEV_CTRL_DEV_ON,
 			0);
@@ -446,6 +445,8 @@ static void palmas_power_off(void)
 	if (ret)
 		pr_err("%s: Unable to write to DEV_CTRL_DEV_ON: %d\n",
 				__func__, ret);
+
+	return NOTIFY_DONE;
 }
 
 static unsigned int palmas_features = PALMAS_PMIC_FEATURE_SMPS10_BOOST;
@@ -668,9 +669,15 @@ no_irq:
 		ret = of_platform_populate(node, NULL, NULL, &i2c->dev);
 		if (ret < 0) {
 			goto err_irq;
-		} else if (pdata->pm_off && !pm_power_off) {
-			palmas_dev = palmas;
-			pm_power_off = palmas_power_off;
+		} else if (pdata->pm_off) {
+			palmas->poweroff_nb.notifier_call = palmas_power_off;
+			palmas->poweroff_nb.priority = 64;
+			ret = register_poweroff_handler(&palmas->poweroff_nb);
+			if (ret) {
+				dev_err(palmas->dev,
+					"Failed to register poweroff handler");
+				ret = 0;
+			}
 		}
 	}
 
@@ -698,10 +705,7 @@ static int palmas_i2c_remove(struct i2c_client *i2c)
 			i2c_unregister_device(palmas->i2c_clients[i]);
 	}
 
-	if (palmas == palmas_dev) {
-		pm_power_off = NULL;
-		palmas_dev = NULL;
-	}
+	unregister_poweroff_handler(&palmas->poweroff_nb);
 
 	return 0;
 }
diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
index fb0390a..4715057 100644
--- a/include/linux/mfd/palmas.h
+++ b/include/linux/mfd/palmas.h
@@ -18,6 +18,7 @@
 
 #include <linux/usb/otg.h>
 #include <linux/leds.h>
+#include <linux/notifier.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/extcon.h>
@@ -68,6 +69,8 @@ struct palmas {
 	struct i2c_client *i2c_clients[PALMAS_NUM_CLIENTS];
 	struct regmap *regmap[PALMAS_NUM_CLIENTS];
 
+	struct notifier_block poweroff_nb;
+
 	/* Stored chip id */
 	int id;
 
-- 
1.9.1
