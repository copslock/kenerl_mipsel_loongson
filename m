Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2016 14:26:45 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38150 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992544AbcKIN0jchQv0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2016 14:26:39 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B3111ED41876B;
        Wed,  9 Nov 2016 13:26:30 +0000 (GMT)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 9 Nov 2016 13:26:33 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] MIPS: mm: Fix output of __do_page_fault
Date:   Wed, 9 Nov 2016 13:26:25 +0000
Message-ID: <1478697985-5332-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Since commit 4bcc595ccd80 ("printk: reinstate KERN_CONT for printing
continuation lines") the output from __do_page_fault on MIPS has been
pretty unreadable due to the lack of KERN_CONT markers. Use pr_cont
to provide the appropriate markers & restore the expected output.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

 arch/mips/mm/fault.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index d56a855828c2..3bef306cdfdb 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -209,17 +209,18 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 		if (show_unhandled_signals &&
 		    unhandled_signal(tsk, SIGSEGV) &&
 		    __ratelimit(&ratelimit_state)) {
-			pr_info("\ndo_page_fault(): sending SIGSEGV to %s for invalid %s %0*lx",
+			pr_info("do_page_fault(): sending SIGSEGV to %s for invalid %s %0*lx\n",
 				tsk->comm,
 				write ? "write access to" : "read access from",
 				field, address);
 			pr_info("epc = %0*lx in", field,
 				(unsigned long) regs->cp0_epc);
-			print_vma_addr(" ", regs->cp0_epc);
+			print_vma_addr(KERN_CONT " ", regs->cp0_epc);
+			pr_cont("\n");
 			pr_info("ra  = %0*lx in", field,
 				(unsigned long) regs->regs[31]);
-			print_vma_addr(" ", regs->regs[31]);
-			pr_info("\n");
+			print_vma_addr(KERN_CONT " ", regs->regs[31]);
+			pr_cont("\n");
 		}
 		current->thread.trap_nr = (regs->cp0_cause >> 2) & 0x1f;
 		info.si_signo = SIGSEGV;
-- 
2.7.4
