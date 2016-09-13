Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2016 18:57:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37928 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992285AbcIMQ5jeNxce (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Sep 2016 18:57:39 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8F857DA76E8AC;
        Tue, 13 Sep 2016 17:57:19 +0100 (IST)
Received: from localhost (10.100.200.124) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 13 Sep
 2016 17:57:23 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] clocksource: mips-gic-timer: Stop checking cpu_has_counter
Date:   Tue, 13 Sep 2016 17:56:44 +0100
Message-ID: <20160913165644.627-2-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160913165644.627-1-paul.burton@imgtec.com>
References: <20160913165644.627-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.124]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The cpu_has_counter macro indicates whether the current CPU has a
working coprocessor 0 count & compare registers, and has no bearing on
the GIC. Stop checking it.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 drivers/clocksource/mips-gic-timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 802055b..7a960cd 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -109,7 +109,7 @@ static int gic_clockevent_init(void)
 {
 	int ret;
 
-	if (!cpu_has_counter || !gic_frequency)
+	if (!gic_frequency)
 		return -ENXIO;
 
 	ret = setup_percpu_irq(gic_timer_irq, &gic_compare_irqaction);
-- 
2.9.3
