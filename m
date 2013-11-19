Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Nov 2013 18:33:42 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:2613 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819765Ab3KSRcRyYRxA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Nov 2013 18:32:17 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 3/6] mips: simplify ptrace_getfpregs FPU IR retrieval
Date:   Tue, 19 Nov 2013 17:30:36 +0000
Message-ID: <1384882239-17965-4-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1384882239-17965-1-git-send-email-paul.burton@imgtec.com>
References: <1384882239-17965-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2013_11_19_17_32_12
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38554
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

All architecturally defined bits in the FPU implementation register
are read only & unchanging. It contains some implementation-defined
bits but the architecture manual states "This bits are explicitly not
intended to be used for mode control functions" which seems to provide
justification for viewing the register as a whole as unchanging. This
being the case we can simply re-use the value we read at boot rather
than having to re-read it later, and avoid the complexity which that
read entails.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/kernel/ptrace.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 7654ac2..98602b9 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -114,7 +114,6 @@ int ptrace_setregs(struct task_struct *child, __s64 __user *data)
 int ptrace_getfpregs(struct task_struct *child, __u32 __user *data)
 {
 	int i;
-	unsigned int tmp;
 
 	if (!access_ok(VERIFY_WRITE, data, 33 * 8))
 		return -EIO;
@@ -130,29 +129,7 @@ int ptrace_getfpregs(struct task_struct *child, __u32 __user *data)
 	}
 
 	__put_user(child->thread.fpu.fcr31, data + 64);
-
-	preempt_disable();
-	if (cpu_has_fpu) {
-		unsigned int flags;
-
-		if (cpu_has_mipsmt) {
-			unsigned int vpflags = dvpe();
-			flags = read_c0_status();
-			__enable_fpu(FPU_AS_IS);
-			__asm__ __volatile__("cfc1\t%0,$0" : "=r" (tmp));
-			write_c0_status(flags);
-			evpe(vpflags);
-		} else {
-			flags = read_c0_status();
-			__enable_fpu(FPU_AS_IS);
-			__asm__ __volatile__("cfc1\t%0,$0" : "=r" (tmp));
-			write_c0_status(flags);
-		}
-	} else {
-		tmp = 0;
-	}
-	preempt_enable();
-	__put_user(tmp, data + 65);
+	__put_user(current_cpu_data.fpu_id, data + 65);
 
 	return 0;
 }
-- 
1.8.4.2
