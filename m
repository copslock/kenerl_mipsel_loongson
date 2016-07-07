Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2016 20:40:12 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:52608 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992366AbcGGSjZESHvF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jul 2016 20:39:25 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1bLECn-0007rg-Gb; Thu, 07 Jul 2016 18:39:21 +0000
Received: from kamal by fourier with local (Exim 4.86_2)
        (envelope-from <kamal@whence.com>)
        id 1bLECl-0004wq-Av; Thu, 07 Jul 2016 11:39:19 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.19.y-ckt 44/99] MIPS: Don't unwind to user mode with EVA
Date:   Thu,  7 Jul 2016 11:37:43 -0700
Message-Id: <1467916718-18638-45-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1467916718-18638-1-git-send-email-kamal@canonical.com>
References: <1467916718-18638-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.19
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

3.19.8-ckt23 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

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
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 85bff5d..06ee0d3 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -450,7 +450,7 @@ unsigned long notrace unwind_stack_by_address(unsigned long stack_page,
 		    *sp + sizeof(*regs) <= stack_page + THREAD_SIZE - 32) {
 			regs = (struct pt_regs *)*sp;
 			pc = regs->cp0_epc;
-			if (__kernel_text_address(pc)) {
+			if (!user_mode(regs) && __kernel_text_address(pc)) {
 				*sp = regs->regs[29];
 				*ra = regs->regs[31];
 				return pc;
-- 
2.7.4
