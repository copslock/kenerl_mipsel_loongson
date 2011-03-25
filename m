Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Mar 2011 21:18:38 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:53264 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491198Ab1CYUSf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Mar 2011 21:18:35 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p2PKISF6022449;
        Fri, 25 Mar 2011 13:18:28 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
         Fri, 25 Mar 2011 13:18:27 -0700
Received: from localhost.localdomain ([128.224.176.150]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
         Fri, 25 Mar 2011 13:18:27 -0700
From:   Wu Zhangjin <zhangjin.wu@windriver.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: Fix the reentrancy problem of synchronise_count_slave()
Date:   Sat, 26 Mar 2011 04:21:29 +0800
Message-Id: <1301084489-17314-1-git-send-email-zhangjin.wu@windriver.com>
X-Mailer: git-send-email 1.7.0.4
X-OriginalArrivalTime: 25 Mar 2011 20:18:27.0533 (UTC) FILETIME=[CCFA3FD0:01CBEB29]
Return-Path: <Zhangjin.Wu@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhangjin.wu@windriver.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

CPU stall has been observed when SYNC_R4K=y and CONFIG_HOTPLUG=y. The root
cause is that synchronise_count_slave() is not reenterable after SMP bootstrap
but the cpu online interface(cpu_up) will call it at SMP bootstrap and also
when 1 is written to /sys/devices/system/cpu/cpuX/online from user-space.

The scene looks like this:

	synchronise_count_master():

		[...]
		atomic_set(&count_count_start, 0);
		[...]

count_count_start is set to 0 after all cpus are online:

	synchronise_count_slave():

		[...]
	ncpus = num_online_cpus();
	for (i = 0; i < NR_LOOPS; i++) {
		atomic_inc(&count_count_start);
		while (atomic_read(&count_count_start) != ncpus)
			mb();
		[...]

In user-space, If one cpu is offline and online later,
synchronise_count_slave() will be called again, count_count_start is always 1
and will never equal to ncpus, therefore, the cpu will loop in the above while
and stall at last.

Except the above scene, after SMP bootstrap, whenever cpu_up() is called,
synchronise_count_slave() will be reentered, Similar stall will happen.

And in reality, If R4K is synced in SMP bootstrap, no need to re-sync it.

Therefore, to fix the reentrancy problem, this adds sync_finish_flag, set it to
1 after all cpus are synced and check it when enter into
synchronise_count_slave(), if sync_finish_flag is set, don't reenter but return
directly.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/sync-r4k.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/sync-r4k.c b/arch/mips/kernel/sync-r4k.c
index 05dd170..ebba8c9 100644
--- a/arch/mips/kernel/sync-r4k.c
+++ b/arch/mips/kernel/sync-r4k.c
@@ -24,6 +24,7 @@ static atomic_t __cpuinitdata count_start_flag = ATOMIC_INIT(0);
 static atomic_t __cpuinitdata count_count_start = ATOMIC_INIT(0);
 static atomic_t __cpuinitdata count_count_stop = ATOMIC_INIT(0);
 static atomic_t __cpuinitdata count_reference = ATOMIC_INIT(0);
+static atomic_t __cpuinitdata sync_finish_flag = ATOMIC_INIT(0);
 
 #define COUNTON	100
 #define NR_LOOPS 5
@@ -106,6 +107,9 @@ void __cpuinit synchronise_count_master(void)
 	 * so no point in alarming people
 	 */
 	printk("done.\n");
+
+	/* Safely mark the finish flag here */
+	atomic_set(&sync_finish_flag, 1);
 }
 
 void __cpuinit synchronise_count_slave(void)
@@ -123,6 +127,10 @@ void __cpuinit synchronise_count_slave(void)
 	return;
 #endif
 
+	/* No need to re-sync it when sync have been done */
+	if (atomic_read(&sync_finish_flag))
+		return;
+
 	local_irq_save(flags);
 
 	/*
-- 
1.7.0.4
