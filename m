Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jun 2017 16:05:35 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61399 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993866AbdF2OF1pYpTH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jun 2017 16:05:27 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C6570A4CCF6FD;
        Thu, 29 Jun 2017 15:05:18 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 29 Jun 2017 15:05:21 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: [PATCH 1/1] MIPS: Avoid accidental raw backtrace
Date:   Thu, 29 Jun 2017 15:05:04 +0100
Message-ID: <913e3161e788882af01f96be523b1b67ae549039.1498744803.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.13.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Since commit 81a76d7119f6 ("MIPS: Avoid using unwind_stack() with
usermode") show_backtrace() invokes the raw backtracer when
cp0_status & ST0_KSU indicates user mode to fix issues on EVA kernels
where user and kernel address spaces overlap.

However this is used by show_stack() which creates its own pt_regs on
the stack and leaves cp0_status uninitialised in most of the code paths.
This results in the non deterministic use of the raw back tracer
depending on the previous stack content.

show_stack() deals exclusively with kernel mode stacks anyway, so
explicitly initialise regs.cp0_status to KSU_KERNEL (i.e. 0) to ensure
we get a useful backtrace.

Fixes: 81a76d7119f6 ("MIPS: Avoid using unwind_stack() with usermode")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.15+
---
 arch/mips/kernel/traps.c | 2 ++
 1 file changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 9681b5877140..38dfa27730ff 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -201,6 +201,8 @@ void show_stack(struct task_struct *task, unsigned long *sp)
 {
 	struct pt_regs regs;
 	mm_segment_t old_fs = get_fs();
+
+	regs.cp0_status = KSU_KERNEL;
 	if (sp) {
 		regs.regs[29] = (unsigned long)sp;
 		regs.regs[31] = 0;
-- 
git-series 0.8.10
