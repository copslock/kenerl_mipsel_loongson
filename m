Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2014 20:02:01 +0200 (CEST)
Received: from mail-pd0-f181.google.com ([209.85.192.181]:38477 "EHLO
        mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010154AbaI3SBTSFoXC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Sep 2014 20:01:19 +0200
Received: by mail-pd0-f181.google.com with SMTP id z10so5559344pdj.26
        for <linux-mips@linux-mips.org>; Tue, 30 Sep 2014 11:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9PcH9vkqtbwsQEhiONThBwmzk2VQhEfeE7yLBkZxmg8=;
        b=SF6B8zhBABnJvHJcJpUhdlVKHl4srwi2kmAkFGImYdDKRg7wRv9uPAo8ouWn4WvJGc
         DfcKipMxk2k7unsqfOQ4D+YcPKOoQnkzscGCYFA6CffrqNlA9oF4n2Qg3B5iwLQ8/Kky
         TugkkGbVBhcSdRuaVY/oU5LjCwWnCesRw9EUANsHE9wNPAzP1SEpZIXS5QfumaFSYpLN
         UlJbdgjlZAFtlATlSNlNoixWS7w2y9aA8cvdaub7cONnDj+4mp1+3EIvBDUgbpbTt/VX
         nhlSV9jtGdgXBWVQ1F6hXoizor4KjQSOISt/2vWhFyDQ9h5oNelLtufDv56ROWV5M2Lc
         ksHQ==
X-Received: by 10.69.20.10 with SMTP id gy10mr38012021pbd.119.1412100073196;
        Tue, 30 Sep 2014 11:01:13 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id n3sm6561773pda.7.2014.09.30.11.01.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Sep 2014 11:01:12 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.de>
Subject: [RFC PATCH 02/16] hwmon: (ab8500) Call kernel_power_off instead of pm_power_off
Date:   Tue, 30 Sep 2014 11:00:42 -0700
Message-Id: <1412100056-15517-3-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42908
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
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
I already submitted this patch separately as non-RFC. It is included
in this series for completeness.

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
