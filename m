Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Aug 2014 05:17:08 +0200 (CEST)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:63358 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859946AbaHHDQfXLiIU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Aug 2014 05:16:35 +0200
Received: by mail-pa0-f48.google.com with SMTP id et14so6453649pad.7
        for <multiple recipients>; Thu, 07 Aug 2014 20:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=ib9utR1/W3DMw7IvrHdrLSGGhvMQ2SbLPtKxnkazVms=;
        b=QzciI5OScisZc0I5FExWCKc2g371tmpNxHndighBmiLoWPnh6MM7BVi4hl9PN6lStv
         ddDiKsuLEA6lilQOuKJmHMJXn6y4RkrO8YYRBvTl5FZxQdWjwQ9Kb9UNVq29YWeNPVCu
         MKXqebIQi+ONZCYWfh2NOxc9RjFRf0sS/THbelyJ4+1wahMGkJfrS3fTQ3zWdJ8m5RW5
         RlHEr3U/R+DApAB6yvqjGoezqluZZT88AvwQfj3XpcMOW+U+9oXVaKSxTs3oyjGW0YCs
         qTU6iGDIMRTgk//B4vcp1nbrCDbN0Hq+4u8wPNSUMZXbZYUIK1ifPvU07/CLjB6+qLxw
         j6TA==
X-Received: by 10.70.35.207 with SMTP id k15mr21372277pdj.5.1407467785920;
        Thu, 07 Aug 2014 20:16:25 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id j1sm2005181pdh.31.2014.08.07.20.16.21
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 20:16:25 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        "Jayachandran C." <jchandra@broadcom.com>
Subject: [PATCH 1/2] MIPS: Move CPU topology macros to topology.h
Date:   Fri,  8 Aug 2014 11:16:07 +0800
Message-Id: <1407467768-24097-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41904
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

This fix macros redefinition problems for Netlogic.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: Jayachandran C. <jchandra@broadcom.com>
---
 arch/mips/include/asm/smp.h      |    5 -----
 arch/mips/include/asm/topology.h |   13 +++++++++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 1e0f20a..eacf865 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -37,11 +37,6 @@ extern int __cpu_logical_map[NR_CPUS];
 
 #define NO_PROC_ID	(-1)
 
-#define topology_physical_package_id(cpu)	(cpu_data[cpu].package)
-#define topology_core_id(cpu)			(cpu_data[cpu].core)
-#define topology_core_cpumask(cpu)		(&cpu_core_map[cpu])
-#define topology_thread_cpumask(cpu)		(&cpu_sibling_map[cpu])
-
 #define SMP_RESCHEDULE_YOURSELF 0x1	/* XXX braindead */
 #define SMP_CALL_FUNCTION	0x2
 /* Octeon - Tell another core to flush its icache */
diff --git a/arch/mips/include/asm/topology.h b/arch/mips/include/asm/topology.h
index 20ea485..2a0f04b 100644
--- a/arch/mips/include/asm/topology.h
+++ b/arch/mips/include/asm/topology.h
@@ -10,4 +10,17 @@
 
 #include <topology.h>
 
+#ifndef topology_physical_package_id
+#define topology_physical_package_id(cpu)	(cpu_data[cpu].package)
+#endif
+#ifndef topology_core_id
+#define topology_core_id(cpu)			(cpu_data[cpu].core)
+#endif
+#ifndef topology_core_cpumask
+#define topology_core_cpumask(cpu)		(&cpu_core_map[cpu])
+#endif
+#ifndef topology_thread_cpumask
+#define topology_thread_cpumask(cpu)		(&cpu_sibling_map[cpu])
+#endif
+
 #endif /* __ASM_TOPOLOGY_H */
-- 
1.7.7.3
