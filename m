Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Oct 2018 17:31:23 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40392 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992087AbeJNPaabpgjA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Oct 2018 17:30:30 +0200
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLb-0004cg-Re; Sun, 14 Oct 2018 16:30:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLZ-0000gB-7F; Sun, 14 Oct 2018 16:30:25 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Maciej W. Rozycki" <macro@mips.com>,
        "Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "James Hogan" <jhogan@kernel.org>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.166439063@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 308/366] MIPS: Fix ptrace(2) PTRACE_PEEKUSR and
 PTRACE_POKEUSR accesses to o32 FGRs
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej W. Rozycki" <macro@mips.com>

commit 9a3a92ccfe3620743d4ae57c987dc8e9c5f88996 upstream.

Check the TIF_32BIT_FPREGS task setting of the tracee rather than the
tracer in determining the layout of floating-point general registers in
the floating-point context, correcting access to odd-numbered registers
for o32 tracees where the setting disagrees between the two processes.

Fixes: 597ce1723e0f ("MIPS: Support for 64-bit FP with O32 binaries")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/ptrace.c   | 4 ++--
 arch/mips/kernel/ptrace32.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -741,7 +741,7 @@ long arch_ptrace(struct task_struct *chi
 			fregs = get_fpu_regs(child);
 
 #ifdef CONFIG_32BIT
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
@@ -830,7 +830,7 @@ long arch_ptrace(struct task_struct *chi
 
 			init_fp_ctx(child);
 #ifdef CONFIG_32BIT
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -97,7 +97,7 @@ long compat_arch_ptrace(struct task_stru
 				break;
 			}
 			fregs = get_fpu_regs(child);
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
@@ -203,7 +203,7 @@ long compat_arch_ptrace(struct task_stru
 				       sizeof(child->thread.fpu));
 				child->thread.fpu.fcr31 = 0;
 			}
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
