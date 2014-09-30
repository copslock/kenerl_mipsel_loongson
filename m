Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2014 20:06:07 +0200 (CEST)
Received: from mail-pd0-f181.google.com ([209.85.192.181]:42424 "EHLO
        mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010205AbaI3SByNVqNg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Sep 2014 20:01:54 +0200
Received: by mail-pd0-f181.google.com with SMTP id z10so5560216pdj.26
        for <linux-mips@linux-mips.org>; Tue, 30 Sep 2014 11:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s7ufAtV/ZoQ2+ziCYficZ7QndekSVO3B0hrlF3X88LQ=;
        b=E7XBhfMWgo1ACzLXjlN4D9zrCMI88vNgFKUk1rLu9okB8VbTquFJQw9fonbmgWv4wj
         /9Jlg62RHfVIXgDINbemqnwuXm9l6cOE9UcBgeQMpnHUuuIFgN/KvauT5qFmTQatsvaY
         4Q9Cp4R0c/pfts2BW+QPVOmd8qaYESOLnYX3HS2MNCdmIJsYQ74q4gAgciRzDRM7B3Dn
         CUsP0rn0bSAuA4NjzC1BxQfet7ogkqF6sVa0X8GpG3uujRD0t3uavdxbKyDy6goi6HYm
         QyqTeFDTyM/F/4pSEgHuBoJhWqsHp8Hmx2IlVaGVyDISZqCexD/gsK9RIHYcksGkUEUC
         McMg==
X-Received: by 10.70.87.169 with SMTP id az9mr87830076pdb.63.1412100108312;
        Tue, 30 Sep 2014 11:01:48 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id z1sm15802891pdb.21.2014.09.30.11.01.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Sep 2014 11:01:47 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [RFC PATCH 16/16] mfd: palmas: Register with kernel poweroff handler
Date:   Tue, 30 Sep 2014 11:00:56 -0700
Message-Id: <1412100056-15517-17-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42922
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
directly.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/mfd/palmas.c       | 30 +++++++++++++++++-------------
 include/linux/mfd/palmas.h |  3 +++
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index 28cb048..e8ef345a 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -19,6 +19,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/reboot.h>
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
+			palmas->poweroff_nb.priority = 128;
+			ret = register_poweroff_handler(&palmas->poweroff_nb);
+			if (ret) {
+				dev_err(palmas->dev,
+					"cannot register poweroff handler");
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
