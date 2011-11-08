Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2011 23:55:07 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3629 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904024Ab1KHWzB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Nov 2011 23:55:01 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4eb9b3960000>; Tue, 08 Nov 2011 14:56:22 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 8 Nov 2011 14:54:59 -0800
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 8 Nov 2011 14:54:58 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pA8MswbZ022773;
        Tue, 8 Nov 2011 14:54:58 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pA8MsvR9022772;
        Tue, 8 Nov 2011 14:54:57 -0800
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Hook up process_vm_readv and process_vm_writev system calls.
Date:   Tue,  8 Nov 2011 14:54:55 -0800
Message-Id: <1320792895-22740-1-git-send-email-david.daney@cavium.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 08 Nov 2011 22:54:58.0845 (UTC) FILETIME=[70D1BCD0:01CC9E69]
X-archive-position: 31442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7280

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/unistd.h |   18 ++++++++++++------
 arch/mips/kernel/scall32-o32.S |    2 ++
 arch/mips/kernel/scall64-64.S  |    2 ++
 arch/mips/kernel/scall64-n32.S |    2 ++
 arch/mips/kernel/scall64-o32.S |    2 ++
 5 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index ecea787..d8dad53 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -365,16 +365,18 @@
 #define __NR_syncfs			(__NR_Linux + 342)
 #define __NR_sendmmsg			(__NR_Linux + 343)
 #define __NR_setns			(__NR_Linux + 344)
+#define __NR_process_vm_readv		(__NR_Linux + 345)
+#define __NR_process_vm_writev		(__NR_Linux + 346)
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		344
+#define __NR_Linux_syscalls		346
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		344
+#define __NR_O32_Linux_syscalls		346
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -686,16 +688,18 @@
 #define __NR_syncfs			(__NR_Linux + 301)
 #define __NR_sendmmsg			(__NR_Linux + 302)
 #define __NR_setns			(__NR_Linux + 303)
+#define __NR_process_vm_readv		(__NR_Linux + 304)
+#define __NR_process_vm_writev		(__NR_Linux + 305)
 
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		303
+#define __NR_Linux_syscalls		305
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		303
+#define __NR_64_Linux_syscalls		305
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -1012,16 +1016,18 @@
 #define __NR_syncfs			(__NR_Linux + 306)
 #define __NR_sendmmsg			(__NR_Linux + 307)
 #define __NR_setns			(__NR_Linux + 308)
+#define __NR_process_vm_readv		(__NR_Linux + 309)
+#define __NR_process_vm_writev		(__NR_Linux + 310)
 
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		308
+#define __NR_Linux_syscalls		310
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		308
+#define __NR_N32_Linux_syscalls		310
 
 #ifdef __KERNEL__
 
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 4792065..a632bc1 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -591,6 +591,8 @@ einval:	li	v0, -ENOSYS
 	sys	sys_syncfs		1
 	sys	sys_sendmmsg		4
 	sys	sys_setns		2
+	sys	sys_process_vm_readv	6	/* 4345 */
+	sys	sys_process_vm_writev	6
 	.endm
 
 	/* We pre-compute the number of _instruction_ bytes needed to
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index fb7334b..3b5a5e9 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -430,4 +430,6 @@ sys_call_table:
 	PTR	sys_syncfs
 	PTR	sys_sendmmsg
 	PTR	sys_setns
+	PTR	sys_process_vm_readv
+	PTR	sys_process_vm_writev		/* 5305 */
 	.size	sys_call_table,.-sys_call_table
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 6de1f59..6be6f70 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -430,4 +430,6 @@ EXPORT(sysn32_call_table)
 	PTR	sys_syncfs
 	PTR	compat_sys_sendmmsg
 	PTR	sys_setns
+	PTR	compat_sys_process_vm_readv
+	PTR	compat_sys_process_vm_writev	/* 6310 */
 	.size	sysn32_call_table,.-sysn32_call_table
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 1d81316..5422855 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -548,4 +548,6 @@ sys_call_table:
 	PTR	sys_syncfs
 	PTR	compat_sys_sendmmsg
 	PTR	sys_setns
+	PTR	compat_sys_process_vm_readv	/* 4345 */
+	PTR	compat_sys_process_vm_writev
 	.size	sys_call_table,.-sys_call_table
-- 
1.7.2.3
