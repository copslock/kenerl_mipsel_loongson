Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 20:14:31 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11938 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009093AbbIVSOY5WMdU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 20:14:24 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 793A98905100C;
        Tue, 22 Sep 2015 19:14:15 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 19:14:19 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 19:14:18 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Andrew Bresticker <abrestic@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 06/10] MIPS: CPS: warn if a core doesn't start
Date:   Tue, 22 Sep 2015 11:12:14 -0700
Message-ID: <1442945538-26141-7-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1442945538-26141-1-git-send-email-paul.burton@imgtec.com>
References: <1442945538-26141-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49307
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

When debugging core bringup it is useful to see the state of the CPC
sequencer, so output that value if the core hasn't started within a
reasonable amount of time (1 second). This avoids simply appearing to
the user to hang if a secondary core fails to start.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/smp-cps.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 8b96750..48b1b75 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -8,6 +8,7 @@
  * option) any later version.
  */
 
+#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/irqchip/mips-gic.h>
 #include <linux/sched.h>
@@ -188,7 +189,8 @@ err_out:
 
 static void boot_core(unsigned core)
 {
-	u32 access;
+	u32 access, stat, seq_state;
+	unsigned timeout;
 
 	/* Select the appropriate core */
 	write_gcr_cl_other(core << CM_GCR_Cx_OTHER_CORENUM_SHF);
@@ -208,6 +210,28 @@ static void boot_core(unsigned core)
 		/* Reset the core */
 		mips_cpc_lock_other(core);
 		write_cpc_co_cmd(CPC_Cx_CMD_RESET);
+
+		timeout = 100;
+		while (true) {
+			stat = read_cpc_co_stat_conf();
+			seq_state = stat & CPC_Cx_STAT_CONF_SEQSTATE_MSK;
+
+			/* U6 == coherent execution, ie. the core is up */
+			if (seq_state == CPC_Cx_STAT_CONF_SEQSTATE_U6)
+				break;
+
+			/* Delay a little while before we start warning */
+			if (timeout) {
+				timeout--;
+				mdelay(10);
+				continue;
+			}
+
+			pr_warn("Waiting for core %u to start... STAT_CONF=0x%x\n",
+				core, stat);
+			mdelay(1000);
+		}
+
 		mips_cpc_unlock_other();
 	} else {
 		/* Take the core out of reset */
-- 
2.5.3
