Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2012 23:51:57 +0100 (CET)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:50788 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903721Ab2BNWvd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Feb 2012 23:51:33 +0100
Received: by mail-pw0-f49.google.com with SMTP id un1so1016177pbc.36
        for <linux-mips@linux-mips.org>; Tue, 14 Feb 2012 14:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=gamma;
        h=mime-version:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=psl136/XZoyJUs945OjqLnHMlnq03KdyDx6J2qaidGA=;
        b=xavVDcD7kNYyy+rkAjVPpSxw+x9UtQ3AGtWg/yABe3QfvKN3JswCLkSP0UCuFzFEsS
         PHEBoou99wvUW8MM43yfXxwJ9Luw7BhFYkGQyj80H1TJMyd2xIXxM4JZqqItzHhN9EzF
         pKof4Z9zOX6AJJSCwSbEg0ahmh5fnsg3v9KWM=
MIME-Version: 1.0
Received: by 10.68.212.130 with SMTP id nk2mr63046465pbc.69.1329259892080;
        Tue, 14 Feb 2012 14:51:32 -0800 (PST)
Received: by 10.68.212.130 with SMTP id nk2mr63046390pbc.69.1329259891972;
        Tue, 14 Feb 2012 14:51:31 -0800 (PST)
Received: from tippy.mtv.corp.google.com (tippy.mtv.corp.google.com [172.18.96.130])
        by mx.google.com with ESMTPS id y9sm6426972pbi.3.2012.02.14.14.51.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Feb 2012 14:51:31 -0800 (PST)
From:   Venkatesh Pallipadi <venki@google.com>
To:     Rusty Russell <rusty@rustcorp.com.au>
Cc:     Tony Luck <tony.luck@gmail.com>,
        "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        KOSAKI Motohiro <kosaki.motohiro@gmail.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mike Travis <travis@sgi.com>,
        "Paul E. McKenney" <paul.mckenney@linaro.org>,
        "Rafael J. Wysocki" <rjw@sisk.pl>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>,
        linux-hexagon@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        user-mode-linux-devel@lists.sourceforge.net,
        Venkatesh Pallipadi <venki@google.com>
Subject: [PATCH 2/3] mips: Avoid raw handling of cpu_possible_map/cpu_online_map
Date:   Tue, 14 Feb 2012 14:49:43 -0800
Message-Id: <1329259784-20592-3-git-send-email-venki@google.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1329259784-20592-1-git-send-email-venki@google.com>
References: <87wr7pbwbz.fsf@rustcorp.com.au>
 <1329259784-20592-1-git-send-email-venki@google.com>
X-Gm-Message-State: ALoCoQn8VYe2VZG/u6zSMdUsiiMEkvnyzpGfikt1n7sa0D1VCngMKELhXZIybcI4kW1ApZNbHXaDqBHI0nN2pCdq2NUVybxkoJDw2iSfuI+5HFXcEk5O3S1WYk57Q86DkNn1VkAlFYuJpeGHKs3GUFLEPMm9JzFa7uNpxY3DtOeLTK73GW1lznA=
X-archive-position: 32427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: venki@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Use set_cpu_* and init_cpu_* variants instead.

Signed-off-by: Venkatesh Pallipadi <venki@google.com>
---
 arch/mips/cavium-octeon/smp.c       |    2 +-
 arch/mips/kernel/smp.c              |    4 ++--
 arch/mips/netlogic/xlr/smp.c        |    4 ++--
 arch/mips/pmc-sierra/yosemite/smp.c |    4 ++--
 arch/mips/sgi-ip27/ip27-smp.c       |    2 +-
 arch/mips/sibyte/bcm1480/smp.c      |    5 ++---
 arch/mips/sibyte/sb1250/smp.c       |    5 ++---
 7 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index efcfff4..5cce09c 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -268,7 +268,7 @@ static int octeon_cpu_disable(void)
 
 	spin_lock(&smp_reserve_lock);
 
-	cpu_clear(cpu, cpu_online_map);
+	set_cpu_online(cpu, false);
 	cpu_clear(cpu, cpu_callin_map);
 	local_irq_disable();
 	fixup_irqs();
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 32c1e95..28777ff 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -148,7 +148,7 @@ static void stop_this_cpu(void *dummy)
 	/*
 	 * Remove this CPU:
 	 */
-	cpu_clear(smp_processor_id(), cpu_online_map);
+	set_cpu_online(smp_processor_id(), false);
 	for (;;) {
 		if (cpu_wait)
 			(*cpu_wait)();		/* Wait if available. */
@@ -248,7 +248,7 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	while (!cpu_isset(cpu, cpu_callin_map))
 		udelay(100);
 
-	cpu_set(cpu, cpu_online_map);
+	set_cpu_online(cpu, true);
 
 	return 0;
 }
diff --git a/arch/mips/netlogic/xlr/smp.c b/arch/mips/netlogic/xlr/smp.c
index 080284d..8084221 100644
--- a/arch/mips/netlogic/xlr/smp.c
+++ b/arch/mips/netlogic/xlr/smp.c
@@ -154,7 +154,7 @@ void __init nlm_smp_setup(void)
 	cpu_set(boot_cpu, phys_cpu_present_map);
 	__cpu_number_map[boot_cpu] = 0;
 	__cpu_logical_map[0] = boot_cpu;
-	cpu_set(0, cpu_possible_map);
+	set_cpu_possible(0, true);
 
 	num_cpus = 1;
 	for (i = 0; i < NR_CPUS; i++) {
@@ -166,7 +166,7 @@ void __init nlm_smp_setup(void)
 			cpu_set(i, phys_cpu_present_map);
 			__cpu_number_map[i] = num_cpus;
 			__cpu_logical_map[num_cpus] = i;
-			cpu_set(num_cpus, cpu_possible_map);
+			set_cpu_possible(num_cpus, true);
 			++num_cpus;
 		}
 	}
diff --git a/arch/mips/pmc-sierra/yosemite/smp.c b/arch/mips/pmc-sierra/yosemite/smp.c
index 2608752..b2b23eb 100644
--- a/arch/mips/pmc-sierra/yosemite/smp.c
+++ b/arch/mips/pmc-sierra/yosemite/smp.c
@@ -155,10 +155,10 @@ static void __init yos_smp_setup(void)
 {
 	int i;
 
-	cpus_clear(cpu_possible_map);
+	init_cpu_possible(cpumask_of(0));
 
 	for (i = 0; i < 2; i++) {
-		cpu_set(i, cpu_possible_map);
+		set_cpu_possible(i, true);
 		__cpu_number_map[i]	= i;
 		__cpu_logical_map[i]	= i;
 	}
diff --git a/arch/mips/sgi-ip27/ip27-smp.c b/arch/mips/sgi-ip27/ip27-smp.c
index c6851df..735b43b 100644
--- a/arch/mips/sgi-ip27/ip27-smp.c
+++ b/arch/mips/sgi-ip27/ip27-smp.c
@@ -76,7 +76,7 @@ static int do_cpumask(cnodeid_t cnode, nasid_t nasid, int highest)
 			/* Only let it join in if it's marked enabled */
 			if ((acpu->cpu_info.flags & KLINFO_ENABLE) &&
 			    (tot_cpus_found != NR_CPUS)) {
-				cpu_set(cpuid, cpu_possible_map);
+				set_cpu_possible(cpuid, true);
 				alloc_cpupda(cpuid, tot_cpus_found);
 				cpus_found++;
 				tot_cpus_found++;
diff --git a/arch/mips/sibyte/bcm1480/smp.c b/arch/mips/sibyte/bcm1480/smp.c
index d667875..63d2211 100644
--- a/arch/mips/sibyte/bcm1480/smp.c
+++ b/arch/mips/sibyte/bcm1480/smp.c
@@ -147,14 +147,13 @@ static void __init bcm1480_smp_setup(void)
 {
 	int i, num;
 
-	cpus_clear(cpu_possible_map);
-	cpu_set(0, cpu_possible_map);
+	init_cpu_possible(cpumask_of(0));
 	__cpu_number_map[0] = 0;
 	__cpu_logical_map[0] = 0;
 
 	for (i = 1, num = 0; i < NR_CPUS; i++) {
 		if (cfe_cpu_stop(i) == 0) {
-			cpu_set(i, cpu_possible_map);
+			set_cpu_possible(i, true);
 			__cpu_number_map[i] = ++num;
 			__cpu_logical_map[num] = i;
 		}
diff --git a/arch/mips/sibyte/sb1250/smp.c b/arch/mips/sibyte/sb1250/smp.c
index 38e7f6b..77f0df5 100644
--- a/arch/mips/sibyte/sb1250/smp.c
+++ b/arch/mips/sibyte/sb1250/smp.c
@@ -135,14 +135,13 @@ static void __init sb1250_smp_setup(void)
 {
 	int i, num;
 
-	cpus_clear(cpu_possible_map);
-	cpu_set(0, cpu_possible_map);
+	init_cpu_possible(cpumask_of(0));
 	__cpu_number_map[0] = 0;
 	__cpu_logical_map[0] = 0;
 
 	for (i = 1, num = 0; i < NR_CPUS; i++) {
 		if (cfe_cpu_stop(i) == 0) {
-			cpu_set(i, cpu_possible_map);
+			set_cpu_possible(i, true);
 			__cpu_number_map[i] = ++num;
 			__cpu_logical_map[num] = i;
 		}
-- 
1.7.7.3
