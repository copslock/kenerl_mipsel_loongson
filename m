Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 21:06:33 +0200 (CEST)
Received: from mail-ob0-f201.google.com ([209.85.214.201]:61208 "EHLO
        mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011973AbaJTTERd1rVt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 21:04:17 +0200
Received: by mail-ob0-f201.google.com with SMTP id m8so827083obr.2
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 12:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iRsuCuQqcyrQbbT8Ep22CvfCTIuniajIWFuHOs5T55U=;
        b=IUTBGX7EO2+LC8NXdKHeRWIzMhouJm/z0VmPPLqn/KcknYjiHODZNtAQnIv9ZVLWW9
         spJ70eQvRd4CzOPLUDqHfsVUVq/Q8TIg2zwNlNESOpvhImhHy0v2mSEZFwMzNfELm3lM
         DPKyNut69QynAkKs6lKXnqCXMF0BJhHapmohxI2WoiRtK5yXJK0X5rnhgo3y1WVpASfm
         yzht8yS2Rf35Er1Jq5ZPdB1GUL+Xai/OkeCqz0e1kDYxuGZVLTHyvysFAnTD3C4JYqPr
         7NnhX8MsIvtOGjMHFL7AmFc5zis1LStFIm0wZrkWNxE2PBFxkEPvOQms3HRa4LQysrR6
         K/Qw==
X-Gm-Message-State: ALoCoQkhXIssB8DDCuIEMnzSB/yX/fEV+cUDMw0ba7EjskVegZaIYilmmw7917oLgT0MPdNjSuxD
X-Received: by 10.50.111.135 with SMTP id ii7mr13125623igb.0.1413831851733;
        Mon, 20 Oct 2014 12:04:11 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n24si435316yha.6.2014.10.20.12.04.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Oct 2014 12:04:11 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id SSPIjhGM.2; Mon, 20 Oct 2014 12:04:11 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id BE41E220B55; Mon, 20 Oct 2014 12:04:10 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/19] irqchip: mips-gic: Clean up #includes
Date:   Mon, 20 Oct 2014 12:03:55 -0700
Message-Id: <1413831846-32100-9-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
References: <1413831846-32100-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Sort the #includes and remove those which are unnecessary.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/irqchip/irq-mips-gic.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index adcb9b2..a1ccde6 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -7,19 +7,16 @@
  * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
 #include <linux/bitmap.h>
+#include <linux/clocksource.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/irqchip/mips-gic.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
-#include <linux/irq.h>
-#include <linux/clocksource.h>
 
-#include <asm/io.h>
 #include <asm/setup.h>
 #include <asm/traps.h>
-#include <linux/hardirq.h>
-#include <asm-generic/bitops/find.h>
 
 unsigned int gic_frequency;
 unsigned int gic_present;
-- 
2.1.0.rc2.206.gedb03e5
