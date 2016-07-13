Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2016 15:13:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15854 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992536AbcGMNNXE--Qh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jul 2016 15:13:23 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 1148F35C4139B;
        Wed, 13 Jul 2016 14:13:14 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 13 Jul 2016 14:13:16 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Subject: [PATCH 03/13] MIPS: SMP: Drop stop_this_cpu() cpu_foreign_map hack
Date:   Wed, 13 Jul 2016 14:12:46 +0100
Message-ID: <1468415576-12600-4-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1468415576-12600-1-git-send-email-james.hogan@imgtec.com>
References: <1468415576-12600-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Commit cccf34e9411c ("MIPS: c-r4k: Fix cache flushing for MT cores")
added the cpu_foreign_map cpumask containing a single VPE from each
online core, and recalculated it when secondary CPUs are brought up.

stop_this_cpu() was also updated to recalculate cpu_foreign_map, but
with an additional hack before marking the CPU as offline to copy
cpu_online_mask into cpu_foreign_map and perform an SMP memory barrier.

This appears to have been intended to prevent cache management IPIs
being missed when the VPE representing the core in cpu_foreign_map is
taken offline while other VPEs remain online. Unfortunately there is
nothing in this hack to prevent r4k_on_each_cpu() from reading the old
cpu_foreign_map, and smp_call_function_many() from reading that new
cpu_online_mask with the core's representative VPE marked offline. It
then wouldn't send an IPI to any online VPEs of that core.

stop_this_cpu() is only actually called in panic and system shutdown /
halt / reboot situations, in which case all CPUs are going down and we
don't really need to care about cache management, so drop this hack.

Note that the __cpu_disable() case for CPU hotplug is handled in the
previous commit, and no synchronisation is needed there due to the use
of stop_machine() which prevents hotplug from taking place while any CPU
has disabled preemption (as r4k_on_each_cpu() does).

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
---
 arch/mips/kernel/smp.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index a4d4309ecff2..783d5f50ab9d 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -344,16 +344,9 @@ asmlinkage void start_secondary(void)
 static void stop_this_cpu(void *dummy)
 {
 	/*
-	 * Remove this CPU. Be a bit slow here and
-	 * set the bits for every online CPU so we don't miss
-	 * any IPI whilst taking this VPE down.
+	 * Remove this CPU:
 	 */
 
-	cpumask_copy(&cpu_foreign_map, cpu_online_mask);
-
-	/* Make it visible to every other CPU */
-	smp_mb();
-
 	set_cpu_online(smp_processor_id(), false);
 	calculate_cpu_foreign_map();
 	local_irq_disable();
-- 
2.4.10
