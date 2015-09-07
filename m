Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Sep 2015 18:16:38 +0200 (CEST)
Received: from mail.efficios.com ([78.47.125.74]:47841 "EHLO mail.efficios.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007562AbbIGQQf0-9Q1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Sep 2015 18:16:35 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 04C7F3405A0;
        Mon,  7 Sep 2015 16:16:31 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VCShKGKZzL1C; Mon,  7 Sep 2015 16:16:25 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 44AFE34059D;
        Mon,  7 Sep 2015 16:16:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dtT6HqRnX0co; Mon,  7 Sep 2015 16:16:25 +0000 (UTC)
Received: from thinkos.etherlink (cable-192.222.213.99.electronicbox.net [192.222.213.99])
        by mail.efficios.com (Postfix) with ESMTPSA id B418D34059B;
        Mon,  7 Sep 2015 16:16:23 +0000 (UTC)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-mips@linux-mips.org
Subject: [PATCH v2 2/9] mips: allocate sys_membarrier system call number
Date:   Mon,  7 Sep 2015 12:15:49 -0400
Message-Id: <1441642556-30972-3-git-send-email-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1441642556-30972-1-git-send-email-mathieu.desnoyers@efficios.com>
References: <1441642556-30972-1-git-send-email-mathieu.desnoyers@efficios.com>
Return-Path: <mathieu.desnoyers@efficios.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mathieu.desnoyers@efficios.com
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

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: linux-api@vger.kernel.org
CC: linux-mips@linux-mips.org
---
 arch/mips/include/uapi/asm/unistd.h | 15 +++++++++------
 arch/mips/kernel/scall32-o32.S      |  1 +
 arch/mips/kernel/scall64-64.S       |  1 +
 arch/mips/kernel/scall64-n32.S      |  1 +
 arch/mips/kernel/scall64-o32.S      |  1 +
 5 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index d0bdfaa..b107983 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -378,16 +378,17 @@
 #define __NR_bpf			(__NR_Linux + 355)
 #define __NR_execveat			(__NR_Linux + 356)
 #define __NR_mlock2			(__NR_Linux + 357)
+#define __NR_membarrier			(__NR_Linux + 358)
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		357
+#define __NR_Linux_syscalls		358
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		357
+#define __NR_O32_Linux_syscalls		358
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -713,16 +714,17 @@
 #define __NR_bpf			(__NR_Linux + 315)
 #define __NR_execveat			(__NR_Linux + 316)
 #define __NR_mlock2			(__NR_Linux + 317)
+#define __NR_membarrier			(__NR_Linux + 318)
 
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		317
+#define __NR_Linux_syscalls		318
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		317
+#define __NR_64_Linux_syscalls		318
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -1052,15 +1054,16 @@
 #define __NR_bpf			(__NR_Linux + 319)
 #define __NR_execveat			(__NR_Linux + 320)
 #define __NR_mlock2			(__NR_Linux + 321)
+#define __NR_membarrier			(__NR_Linux + 322)
 
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		321
+#define __NR_Linux_syscalls		322
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		321
+#define __NR_N32_Linux_syscalls		322
 
 #endif /* _UAPI_ASM_UNISTD_H */
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index b0b377a..9265542 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -600,3 +600,4 @@ EXPORT(sys_call_table)
 	PTR	sys_bpf				/* 4355 */
 	PTR	sys_execveat
 	PTR	sys_mlock2
+	PTR	sys_membarrier
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index f12eb03..79d4fb0 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -437,4 +437,5 @@ EXPORT(sys_call_table)
 	PTR	sys_bpf				/* 5315 */
 	PTR	sys_execveat
 	PTR	sys_mlock2
+	PTR	sys_membarrier
 	.size	sys_call_table,.-sys_call_table
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index ecdd65a..235892a 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -430,4 +430,5 @@ EXPORT(sysn32_call_table)
 	PTR	sys_bpf
 	PTR	compat_sys_execveat		/* 6320 */
 	PTR	sys_mlock2
+	PTR	sys_membarrier
 	.size	sysn32_call_table,.-sysn32_call_table
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 7a8b2df..c051bd3 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -585,4 +585,5 @@ EXPORT(sys32_call_table)
 	PTR	sys_bpf				/* 4355 */
 	PTR	compat_sys_execveat
 	PTR	sys_mlock2
+	PTR	sys_membarrier
 	.size	sys32_call_table,.-sys32_call_table
-- 
1.9.1
