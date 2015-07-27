Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jul 2015 16:02:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51448 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011267AbbG0OB3zSTrd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jul 2015 16:01:29 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5AA60F41C044E;
        Mon, 27 Jul 2015 15:01:21 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 27 Jul
 2015 15:01:23 +0100
Received: from imgworks-VB.kl.imgtec.org (192.168.167.141) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 27 Jul 2015 15:01:23 +0100
From:   Govindraj Raja <govindraj.raja@imgtec.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        <devicetree@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <James.Hartley@imgtec.com>,
        "Govindraj Raja" <Govindraj.Raja@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH v4 2/7] clocksource: mips-gic: Add missing error returns checks
Date:   Mon, 27 Jul 2015 15:00:13 +0100
Message-ID: <1438005618-27003-3-git-send-email-govindraj.raja@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1438005618-27003-1-git-send-email-govindraj.raja@imgtec.com>
References: <1438005618-27003-1-git-send-email-govindraj.raja@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.167.141]
Return-Path: <Govindraj.Raja@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: govindraj.raja@imgtec.com
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

From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

This commit adds the required checks on the functions that return
an error. Some of them are not critical, so only a warning is
printed.

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 drivers/clocksource/mips-gic-timer.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 913585d..c4352f0 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -100,12 +100,18 @@ static struct notifier_block gic_cpu_nb = {
 
 static int gic_clockevent_init(void)
 {
+	int ret;
+
 	if (!cpu_has_counter || !gic_frequency)
 		return -ENXIO;
 
-	setup_percpu_irq(gic_timer_irq, &gic_compare_irqaction);
+	ret = setup_percpu_irq(gic_timer_irq, &gic_compare_irqaction);
+	if (ret < 0)
+		return ret;
 
-	register_cpu_notifier(&gic_cpu_nb);
+	ret = register_cpu_notifier(&gic_cpu_nb);
+	if (ret < 0)
+		pr_warn("GIC: Unable to register CPU notifier\n");
 
 	gic_clockevent_cpu_init(this_cpu_ptr(&gic_clockevent_device));
 
@@ -125,13 +131,17 @@ static struct clocksource gic_clocksource = {
 
 static void __init __gic_clocksource_init(void)
 {
+	int ret;
+
 	/* Set clocksource mask. */
 	gic_clocksource.mask = CLOCKSOURCE_MASK(gic_get_count_width());
 
 	/* Calculate a somewhat reasonable rating value. */
 	gic_clocksource.rating = 200 + gic_frequency / 10000000;
 
-	clocksource_register_hz(&gic_clocksource, gic_frequency);
+	ret = clocksource_register_hz(&gic_clocksource, gic_frequency);
+	if (ret < 0)
+		pr_warn("GIC: Unable to register clocksource\n");
 
 	gic_clockevent_init();
 
-- 
1.9.1
