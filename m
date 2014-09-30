Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2014 20:02:53 +0200 (CEST)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:41779 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010187AbaI3SB0l2cIr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Sep 2014 20:01:26 +0200
Received: by mail-pa0-f42.google.com with SMTP id et14so2292278pad.29
        for <linux-mips@linux-mips.org>; Tue, 30 Sep 2014 11:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UQk2ZZIEsVV7XoBvwBpR2xNqiFttFEVsvwGJrA9ovjo=;
        b=RpgJOc5f6D4ezqK8vg12ZsWDCubAigAMtWGnSg09mE3LDY2cksZZ0QTwtto/Ra15ax
         yDO7QBUwhaqRqjfuIeEQH+T6Hor5SLCAR6m10hb/43wJcfd1PCRQAzi7SHtcJnQ+gnS9
         EOmoNWNZalEbu0nnRVJ+W72p87mGOQ6sAoBX20q7TSwWpQyaMg8mEZHqIpLRjlGP/ZBq
         TGo2Ol4D0/QlIDtuktQl+RyZA0XtqnNq7rwkwhfSBBW4BvyBNZsGxNce6KPzqnsK3e7s
         hzmro+ZTqCXzp4yTMb4x860bb61Jigw2Dmo4oQ9PlOmQ6gqu7J9zTMhFIrSTfILrfZZt
         8+2g==
X-Received: by 10.68.95.227 with SMTP id dn3mr72199435pbb.108.1412100075765;
        Tue, 30 Sep 2014 11:01:15 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id f2sm15798823pdd.25.2014.09.30.11.01.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Sep 2014 11:01:15 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>
Subject: [RFC PATCH 03/16] parisc: support poweroff through poweroff handler call chain
Date:   Tue, 30 Sep 2014 11:00:43 -0700
Message-Id: <1412100056-15517-4-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42911
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

The kernel core now supports a poweroff handler call chain
to remove power from the system. Call it from machine_power_off.

Also, do not use pm_power_off as alternate pointer to machine_power_off.
Have the parisc/power driver call kernel_power_off() which in turn will
call machine_power_off().

Cc: James E.J. Bottomley <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/parisc/kernel/process.c | 7 +++++--
 drivers/parisc/power.c       | 3 +--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index 0bbbf0d..21d1ab3 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -42,6 +42,7 @@
 #include <linux/module.h>
 #include <linux/personality.h>
 #include <linux/ptrace.h>
+#include <linux/reboot.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/stddef.h>
@@ -133,7 +134,9 @@ void machine_power_off(void)
 	pdc_soft_power_button(0);
 	
 	pdc_chassis_send_status(PDC_CHASSIS_DIRECT_SHUTDOWN);
-		
+
+	do_kernel_poweroff();
+
 	/* It seems we have no way to power the system off via
 	 * software. The user has to press the button himself. */
 
@@ -141,7 +144,7 @@ void machine_power_off(void)
 	       "Please power this system off now.");
 }
 
-void (*pm_power_off)(void) = machine_power_off;
+void (*pm_power_off)(void);
 EXPORT_SYMBOL(pm_power_off);
 
 /*
diff --git a/drivers/parisc/power.c b/drivers/parisc/power.c
index 90cca5e..de5b2ff 100644
--- a/drivers/parisc/power.c
+++ b/drivers/parisc/power.c
@@ -95,8 +95,7 @@ static void process_shutdown(void)
 		/* send kill signal */
 		if (kill_cad_pid(SIGINT, 1)) {
 			/* just in case killing init process failed */
-			if (pm_power_off)
-				pm_power_off();
+			kernel_power_off();
 		}
 	}
 }
-- 
1.9.1
