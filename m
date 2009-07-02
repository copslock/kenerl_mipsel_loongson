Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 04:49:59 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:39583 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492004AbZGBCsH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Jul 2009 04:48:07 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.60])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n622gOTm016337
	for <linux-mips@linux-mips.org>; Wed, 1 Jul 2009 19:42:24 -0700
Received: from mercury.mips.com ([192.168.64.101]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 1 Jul 2009 19:42:24 -0700
Received: from [192.168.65.97] (linux-raghu [192.168.65.97])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id n622gN7D006008;
	Wed, 1 Jul 2009 19:42:24 -0700 (PDT)
From:	Raghu Gandham <raghu@mips.com>
Subject: [PATCH 09/15] Add debug prints during CPU intialization.
To:	linux-mips@linux-mips.org
Cc:	chris@mips.com
Date:	Wed, 01 Jul 2009 19:41:58 -0700
Message-ID: <20090702024158.23268.37787.stgit@linux-raghu>
In-Reply-To: <20090702023938.23268.65453.stgit@linux-raghu>
References: <20090702023938.23268.65453.stgit@linux-raghu>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jul 2009 02:42:24.0240 (UTC) FILETIME=[BADAC700:01C9FABE]
Return-Path: <raghu@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23601
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
 
