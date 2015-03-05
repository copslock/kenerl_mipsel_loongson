Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2015 02:02:38 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57719 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012189AbbCEA7reIFp8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Mar 2015 01:59:47 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 388EB2A3E58D9;
        Thu,  5 Mar 2015 00:59:38 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 5 Mar
 2015 00:59:42 +0000
Received: from fun-lab.mips.com (10.20.2.221) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 4 Mar 2015
 16:59:40 -0800
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: [PATCH 12/15] MIPS: jz4740: Implement read_sched_clock
Date:   Wed, 4 Mar 2015 16:58:54 -0800
Message-ID: <1425517137-26463-13-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1425517137-26463-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1425517137-26463-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.2.221]
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

Use jz4740 timer counter for sched_clock source. This implementation will
give high resolution cputime accounting.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
 arch/mips/jz4740/time.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/jz4740/time.c b/arch/mips/jz4740/time.c
index 5e430ce..72b0cecb 100644
--- a/arch/mips/jz4740/time.c
+++ b/arch/mips/jz4740/time.c
@@ -18,6 +18,7 @@
 #include <linux/time.h>
 
 #include <linux/clockchips.h>
+#include <linux/sched_clock.h>
 
 #include <asm/mach-jz4740/irq.h>
 #include <asm/mach-jz4740/timer.h>
@@ -43,6 +44,11 @@ static struct clocksource jz4740_clocksource = {
 	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+static u64 notrace jz4740_read_sched_clock(void)
+{
+	return jz4740_timer_get_count(TIMER_CLOCKSOURCE);
+}
+
 static irqreturn_t jz4740_clockevent_irq(int irq, void *devid)
 {
 	struct clock_event_device *cd = devid;
@@ -126,6 +132,8 @@ void __init plat_time_init(void)
 	if (ret)
 		printk(KERN_ERR "Failed to register clocksource: %d\n", ret);
 
+	sched_clock_register(jz4740_read_sched_clock, 16, clk_rate);
+
 	setup_irq(JZ4740_IRQ_TCU0, &timer_irqaction);
 
 	ctrl = JZ_TIMER_CTRL_PRESCALE_16 | JZ_TIMER_CTRL_SRC_EXT;
-- 
1.8.5.3
