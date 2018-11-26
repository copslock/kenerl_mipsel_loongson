Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2018 12:14:48 +0100 (CET)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50296 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994753AbeKZLOgQc2-O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Nov 2018 12:14:36 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0ACD3918;
        Mon, 26 Nov 2018 03:14:34 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 255593F5AF;
        Mon, 26 Nov 2018 03:14:29 -0800 (PST)
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
Subject: [PATCH v2 14/20] powerpc: perf/core: remove unnecessary checks for exclusion
Date:   Mon, 26 Nov 2018 11:12:30 +0000
Message-Id: <1543230756-15319-15-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
Return-Path: <andrew.murray@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67501
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

For PowerPC PMUs that do not support context exclusion we do not
advertise the PERF_PMU_CAP_EXCLUDE capability. This ensures that
perf will prevent us from handling events where any exclusion
flags are set. Let's remove the now unnecessary check for exclusion
flags.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/powerpc/perf/hv-24x7.c |  9 ---------
 arch/powerpc/perf/hv-gpci.c |  9 ---------
 arch/powerpc/perf/imc-pmu.c | 18 ------------------
 3 files changed, 36 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 72238ee..d13d8a9 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1306,15 +1306,6 @@ static int h_24x7_event_init(struct perf_event *event)
 		return -EINVAL;
 	}
 
-	/* unsupported modes and filters */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest)
-		return -EINVAL;
-
 	/* no branch sampling */
 	if (has_branch_stack(event))
 		return -EOPNOTSUPP;
diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
index 43fabb3..e0ce0e0 100644
--- a/arch/powerpc/perf/hv-gpci.c
+++ b/arch/powerpc/perf/hv-gpci.c
@@ -232,15 +232,6 @@ static int h_gpci_event_init(struct perf_event *event)
 		return -EINVAL;
 	}
 
-	/* unsupported modes and filters */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest)
-		return -EINVAL;
-
 	/* no branch sampling */
 	if (has_branch_stack(event))
 		return -EOPNOTSUPP;
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 1fafc32b..49c0b1c 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -473,15 +473,6 @@ static int nest_imc_event_init(struct perf_event *event)
 	if (event->hw.sample_period)
 		return -EINVAL;
 
-	/* unsupported modes and filters */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest)
-		return -EINVAL;
-
 	if (event->cpu < 0)
 		return -EINVAL;
 
@@ -748,15 +739,6 @@ static int core_imc_event_init(struct perf_event *event)
 	if (event->hw.sample_period)
 		return -EINVAL;
 
-	/* unsupported modes and filters */
-	if (event->attr.exclude_user   ||
-	    event->attr.exclude_kernel ||
-	    event->attr.exclude_hv     ||
-	    event->attr.exclude_idle   ||
-	    event->attr.exclude_host   ||
-	    event->attr.exclude_guest)
-		return -EINVAL;
-
 	if (event->cpu < 0)
 		return -EINVAL;
 
-- 
2.7.4
