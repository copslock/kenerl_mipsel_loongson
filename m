Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Feb 2011 19:22:04 +0100 (CET)
Received: from mms1.broadcom.com ([216.31.210.17]:3611 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491117Ab1BLSWB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Feb 2011 19:22:01 +0100
Received: from [10.9.200.133] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Sat, 12 Feb 2011 10:23:38 -0800
X-Server-Uuid: 02CED230-5797-4B57-9875-D5D2FEE4708A
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Sat, 12 Feb 2011 10:21:41 -0800
Received: from stb-bld-00.broadcom.com (stb-bld-00 [10.13.134.27]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id BC2C274D05; Sat, 12
 Feb 2011 10:21:41 -0800 (PST)
From:   maksim.rayskiy@gmail.com
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
cc:     "Maksim Rayskiy" <mrayskiy@broadcom.com>
Subject: [PATCH v2] MIPS: move idle task creation to work queue
Date:   Sat, 12 Feb 2011 10:21:32 -0800
Message-ID: <1297534892-29952-1-git-send-email-maksim.rayskiy@gmail.com>
X-Mailer: git-send-email 1.7.3.2
MIME-Version: 1.0
X-WSS-ID: 61480FA03DG7319926-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <maksim.rayskiy@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maksim.rayskiy@gmail.com
Precedence: bulk
X-list: linux-mips

From: Maksim Rayskiy <mrayskiy@broadcom.com>

To avoid forking usermode thread when creating an idle task, move fork_idle
to a work queue.
This is a small improvement to 467f0b8e708390052ada48b28d1a56d20fe8b3de
[ MIPS: Clear idle task mm pointer when hotplugging cpu ]

Signed-off-by: Maksim Rayskiy <mrayskiy@broadcom.com>
---

Style improvements per Sergei's suggestions.

 arch/mips/kernel/smp.c |   35 +++++++++++++++++++++++++++++------
 1 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 4593916..635484d 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -193,6 +193,22 @@ void __devinit smp_prepare_boot_cpu(void)
  */
 static struct task_struct *cpu_idle_thread[NR_CPUS];
 
+struct create_idle {
+	struct work_struct work;
+	struct task_struct *idle;
+	struct completion done;
+	int cpu;
+};
+
+static void __cpuinit do_fork_idle(struct work_struct *work)
+{
+	struct create_idle *c_idle =
+		container_of(work, struct create_idle, work);
+
+	c_idle->idle = fork_idle(c_idle->cpu);
+	complete(&c_idle->done);
+}
+
 int __cpuinit __cpu_up(unsigned int cpu)
 {
 	struct task_struct *idle;
@@ -203,16 +219,23 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	 * Linux can schedule processes on this slave.
 	 */
 	if (!cpu_idle_thread[cpu]) {
-		idle = fork_idle(cpu);
-		cpu_idle_thread[cpu] = idle;
+		/*
+		 * Schedule work item to avoid forking user task
+		 * Ported from arch/x86/kernel/smpboot.c
+		 */
+		struct create_idle c_idle = {
+			.cpu	= cpu,
+			.done	= COMPLETION_INITIALIZER_ONSTACK(c_idle.done),
+		};
+
+		INIT_WORK_ONSTACK(&c_idle.work, do_fork_idle);
+		schedule_work(&c_idle.work);
+		wait_for_completion(&c_idle.done);
+		idle = cpu_idle_thread[cpu] = c_idle.idle;
 
 		if (IS_ERR(idle))
 			panic(KERN_ERR "Fork failed for CPU %d", cpu);
 
-		if (idle->mm) {
-			mmput(idle->mm);
-			idle->mm = NULL;
-		}
 	} else {
 		idle = cpu_idle_thread[cpu];
 		init_idle(idle, cpu);
-- 
1.7.3.2
