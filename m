Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2014 21:20:46 +0200 (CEST)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:50827 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816676AbaDCTUmQ8gT6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Apr 2014 21:20:42 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id E50DB19BFC7;
        Thu,  3 Apr 2014 22:20:39 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id IiiJs4p0tZlK; Thu,  3 Apr 2014 22:20:34 +0300 (EEST)
Received: from cooljazz.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id ACFF35BC004;
        Thu,  3 Apr 2014 22:20:34 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        cpufreq@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>, stable@vger.kernel.org
Subject: [PATCH v2] MIPS/loongson2_cpufreq: fix CPU clock rate setting
Date:   Thu,  3 Apr 2014 22:24:01 +0300
Message-Id: <1396553041-29951-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.9.0
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Loongson2 has been using (incorrectly) kHz for cpu_clk rate. This has
been unnoticed, as loongson2_cpufreq was the only place where the rate
was set/get. After commit 652ed95d5fa6074b3c4ea245deb0691f1acb6656
(cpufreq: introduce cpufreq_generic_get() routine) things however broke,
and now loops_per_jiffy adjustments are incorrect (1000 times too long).
The patch fixes this by changing cpu_clk rate to Hz.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: stable@vger.kernel.org
---

	v2: Initialize rate_khz when it's declared.

	v1: http://marc.info/?t=139646562700001&r=1&w=2

 arch/mips/loongson/lemote-2f/clock.c | 5 +++--
 drivers/cpufreq/loongson2_cpufreq.c  | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/mips/loongson/lemote-2f/clock.c b/arch/mips/loongson/lemote-2f/clock.c
index aed32b8..7d8c9cc 100644
--- a/arch/mips/loongson/lemote-2f/clock.c
+++ b/arch/mips/loongson/lemote-2f/clock.c
@@ -91,6 +91,7 @@ EXPORT_SYMBOL(clk_put);
 
 int clk_set_rate(struct clk *clk, unsigned long rate)
 {
+	unsigned int rate_khz = rate / 1000;
 	int ret = 0;
 	int regval;
 	int i;
@@ -111,10 +112,10 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 		if (loongson2_clockmod_table[i].frequency ==
 		    CPUFREQ_ENTRY_INVALID)
 			continue;
-		if (rate == loongson2_clockmod_table[i].frequency)
+		if (rate_khz == loongson2_clockmod_table[i].frequency)
 			break;
 	}
-	if (rate != loongson2_clockmod_table[i].frequency)
+	if (rate_khz != loongson2_clockmod_table[i].frequency)
 		return -ENOTSUPP;
 
 	clk->rate = rate;
diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
index b6581ab..807d006 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -62,7 +62,7 @@ static int loongson2_cpufreq_target(struct cpufreq_policy *policy,
 	set_cpus_allowed_ptr(current, &cpus_allowed);
 
 	/* setting the cpu frequency */
-	clk_set_rate(policy->clk, freq);
+	clk_set_rate(policy->clk, freq * 1000);
 
 	return 0;
 }
@@ -92,7 +92,7 @@ static int loongson2_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	     i++)
 		loongson2_clockmod_table[i].frequency = (rate * i) / 8;
 
-	ret = clk_set_rate(cpuclk, rate);
+	ret = clk_set_rate(cpuclk, rate * 1000);
 	if (ret) {
 		clk_put(cpuclk);
 		return ret;
-- 
1.9.0
