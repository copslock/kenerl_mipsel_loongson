Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Mar 2015 19:34:49 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42856 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012507AbbCGScPvYysn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Mar 2015 19:32:15 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4251375066ADC;
        Sat,  7 Mar 2015 18:32:07 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Sat, 7 Mar
 2015 18:32:10 +0000
Received: from fun-lab.mips.com (10.20.2.221) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Sat, 7 Mar 2015
 10:32:08 -0800
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     <macro@linux-mips.org>, Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: [PATCH v2 11/17] MIPS: sgi-ip27: Implement read_sched_clock
Date:   Sat, 7 Mar 2015 10:30:29 -0800
Message-ID: <1425753035-17087-12-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 2.3.2
In-Reply-To: <1425753035-17087-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1425753035-17087-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.2.221]
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46261
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

Use ip27 hub real time counter for sched_clock source. This implementation
will give high resolution cputime accounting.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
 arch/mips/sgi-ip27/ip27-timer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
index 1d97eab..a6d10f6 100644
--- a/arch/mips/sgi-ip27/ip27-timer.c
+++ b/arch/mips/sgi-ip27/ip27-timer.c
@@ -7,6 +7,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/sched_clock.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
 #include <linux/param.h>
@@ -159,11 +160,18 @@ struct clocksource hub_rt_clocksource = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+static u64 notrace hub_rt_read_sched_clock(void)
+{
+	return REMOTE_HUB_L(cputonasid(0), PI_RT_COUNT);
+}
+
 static void __init hub_rt_clocksource_init(void)
 {
 	struct clocksource *cs = &hub_rt_clocksource;
 
 	clocksource_register_hz(cs, CYCLES_PER_SEC);
+
+	sched_clock_register(hub_rt_read_sched_clock, 52, CYCLES_PER_SEC);
 }
 
 void __init plat_time_init(void)
-- 
2.3.2
