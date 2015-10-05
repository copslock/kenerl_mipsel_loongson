Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Oct 2015 13:31:33 +0200 (CEST)
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37337 "EHLO
        mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009490AbbJELbYjFAcV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Oct 2015 13:31:24 +0200
Received: by wicfx3 with SMTP id fx3so109701674wic.0;
        Mon, 05 Oct 2015 04:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=yMamVg8Q87/4cjANfdCzgcS87qkPLzxPJeS4cwZtPis=;
        b=UmIcmYfMznvwBS2Dac7CAzSUoWTf+8YYXNOMUdsybVzMTL25wCsaNxJ0SgBb6JHoC5
         mI+9xg5iiyXoAgSStprXHrypvCh2hZ7LFfImGtqS4f26YPSSBfbAsvEYDnsX/gqdWrPt
         WpbocOINT0hD3WlVOEdGoaTBNkebdZ5z+vEQt0B+s3WrO4di9rrSvfCnFVxpVRZytpdi
         uFynSAU/BYkc76HWEWy2VuoHUZs6YzMDpgrtBsRfBKIj3oIvnGZAhwlxWB7DAwazUtMO
         IhYemPPVUuFJiRr+NNEl2tsWVtdpwWzx1eEYaeLqB74ZseX/RhpHUAkJ4KcqAxmYT9c6
         Wc8Q==
X-Received: by 10.194.113.1 with SMTP id iu1mr34742156wjb.158.1444044679215;
        Mon, 05 Oct 2015 04:31:19 -0700 (PDT)
Received: from localhost (port-54044.pppoe.wtnet.de. [46.59.211.200])
        by smtp.gmail.com with ESMTPSA id bh5sm26403960wjb.42.2015.10.05.04.31.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2015 04:31:18 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] MIPS: jz4740: Use PWM lookup table
Date:   Mon,  5 Oct 2015 13:31:17 +0200
Message-Id: <1444044677-11518-1-git-send-email-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.5.0
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@gmail.com
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

Associate the PWM with the pwm-beeper device using a PWM lookup table.
This will eventually allow the legacy function calls to pwm_request() to
be removed from all consumer drivers.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 arch/mips/jz4740/board-qi_lb60.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index f2885adda9d0..0e6ad22d265c 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -25,6 +25,7 @@
 #include <linux/power_supply.h>
 #include <linux/power/jz4740-battery.h>
 #include <linux/power/gpio-charger.h>
+#include <linux/pwm.h>
 
 #include <asm/mach-jz4740/jz4740_fb.h>
 #include <asm/mach-jz4740/jz4740_mmc.h>
@@ -399,13 +400,15 @@ static struct platform_device avt2_usb_regulator_device = {
 	}
 };
 
+static struct pwm_lookup qi_lb60_pwm_lookup[] = {
+	PWM_LOOKUP("jz4740-pwm", 4, "pwm-beeper", NULL, 0,
+		   PWM_POLARITY_NORMAL),
+};
+
 /* beeper */
 static struct platform_device qi_lb60_pwm_beeper = {
 	.name = "pwm-beeper",
 	.id = -1,
-	.dev = {
-		.platform_data = (void *)4,
-	},
 };
 
 /* charger */
@@ -491,6 +494,8 @@ static int __init qi_lb60_init_platform_devices(void)
 		platform_device_register(&jz4740_usb_ohci_device);
 	}
 
+	pwm_add_table(qi_lb60_pwm_lookup, ARRAY_SIZE(qi_lb60_pwm_lookup));
+
 	return platform_add_devices(jz_platform_devices,
 					ARRAY_SIZE(jz_platform_devices));
 
-- 
2.5.0
