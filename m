Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2015 02:03:11 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34409 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012230AbbCEA7wiaMF0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Mar 2015 01:59:52 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 463D7C0F0076F;
        Thu,  5 Mar 2015 00:59:43 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 5 Mar
 2015 00:59:47 +0000
Received: from fun-lab.mips.com (10.20.2.221) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 4 Mar 2015
 16:59:45 -0800
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: [PATCH 14/15] MIPS: csrc-sb1250: Implement read_sched_clock
Date:   Wed, 4 Mar 2015 16:58:56 -0800
Message-ID: <1425517137-26463-15-git-send-email-dengcheng.zhu@imgtec.com>
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
X-archive-position: 46180
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

Use sb1250 hpt for sched_clock source. This implementation will give high
resolution cputime accounting.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
 arch/mips/kernel/csrc-sb1250.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/kernel/csrc-sb1250.c b/arch/mips/kernel/csrc-sb1250.c
index df84836..6546fff 100644
--- a/arch/mips/kernel/csrc-sb1250.c
+++ b/arch/mips/kernel/csrc-sb1250.c
@@ -12,6 +12,7 @@
  * GNU General Public License for more details.
  */
 #include <linux/clocksource.h>
+#include <linux/sched_clock.h>
 
 #include <asm/addrspace.h>
 #include <asm/io.h>
@@ -46,6 +47,11 @@ struct clocksource bcm1250_clocksource = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+static u64 notrace sb1250_read_sched_clock(void)
+{
+	return sb1250_hpt_read(NULL);
+}
+
 void __init sb1250_clocksource_init(void)
 {
 	struct clocksource *cs = &bcm1250_clocksource;
@@ -62,4 +68,6 @@ void __init sb1250_clocksource_init(void)
 						 R_SCD_TIMER_CFG)));
 
 	clocksource_register_hz(cs, V_SCD_TIMER_FREQ);
+
+	sched_clock_register(sb1250_read_sched_clock, 23, V_SCD_TIMER_FREQ);
 }
-- 
1.8.5.3
