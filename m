Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2017 17:47:34 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:57931 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993005AbdKAQrUglZin (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Nov 2017 17:47:20 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 01 Nov 2017 16:47:02 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Wed, 1 Nov 2017 09:46:25 -0700
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
CC:     Matt Redfearn <matt.redfearn@mips.com>,
        <linux-mips@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] MIPS: CPS: Fix use of current_cpu_data in preemptible code
Date:   Wed, 1 Nov 2017 16:45:56 +0000
Message-ID: <1509554756-16784-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1509554822-452059-3093-511574-1
X-BESS-VER: 2017.12.1-r1710261623
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186483
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

Commit 1ec9dd80bedc2 ("MIPS: CPS: Detect CPUs in secondary clusters")
added a check in cps_boot_secondary() that the secondary being booted is
in the same cluster as the CPU running this code. This check is
performed using current_cpu_data without disabling preemption. As such
when CONFIG_PREEMPT=y, a BUG is triggered:

[   57.991693] BUG: using smp_processor_id() in preemptible [00000000] code: hotplug/1749
<snip>
[   58.063077] Call Trace:
[   58.065842] [<8040cdb4>] show_stack+0x84/0x114
[   58.070830] [<80b11b38>] dump_stack+0xf8/0x140
[   58.075796] [<8079b12c>] check_preemption_disabled+0xec/0x118
[   58.082204] [<80415110>] cps_boot_secondary+0x84/0x44c
[   58.087935] [<80413a14>] __cpu_up+0x34/0x98
[   58.092624] [<80434240>] bringup_cpu+0x38/0x114
[   58.097680] [<80434af0>] cpuhp_invoke_callback+0x168/0x8f0
[   58.103801] [<804362d0>] _cpu_up+0x154/0x1c8
[   58.108565] [<804363dc>] do_cpu_up+0x98/0xa8
[   58.113333] [<808261f8>] device_online+0x84/0xc0
[   58.118481] [<80826294>] online_store+0x60/0x98
[   58.123562] [<8062261c>] kernfs_fop_write+0x158/0x1d4
[   58.129196] [<805a2ae4>] __vfs_write+0x4c/0x168
[   58.134247] [<805a2dc8>] vfs_write+0xe0/0x190
[   58.139095] [<805a2fe0>] SyS_write+0x68/0xc4
[   58.143854] [<80415d58>] syscall_common+0x34/0x58

In reality we don't currently support running the kernel on CPUs not in
cluster 0, so the answer to cpu_cluster(&current_cpu_data) will always
be 0, even if this task being preempted and continues running on a
different CPU. Regardless, the BUG should not be triggered, so fix this
by switching to raw_current_cpu_data. When multicluster support lands
upstream this check will need removing or changing anyway.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Reviewed-by: Paul Burton <paul.burton@mips.com>
CC: linux-mips@linux-mips.org
CC: Paul Burton <paul.burton@mips.com>
---

 arch/mips/kernel/smp-cps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 0063122c85da..8e7a40bcd9d3 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -306,7 +306,7 @@ static int cps_boot_secondary(int cpu, struct task_struct *idle)
 	int err;
 
 	/* We don't yet support booting CPUs in other clusters */
-	if (cpu_cluster(&cpu_data[cpu]) != cpu_cluster(&current_cpu_data))
+	if (cpu_cluster(&cpu_data[cpu]) != cpu_cluster(&raw_current_cpu_data))
 		return -ENOSYS;
 
 	vpe_cfg->pc = (unsigned long)&smp_bootstrap;
-- 
2.7.4
