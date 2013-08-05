Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Aug 2013 20:27:59 +0200 (CEST)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:41845 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6826074Ab3HES1wADFZL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Aug 2013 20:27:52 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 9B02921B779;
        Mon,  5 Aug 2013 21:27:48 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id 9CTbQkA+IgmN; Mon,  5 Aug 2013 21:27:44 +0300 (EEST)
Received: from blackmetal.pp.htv.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp4.welho.com (Postfix) with ESMTP id 5DD815BC011;
        Mon,  5 Aug 2013 21:27:44 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     "Rafael J. Wysocki" <rjw@sisk.pl>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        cpufreq@vger.kernel.org, linux-pm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Aaro Koskinen <aaro.koskinen@iki.fi>, stable@vger.kernel.org
Subject: [PATCH v2] cpufreq: loongson2: fix broken cpufreq
Date:   Mon,  5 Aug 2013 21:27:12 +0300
Message-Id: <1375727232-17796-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.8.3.2
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37435
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

Commit 42913c799 (MIPS: Loongson2: Use clk API instead of direct
dereferences) broke the cpufreq functionality on Loongson2 boards:
clk_set_rate() is called before the CPU frequency table is initialized,
and therefore will always fail.

Fix by moving the clk_set_rate() after the table initialization.
Tested on Lemote FuLoong mini-PC.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: stable@vger.kernel.org
---

	Changes since the first version
	(http://marc.info/?l=linux-kernel&m=137357177225034&w=2):

	- Changed the subject prefix. I guess this should be merged through
	  the cpufreq/PM instead of MIPS tree?

	- Added ACK from Viresh Kumar.

 drivers/cpufreq/loongson2_cpufreq.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
index bb838b9..9536852 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -118,11 +118,6 @@ static int loongson2_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		clk_put(cpuclk);
 		return -EINVAL;
 	}
-	ret = clk_set_rate(cpuclk, rate);
-	if (ret) {
-		clk_put(cpuclk);
-		return ret;
-	}
 
 	/* clock table init */
 	for (i = 2;
@@ -130,6 +125,12 @@ static int loongson2_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	     i++)
 		loongson2_clockmod_table[i].frequency = (rate * i) / 8;
 
+	ret = clk_set_rate(cpuclk, rate);
+	if (ret) {
+		clk_put(cpuclk);
+		return ret;
+	}
+
 	policy->cur = loongson2_cpufreq_get(policy->cpu);
 
 	cpufreq_frequency_table_get_attr(&loongson2_clockmod_table[0],
-- 
1.8.3.2
