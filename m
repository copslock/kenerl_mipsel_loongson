Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2016 10:04:21 +0200 (CEST)
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38064 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992424AbcGGIEMxjDh6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jul 2016 10:04:12 +0200
Received: by mail-wm0-f52.google.com with SMTP id n127so5827110wme.1
        for <linux-mips@linux-mips.org>; Thu, 07 Jul 2016 01:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=62+V+FtrgDqz2jTwhqhFybSs8bf02jV04Ww8vyMQGZM=;
        b=G7PKPd3asct1TJy4b9uZboCimFhdXfA9Cb/CkCleQoyMW4/2QSSmT2aasi2cr9sdS4
         vOwRN4zMxeICf6yNG5gpk8kEkgaFOgYMp/SjsgO5w/re7cbXglZazjNbMyCp8cLpSbHx
         aUy5javcCuEmg1NhiYirymxyQN+ek3wWoKpMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=62+V+FtrgDqz2jTwhqhFybSs8bf02jV04Ww8vyMQGZM=;
        b=Ey24Nu7Xrnf0Epsjq4J6zT9baStVuNGEhxDQwCsxPUDxjg2FKAxTVTNNiV6sME6m1g
         jQZKtuD0CdgYoIc+uXAN0zBA8ds2MvFohi4hGxPaaM3o3mCZz3Gn8RFSIODK80W0z4pn
         GJfRoV6q4iW4WIDtvDP7eQBbgKwpw5pZhc5VOX4p/TEHrLbiJNH7/v5+ZXkZT9rZFZ6k
         enVIZA+0fZSKCKGKPP5fL4p7pgwKSSKBUtuGLDuRA87h8KgEHJiVhA7eMLzGH3/S4zg/
         Gh/ERQlthVT5QBnSyBgzzi/jFFJs80vOMeodNK/SxHdKMd+QgpE+g2TfEQ2v3Hol2Auu
         kbIQ==
X-Gm-Message-State: ALyK8tK+qsdMFeIbs1sLkqgTqe4JPCtkNkUK00EMDyzlcMLLo3qNnfqrrpKaU0MFb5s7FEJJ
X-Received: by 10.28.143.212 with SMTP id r203mr24418652wmd.35.1467878645512;
        Thu, 07 Jul 2016 01:04:05 -0700 (PDT)
Received: from localhost.localdomain (lft31-1-88-121-166-205.fbx.proxad.net. [88.121.166.205])
        by smtp.gmail.com with ESMTPSA id v70sm51327wmf.18.2016.07.07.01.04.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Jul 2016 01:04:05 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 66/93] clocksource/drivers/ralink: Convert init function to return error
Date:   Thu,  7 Jul 2016 10:01:39 +0200
Message-Id: <1467878526-1238-66-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1467878526-1238-1-git-send-email-daniel.lezcano@linaro.org>
References: <577E0BED.3020608@linaro.org>
 <1467878526-1238-1-git-send-email-daniel.lezcano@linaro.org>
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54244
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
