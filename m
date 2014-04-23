Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2014 13:18:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:48173 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6819447AbaDWLSFoNxAw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Apr 2014 13:18:05 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B36F08B3935CB;
        Wed, 23 Apr 2014 12:17:56 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 23 Apr 2014 12:17:58 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.65) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 23 Apr 2014 12:17:58 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH] MIPS: Wire up renameat2 syscall
Date:   Wed, 23 Apr 2014 12:17:37 +0100
Message-ID: <1398251857-16290-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.8.1.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.65]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39906
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

Wire up for MIPS the new renameat2 system call added in commit
520c8b165052 (vfs: add renameat2 syscall) merged in v3.15-rc1.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/uapi/asm/unistd.h | 15 +++++++++------
 arch/mips/kernel/scall32-o32.S      |  1 +
 arch/mips/kernel/scall64-64.S       |  1 +
 arch/mips/kernel/scall64-n32.S      |  1 +
 arch/mips/kernel/scall64-o32.S      |  1 +
 5 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index d6e154a9e6a5..5805414777e0 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -371,16 +371,17 @@
 #define __NR_finit_module		(__NR_Linux + 348)
 #define __NR_sched_setattr		(__NR_Linux + 349)
 #define __NR_sched_getattr		(__NR_Linux + 350)
+#define __NR_renameat2			(__NR_Linux + 351)
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		350
+#define __NR_Linux_syscalls		351
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		350
+#define __NR_O32_Linux_syscalls		351
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -699,16 +700,17 @@
 #define __NR_getdents64			(__NR_Linux + 308)
 #define __NR_sched_setattr		(__NR_Linux + 309)
 #define __NR_sched_getattr		(__NR_Linux + 310)
+#define __NR_renameat2			(__NR_Linux + 311)
 
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		310
+#define __NR_Linux_syscalls		311
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		310
+#define __NR_64_Linux_syscalls		311
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -1031,15 +1033,16 @@
 #define __NR_finit_module		(__NR_Linux + 312)
 #define __NR_sched_setattr		(__NR_Linux + 313)
 #define __NR_sched_getattr		(__NR_Linux + 314)
+#define __NR_renameat2			(__NR_Linux + 315)
 
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		314
+#define __NR_Linux_syscalls		315
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		314
+#define __NR_N32_Linux_syscalls		315
 
 #endif /* _UAPI_ASM_UNISTD_H */
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index fdc70b400442..3245474f19d5 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -577,3 +577,4 @@ EXPORT(sys_call_table)
 	PTR	sys_finit_module
 	PTR	sys_sched_setattr
 	PTR	sys_sched_getattr		/* 4350 */
+	PTR	sys_renameat2
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index dd99c3285aea..be2fedd4ae33 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -430,4 +430,5 @@ EXPORT(sys_call_table)
 	PTR	sys_getdents64
 	PTR	sys_sched_setattr
 	PTR	sys_sched_getattr		/* 5310 */
+	PTR	sys_renameat2
 	.size	sys_call_table,.-sys_call_table
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index f68d2f4f0090..c1dbcda4b816 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -423,4 +423,5 @@ EXPORT(sysn32_call_table)
 	PTR	sys_finit_module
 	PTR	sys_sched_setattr
 	PTR	sys_sched_getattr
+	PTR	sys_renameat2			/* 6315 */
 	.size	sysn32_call_table,.-sysn32_call_table
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 70f6acecd928..f1343ccd7ed7 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -556,4 +556,5 @@ EXPORT(sys32_call_table)
 	PTR	sys_finit_module
 	PTR	sys_sched_setattr
 	PTR	sys_sched_getattr		/* 4350 */
+	PTR	sys_renameat2
 	.size	sys32_call_table,.-sys32_call_table
-- 
1.8.1.2
