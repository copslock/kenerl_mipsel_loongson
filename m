Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Mar 2013 14:49:28 +0100 (CET)
Received: from mail-pb0-f51.google.com ([209.85.160.51]:62480 "EHLO
        mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825665Ab3CXNtNMhV0H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 Mar 2013 14:49:13 +0100
Received: by mail-pb0-f51.google.com with SMTP id rr4so1058675pbb.24
        for <linux-mips@linux-mips.org>; Sun, 24 Mar 2013 06:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=D7t+RcXzhaO5PJdrFePfSyddF67XFQ+wFJt1kPjgH58=;
        b=SLk2a7HIAdgi2pxIyFmUxAijXwI6x1cvYwRzvfDTNwl61PyXgFV2nZO8Ap7yO+/Xe5
         TcEVsW+1yANyS46m+yRooKbA3yuGHq6YlGEW5d9aQ2VB7cZpHUvFiLk0p2NnnZhSB1Jb
         r5zeBRQmQRU6IiYn54SGakXz0dgOgljfsRxFHNcCqhvWA3Gdx7fY9Q8r8QLbFNdaUjzl
         I7KDfFhJuAKplnOWjhDCIkO5UE6no5B8sPlZiDO1nT7u4dllm361POBhLIuje7e46/vQ
         MOO2UQGsFyj85hVgKt/zrvLoEeoWT2jlVw8rcY3Y8uT9XrUbu2SxIBUFofcVTwLbjjG4
         tjlA==
X-Received: by 10.66.154.65 with SMTP id vm1mr13010162pab.110.1364132946734;
        Sun, 24 Mar 2013 06:49:06 -0700 (PDT)
Received: from localhost ([122.166.179.164])
        by mx.google.com with ESMTPS id zv3sm10871444pab.0.2013.03.24.06.49.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 24 Mar 2013 06:49:06 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rjw@sisk.pl
Cc:     cpufreq@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, arvind.chauhan@arm.com,
        robin.randhawa@arm.com, Steve.Bannister@arm.com,
        Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com,
        linaro-kernel@lists.linaro.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Renninger <trenn@suse.de>,
        Borislav Petkov <bp@alien8.de>, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 2/2] cpufreq: Don't check if cpu is online/offline for cpufreq callbacks
Date:   Sun, 24 Mar 2013 19:18:32 +0530
Message-Id: <ebbe8178fab5739c7322745b3a7ba05955477761.1364132845.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <981c23bd4b2a14c346820685e1203ab7054378f8.1364132845.git.viresh.kumar@linaro.org>
References: <981c23bd4b2a14c346820685e1203ab7054378f8.1364132845.git.viresh.kumar@linaro.org>
In-Reply-To: <981c23bd4b2a14c346820685e1203ab7054378f8.1364132845.git.viresh.kumar@linaro.org>
References: <981c23bd4b2a14c346820685e1203ab7054378f8.1364132845.git.viresh.kumar@linaro.org>
X-Gm-Message-State: ALoCoQnWnHbPqHGJ1Z5defGuQjbpdXPGWfBRh6lxCUD9lFmLsH0NsAV0n5uhj80bH8x7Vd3zHqhi
X-archive-position: 35966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viresh.kumar@linaro.org
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

cpufreq layer doesn't call cpufreq driver's callback for any offline cpu and so
checking that isn't useful.

Lets get rid of it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Thomas Renninger <trenn@suse.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: linux-mips@linux-mips.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/kernel/cpufreq/loongson2_cpufreq.c | 6 ------
 arch/sh/kernel/cpufreq.c                     | 6 ------
 arch/sparc/kernel/us2e_cpufreq.c             | 6 ------
 arch/sparc/kernel/us3_cpufreq.c              | 6 ------
 drivers/cpufreq/p4-clockmod.c                | 3 +--
 drivers/cpufreq/powernow-k8.c                | 3 ---
 drivers/cpufreq/speedstep-centrino.c         | 4 ----
 7 files changed, 1 insertion(+), 33 deletions(-)

diff --git a/arch/mips/kernel/cpufreq/loongson2_cpufreq.c b/arch/mips/kernel/cpufreq/loongson2_cpufreq.c
index bafda70..8488957 100644
--- a/arch/mips/kernel/cpufreq/loongson2_cpufreq.c
+++ b/arch/mips/kernel/cpufreq/loongson2_cpufreq.c
@@ -61,9 +61,6 @@ static int loongson2_cpufreq_target(struct cpufreq_policy *policy,
 	struct cpufreq_freqs freqs;
 	unsigned int freq;
 
-	if (!cpu_online(cpu))
-		return -ENODEV;
-
 	cpus_allowed = current->cpus_allowed;
 	set_cpus_allowed_ptr(current, cpumask_of(cpu));
 
@@ -109,9 +106,6 @@ static int loongson2_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	unsigned long rate;
 	int ret;
 
-	if (!cpu_online(policy->cpu))
-		return -ENODEV;
-
 	cpuclk = clk_get(NULL, "cpu_clk");
 	if (IS_ERR(cpuclk)) {
 		printk(KERN_ERR "cpufreq: couldn't get CPU clk\n");
diff --git a/arch/sh/kernel/cpufreq.c b/arch/sh/kernel/cpufreq.c
index 2c7bd94..0fdf64b 100644
--- a/arch/sh/kernel/cpufreq.c
+++ b/arch/sh/kernel/cpufreq.c
@@ -51,9 +51,6 @@ static int sh_cpufreq_target(struct cpufreq_policy *policy,
 	struct device *dev;
 	long freq;
 
-	if (!cpu_online(cpu))
-		return -ENODEV;
-
 	cpus_allowed = current->cpus_allowed;
 	set_cpus_allowed_ptr(current, cpumask_of(cpu));
 
@@ -111,9 +108,6 @@ static int sh_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	struct cpufreq_frequency_table *freq_table;
 	struct device *dev;
 
-	if (!cpu_online(cpu))
-		return -ENODEV;
-
 	dev = get_cpu_device(cpu);
 
 	cpuclk = clk_get(dev, "cpu_clk");
diff --git a/arch/sparc/kernel/us2e_cpufreq.c b/arch/sparc/kernel/us2e_cpufreq.c
index abe963d..306ae46 100644
--- a/arch/sparc/kernel/us2e_cpufreq.c
+++ b/arch/sparc/kernel/us2e_cpufreq.c
@@ -234,9 +234,6 @@ static unsigned int us2e_freq_get(unsigned int cpu)
 	cpumask_t cpus_allowed;
 	unsigned long clock_tick, estar;
 
-	if (!cpu_online(cpu))
-		return 0;
-
 	cpumask_copy(&cpus_allowed, tsk_cpus_allowed(current));
 	set_cpus_allowed_ptr(current, cpumask_of(cpu));
 
@@ -257,9 +254,6 @@ static void us2e_set_cpu_divider_index(struct cpufreq_policy *policy,
 	cpumask_t cpus_allowed;
 	struct cpufreq_freqs freqs;
 
-	if (!cpu_online(cpu))
-		return;
-
 	cpumask_copy(&cpus_allowed, tsk_cpus_allowed(current));
 	set_cpus_allowed_ptr(current, cpumask_of(cpu));
 
diff --git a/arch/sparc/kernel/us3_cpufreq.c b/arch/sparc/kernel/us3_cpufreq.c
index 7ceb9c8..c71ee14 100644
--- a/arch/sparc/kernel/us3_cpufreq.c
+++ b/arch/sparc/kernel/us3_cpufreq.c
@@ -82,9 +82,6 @@ static unsigned int us3_freq_get(unsigned int cpu)
 	unsigned long reg;
 	unsigned int ret;
 
-	if (!cpu_online(cpu))
-		return 0;
-
 	cpumask_copy(&cpus_allowed, tsk_cpus_allowed(current));
 	set_cpus_allowed_ptr(current, cpumask_of(cpu));
 
@@ -104,9 +101,6 @@ static void us3_set_cpu_divider_index(struct cpufreq_policy *policy,
 	cpumask_t cpus_allowed;
 	struct cpufreq_freqs freqs;
 
-	if (!cpu_online(cpu))
-		return;
-
 	cpumask_copy(&cpus_allowed, tsk_cpus_allowed(current));
 	set_cpus_allowed_ptr(current, cpumask_of(cpu));
 
diff --git a/drivers/cpufreq/p4-clockmod.c b/drivers/cpufreq/p4-clockmod.c
index 4b2e773..421ef37 100644
--- a/drivers/cpufreq/p4-clockmod.c
+++ b/drivers/cpufreq/p4-clockmod.c
@@ -58,8 +58,7 @@ static int cpufreq_p4_setdc(unsigned int cpu, unsigned int newstate)
 {
 	u32 l, h;
 
-	if (!cpu_online(cpu) ||
-	    (newstate > DC_DISABLE) || (newstate == DC_RESV))
+	if ((newstate > DC_DISABLE) || (newstate == DC_RESV))
 		return -EINVAL;
 
 	rdmsr_on_cpu(cpu, MSR_IA32_THERM_STATUS, &l, &h);
diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index 52137a3..b828efe 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -1102,9 +1102,6 @@ static int __cpuinit powernowk8_cpu_init(struct cpufreq_policy *pol)
 	struct init_on_cpu init_on_cpu;
 	int rc;
 
-	if (!cpu_online(pol->cpu))
-		return -ENODEV;
-
 	smp_call_function_single(pol->cpu, check_supported_cpu, &rc, 1);
 	if (rc)
 		return -ENODEV;
diff --git a/drivers/cpufreq/speedstep-centrino.c b/drivers/cpufreq/speedstep-centrino.c
index 3dbbcc3..618e6f4 100644
--- a/drivers/cpufreq/speedstep-centrino.c
+++ b/drivers/cpufreq/speedstep-centrino.c
@@ -481,10 +481,6 @@ static int centrino_target (struct cpufreq_policy *policy,
 	for_each_cpu(j, policy->cpus) {
 		int good_cpu;
 
-		/* cpufreq holds the hotplug lock, so we are safe here */
-		if (!cpu_online(j))
-			continue;
-
 		/*
 		 * Support for SMP systems.
 		 * Make sure we are running on CPU that wants to change freq
-- 
1.7.12.rc2.18.g61b472e
