Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2018 12:15:10 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:50482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994838AbeKZLPAz9uFO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Nov 2018 12:15:00 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19806356D;
        Mon, 26 Nov 2018 03:15:00 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 629F53F5AF;
        Mon, 26 Nov 2018 03:14:55 -0800 (PST)
From:   Andrew Murray <andrew.murray@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-s390@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org
Subject: [PATCH v2 19/20] x86: perf/core: advertise PMU exclusion capability
Date:   Mon, 26 Nov 2018 11:12:35 +0000
Message-Id: <1543230756-15319-20-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
Return-Path: <andrew.murray@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrew.murray@arm.com
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

For PMUs that have the capability to exclude events based
on context. Let's advertise that we support the
PERF_PMU_CAP_EXCLUDE capability to ensure that perf doesn't
prevent us from handling events where any exclusion flags
are set.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/x86/events/core.c      | 2 ++
 arch/x86/events/intel/bts.c | 2 +-
 arch/x86/events/intel/pt.c  | 4 +++-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index dfb2f7c..3f51916 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2297,6 +2297,8 @@ static struct pmu pmu = {
 	.event_idx		= x86_pmu_event_idx,
 	.sched_task		= x86_pmu_sched_task,
 	.task_ctx_size          = sizeof(struct x86_perf_task_context),
+
+	.capabilities		= PERF_PMU_CAP_EXCLUDE,
 };
 
 void arch_perf_update_userpage(struct perf_event *event,
diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 24ffa1e..4976695 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -601,7 +601,7 @@ static __init int bts_init(void)
 	}
 
 	bts_pmu.capabilities	= PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_ITRACE |
-				  PERF_PMU_CAP_EXCLUSIVE;
+				  PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_EXCLUDE;
 	bts_pmu.task_ctx_nr	= perf_sw_context;
 	bts_pmu.event_init	= bts_event_init;
 	bts_pmu.add		= bts_event_add;
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 8d016ce..2d811f8 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1516,7 +1516,9 @@ static __init int pt_init(void)
 		pt_pmu.pmu.capabilities =
 			PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_AUX_SW_DOUBLEBUF;
 
-	pt_pmu.pmu.capabilities	|= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE;
+	pt_pmu.pmu.capabilities		 = PERF_PMU_CAP_EXCLUSIVE |
+					   PERF_PMU_CAP_ITRACE |
+					   PERF_PMU_CAP_EXCLUDE;
 	pt_pmu.pmu.attr_groups		 = pt_attr_groups;
 	pt_pmu.pmu.task_ctx_nr		 = perf_sw_context;
 	pt_pmu.pmu.event_init		 = pt_event_init;
-- 
2.7.4
