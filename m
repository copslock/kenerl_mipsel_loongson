Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 07:37:15 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:51784 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010690AbaJGFbXsqSZo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 07:31:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=B13QiruosJUXTjC1met91TjwbeZT033r9zbwyDVICO0=;
        b=s/zgqHLQT5/OxdivG5Szff2rVLZOEZBqUmirHezRM4zOoQ1AkUzEzpf8Q+3zlV2/xPO7mZILY7+uNv3ASrayKYHDY72OxWpi6Z0YXnribf9VSJeS0CJCACCYC+vCm1UXHKxykFVi+8L/obQEOU576NxsFh5MOtokA68pZ+IZ2E4=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNMj-002ldh-J9
        for linux-mips@linux-mips.org; Tue, 07 Oct 2014 05:31:17 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:32907 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNKv-002aV4-95; Tue, 07 Oct 2014 05:29:25 +0000
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
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Samuel Ortiz <sameo@linux.intel.com>
Subject: [PATCH 12/44] mfd: ab8500-sysctrl: Register with kernel poweroff handler
Date:   Mon,  6 Oct 2014 22:28:14 -0700
Message-Id: <1412659726-29957-13-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=2.8
X-CTCH-PVer: 0000001
X-CTCH-Spam: Suspect
X-CTCH-VOD: Unknown
X-CTCH-Flags: 512
X-CTCH-RefID: str=0001.0A020208.54337AA5.010A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=512,sb=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 1131
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 86
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
X-archive-position: 43017
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

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/mfd/ab8500-sysctrl.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index 8e0dae5..677438f 100644
--- a/drivers/mfd/ab8500-sysctrl.c
+++ b/drivers/mfd/ab8500-sysctrl.c
@@ -6,6 +6,7 @@
 
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/reboot.h>
@@ -23,7 +24,8 @@
 
 static struct device *sysctrl_dev;
 
-static void ab8500_power_off(void)
+static int ab8500_power_off(struct notifier_block *this, unsigned long unused1,
+			    void *unused2)
 {
 	sigset_t old;
 	sigset_t all;
@@ -34,11 +36,6 @@ static void ab8500_power_off(void)
 	struct power_supply *psy;
 	int ret;
 
-	if (sysctrl_dev == NULL) {
-		pr_err("%s: sysctrl not initialized\n", __func__);
-		return;
-	}
-
 	/*
 	 * If we have a charger connected and we're powering off,
 	 * reboot into charge-only mode.
@@ -83,8 +80,15 @@ shutdown:
 					 AB8500_STW4500CTRL1_SWRESET4500N);
 		(void)sigprocmask(SIG_SETMASK, &old, NULL);
 	}
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block ab8500_poweroff_nb = {
+	.notifier_call = ab8500_power_off,
+	.priority = 64,
+};
+
 /*
  * Use the AB WD to reset the platform. It will perform a hard
  * reset instead of a soft reset. Write the reset reason to
@@ -185,6 +189,7 @@ static int ab8500_sysctrl_probe(struct platform_device *pdev)
 	struct ab8500 *ab8500 = dev_get_drvdata(pdev->dev.parent);
 	struct ab8500_platform_data *plat;
 	struct ab8500_sysctrl_platform_data *pdata;
+	int err;
 
 	plat = dev_get_platdata(pdev->dev.parent);
 
@@ -193,8 +198,9 @@ static int ab8500_sysctrl_probe(struct platform_device *pdev)
 
 	sysctrl_dev = &pdev->dev;
 
-	if (!pm_power_off)
-		pm_power_off = ab8500_power_off;
+	err = register_poweroff_handler(&ab8500_poweroff_nb);
+	if (err)
+		dev_err(&pdev->dev, "Failed to register poweroff handler\n");
 
 	pdata = plat->sysctrl;
 	if (pdata) {
@@ -226,11 +232,9 @@ static int ab8500_sysctrl_probe(struct platform_device *pdev)
 
 static int ab8500_sysctrl_remove(struct platform_device *pdev)
 {
+	unregister_poweroff_handler(&ab8500_poweroff_nb);
 	sysctrl_dev = NULL;
 
-	if (pm_power_off == ab8500_power_off)
-		pm_power_off = NULL;
-
 	return 0;
 }
 
-- 
1.9.1
