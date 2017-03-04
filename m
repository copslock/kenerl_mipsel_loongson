Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Mar 2017 01:32:23 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30824 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993420AbdCDAcPhRwjk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Mar 2017 01:32:15 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 778B7CD5C4E03;
        Sat,  4 Mar 2017 00:32:04 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Sat, 4 Mar 2017 00:32:09 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] MIPS: Include asm/ptrace.h now linux/sched.h doesn't
Date:   Sat, 4 Mar 2017 00:32:03 +0000
Message-ID: <0cd2d2c571afea9658428ee251ae5d3325bfe01b.1488587471.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57027
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

Use of the task_pt_regs() based macros in MIPS' asm/processor.h for
accessing the user context on the kernel stack need the definition of
struct pt_regs from asm/ptrace.h. __own_fpu() in asm/fpu.h uses these
macros but implicitly depended on linux/sched.h to include asm/ptrace.h.

Since commit f780d89a0e82 ("sched/headers: Remove <asm/ptrace.h> from
<linux/sched.h>") however linux/sched.h no longer includes asm/ptrace.h,
so include it explicitly from asm/fpu.h where it is needed instead.

This fixes build errors such as:

./arch/mips/include/asm/fpu.h: In function '__own_fpu':
./arch/mips/include/asm/processor.h:385:31: error: invalid application of 'sizeof' to incomplete type 'struct pt_regs'
     THREAD_SIZE - 32 - sizeof(struct pt_regs))
                               ^

Fixes: f780d89a0e82 ("sched/headers: Remove <asm/ptrace.h> from <linux/sched.h>")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/fpu.h | 1 +
 1 file changed, 1 insertion(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index 321752bcbab6..1527efaf4af4 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -20,6 +20,7 @@
 #include <asm/cpu-features.h>
 #include <asm/fpu_emulator.h>
 #include <asm/hazards.h>
+#include <asm/ptrace.h>
 #include <asm/processor.h>
 #include <asm/current.h>
 #include <asm/msa.h>
-- 
git-series 0.8.10
