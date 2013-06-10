Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 09:44:59 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:4694 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823038Ab3FJHkNHDou7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 09:40:13 +0200
Received: from [10.9.208.57] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 10 Jun 2013 00:36:21 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 10 Jun 2013 00:40:00 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 10 Jun 2013 00:40:00 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 8B0B2F2D72; Mon, 10
 Jun 2013 00:39:59 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 08/11] MIPS: Netlogic: wait for all hardware threads
Date:   Mon, 10 Jun 2013 13:11:07 +0530
Message-ID: <1370850070-5127-9-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370850070-5127-1-git-send-email-jchandra@broadcom.com>
References: <1370850070-5127-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7DAB5E7F31W33902876-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36789
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

Earlier we just waited for the first thread of the CPU to come online
before proceeding to wake up others. Update it to wait for all the CPUs
in the core. This will be useful when the boot-up is slow, like while
debugging or when running in a simulator.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/xlp/wakeup.c |   27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/mips/netlogic/xlp/wakeup.c b/arch/mips/netlogic/xlp/wakeup.c
index feb5736..0cce37c 100644
--- a/arch/mips/netlogic/xlp/wakeup.c
+++ b/arch/mips/netlogic/xlp/wakeup.c
@@ -77,13 +77,28 @@ static int xlp_wakeup_core(uint64_t sysbase, int node, int core)
 	return count != 0;
 }
 
+static int wait_for_cpus(int cpu, int bootcpu)
+{
+	volatile uint32_t *cpu_ready = nlm_get_boot_data(BOOT_CPU_READY);
+	int i, count, notready;
+
+	count = 0x20000000;
+	do {
+		notready = nlm_threads_per_core;
+		for (i = 0; i < nlm_threads_per_core; i++)
+			if (cpu_ready[cpu + i] || cpu == bootcpu)
+				--notready;
+	} while (notready != 0 && --count > 0);
+
+	return count != 0;
+}
+
 static void xlp_enable_secondary_cores(const cpumask_t *wakeup_mask)
 {
 	struct nlm_soc_info *nodep;
 	uint64_t syspcibase;
 	uint32_t syscoremask;
-	volatile uint32_t *cpu_ready = nlm_get_boot_data(BOOT_CPU_READY);
-	int core, n, cpu, count, val;
+	int core, n, cpu;
 
 	for (n = 0; n < NLM_NR_NODES; n++) {
 		syspcibase = nlm_get_sys_pcibase(n);
@@ -123,11 +138,8 @@ static void xlp_enable_secondary_cores(const cpumask_t *wakeup_mask)
 			/* core is up */
 			nodep->coremask |= 1u << core;
 
-			/* spin until the first hw thread sets its ready */
-			count = 0x20000000;
-			do {
-				val = cpu_ready[cpu];
-			} while (val == 0 && --count > 0);
+			/* spin until the hw threads sets their ready */
+			wait_for_cpus(cpu, 0);
 		}
 	}
 }
@@ -139,6 +151,7 @@ void xlp_wakeup_secondary_cpus()
 	 * first wakeup core 0 threads
 	 */
 	xlp_boot_core0_siblings();
+	wait_for_cpus(0, 0);
 
 	/* now get other cores out of reset */
 	xlp_enable_secondary_cores(&nlm_cpumask);
-- 
1.7.9.5
