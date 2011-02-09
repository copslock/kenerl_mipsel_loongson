Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Feb 2011 01:21:00 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:2019 "EHLO MMS3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491914Ab1BIAU4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Feb 2011 01:20:56 +0100
Received: from [10.9.200.131] by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Tue, 08 Feb 2011 16:20:04 -0800
X-Server-Uuid: B55A25B1-5D7D-41F8-BC53-C57E7AD3C201
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Tue, 8 Feb 2011 16:18:19 -0800
Received: from stb-bld-00.broadcom.com (stb-bld-00 [10.13.134.27]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 8A46874D03; Tue, 8
 Feb 2011 16:18:19 -0800 (PST)
From:   maksim.rayskiy@gmail.com
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Maksim Rayskiy" <mrayskiy@broadcom.com>
Subject: [PATCH] MIPS: clear idle task mm pointer when hotplugging cpu
Date:   Tue, 8 Feb 2011 16:18:07 -0800
Message-ID: <1297210687-14589-1-git-send-email-maksim.rayskiy@gmail.com>
X-Mailer: git-send-email 1.7.3.2
MIME-Version: 1.0
X-WSS-ID: 614F023E0604167947-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <maksim.rayskiy@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maksim.rayskiy@gmail.com
Precedence: bulk
X-list: linux-mips

From: Maksim Rayskiy <mrayskiy@broadcom.com>

If kernel starts with maxcpus= option which does not bring all
available cpus online at boot time, idle tasks for offline cpus
are not created. If later offline cpus are hotplugged through sysfs,
__cpu_up is called in the context of the user task, and fork_idle
copies its non-zero mm pointer.  This causes BUG() in per_cpu_trap_init.

To avoid this, release mm for idle task and reset the pointer after
fork_idle().

Signed-off-by: Maksim Rayskiy <mrayskiy@broadcom.com>
---
 arch/mips/kernel/smp.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 383aeb9..4593916 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -208,6 +208,11 @@ int __cpuinit __cpu_up(unsigned int cpu)
 
 		if (IS_ERR(idle))
 			panic(KERN_ERR "Fork failed for CPU %d", cpu);
+
+		if (idle->mm) {
+			mmput(idle->mm);
+			idle->mm = NULL;
+		}
 	} else {
 		idle = cpu_idle_thread[cpu];
 		init_idle(idle, cpu);
-- 
1.7.3.2
