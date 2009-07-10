Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2009 11:06:16 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:35230 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491987AbZGJJF7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Jul 2009 11:05:59 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.60])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n6A95qxF024442
	for <linux-mips@linux-mips.org>; Fri, 10 Jul 2009 02:05:52 -0700
Received: from mercury.mips.com ([192.168.64.101]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 10 Jul 2009 02:05:51 -0700
Received: from [192.168.65.97] (linux-raghu [192.168.65.97])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id n6A95pgg021854;
	Fri, 10 Jul 2009 02:05:51 -0700 (PDT)
From:	Raghu Gandham <raghu@mips.com>
Subject: [PATCH 1/2] Add debug prints during CPU intialization.
To:	linux-mips@linux-mips.org
Cc:	raghu@mips.com, chris@mips.com
Date:	Fri, 10 Jul 2009 02:05:45 -0700
Message-ID: <20090710090545.26243.24073.stgit@linux-raghu>
In-Reply-To: <20090710090529.26243.22320.stgit@linux-raghu>
References: <20090710090529.26243.22320.stgit@linux-raghu>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jul 2009 09:05:51.0990 (UTC) FILETIME=[9FD8D160:01CA013D]
Return-Path: <raghu@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghu@mips.com
Precedence: bulk
X-list: linux-mips

From: Chris Dearman <chris@mips.com>

Signed-off-by: Chris Dearman <chris@mips.com>
---

 arch/mips/kernel/smp-mt.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index 6f7ee5a..c6c7b54 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -152,7 +152,7 @@ static void vsmp_send_ipi_mask(cpumask_t mask, unsigned int action)
 static void __cpuinit vsmp_init_secondary(void)
 {
 	extern int gic_present;
-
+	pr_debug("SMPMT: CPU%d: vsmp_init_secondary\n", smp_processor_id());
 	/* This is Malta specific: IPI,performance and timer inetrrupts */
 	if (gic_present)
 		change_c0_status(ST0_IM, STATUSF_IP3 | STATUSF_IP4 |
@@ -164,6 +164,8 @@ static void __cpuinit vsmp_init_secondary(void)
 
 static void __cpuinit vsmp_smp_finish(void)
 {
+	pr_debug("SMPMT: CPU%d: vsmp_smp_finish\n", smp_processor_id());
+
 	/* CDFIXME: remove this? */
 	write_c0_compare(read_c0_count() + (8* mips_hpt_frequency/HZ));
 
@@ -178,6 +180,7 @@ static void __cpuinit vsmp_smp_finish(void)
 
 static void vsmp_cpus_done(void)
 {
+	pr_debug("SMPMT: CPU%d: vsmp_cpus_done\n", smp_processor_id());
 }
 
 /*
@@ -191,6 +194,8 @@ static void vsmp_cpus_done(void)
 static void __cpuinit vsmp_boot_secondary(int cpu, struct task_struct *idle)
 {
 	struct thread_info *gp = task_thread_info(idle);
+	pr_debug("SMPMT: CPU%d: vsmp_boot_secondary cpu %d\n",
+		smp_processor_id(), cpu);
 	dvpe();
 	set_c0_mvpcontrol(MVPCONTROL_VPC);
 
@@ -232,6 +237,7 @@ static void __init vsmp_smp_setup(void)
 	unsigned int mvpconf0, ntc, tc, ncpu = 0;
 	unsigned int nvpe;
 
+	pr_debug("SMPMT: CPU%d: vsmp_smp_setup\n", smp_processor_id());
 #ifdef CONFIG_MIPS_MT_FPAFF
 	/* If we have an FPU, enroll ourselves in the FPU-full mask */
 	if (cpu_has_fpu)
@@ -272,6 +278,8 @@ static void __init vsmp_smp_setup(void)
 
 static void __init vsmp_prepare_cpus(unsigned int max_cpus)
 {
+	pr_debug("SMPMT: CPU%d: vsmp_prepare_cpus %d\n",
+		smp_processor_id(), max_cpus);
 	mips_mt_set_cpuoptions();
 }
 
