Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 10:27:34 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50457 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007056AbcCQJ1dREfdF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 10:27:33 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id AF16488458FD9;
        Thu, 17 Mar 2016 09:27:25 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 17 Mar 2016 09:27:26 +0000
Received: from mredfearn-linux.kl.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 17 Mar 2016 09:27:26 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     <keescook@chromium.org>
CC:     <milko.leporis@imgtec.com>, <ralf@linux-mips.org>,
        <luto@amacapital.net>, <wad@chromium.org>,
        <shuahkh@osg.samsung.com>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH] selftests/seccomp: add MIPS self-test support
Date:   Thu, 17 Mar 2016 09:26:38 +0000
Message-ID: <1458206798-26592-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.5.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52633
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

This adds self-test support on MIPS, based on RFC patch from Kees Cook.
Modifications from the RFC:
- support the O32 syscall which passes the real syscall number in a0.
- Use PTRACE_{GET,SET}REGS
- Because SYSCALL_NUM and SYSCALL_RET are the same register, it is not
  possible to test modifying the syscall return value when skipping,
  since both would need to set the same register. Therefore modify that
  test case to just detect the skipped test.
Tested on MIPS32r2 with an O32 userland where 48/48 tests now pass.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 30 +++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index b9453b838162..92862c828c4a 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -5,6 +5,7 @@
  * Test code for seccomp bpf.
  */
 
+#include <sys/types.h>
 #include <asm/siginfo.h>
 #define __have_siginfo_t 1
 #define __have_sigval_t 1
@@ -14,7 +15,6 @@
 #include <linux/filter.h>
 #include <sys/prctl.h>
 #include <sys/ptrace.h>
-#include <sys/types.h>
 #include <sys/user.h>
 #include <linux/prctl.h>
 #include <linux/ptrace.h>
@@ -1242,6 +1242,12 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 # define ARCH_REGS     s390_regs
 # define SYSCALL_NUM   gprs[2]
 # define SYSCALL_RET   gprs[2]
+#elif defined(__mips__)
+# define ARCH_REGS	struct pt_regs
+# define SYSCALL_NUM	regs[2]
+# define SYSCALL_SYSCALL_NUM regs[4]
+# define SYSCALL_RET	regs[2]
+# define SYSCALL_NUM_RET_SHARE_REG
 #else
 # error "Do not know how to find your architecture's registers and syscalls"
 #endif
@@ -1249,7 +1255,7 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 /* Use PTRACE_GETREGS and PTRACE_SETREGS when available. This is useful for
  * architectures without HAVE_ARCH_TRACEHOOK (e.g. User-mode Linux).
  */
-#if defined(__x86_64__) || defined(__i386__)
+#if defined(__x86_64__) || defined(__i386__) || defined(__mips__)
 #define HAVE_GETREGS
 #endif
 
@@ -1273,6 +1279,10 @@ int get_syscall(struct __test_metadata *_metadata, pid_t tracee)
 	}
 #endif
 
+#if defined(__mips__)
+	if (regs.SYSCALL_NUM == __NR_syscall)
+		return regs.SYSCALL_SYSCALL_NUM;
+#endif
 	return regs.SYSCALL_NUM;
 }
 
@@ -1297,6 +1307,13 @@ void change_syscall(struct __test_metadata *_metadata,
 	{
 		regs.SYSCALL_NUM = syscall;
 	}
+#elif defined(__mips__)
+	{
+		if (regs.SYSCALL_NUM == __NR_syscall)
+			regs.SYSCALL_SYSCALL_NUM = syscall;
+		else
+			regs.SYSCALL_NUM = syscall;
+	}
 
 #elif defined(__arm__)
 # ifndef PTRACE_SET_SYSCALL
@@ -1327,7 +1344,11 @@ void change_syscall(struct __test_metadata *_metadata,
 
 	/* If syscall is skipped, change return value. */
 	if (syscall == -1)
+#ifdef SYSCALL_NUM_RET_SHARE_REG
+		TH_LOG("Can't modify syscall return on this architecture");
+#else
 		regs.SYSCALL_RET = 1;
+#endif
 
 #ifdef HAVE_GETREGS
 	ret = ptrace(PTRACE_SETREGS, tracee, 0, &regs);
@@ -1465,8 +1486,13 @@ TEST_F(TRACE_syscall, syscall_dropped)
 	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &self->prog, 0, 0);
 	ASSERT_EQ(0, ret);
 
+#ifdef SYSCALL_NUM_RET_SHARE_REG
+	/* gettid has been skipped */
+	EXPECT_EQ(-1, syscall(__NR_gettid));
+#else
 	/* gettid has been skipped and an altered return value stored. */
 	EXPECT_EQ(1, syscall(__NR_gettid));
+#endif
 	EXPECT_NE(self->mytid, syscall(__NR_gettid));
 }
 
-- 
2.5.0
