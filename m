Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Sep 2014 21:47:19 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:38505 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009003AbaIOTrRO2hU0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Sep 2014 21:47:17 +0200
Received: from localhost (c-24-22-230-10.hsd1.wa.comcast.net [24.22.230.10])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F1293A54;
        Mon, 15 Sep 2014 19:47:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.10 20/71] MIPS: Prevent user from setting FCSR cause bits
Date:   Mon, 15 Sep 2014 12:26:18 -0700
Message-Id: <20140915192639.383488267@linuxfoundation.org>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <20140915192638.702282534@linuxfoundation.org>
References: <20140915192638.702282534@linuxfoundation.org>
User-Agent: quilt/0.63-1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42595
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

3.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit b1442d39fac2fcfbe6a4814979020e993ca59c9e upstream.

If one or more matching FCSR cause & enable bits are set in saved thread
context then when that context is restored the kernel will take an FP
exception. This is of course undesirable and considered an oops, leading
to the kernel writing a backtrace to the console and potentially
rebooting depending upon the configuration. Thus the kernel avoids this
situation by clearing the cause bits of the FCSR register when handling
FP exceptions and after emulating FP instructions.

However the kernel does not prevent userland from setting arbitrary FCSR
cause & enable bits via ptrace, using either the PTRACE_POKEUSR or
PTRACE_SETFPREGS requests. This means userland can trivially cause the
kernel to oops on any system with an FPU. Prevent this from happening
by clearing the cause bits when writing to the saved FCSR context via
ptrace.

This problem appears to exist at least back to the beginning of the git
era in the PTRACE_POKEUSR case.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: stable@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/7438/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/ptrace.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -161,6 +161,7 @@ int ptrace_setfpregs(struct task_struct
 		__get_user(fregs[i], i + (__u64 __user *) data);
 
 	__get_user(child->thread.fpu.fcr31, data + 64);
+	child->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
 
 	/* FIR may not be written.  */
 
@@ -451,7 +452,7 @@ long arch_ptrace(struct task_struct *chi
 			break;
 #endif
 		case FPC_CSR:
-			child->thread.fpu.fcr31 = data;
+			child->thread.fpu.fcr31 = data & ~FPU_CSR_ALL_X;
 			break;
 		case DSP_BASE ... DSP_BASE + 5: {
 			dspreg_t *dregs;
