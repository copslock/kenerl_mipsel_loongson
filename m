Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jun 2016 23:43:23 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:59965 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042443AbcFEVmfv0Flp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Jun 2016 23:42:35 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EE0E4884;
        Sun,  5 Jun 2016 21:42:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 04/99] MIPS: Dont unwind to user mode with EVA
Date:   Sun,  5 Jun 2016 14:40:37 -0700
Message-Id: <20160605213903.431245341@linuxfoundation.org>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160605213902.974592018@linuxfoundation.org>
References: <20160605213902.974592018@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53819
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit a816b306c62195b7c43c92cb13330821a96bdc27 upstream.

When unwinding through IRQs and exceptions, the unwinding only continues
if the PC is a kernel text address, however since EVA it is possible for
user and kernel address ranges to overlap, potentially allowing
unwinding to continue to user mode if the user PC happens to be in the
kernel text address range.

Adjust the check to also ensure that the register state from before the
exception is actually running in kernel mode, i.e. !user_mode(regs).

I don't believe any harm can come of this problem, since the PC is only
output, the stack pointer is checked to ensure it resides within the
task's stack page before it is dereferenced in search of the return
address, and the return address register is similarly only output (if
the PC is in a leaf function or the beginning of a non-leaf function).

However unwind_stack() is only meant for unwinding kernel code, so to be
correct the unwind should stop there.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/11700/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/process.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -457,7 +457,7 @@ unsigned long notrace unwind_stack_by_ad
 		    *sp + sizeof(*regs) <= stack_page + THREAD_SIZE - 32) {
 			regs = (struct pt_regs *)*sp;
 			pc = regs->cp0_epc;
-			if (__kernel_text_address(pc)) {
+			if (!user_mode(regs) && __kernel_text_address(pc)) {
 				*sp = regs->regs[29];
 				*ra = regs->regs[31];
 				return pc;
