Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2014 15:07:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:37387 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837171AbaDPNGUAWHNZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2014 15:06:20 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7D1CD575374BF
        for <linux-mips@linux-mips.org>; Wed, 16 Apr 2014 14:06:10 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 16 Apr 2014 14:06:13 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 16 Apr 2014 14:06:12 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 35/39] MIPS: cpuidle wait instruction state
Date:   Wed, 16 Apr 2014 14:06:09 +0100
Message-ID: <1397653569-4813-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
References: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Defines a macro intended to allow trivial use of the regular MIPS wait
instruction from cpuidle drivers, which may simply invoke the macro
within their array of states.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/idle.h | 14 ++++++++++++++
 arch/mips/kernel/idle.c      | 11 +++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/mips/include/asm/idle.h b/arch/mips/include/asm/idle.h
index d192158..d9f932d 100644
--- a/arch/mips/include/asm/idle.h
+++ b/arch/mips/include/asm/idle.h
@@ -1,6 +1,7 @@
 #ifndef __ASM_IDLE_H
 #define __ASM_IDLE_H
 
+#include <linux/cpuidle.h>
 #include <linux/linkage.h>
 
 extern void (*cpu_wait)(void);
@@ -20,4 +21,17 @@ static inline int address_is_in_r4k_wait_irqoff(unsigned long addr)
 	       addr < (unsigned long)__pastwait;
 }
 
+extern int mips_cpuidle_wait_enter(struct cpuidle_device *dev,
+				   struct cpuidle_driver *drv, int index);
+
+#define MIPS_CPUIDLE_WAIT_STATE {\
+	.enter			= mips_cpuidle_wait_enter,\
+	.exit_latency		= 1,\
+	.target_residency	= 1,\
+	.power_usage		= UINT_MAX,\
+	.flags			= CPUIDLE_FLAG_TIME_VALID,\
+	.name			= "wait",\
+	.desc			= "MIPS wait",\
+}
+
 #endif /* __ASM_IDLE_H  */
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 837ff27..2879e2e 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -250,3 +250,14 @@ void arch_cpu_idle(void)
 	else
 		local_irq_enable();
 }
+
+#ifdef CONFIG_CPU_IDLE
+
+int mips_cpuidle_wait_enter(struct cpuidle_device *dev,
+			    struct cpuidle_driver *drv, int index)
+{
+	arch_cpu_idle();
+	return index;
+}
+
+#endif
-- 
1.8.5.3
