Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jan 2016 06:55:28 +0100 (CET)
Received: from smtpproxy19.qq.com ([184.105.206.84]:53302 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008076AbcAEFytVrL6- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jan 2016 06:54:49 +0100
X-QQ-mid: bizesmtp4t1451973261t656t270
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 05 Jan 2016 13:54:20 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK70B00A0000000
X-QQ-FEAT: 6dXuswn9i1WZKreTQ5Ap9Ne/NJCMX9YyRLm31lvmTwxtNdVpg96fY0/gNd2Iw
        /nXOCqB29ORz2UYWF6m+igvt3IwFI/5ojTxriAZCF77dPIj7L2FwIMZq0t//HscvmuJIXdy
        T5iIMzVkIoVwC4FcS+BwpjA4dDzAsAFhL3ZBdOxqfqA7MawRMEqrtCTtpK84oZrKKzcmFLg
        lLoDGQZEl5/kU1w4isvwRtcpJAus9Yt5hgYbRWx9TNeUnKvoYxelhj9ycB9FgbAe/agQys3
        h9fJ+rpcrYjrbfXDjzIUcBBrc=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 5/6] MIPS: sync-r4k: reduce skew while synchronization
Date:   Tue,  5 Jan 2016 13:59:08 +0800
Message-Id: <1451973549-16198-6-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1451973549-16198-1-git-send-email-chenhc@lemote.com>
References: <1451973549-16198-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

While synchronization, count register will go backwards for the master.
If synchronise_count_master() runs before synchronise_count_slave(),
skew becomes even more. The skew is very harmful for CPU hotplug (CPU0
do synchronization with CPU1, then CPU0 do synchronization with CPU2
and CPU0's count goes backwards, so it will be out of sync with CPU1).

After the commit cf9bfe55f24973a8f40e2 (MIPS: Synchronize MIPS count one
CPU at a time), we needn't evaluate count_reference at the beginning of
synchronise_count_master() any more. Thus, we evaluate the initcount (It
seems like count_reference is redundant) in the 2nd loop. Since we write
the count register in the last loop, we don't need additional barriers
(the existing memory barriers are enough).

Moreover, I think we loop 3 times is enough to get a primed instruction
cache, this can also get less skew than looping 5 times.

Comments are also updated in this patch.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/kernel/sync-r4k.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/arch/mips/kernel/sync-r4k.c b/arch/mips/kernel/sync-r4k.c
index 2242bdd..4472a7f 100644
--- a/arch/mips/kernel/sync-r4k.c
+++ b/arch/mips/kernel/sync-r4k.c
@@ -17,35 +17,23 @@
 #include <asm/barrier.h>
 #include <asm/mipsregs.h>
 
-static atomic_t count_start_flag = ATOMIC_INIT(0);
+static unsigned int initcount = 0;
 static atomic_t count_count_start = ATOMIC_INIT(0);
 static atomic_t count_count_stop = ATOMIC_INIT(0);
-static atomic_t count_reference = ATOMIC_INIT(0);
 
 #define COUNTON 100
-#define NR_LOOPS 5
+#define NR_LOOPS 3
 
 void synchronise_count_master(int cpu)
 {
 	int i;
 	unsigned long flags;
-	unsigned int initcount;
 
 	printk(KERN_INFO "Synchronize counters for CPU %u: ", cpu);
 
 	local_irq_save(flags);
 
 	/*
-	 * Notify the slaves that it's time to start
-	 */
-	atomic_set(&count_reference, read_c0_count());
-	atomic_set(&count_start_flag, cpu);
-	smp_wmb();
-
-	/* Count will be initialised to current timer for all CPU's */
-	initcount = read_c0_count();
-
-	/*
 	 * We loop a few times to get a primed instruction cache,
 	 * then the last pass is more or less synchronised and
 	 * the master and slaves each set their cycle counters to a known
@@ -63,9 +51,13 @@ void synchronise_count_master(int cpu)
 		atomic_set(&count_count_stop, 0);
 		smp_wmb();
 
-		/* this lets the slaves write their count register */
+		/* Let the slave writes its count register */
 		atomic_inc(&count_count_start);
 
+		/* Count will be initialised to current timer */
+		if (i == 1)
+			initcount = read_c0_count();
+
 		/*
 		 * Everyone initialises count in the last loop:
 		 */
@@ -73,7 +65,7 @@ void synchronise_count_master(int cpu)
 			write_c0_count(initcount);
 
 		/*
-		 * Wait for all slaves to leave the synchronization point:
+		 * Wait for slave to leave the synchronization point:
 		 */
 		while (atomic_read(&count_count_stop) != 1)
 			mb();
@@ -83,7 +75,6 @@ void synchronise_count_master(int cpu)
 	}
 	/* Arrange for an interrupt in a short while */
 	write_c0_compare(read_c0_count() + COUNTON);
-	atomic_set(&count_start_flag, 0);
 
 	local_irq_restore(flags);
 
@@ -98,19 +89,12 @@ void synchronise_count_master(int cpu)
 void synchronise_count_slave(int cpu)
 {
 	int i;
-	unsigned int initcount;
 
 	/*
 	 * Not every cpu is online at the time this gets called,
 	 * so we first wait for the master to say everyone is ready
 	 */
 
-	while (atomic_read(&count_start_flag) != cpu)
-		mb();
-
-	/* Count will be initialised to next expire for all CPU's */
-	initcount = atomic_read(&count_reference);
-
 	for (i = 0; i < NR_LOOPS; i++) {
 		atomic_inc(&count_count_start);
 		while (atomic_read(&count_count_start) != 2)
-- 
2.4.6
