Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2016 10:36:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46201 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27024909AbcC2IgAR1iSk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Mar 2016 10:36:00 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 52E6D93B9BCB;
        Tue, 29 Mar 2016 09:35:52 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 29 Mar 2016 09:35:54 +0100
Received: from mredfearn-linux.kl.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 29 Mar 2016 09:35:53 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     <IMG-MIPSLinuxKerneldevelopers@imgtec.com>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-mips@linux-mips.org>, Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 5/6] MIPS: seccomp: Support compat with both O32 and N32
Date:   Tue, 29 Mar 2016 09:35:33 +0100
Message-ID: <1459240534-8658-6-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459240534-8658-1-git-send-email-matt.redfearn@imgtec.com>
References: <1459240534-8658-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Previously the seccomp would only support strict mode on O32 userland
programs when the kernel had support for both O32 and N32 ABIs. Remove
kludge and support both ABIs.

With this patch in place, the seccomp_bpf self test now passes
global.mode_strict_support with N32 userland.

Suggested-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

Changes in v2: None

 arch/mips/include/asm/seccomp.h | 47 +++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/arch/mips/include/asm/seccomp.h b/arch/mips/include/asm/seccomp.h
index 1d8a2e2c75c1..684fb3a12ed3 100644
--- a/arch/mips/include/asm/seccomp.h
+++ b/arch/mips/include/asm/seccomp.h
@@ -2,27 +2,32 @@
 
 #include <linux/unistd.h>
 
-/*
- * Kludge alert:
- *
- * The generic seccomp code currently allows only a single compat ABI.	Until
- * this is fixed we priorize O32 as the compat ABI over N32.
- */
-#ifdef CONFIG_MIPS32_O32
-
-#define __NR_seccomp_read_32		4003
-#define __NR_seccomp_write_32		4004
-#define __NR_seccomp_exit_32		4001
-#define __NR_seccomp_sigreturn_32	4193	/* rt_sigreturn */
-
-#elif defined(CONFIG_MIPS32_N32)
-
-#define __NR_seccomp_read_32		6000
-#define __NR_seccomp_write_32		6001
-#define __NR_seccomp_exit_32		6058
-#define __NR_seccomp_sigreturn_32	6211	/* rt_sigreturn */
-
-#endif /* CONFIG_MIPS32_O32 */
+#ifdef CONFIG_COMPAT
+static inline const int *get_compat_mode1_syscalls(void)
+{
+	static const int syscalls_O32[] = {
+		__NR_O32_Linux + 3, __NR_O32_Linux + 4,
+		__NR_O32_Linux + 1, __NR_O32_Linux + 193,
+		0, /* null terminated */
+	};
+	static const int syscalls_N32[] = {
+		__NR_N32_Linux + 0, __NR_N32_Linux + 1,
+		__NR_N32_Linux + 58, __NR_N32_Linux + 211,
+		0, /* null terminated */
+	};
+
+	if (config_enabled(CONFIG_MIPS32_O32) && test_thread_flag(TIF_32BIT_REGS))
+		return syscalls_O32;
+
+	if (config_enabled(CONFIG_MIPS32_N32))
+		return syscalls_N32;
+
+	BUG();
+}
+
+#define get_compat_mode1_syscalls get_compat_mode1_syscalls
+
+#endif /* CONFIG_COMPAT */
 
 #include <asm-generic/seccomp.h>
 
-- 
2.5.0
