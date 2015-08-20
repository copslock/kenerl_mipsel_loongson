Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Aug 2015 13:46:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55426 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011670AbbHTLpiEPoXm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Aug 2015 13:45:38 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 76D2A8E529BEA
        for <linux-mips@linux-mips.org>; Thu, 20 Aug 2015 12:45:29 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 20 Aug 2015 12:45:32 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.168) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 20 Aug 2015 12:45:31 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
Subject: [PATCH 2/2] MIPS: kernel: signal: Drop unused arguments for traditional signal handlers
Date:   Thu, 20 Aug 2015 12:45:22 +0100
Message-ID: <1440071122-24971-3-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1440071122-24971-1-git-send-email-markos.chandras@imgtec.com>
References: <1440071122-24971-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.168]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Traditional signal handlers (ie !SA_SIGINFO) only need only argument
holding the signal number so we drop the additional arguments and fix
the related comments. We also update the comments for the SA_SIGINFO
case where the second argument is a pointer to a siginfo_t structure.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/signal.c     | 6 +-----
 arch/mips/kernel/signal32.c   | 6 +-----
 arch/mips/kernel/signal_n32.c | 2 +-
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index be3ac5f7cbbb..3a125331bf8b 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -683,15 +683,11 @@ static int setup_frame(void *sig_return, struct ksignal *ksig,
 	 * Arguments to signal handler:
 	 *
 	 *   a0 = signal number
-	 *   a1 = 0 (should be cause)
-	 *   a2 = pointer to struct sigcontext
 	 *
 	 * $25 and c0_epc point to the signal handler, $29 points to the
 	 * struct sigframe.
 	 */
 	regs->regs[ 4] = ksig->sig;
-	regs->regs[ 5] = 0;
-	regs->regs[ 6] = (unsigned long) &frame->sf_sc;
 	regs->regs[29] = (unsigned long) frame;
 	regs->regs[31] = (unsigned long) sig_return;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ksig->ka.sa.sa_handler;
@@ -730,7 +726,7 @@ static int setup_rt_frame(void *sig_return, struct ksignal *ksig,
 	 * Arguments to signal handler:
 	 *
 	 *   a0 = signal number
-	 *   a1 = 0 (should be cause)
+	 *   a1 = pointer to siginfo_t
 	 *   a2 = pointer to ucontext
 	 *
 	 * $25 and c0_epc point to the signal handler, $29 points to
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 3059f36bfc89..6f6f79435edf 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -336,15 +336,11 @@ static int setup_frame_32(void *sig_return, struct ksignal *ksig,
 	 * Arguments to signal handler:
 	 *
 	 *   a0 = signal number
-	 *   a1 = 0 (should be cause)
-	 *   a2 = pointer to struct sigcontext
 	 *
 	 * $25 and c0_epc point to the signal handler, $29 points to the
 	 * struct sigframe.
 	 */
 	regs->regs[ 4] = ksig->sig;
-	regs->regs[ 5] = 0;
-	regs->regs[ 6] = (unsigned long) &frame->sf_sc;
 	regs->regs[29] = (unsigned long) frame;
 	regs->regs[31] = (unsigned long) sig_return;
 	regs->cp0_epc = regs->regs[25] = (unsigned long) ksig->ka.sa.sa_handler;
@@ -383,7 +379,7 @@ static int setup_rt_frame_32(void *sig_return, struct ksignal *ksig,
 	 * Arguments to signal handler:
 	 *
 	 *   a0 = signal number
-	 *   a1 = 0 (should be cause)
+	 *   a1 = pointer to siginfo_t
 	 *   a2 = pointer to ucontext
 	 *
 	 * $25 and c0_epc point to the signal handler, $29 points to
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index 0d017fdcaf07..04c4a2a7df13 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -129,7 +129,7 @@ static int setup_rt_frame_n32(void *sig_return, struct ksignal *ksig,
 	 * Arguments to signal handler:
 	 *
 	 *   a0 = signal number
-	 *   a1 = 0 (should be cause)
+	 *   a1 = pointer to siginfo_t
 	 *   a2 = pointer to ucontext
 	 *
 	 * $25 and c0_epc point to the signal handler, $29 points to
-- 
2.5.0
