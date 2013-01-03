Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jan 2013 10:34:32 +0100 (CET)
Received: from mail1-relais-roc.national.inria.fr ([192.134.164.82]:2829 "EHLO
        mail1-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816521Ab3ACJeauDha1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jan 2013 10:34:30 +0100
X-IronPort-AV: E=Sophos;i="4.84,402,1355094000"; 
   d="scan'208";a="188308018"
Received: from palace.lip6.fr (HELO localhost.localdomain) ([132.227.105.202])
  by mail1-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Jan 2013 10:34:25 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     kernel-janitors@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arch/mips/kernel/cpufreq/loongson2_cpufreq.c: use clk API instead of direct dereferences
Date:   Thu,  3 Jan 2013 11:34:20 +0100
Message-Id: <1357209260-15412-2-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.7.8.6
X-archive-position: 35355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Julia.Lawall@lip6.fr
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Julia Lawall <Julia.Lawall@lip6.fr>

A struct clk value is intended to be an abstract pointer, so it should be
manipulated using the various API functions.

clk_put is additionally added on the failure paths.

The semantic match that finds the first problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e,e1;
identifier i;
@@

*e = clk_get(...)
 ... when != e = e1
     when any
*e->i
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
I am not able to compile this code.

 arch/mips/kernel/cpufreq/loongson2_cpufreq.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/cpufreq/loongson2_cpufreq.c b/arch/mips/kernel/cpufreq/loongson2_cpufreq.c
index e7c98e2..51f5b68 100644
--- a/arch/mips/kernel/cpufreq/loongson2_cpufreq.c
+++ b/arch/mips/kernel/cpufreq/loongson2_cpufreq.c
@@ -107,6 +107,8 @@ static int loongson2_cpufreq_target(struct cpufreq_policy *policy,
 static int loongson2_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	int i;
+	unsigned long rate;
+	int ret;
 
 	if (!cpu_online(policy->cpu))
 		return -ENODEV;
@@ -117,15 +119,22 @@ static int loongson2_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		return PTR_ERR(cpuclk);
 	}
 
-	cpuclk->rate = cpu_clock_freq / 1000;
-	if (!cpuclk->rate)
+	rate = cpu_clock_freq / 1000;
+	if (!rate) {
+		clk_put(cpuclk);
 		return -EINVAL;
+	}
+	ret = clk_set_rate(cpuclk, rate);
+	if (ret) {
+		clk_put(cpuclk);
+		return ret;
+	}
 
 	/* clock table init */
 	for (i = 2;
 	     (loongson2_clockmod_table[i].frequency != CPUFREQ_TABLE_END);
 	     i++)
-		loongson2_clockmod_table[i].frequency = (cpuclk->rate * i) / 8;
+		loongson2_clockmod_table[i].frequency = (rate * i) / 8;
 
 	policy->cur = loongson2_cpufreq_get(policy->cpu);
 
