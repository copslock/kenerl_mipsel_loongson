Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 07:42:39 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:52116 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010669AbaJGFcHiLjS2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 07:32:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=RGGZb7qJJC2L2icaJmDZrW2KX/dc9GyS/oXuJdZKDpw=;
        b=rJqaPjmqAMMUGv4PPcOb3swbqr0qBcNb8uNJw9FAeX68DCdBFW1ieTnJVqcjFgrF665XfryJFuubbiduLzIjhbn283CUUrwu5aCV50spCba6DNvgwr50byYlhKelQVfM9Ip3NgPOfvp+uRKxb/Nu+pDPaNKkF6g7izC0SxSH580=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNNR-002oO0-Cp
        for linux-mips@linux-mips.org; Tue, 07 Oct 2014 05:32:01 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:32946 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNM9-002hSH-SM; Tue, 07 Oct 2014 05:30:42 +0000
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
        Jean Delvare <jdelvare@suse.de>
Subject: [PATCH 43/44] hwmon: (ab8500) Call kernel_power_off instead of pm_power_off
Date:   Mon,  6 Oct 2014 22:28:45 -0700
Message-Id: <1412659726-29957-44-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=2.8
X-CTCH-PVer: 0000001
X-CTCH-Spam: Suspect
X-CTCH-VOD: Unknown
X-CTCH-Flags: 512
X-CTCH-RefID: str=0001.0A020206.54337AD1.00DA,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=512,sb=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 1370
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 185
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
X-archive-position: 43036
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

Drivers should not call pm_power_off directly; it is not guaranteed
to be non-NULL. Call kernel_power_off instead.

Cc: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ab8500.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ab8500.c b/drivers/hwmon/ab8500.c
index d844dc8..8b6a4f4 100644
--- a/drivers/hwmon/ab8500.c
+++ b/drivers/hwmon/ab8500.c
@@ -6,7 +6,7 @@
  *
  * When the AB8500 thermal warning temperature is reached (threshold cannot
  * be changed by SW), an interrupt is set, and if no further action is taken
- * within a certain time frame, pm_power off will be called.
+ * within a certain time frame, kernel_power_off will be called.
  *
  * When AB8500 thermal shutdown temperature is reached a hardware shutdown of
  * the AB8500 will occur.
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/power/ab8500.h>
+#include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include "abx500.h"
@@ -106,7 +107,7 @@ static void ab8500_thermal_power_off(struct work_struct *work)
 
 	dev_warn(&abx500_data->pdev->dev, "Power off due to critical temp\n");
 
-	pm_power_off();
+	kernel_power_off();
 }
 
 static ssize_t ab8500_show_name(struct device *dev,
-- 
1.9.1
