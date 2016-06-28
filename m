Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jun 2016 12:34:36 +0200 (CEST)
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37408 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008161AbcF1KednC7A2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Jun 2016 12:34:33 +0200
Received: by mail-wm0-f52.google.com with SMTP id a66so20976993wme.0
        for <linux-mips@linux-mips.org>; Tue, 28 Jun 2016 03:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=62+V+FtrgDqz2jTwhqhFybSs8bf02jV04Ww8vyMQGZM=;
        b=R749o49wIJAXnNC8agr6p4Uid1prVvy3IfjeyhFG8tx8ISSAYARIat3ywcGSL2PTPO
         bPtuDj34BbWjY9kH8HW5uu4PTiIzuzdY3zmnTTUHW+3gEH4HH+KL2GNrDlXaIXrZaNQ5
         rSbZIHLe7YoueyxFP1F+n1A29cJmmV7G7XqCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=62+V+FtrgDqz2jTwhqhFybSs8bf02jV04Ww8vyMQGZM=;
        b=JKc8QsuIg1dVldi+LkfMpD73Dsf2/bmr9924V7t8Wjw8c+87EurN2fa4VuODjSVHYl
         F1n9IBR92tRXWAXNpGepIyjyhzdW4MZuk2l1XcltZzntRTP0c64cCv/OTf/TNotDU99m
         GqsGqF8kyl1ANwW0bZAw2A490fDbqaNh+HVvSL4Y667v9wEoccdaU9ZGkPV2WnJR7Biu
         B5OMBQO6tpTEotwOYpQxv0uT67osXWlHcpfl3ti4ytZWyEb8kjlYRdGw68kmwRLg+euv
         QV1DGxjJUce+loU8VKLIjymBnmXPq6nSFjkqEZ9u8N8xsW6+xxMRlhw1eGbJI0e/gNyg
         FiKA==
X-Gm-Message-State: ALyK8tIAeAjiZ2A5F4XCUo+K5SYXfhgEXEPFe1hDwXIutZqedDjKyK4IaIou0beiWyeeO7yb
X-Received: by 10.28.193.14 with SMTP id r14mr4490716wmf.94.1467110067879;
        Tue, 28 Jun 2016 03:34:27 -0700 (PDT)
Received: from localhost.localdomain (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.gmail.com with ESMTPSA id a84sm5377403wma.0.2016.06.28.03.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jun 2016 03:34:27 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 66/92] clocksource/drivers/ralink: Convert init function to return error
Date:   Tue, 28 Jun 2016 12:31:25 +0200
Message-Id: <1467109911-11060-66-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1467109911-11060-1-git-send-email-daniel.lezcano@linaro.org>
References: <577251A4.7030508@linaro.org>
 <1467109911-11060-1-git-send-email-daniel.lezcano@linaro.org>
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.lezcano@linaro.org
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

The init functions do not return any error. They behave as the following:

  - panic, thus leading to a kernel crash while another timer may work and
       make the system boot up correctly

  or

  - print an error and let the caller unaware if the state of the system

Change that by converting the init functions to return an error conforming
to the CLOCKSOURCE_OF_RET prototype.

Proper error handling (rollback, errno value) will be changed later case
by case, thus this change just return back an error or success in the init
function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/mips/ralink/cevt-rt3352.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/mips/ralink/cevt-rt3352.c b/arch/mips/ralink/cevt-rt3352.c
index 3ad0b07..f2d3c79 100644
--- a/arch/mips/ralink/cevt-rt3352.c
+++ b/arch/mips/ralink/cevt-rt3352.c
@@ -117,11 +117,13 @@ static int systick_set_oneshot(struct clock_event_device *evt)
 	return 0;
 }
 
-static void __init ralink_systick_init(struct device_node *np)
+static int __init ralink_systick_init(struct device_node *np)
 {
+	int ret;
+
 	systick.membase = of_iomap(np, 0);
 	if (!systick.membase)
-		return;
+		return -ENXIO;
 
 	systick_irqaction.name = np->name;
 	systick.dev.name = np->name;
@@ -131,16 +133,21 @@ static void __init ralink_systick_init(struct device_node *np)
 	systick.dev.irq = irq_of_parse_and_map(np, 0);
 	if (!systick.dev.irq) {
 		pr_err("%s: request_irq failed", np->name);
-		return;
+		return -EINVAL;
 	}
 
-	clocksource_mmio_init(systick.membase + SYSTICK_COUNT, np->name,
-			SYSTICK_FREQ, 301, 16, clocksource_mmio_readl_up);
+	ret = clocksource_mmio_init(systick.membase + SYSTICK_COUNT, np->name,
+				    SYSTICK_FREQ, 301, 16,
+				    clocksource_mmio_readl_up);
+	if (ret)
+		return ret;
 
 	clockevents_register_device(&systick.dev);
 
 	pr_info("%s: running - mult: %d, shift: %d\n",
 			np->name, systick.dev.mult, systick.dev.shift);
+
+	return 0;
 }
 
-CLOCKSOURCE_OF_DECLARE(systick, "ralink,cevt-systick", ralink_systick_init);
+CLOCKSOURCE_OF_DECLARE_RET(systick, "ralink,cevt-systick", ralink_systick_init);
-- 
1.9.1
