Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2014 20:05:49 +0200 (CEST)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:50120 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010204AbaI3SBvm5-8L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Sep 2014 20:01:51 +0200
Received: by mail-pd0-f180.google.com with SMTP id fp1so5594571pdb.25
        for <linux-mips@linux-mips.org>; Tue, 30 Sep 2014 11:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wg2XW74gD/Zbn5fEfiZUMJ6VabrKK3ppqtzol0flCAQ=;
        b=vH0+RmoDA7HlG2CqFCPAXzFnaE3CT4mY72JrZpjpTj9rRSKAaOkP11DutEJA1/RtK3
         fKE+UZOsw9NWxTdFIAzUI21bNCBxrERZte20hURLgZZa4ZAlxqVFm11sfq31l+vIB2Mw
         5+rBOJ5bbjZ+krP3r0HHSlklB1Lcpl+Ntf41Wr5WK6EzHmPx2/tj5ggpaMv8D8mCpvkl
         awNlLK9LCGgV+7cGgRZ+9jcwbtdKp6cb/MbClQm1p5v2VWhP4E5OxwZK8eTmr2wH3clP
         vy10kT6VhPlpJCavgPfxLLc+AwaXnjGpX+nl2i/1t3ii3AxRmRBDUxLeP+0Dj9s2pWaF
         kWhA==
X-Received: by 10.70.51.136 with SMTP id k8mr28637449pdo.132.1412100105817;
        Tue, 30 Sep 2014 11:01:45 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id rz8sm15716763pbc.63.2014.09.30.11.01.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Sep 2014 11:01:45 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [RFC PATCH 15/16] power/reset: restart-poweroff: Register with kernel poweroff handler
Date:   Tue, 30 Sep 2014 11:00:55 -0700
Message-Id: <1412100056-15517-16-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42921
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

Register with kernel poweroff handler instead of seting pm_power_off
directly.  Register as poweroff handler of last resort since the driver
does not really power off the system but executes a restart.

Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/power/reset/restart-poweroff.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/power/reset/restart-poweroff.c b/drivers/power/reset/restart-poweroff.c
index edd707e..82d058f 100644
--- a/drivers/power/reset/restart-poweroff.c
+++ b/drivers/power/reset/restart-poweroff.c
@@ -12,35 +12,33 @@
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/notifier.h>
 #include <linux/platform_device.h>
 #include <linux/of_platform.h>
 #include <linux/module.h>
 #include <linux/reboot.h>
-#include <asm/system_misc.h>
 
-static void restart_poweroff_do_poweroff(void)
+static int restart_poweroff_do_poweroff(struct notifier_block *this,
+					unsigned long unused1, void *unused2)
 {
 	reboot_mode = REBOOT_HARD;
 	machine_restart(NULL);
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block restart_poweroff_handler = {
+	.notifier_call = restart_poweroff_do_poweroff,
+};
+
 static int restart_poweroff_probe(struct platform_device *pdev)
 {
-	/* If a pm_power_off function has already been added, leave it alone */
-	if (pm_power_off != NULL) {
-		dev_err(&pdev->dev,
-			"pm_power_off function already registered");
-		return -EBUSY;
-	}
-
-	pm_power_off = &restart_poweroff_do_poweroff;
-	return 0;
+	return register_restart_handler(&restart_poweroff_handler);
 }
 
 static int restart_poweroff_remove(struct platform_device *pdev)
 {
-	if (pm_power_off == &restart_poweroff_do_poweroff)
-		pm_power_off = NULL;
+	unregister_restart_handler(&restart_poweroff_handler);
 
 	return 0;
 }
-- 
1.9.1
