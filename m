Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2017 23:51:49 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61205 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993944AbdFBVvKac6SF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Jun 2017 23:51:10 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id DAEE1B4378926;
        Fri,  2 Jun 2017 22:50:59 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Jun 2017 22:51:04
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 6/7] MIPS: CPS: Handle cores not powering down more gracefully
Date:   Fri, 2 Jun 2017 14:48:54 -0700
Message-ID: <20170602214856.4545-7-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170602214856.4545-1-paul.burton@imgtec.com>
References: <20170602214856.4545-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58160
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

If we get into a state where a core that ought to power down isn't doing
so then the current result is that another CPU gets stuck inside
cps_cpu_die() waiting for CPU that ought to be powering down to do so.
The best case scenario is that we then trigger RCU stall messages or
lockup messages, but neither makes it particularly clear what's
happening.

Handle this more gracefully by introducing a timeout beyond which we
warn the user that the core didn't power down & stop waiting for it.
This at least allows the CPU running cps_cpu_die() to continue normally,
and hopefully presuming the CPU that powered back up is doing nothing
harmful the system will continue functioning as normal.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/kernel/smp-cps.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 90ecd099c4b0..f832e99ad4c3 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -490,6 +490,7 @@ static void cps_cpu_die(unsigned int cpu)
 {
 	unsigned core = cpu_data[cpu].core;
 	unsigned int vpe_id = cpu_vpe_id(&cpu_data[cpu]);
+	ktime_t fail_time;
 	unsigned stat;
 	int err;
 
@@ -516,6 +517,7 @@ static void cps_cpu_die(unsigned int cpu)
 		 * state, the latter happening when a JTAG probe is connected
 		 * in which case the CPC will refuse to power down the core.
 		 */
+		fail_time = ktime_add_ms(ktime_get(), 2000);
 		do {
 			mips_cm_lock_other(core, 0);
 			mips_cpc_lock_other(core);
@@ -523,9 +525,28 @@ static void cps_cpu_die(unsigned int cpu)
 			stat &= CPC_Cx_STAT_CONF_SEQSTATE_MSK;
 			mips_cpc_unlock_other();
 			mips_cm_unlock_other();
-		} while (stat != CPC_Cx_STAT_CONF_SEQSTATE_D0 &&
-			 stat != CPC_Cx_STAT_CONF_SEQSTATE_D2 &&
-			 stat != CPC_Cx_STAT_CONF_SEQSTATE_U2);
+
+			if (stat == CPC_Cx_STAT_CONF_SEQSTATE_D0 ||
+			    stat == CPC_Cx_STAT_CONF_SEQSTATE_D2 ||
+			    stat == CPC_Cx_STAT_CONF_SEQSTATE_U2)
+				break;
+
+			/*
+			 * The core ought to have powered down, but didn't &
+			 * now we don't really know what state it's in. It's
+			 * likely that its _pwr_up pin has been wired to logic
+			 * 1 & it powered back up as soon as we powered it
+			 * down...
+			 *
+			 * The best we can do is warn the user & continue in
+			 * the hope that the core is doing nothing harmful &
+			 * might behave properly if we online it later.
+			 */
+			if (WARN(ktime_after(ktime_get(), fail_time),
+				 "CPU%u hasn't powered down, seq. state %u\n",
+				 cpu, stat >> CPC_Cx_STAT_CONF_SEQSTATE_SHF))
+				break;
+		} while (1);
 
 		/* Indicate the core is powered off */
 		bitmap_clear(core_power, core, 1);
-- 
2.13.0
