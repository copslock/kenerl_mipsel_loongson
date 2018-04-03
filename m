Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Apr 2018 14:33:42 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:51026 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993599AbeDCMdd6t5Vw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Apr 2018 14:33:33 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 03 Apr 2018 12:33:06 +0000
Received: from mredfearn-linux.mipstec.com (192.168.155.41) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 3 Apr 2018 05:33:01 -0700
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 2/5] MIPS: perf: Use correct VPE ID when setting up VPE tracing
Date:   Tue, 3 Apr 2018 13:31:28 +0100
Message-ID: <1522758691-17003-3-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522758691-17003-1-git-send-email-matt.redfearn@mips.com>
References: <1522758691-17003-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1522758734-452059-13817-58425-12
X-BESS-VER: 2018.4.1-r1803302241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191653
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
X-archive-position: 63395
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

There are a couple of FIXME's in the perf code which state that
cpu_data[event->cpu].vpe_id reports 0 for both CPUs. This is no longer
the case, since the vpe_id is used extensively by SMP CPS.

VPE local counting gets around this by using smp_processor_id() instead.
As it happens this does work correctly to count events on the right VPE,
but relies on 2 assumptions:
a) Always having 2 VPEs / core.
b) The hardware only paying attention to the least significant bit of
the PERFCTL.VPEID field.
If either of these assumptions change then the incorrect VPEs events
will be counted.

Fix this by replacing smp_processor_id() with
cpu_vpe_id(&current_cpu_data), in the vpe_id() macro, and pass vpe_id()
to M_PERFCTL_VPEID() when setting up PERFCTL.VPEID. The FIXME's can also
be removed since they no longer apply.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/kernel/perf_event_mipsxx.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 3308b35d6680..bb8c6783e9a5 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -137,12 +137,8 @@ static DEFINE_RWLOCK(pmuint_rwlock);
 #define vpe_id()	(cpu_has_mipsmt_pertccounters ? \
 			 0 : (smp_processor_id() & MIPS_CPUID_TO_COUNTER_MASK))
 #else
-/*
- * FIXME: For VSMP, vpe_id() is redefined for Perf-events, because
- * cpu_data[cpuid].vpe_id reports 0 for _both_ CPUs.
- */
 #define vpe_id()	(cpu_has_mipsmt_pertccounters ? \
-			 0 : smp_processor_id())
+			 0 : cpu_vpe_id(&current_cpu_data))
 #endif
 
 /* Copied from op_model_mipsxx.c */
@@ -1279,11 +1275,7 @@ static void check_and_calc_range(struct perf_event *event,
 			 */
 			hwc->config_base |= M_TC_EN_ALL;
 		} else {
-			/*
-			 * FIXME: cpu_data[event->cpu].vpe_id reports 0
-			 * for both CPUs.
-			 */
-			hwc->config_base |= M_PERFCTL_VPEID(event->cpu);
+			hwc->config_base |= M_PERFCTL_VPEID(vpe_id());
 			hwc->config_base |= M_TC_EN_VPE;
 		}
 	} else
-- 
2.7.4
