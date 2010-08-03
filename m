Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Aug 2010 23:01:01 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4463 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492865Ab0HCVAx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Aug 2010 23:00:53 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c5883a10000>; Tue, 03 Aug 2010 14:01:21 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 3 Aug 2010 14:00:52 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 3 Aug 2010 14:00:51 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o73L0lIP002819;
        Tue, 3 Aug 2010 14:00:47 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o73L0lhk002818;
        Tue, 3 Aug 2010 14:00:47 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org, ananth@in.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        masami.hiramatsu.pt@hitachi.com
Cc:     linux-kernel@vger.kernel.org, hschauhan@nulltrace.org,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: KProbes: Use flush_insn_slot() where possible.
Date:   Tue,  3 Aug 2010 14:00:45 -0700
Message-Id: <1280869245-2786-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1280859742-26364-4-git-send-email-ddaney@caviumnetworks.com>
References: <1280859742-26364-4-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 03 Aug 2010 21:00:51.0999 (UTC) FILETIME=[F4EF72F0:01CB334E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---

This is a small cleanup that could either be folded into the original
3/5 or applied in addition to it.

 arch/mips/include/asm/kprobes.h |    1 +
 arch/mips/kernel/kprobes.c      |   11 +++--------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/kprobes.h b/arch/mips/include/asm/kprobes.h
index fe58e08..e6ea4d4 100644
--- a/arch/mips/include/asm/kprobes.h
+++ b/arch/mips/include/asm/kprobes.h
@@ -25,6 +25,7 @@
 #include <linux/ptrace.h>
 #include <linux/types.h>
 
+#include <asm/cacheflush.h>
 #include <asm/kdebug.h>
 #include <asm/inst.h>
 
diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index a74ccd2..ee28683 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -28,7 +28,6 @@
 #include <linux/kdebug.h>
 #include <linux/slab.h>
 
-#include <asm/cacheflush.h>
 #include <asm/ptrace.h>
 #include <asm/break.h>
 #include <asm/inst.h>
@@ -151,18 +150,14 @@ out:
 
 void __kprobes arch_arm_kprobe(struct kprobe *p)
 {
-	*(p->addr) = breakpoint_insn;
-	flush_icache_range((unsigned long)p->addr,
-			   (unsigned long)p->addr +
-			   (MAX_INSN_SIZE * sizeof(kprobe_opcode_t)));
+	*p->addr = breakpoint_insn;
+	flush_insn_slot(p);
 }
 
 void __kprobes arch_disarm_kprobe(struct kprobe *p)
 {
 	*p->addr = p->opcode;
-	flush_icache_range((unsigned long)p->addr,
-			   (unsigned long)p->addr +
-			   (MAX_INSN_SIZE * sizeof(kprobe_opcode_t)));
+	flush_insn_slot(p);
 }
 
 void __kprobes arch_remove_kprobe(struct kprobe *p)
-- 
1.7.1.1
