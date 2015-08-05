Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2015 23:50:06 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:48966 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012460AbbHEVuEb0rsu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Aug 2015 23:50:04 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1ZN6ZY-0000tq-0U; Wed, 05 Aug 2015 21:50:04 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1ZN6ZV-0000B4-PC; Wed, 05 Aug 2015 14:50:01 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.19.y-ckt 028/107] MIPS: kernel: smp-cps: Fix 64-bit compatibility errors due to pointer casting
Date:   Wed,  5 Aug 2015 14:48:20 -0700
Message-Id: <1438811379-384-29-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1438811379-384-1-git-send-email-kamal@canonical.com>
References: <1438811379-384-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.19
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

3.19.8-ckt5 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

commit fd5ed3066bb2f47814fe53cdc56d11a678551ae1 upstream.

Commit 1d8f1f5a780a ("MIPS: smp-cps: hotplug support") added hotplug
support in the SMP/CPS implementation but it introduced a few build problems
on 64-bit kernels due to pointer being casted to and from 'int' C types. We
fix this problem by using 'unsigned long' instead which should match the size
of the pointers in 32/64-bit kernels. Finally, we fix the comment since the
CM base address is loaded to v1($3) instead of v0.

Fixes the following build problems:

arch/mips/kernel/smp-cps.c: In function 'wait_for_sibling_halt':
arch/mips/kernel/smp-cps.c:366:17: error: cast from pointer to integer of
different size [-Werror=pointer-to-int-cast]
[...]
arch/mips/kernel/smp-cps.c: In function 'cps_cpu_die':
arch/mips/kernel/smp-cps.c:427:13: error: cast to pointer
from integer of different size [-Werror=int-to-pointer-cast]

cc1: all warnings being treated as errors

Fixes: 1d8f1f5a780a ("MIPS: smp-cps: hotplug support")
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10586/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/smp-cps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index bed7590..81012b9 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -127,7 +127,7 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
 	/*
 	 * Patch the start of mips_cps_core_entry to provide:
 	 *
-	 * v0 = CM base address
+	 * v1 = CM base address
 	 * s0 = kseg0 CCA
 	 */
 	entry_code = (u32 *)&mips_cps_core_entry;
@@ -363,7 +363,7 @@ void play_dead(void)
 
 static void wait_for_sibling_halt(void *ptr_cpu)
 {
-	unsigned cpu = (unsigned)ptr_cpu;
+	unsigned cpu = (unsigned long)ptr_cpu;
 	unsigned vpe_id = cpu_vpe_id(&cpu_data[cpu]);
 	unsigned halted;
 	unsigned long flags;
@@ -424,7 +424,7 @@ static void cps_cpu_die(unsigned int cpu)
 		 */
 		err = smp_call_function_single(cpu_death_sibling,
 					       wait_for_sibling_halt,
-					       (void *)cpu, 1);
+					       (void *)(unsigned long)cpu, 1);
 		if (err)
 			panic("Failed to call remote sibling CPU\n");
 	}
-- 
1.9.1
