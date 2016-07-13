Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2016 15:28:06 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:39445 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993508AbcGMN16w7xO4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Jul 2016 15:27:58 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id ABA9E1A4760;
        Wed, 13 Jul 2016 15:27:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from mcs14.domain.local (mcs14.domain.local [192.168.232.214])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 95B8C1A4752;
        Wed, 13 Jul 2016 15:27:51 +0200 (CEST)
From:   Petar Jovanovic <petar.jovanovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] MIPS: traps: return correct si code for accessing nonmapped addresses
Date:   Wed, 13 Jul 2016 15:23:37 +0200
Message-Id: <1468416217-54931-1-git-send-email-petar.jovanovic@rt-rk.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <petar.jovanovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: petar.jovanovic@rt-rk.com
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

find_vma() returns the first VMA which satisfies fault_addr < vm_end, but
it does not guarantee fault_addr is actually within VMA. Therefore, kernel
has to check that before it chooses correct si code on return.

Signed-off-by: Petar Jovanovic <petar.jovanovic@rt-rk.com>
---
 arch/mips/kernel/traps.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 4a1712b..b7b50d5 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -704,6 +704,7 @@ asmlinkage void do_ov(struct pt_regs *regs)
 int process_fpemu_return(int sig, void __user *fault_addr, unsigned long fcr31)
 {
 	struct siginfo si = { 0 };
+	struct vm_area_struct *vma;
 
 	switch (sig) {
 	case 0:
@@ -744,7 +745,8 @@ int process_fpemu_return(int sig, void __user *fault_addr, unsigned long fcr31)
 		si.si_addr = fault_addr;
 		si.si_signo = sig;
 		down_read(&current->mm->mmap_sem);
-		if (find_vma(current->mm, (unsigned long)fault_addr))
+		vma = find_vma(current->mm, (unsigned long)fault_addr);
+		if (vma && (vma->vm_start <= (unsigned long)fault_addr))
 			si.si_code = SEGV_ACCERR;
 		else
 			si.si_code = SEGV_MAPERR;
-- 
1.9.1
