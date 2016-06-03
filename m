Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jun 2016 23:47:42 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:42619 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042083AbcFCVrlANBl4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Jun 2016 23:47:41 +0200
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u53LlVt9018834
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 3 Jun 2016 21:47:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id u53LlV4u020958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 3 Jun 2016 21:47:31 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id u53LlSOh018381;
        Fri, 3 Jun 2016 21:47:29 GMT
Received: from lappy.us.oracle.com (/10.154.190.197)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Jun 2016 14:47:28 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 3.18 stable tree] MIPS: Don't unwind to user mode with EVA
Date:   Fri,  3 Jun 2016 17:45:36 -0400
Message-Id: <1464990398-17381-46-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464990398-17381-1-git-send-email-sasha.levin@oracle.com>
References: <1464990398-17381-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sasha.levin@oracle.com
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

From: James Hogan <james.hogan@imgtec.com>

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit a816b306c62195b7c43c92cb13330821a96bdc27 ]

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
Cc: <stable@vger.kernel.org> # 3.15+
Patchwork: https://patchwork.linux-mips.org/patch/11700/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 636b074..7d09efd 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -437,7 +437,7 @@ unsigned long notrace unwind_stack_by_address(unsigned long stack_page,
 		    *sp + sizeof(*regs) <= stack_page + THREAD_SIZE - 32) {
 			regs = (struct pt_regs *)*sp;
 			pc = regs->cp0_epc;
-			if (__kernel_text_address(pc)) {
+			if (!user_mode(regs) && __kernel_text_address(pc)) {
 				*sp = regs->regs[29];
 				*ra = regs->regs[31];
 				return pc;
-- 
2.5.0
