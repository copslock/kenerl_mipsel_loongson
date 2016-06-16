Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jun 2016 23:29:30 +0200 (CEST)
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38099 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042654AbcFPV32ey0o- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Jun 2016 23:29:28 +0200
Received: by mail-wm0-f52.google.com with SMTP id m124so86982025wme.1
        for <linux-mips@linux-mips.org>; Thu, 16 Jun 2016 14:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=62+V+FtrgDqz2jTwhqhFybSs8bf02jV04Ww8vyMQGZM=;
        b=UkqJ7H8z6YwUDN5fdYBIOzTVpZ72iXKgIyzkMyLghvE1PMJUN8kpfYEs6tOeSY5Ib1
         X9lOKsmtITVw8+XzIHPx9ckI3X6FopMB1xKiI/gRFZyQWDu93/5eNlnXNxKdR8ul1MIs
         EatsWtvINOsWKdhJHJyL87odYhKfPO3vTPiRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=62+V+FtrgDqz2jTwhqhFybSs8bf02jV04Ww8vyMQGZM=;
        b=bHgYvSsxccLI0BDTacKp8BZTBqfbB4zDHrpQo9lymzSRhQaTXTlUZrPZMsKO8ixask
         cGIFa0GzYULV4zJwgCXeDGzuY4pp78CjwnbhXU0GpBRtaxO5Bjy/3at6LjaeaVB1Esbp
         tprxVP4Q2E8hHsPI3tnrCGeys3fxW48mrWgC82eZmpu9V2QpJS3K8klQHH5GYDCDx9P/
         FKwOlotSjzzMA9lhc+QbADform9LUx/S1rEVcXnOZlMUSqXDscudR9izwCtb07MyZSZV
         tJvT9qG0TKE70o0sPYIvPucqg/EsfKkziT372NuONg+8vXXeN5YvCEvNHk6D3tu3f61H
         1GAA==
X-Gm-Message-State: ALyK8tI65UZKz3Fnkjz62Zph9vqGHcXCTt+YQj8r6au/tn8DhBK9YGd15LkTSqmkFCn5s7wy
X-Received: by 10.28.140.194 with SMTP id o185mr5152578wmd.86.1466112563282;
        Thu, 16 Jun 2016 14:29:23 -0700 (PDT)
Received: from localhost.localdomain (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.gmail.com with ESMTPSA id x128sm16705606wmf.6.2016.06.16.14.29.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jun 2016 14:29:22 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org (open list:RALINK MIPS ARCHI...)
Subject: [PATCH V2 57/63] clocksource/drivers/ralink: Convert init function to return error
Date:   Thu, 16 Jun 2016 23:27:16 +0200
Message-Id: <1466112442-31105-58-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54082
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
