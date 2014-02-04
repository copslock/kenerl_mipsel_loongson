Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Feb 2014 13:30:42 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:32251 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816676AbaBDMajpVEJq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 Feb 2014 13:30:39 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>
Subject: [PATCH] MIPS: Wire up sched_setattr/sched_getattr syscalls
Date:   Tue, 4 Feb 2014 12:29:01 +0000
Message-ID: <1391516941-20260-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.8.1.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.65]
X-SEF-Processed: 7_3_0_01192__2014_02_04_12_30_34
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39205
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

Wire up for MIPS the new sched_setattr and sched_getattr system calls
added in commit d50dde5a10f3 (sched: Add new scheduler syscalls to
support an extended scheduling parameters ABI) merged in v3.14-rc1.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/uapi/asm/unistd.h | 18 ++++++++++++------
 arch/mips/kernel/scall32-o32.S      |  2 ++
 arch/mips/kernel/scall64-64.S       |  2 ++
 arch/mips/kernel/scall64-n32.S      |  2 ++
 arch/mips/kernel/scall64-o32.S      |  2 ++
 5 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index 1dee279f9665..d6e154a9e6a5 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -369,16 +369,18 @@
 #define __NR_process_vm_writev		(__NR_Linux + 346)
 #define __NR_kcmp			(__NR_Linux + 347)
 #define __NR_finit_module		(__NR_Linux + 348)
+#define __NR_sched_setattr		(__NR_Linux + 349)
+#define __NR_sched_getattr		(__NR_Linux + 350)
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		348
+#define __NR_Linux_syscalls		350
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		348
+#define __NR_O32_Linux_syscalls		350
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -695,16 +697,18 @@
 #define __NR_kcmp			(__NR_Linux + 306)
 #define __NR_finit_module		(__NR_Linux + 307)
 #define __NR_getdents64			(__NR_Linux + 308)
+#define __NR_sched_setattr		(__NR_Linux + 309)
+#define __NR_sched_getattr		(__NR_Linux + 310)
 
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		308
+#define __NR_Linux_syscalls		310
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		308
+#define __NR_64_Linux_syscalls		310
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -1025,15 +1029,17 @@
 #define __NR_process_vm_writev		(__NR_Linux + 310)
 #define __NR_kcmp			(__NR_Linux + 311)
 #define __NR_finit_module		(__NR_Linux + 312)
+#define __NR_sched_setattr		(__NR_Linux + 313)
+#define __NR_sched_getattr		(__NR_Linux + 314)
 
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		312
+#define __NR_Linux_syscalls		314
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		312
+#define __NR_N32_Linux_syscalls		314
 
 #endif /* _UAPI_ASM_UNISTD_H */
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index e8e541b40d86..a5b14f48e1af 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -563,3 +563,5 @@ EXPORT(sys_call_table)
 	PTR	sys_process_vm_writev
 	PTR	sys_kcmp
 	PTR	sys_finit_module
+	PTR	sys_sched_setattr
+	PTR	sys_sched_getattr		/* 4350 */
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index 57e3742fec59..b56e254beb15 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -425,4 +425,6 @@ EXPORT(sys_call_table)
 	PTR	sys_kcmp
 	PTR	sys_finit_module
 	PTR	sys_getdents64
+	PTR	sys_sched_setattr
+	PTR	sys_sched_getattr		/* 5310 */
 	.size	sys_call_table,.-sys_call_table
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 2f48f5934399..f7e5b72cf481 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -418,4 +418,6 @@ EXPORT(sysn32_call_table)
 	PTR	compat_sys_process_vm_writev	/* 6310 */
 	PTR	sys_kcmp
 	PTR	sys_finit_module
+	PTR	sys_sched_setattr
+	PTR	sys_sched_getattr
 	.size	sysn32_call_table,.-sysn32_call_table
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index f1acdb429f4f..6788727d91af 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -541,4 +541,6 @@ EXPORT(sys32_call_table)
 	PTR	compat_sys_process_vm_writev
 	PTR	sys_kcmp
 	PTR	sys_finit_module
+	PTR	sys_sched_setattr
+	PTR	sys_sched_getattr		/* 4350 */
 	.size	sys32_call_table,.-sys32_call_table
-- 
1.8.1.2
