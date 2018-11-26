Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2018 12:14:24 +0100 (CET)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50128 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994739AbeKZLOP5sOTO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Nov 2018 12:14:15 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2B4A3916;
        Mon, 26 Nov 2018 03:14:14 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 186F03F5AF;
        Mon, 26 Nov 2018 03:14:09 -0800 (PST)
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
Subject: [PATCH v2 10/20] drivers/perf: perf/core: remove unnecessary checks for exclusion
Date:   Mon, 26 Nov 2018 11:12:26 +0000
Message-Id: <1543230756-15319-11-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
Return-Path: <andrew.murray@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67497
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

For drivers that do not support context exclusion we do not
advertise the PERF_PMU_CAP_EXCLUDE capability. This ensures that
perf will prevent us from handling events where any exclusion
flags are set. Let's remove the now unnecessary check for
exclusion flags.

This change means that qcom_{l2|l3}_pmu will now also indicate that
they do not support exclude_{host|guest} and that xgene_pmu does
not also support exclude_idle and exclude_hv.

Note that for qcom_l2_pmu we now implictly return -EINVAL instead
of -EOPNOTSUPP. This change will result in the perf userspace
utility retrying the perf_event_open system call with fallback
event attributes that do not fail.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 drivers/perf/qcom_l2_pmu.c | 8 --------
 drivers/perf/qcom_l3_pmu.c | 7 -------
 drivers/perf/xgene_pmu.c   | 5 -----
 3 files changed, 20 deletions(-)

diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index 842135c..518e18c 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -509,14 +509,6 @@ static int l2_cache_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 	}
 
-	/* We cannot filter accurately so we just don't allow it. */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-	    event->attr.exclude_hv || event->attr.exclude_idle) {
-		dev_dbg_ratelimited(&l2cache_pmu->pdev->dev,
-				    "Can't exclude execution levels\n");
-		return -EOPNOTSUPP;
-	}
-
 	if (((L2_EVT_GROUP(event->attr.config) > L2_EVT_GROUP_MAX) ||
 	     ((event->attr.config & ~L2_EVT_MASK) != 0)) &&
 	    (event->attr.config != L2CYCLE_CTR_RAW_CODE)) {
diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
index 2dc63d6..e28bd2f 100644
--- a/drivers/perf/qcom_l3_pmu.c
+++ b/drivers/perf/qcom_l3_pmu.c
@@ -495,13 +495,6 @@ static int qcom_l3_cache__event_init(struct perf_event *event)
 		return -ENOENT;
 
 	/*
-	 * There are no per-counter mode filters in the PMU.
-	 */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-	    event->attr.exclude_hv || event->attr.exclude_idle)
-		return -EINVAL;
-
-	/*
 	 * Sampling not supported since these events are not core-attributable.
 	 */
 	if (hwc->sample_period)
diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 0e31f13..bdc55de 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -914,11 +914,6 @@ static int xgene_perf_event_init(struct perf_event *event)
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EINVAL;
 
-	/* SOC counters do not have usr/os/guest/host bits */
-	if (event->attr.exclude_user || event->attr.exclude_kernel ||
-	    event->attr.exclude_host || event->attr.exclude_guest)
-		return -EINVAL;
-
 	if (event->cpu < 0)
 		return -EINVAL;
 	/*
-- 
2.7.4
