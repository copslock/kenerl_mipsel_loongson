Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Apr 2014 04:26:58 +0200 (CEST)
Received: from g2t2353.austin.hp.com ([15.217.128.52]:1055 "EHLO
        g2t2353.austin.hp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815860AbaDTC0zsUjhd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 20 Apr 2014 04:26:55 +0200
Received: from g2t2360.austin.hp.com (g2t2360.austin.hp.com [16.197.8.247])
        by g2t2353.austin.hp.com (Postfix) with ESMTP id 41150312;
        Sun, 20 Apr 2014 02:26:48 +0000 (UTC)
Received: from buesod1.americas.hpqcorp.net.net (unknown [16.212.160.186])
        by g2t2360.austin.hp.com (Postfix) with ESMTP id F3E9946;
        Sun, 20 Apr 2014 02:26:46 +0000 (UTC)
From:   Davidlohr Bueso <davidlohr@hp.com>
To:     akpm@linux-foundation.org
Cc:     zeus@gnu.org, aswin@hp.com, davidlohr@hp.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: [PATCH 3/6] mips: call find_vma with the mmap_sem held
Date:   Sat, 19 Apr 2014 19:26:28 -0700
Message-Id: <1397960791-16320-4-git-send-email-davidlohr@hp.com>
X-Mailer: git-send-email 1.8.1.4
In-Reply-To: <1397960791-16320-1-git-send-email-davidlohr@hp.com>
References: <1397960791-16320-1-git-send-email-davidlohr@hp.com>
Return-Path: <davidlohr@hp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davidlohr@hp.com
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

Performing vma lookups without taking the mm->mmap_sem is asking
for trouble. While doing the search, the vma in question can be
modified or even removed before returning to the caller. Take the
lock (exclusively) in order to avoid races while iterating through
the vmacache and/or rbtree.

Updates two functions:
  - process_fpemu_return()
  - cteon_flush_cache_sigtramp()

This patch is completely *untested*.

Signed-off-by: Davidlohr Bueso <davidlohr@hp.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/traps.c | 2 ++
 arch/mips/mm/c-octeon.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 074e857..c51bd20 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -712,10 +712,12 @@ int process_fpemu_return(int sig, void __user *fault_addr)
 		si.si_addr = fault_addr;
 		si.si_signo = sig;
 		if (sig == SIGSEGV) {
+			down_read(&current->mm->mmap_sem);
 			if (find_vma(current->mm, (unsigned long)fault_addr))
 				si.si_code = SEGV_ACCERR;
 			else
 				si.si_code = SEGV_MAPERR;
+			up_read(&current->mm->mmap_sem);
 		} else {
 			si.si_code = BUS_ADRERR;
 		}
diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
index f41a5c5..05b1d7c 100644
--- a/arch/mips/mm/c-octeon.c
+++ b/arch/mips/mm/c-octeon.c
@@ -137,8 +137,10 @@ static void octeon_flush_cache_sigtramp(unsigned long addr)
 {
 	struct vm_area_struct *vma;
 
+	down_read(&current->mm->mmap_sem);
 	vma = find_vma(current->mm, addr);
 	octeon_flush_icache_all_cores(vma);
+	up_read(&current->mm->mmap_sem);
 }
 
 
-- 
1.8.1.4
