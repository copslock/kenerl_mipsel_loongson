Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2013 17:10:14 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:4248 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831946Ab3ANQKC3cS-7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Jan 2013 17:10:02 +0100
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 14 Jan 2013 08:06:37 -0800
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Mon, 14 Jan 2013 08:09:33 -0800
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 827CA40FE8; Mon, 14
 Jan 2013 08:09:39 -0800 (PST)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 09/10] MIPS: Netlogic: Fix for quad-XLP boot
Date:   Mon, 14 Jan 2013 21:42:01 +0530
Message-ID: <1358179922-26663-10-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1358179922-26663-1-git-send-email-jchandra@broadcom.com>
References: <1358179922-26663-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7CEAF2873QS854723-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On multi-chip boards, the first core on slave SoCs may take much
more time to wakeup. Add code to wait for the core to come up before
proceeding with the rest of the boot up.

Update xlp_wakeup_core to also skip the boot node and the boot CPU
initialization which is already complete.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/xlp/wakeup.c |   35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/arch/mips/netlogic/xlp/wakeup.c b/arch/mips/netlogic/xlp/wakeup.c
index cb90106..abb3e08 100644
--- a/arch/mips/netlogic/xlp/wakeup.c
+++ b/arch/mips/netlogic/xlp/wakeup.c
@@ -51,7 +51,7 @@
 #include <asm/netlogic/xlp-hal/xlp.h>
 #include <asm/netlogic/xlp-hal/sys.h>
 
-static int xlp_wakeup_core(uint64_t sysbase, int core)
+static int xlp_wakeup_core(uint64_t sysbase, int node, int core)
 {
 	uint32_t coremask, value;
 	int count;
@@ -82,36 +82,51 @@ static void xlp_enable_secondary_cores(const cpumask_t *wakeup_mask)
 	struct nlm_soc_info *nodep;
 	uint64_t syspcibase;
 	uint32_t syscoremask;
-	int core, n, cpu;
+	int core, n, cpu, count, val;
 
 	for (n = 0; n < NLM_NR_NODES; n++) {
 		syspcibase = nlm_get_sys_pcibase(n);
 		if (nlm_read_reg(syspcibase, 0) == 0xffffffff)
 			break;
 
-		/* read cores in reset from SYS and account for boot cpu */
-		nlm_node_init(n);
+		/* read cores in reset from SYS */
+		if (n != 0)
+			nlm_node_init(n);
 		nodep = nlm_get_node(n);
 		syscoremask = nlm_read_sys_reg(nodep->sysbase, SYS_CPU_RESET);
-		if (n == 0)
+		/* The boot cpu */
+		if (n == 0) {
 			syscoremask |= 1;
+			nodep->coremask = 1;
+		}
 
 		for (core = 0; core < NLM_CORES_PER_NODE; core++) {
+			/* we will be on node 0 core 0 */
+			if (n == 0 && core == 0)
+				continue;
+
 			/* see if the core exists */
 			if ((syscoremask & (1 << core)) == 0)
 				continue;
 
-			/* see if at least the first thread is enabled */
+			/* see if at least the first hw thread is enabled */
 			cpu = (n * NLM_CORES_PER_NODE + core)
 						* NLM_THREADS_PER_CORE;
 			if (!cpumask_test_cpu(cpu, wakeup_mask))
 				continue;
 
 			/* wake up the core */
-			if (xlp_wakeup_core(nodep->sysbase, core))
-				nodep->coremask |= 1u << core;
-			else
-				pr_err("Failed to enable core %d\n", core);
+			if (!xlp_wakeup_core(nodep->sysbase, n, core))
+				continue;
+
+			/* core is up */
+			nodep->coremask |= 1u << core;
+
+			/* spin until the first hw thread sets its ready */
+			count = 0x20000000;
+			do {
+				val = *(volatile int *)&nlm_cpu_ready[cpu];
+			} while (val == 0 && --count > 0);
 		}
 	}
 }
-- 
1.7.9.5
