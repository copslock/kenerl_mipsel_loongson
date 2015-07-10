Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2015 17:02:04 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3339 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010023AbbGJPBx7Xnap (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jul 2015 17:01:53 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 39AB579C097AD;
        Fri, 10 Jul 2015 16:01:45 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 10 Jul 2015 16:01:47 +0100
Received: from localhost (10.100.200.2) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 10 Jul
 2015 16:01:47 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Matthew Fortune <matthew.fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "James Hogan" <james.hogan@imgtec.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@codesourcery.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 03/16] MIPS: add offsets to sigcontext FP fields to struct mips_abi
Date:   Fri, 10 Jul 2015 16:00:12 +0100
Message-ID: <1436540426-10021-4-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1436540426-10021-1-git-send-email-paul.burton@imgtec.com>
References: <1436540426-10021-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.2]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48179
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

Add fields to struct mips_abi, which holds information regarding the
kernel-userland ABI regarding signals, to specify the offsets to the FP
related fields within the appropriate variant of struct sigcontext.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/abi.h   | 4 ++++
 arch/mips/kernel/signal.c     | 6 +++++-
 arch/mips/kernel/signal32.c   | 6 +++++-
 arch/mips/kernel/signal_n32.c | 6 +++++-
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/abi.h b/arch/mips/include/asm/abi.h
index 7186bb5..37f8407 100644
--- a/arch/mips/include/asm/abi.h
+++ b/arch/mips/include/asm/abi.h
@@ -20,6 +20,10 @@ struct mips_abi {
 				     struct pt_regs *regs, sigset_t *set);
 	const unsigned long	rt_signal_return_offset;
 	const unsigned long	restart;
+
+	unsigned	off_sc_fpregs;
+	unsigned	off_sc_fpc_csr;
+	unsigned	off_sc_used_math;
 };
 
 #endif /* _ASM_ABI_H */
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 796c7d8..ddf8318 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -521,7 +521,11 @@ struct mips_abi mips_abi = {
 	.setup_rt_frame = setup_rt_frame,
 	.rt_signal_return_offset =
 		offsetof(struct mips_vdso, rt_signal_trampoline),
-	.restart	= __NR_restart_syscall
+	.restart	= __NR_restart_syscall,
+
+	.off_sc_fpregs = offsetof(struct sigcontext, sc_fpregs),
+	.off_sc_fpc_csr = offsetof(struct sigcontext, sc_fpc_csr),
+	.off_sc_used_math = offsetof(struct sigcontext, sc_used_math),
 };
 
 static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 19a7705..6b65658 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -587,7 +587,11 @@ struct mips_abi mips_abi_32 = {
 	.setup_rt_frame = setup_rt_frame_32,
 	.rt_signal_return_offset =
 		offsetof(struct mips_vdso, o32_rt_signal_trampoline),
-	.restart	= __NR_O32_restart_syscall
+	.restart	= __NR_O32_restart_syscall,
+
+	.off_sc_fpregs = offsetof(struct sigcontext32, sc_fpregs),
+	.off_sc_fpc_csr = offsetof(struct sigcontext32, sc_fpc_csr),
+	.off_sc_used_math = offsetof(struct sigcontext32, sc_used_math),
 };
 
 static int signal32_init(void)
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index f1d4751..0d017fd 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -153,5 +153,9 @@ struct mips_abi mips_abi_n32 = {
 	.setup_rt_frame = setup_rt_frame_n32,
 	.rt_signal_return_offset =
 		offsetof(struct mips_vdso, n32_rt_signal_trampoline),
-	.restart	= __NR_N32_restart_syscall
+	.restart	= __NR_N32_restart_syscall,
+
+	.off_sc_fpregs = offsetof(struct sigcontext, sc_fpregs),
+	.off_sc_fpc_csr = offsetof(struct sigcontext, sc_fpc_csr),
+	.off_sc_used_math = offsetof(struct sigcontext, sc_used_math),
 };
-- 
2.4.4
