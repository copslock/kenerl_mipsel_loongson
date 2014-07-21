Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jul 2014 17:29:09 +0200 (CEST)
Received: from mail.sigma-star.at ([95.130.255.111]:45334 "EHLO
        mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861578AbaGUOEY5rRjZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Jul 2014 16:04:24 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.sigma-star.at (Postfix) with ESMTP id 9D6B616B42B7;
        Mon, 21 Jul 2014 16:04:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail.sigma-star.at
Received: from localhost.localdomain (chello213047235169.tirol.surfer.at [213.47.235.169])
        by mail.sigma-star.at (Postfix) with ESMTPSA id 8E8EB16B42BD;
        Mon, 21 Jul 2014 16:04:22 +0200 (CEST)
From:   Richard Weinberger <richard@sigma-star.at>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 40/43] mips: Use sigsp()
Date:   Mon, 21 Jul 2014 16:03:26 +0200
Message-Id: <1405951409-16953-41-git-send-email-richard@sigma-star.at>
X-Mailer: git-send-email 1.8.4.5
In-Reply-To: <1405951409-16953-1-git-send-email-richard@sigma-star.at>
References: <1405951409-16953-1-git-send-email-richard@sigma-star.at>
Return-Path: <richard@sigma-star.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard@sigma-star.at
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

From: Richard Weinberger <richard@nod.at>

Use sigsp() instead of the open coded variant.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/mips/kernel/signal.c     | 10 ++++------
 arch/mips/kernel/signal32.c   |  4 ++--
 arch/mips/kernel/signal_n32.c |  2 +-
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index da4baac..1d57605 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -280,7 +280,7 @@ int restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 	return err;
 }
 
-void __user *get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
+void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
 			  size_t frame_size)
 {
 	unsigned long sp;
@@ -295,9 +295,7 @@ void __user *get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
 	 */
 	sp -= 32;
 
-	/* This is the X/Open sanctioned signal stack switching.  */
-	if ((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags (sp) == 0))
-		sp = current->sas_ss_sp + current->sas_ss_size;
+	sp = sigsp(sp, ksig);
 
 	return (void __user *)((sp - frame_size) & (ICACHE_REFILLS_WORKAROUND_WAR ? ~(cpu_icache_line_size()-1) : ALMASK));
 }
@@ -434,7 +432,7 @@ static int setup_frame(void *sig_return, struct ksignal *ksig,
 	struct sigframe __user *frame;
 	int err = 0;
 
-	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
+	frame = get_sigframe(ksig, regs, sizeof(*frame));
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		return -EFAULT;
 
@@ -473,7 +471,7 @@ static int setup_rt_frame(void *sig_return, struct ksignal *ksig,
 	struct rt_sigframe __user *frame;
 	int err = 0;
 
-	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
+	frame = get_sigframe(ksig, regs, sizeof(*frame));
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		return -EFAULT;
 
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index eb8d0e2..d69179c 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -496,7 +496,7 @@ static int setup_frame_32(void *sig_return, struct ksignal *ksig,
 	struct sigframe32 __user *frame;
 	int err = 0;
 
-	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
+	frame = get_sigframe(ksig, regs, sizeof(*frame));
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		return -EFAULT;
 
@@ -536,7 +536,7 @@ static int setup_rt_frame_32(void *sig_return, struct ksignal *ksig,
 	struct rt_sigframe32 __user *frame;
 	int err = 0;
 
-	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
+	frame = get_sigframe(ksig, regs, sizeof(*frame));
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		return -EFAULT;
 
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index 7d04f28..f1d4751 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -108,7 +108,7 @@ static int setup_rt_frame_n32(void *sig_return, struct ksignal *ksig,
 	struct rt_sigframe_n32 __user *frame;
 	int err = 0;
 
-	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame));
+	frame = get_sigframe(ksig, regs, sizeof(*frame));
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		return -EFAULT;
 
-- 
1.8.4.5
