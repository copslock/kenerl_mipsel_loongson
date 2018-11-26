Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2018 12:14:35 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:50214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994748AbeKZLOZxSHsO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Nov 2018 12:14:25 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB770356D;
        Mon, 26 Nov 2018 03:14:24 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 200453F5AF;
        Mon, 26 Nov 2018 03:14:19 -0800 (PST)
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
Subject: [PATCH v2 12/20] mips: perf/core: advertise PMU exclusion capability
Date:   Mon, 26 Nov 2018 11:12:28 +0000
Message-Id: <1543230756-15319-13-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
Return-Path: <andrew.murray@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67499
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

The MIPS PMU has the capability to exclude events based on
context. Let's advertise that we support the PERF_PMU_CAP_EXCLUDE
capability to ensure that perf doesn't prevent us from handling
events where any exclusion flags are set.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/mips/kernel/perf_event_mipsxx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 4138635..d7813d0 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -670,6 +670,7 @@ static struct pmu pmu = {
 	.start		= mipspmu_start,
 	.stop		= mipspmu_stop,
 	.read		= mipspmu_read,
+	.capabilities	= PERF_PMU_CAP_EXCLUDE,
 };
 
 static unsigned int mipspmu_perf_event_encode(const struct mips_perf_event *pev)
-- 
2.7.4
