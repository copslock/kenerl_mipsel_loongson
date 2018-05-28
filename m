Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 May 2018 12:42:41 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:55172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994830AbeE1KmcDcJg0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 May 2018 12:42:32 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75193208A4;
        Mon, 28 May 2018 10:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527504146;
        bh=TpJqxSRGnhnMKXrr6rq54TmTmCYj6hskGwm1J2Xt3nM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HfcHEOR7uwskuN8DkNKE9JTOyrqmR7gMNYWZ+I56Fjdaw/Ma9qOuYgmFk+nCPXx3B
         GZKbhqKa5HMxUigS2sy9/NEsG8hQEjTrmBCHaJXIN57ALKty6rjArdm0u7no6XPz+t
         /xQqaePPhL7XmhqQXu7DesiVs6OQ1/ZC+x0Jc+xc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.14 003/496] MIPS: Fix ptrace(2) PTRACE_PEEKUSR and PTRACE_POKEUSR accesses to o32 FGRs
Date:   Mon, 28 May 2018 11:56:28 +0200
Message-Id: <20180528100319.661411607@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <SRS0=WbIs=IP=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@mips.com>

commit 9a3a92ccfe3620743d4ae57c987dc8e9c5f88996 upstream.

Check the TIF_32BIT_FPREGS task setting of the tracee rather than the
tracer in determining the layout of floating-point general registers in
the floating-point context, correcting access to odd-numbered registers
for o32 tracees where the setting disagrees between the two processes.

Fixes: 597ce1723e0f ("MIPS: Support for 64-bit FP with O32 binaries")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.14+
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/ptrace.c   |    4 ++--
 arch/mips/kernel/ptrace32.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -798,7 +798,7 @@ long arch_ptrace(struct task_struct *chi
 			fregs = get_fpu_regs(child);
 
 #ifdef CONFIG_32BIT
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
@@ -887,7 +887,7 @@ long arch_ptrace(struct task_struct *chi
 
 			init_fp_ctx(child);
 #ifdef CONFIG_32BIT
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -98,7 +98,7 @@ long compat_arch_ptrace(struct task_stru
 				break;
 			}
 			fregs = get_fpu_regs(child);
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
@@ -205,7 +205,7 @@ long compat_arch_ptrace(struct task_stru
 				       sizeof(child->thread.fpu));
 				child->thread.fpu.fcr31 = 0;
 			}
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
