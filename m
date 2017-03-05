Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Mar 2017 04:23:53 +0100 (CET)
Received: from mail5.windriver.com ([192.103.53.11]:57350 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990600AbdCEDXp4sFmt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 5 Mar 2017 04:23:45 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v253NXng019871
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=OK);
        Sat, 4 Mar 2017 19:23:34 -0800
Received: from pek-jsun4-d1.corp.ad.wrs.com (128.224.155.85) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.3.294.0; Sat, 4 Mar 2017 19:23:33 -0800
From:   Jiwei Sun <jiwei.sun@windriver.com>
To:     <ralf@linux-mips.org>, <paul.burton@imgtec.com>,
        <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <jiwei.sun.bj@qq.com>
Subject: [PATCH] MIPS: reset all task's asid to 0 after asid_cache(cpu) overflows
Date:   Sun, 5 Mar 2017 11:24:20 +0800
Message-ID: <1488684260-18867-1-git-send-email-jiwei.sun@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Jiwei.Sun@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiwei.sun@windriver.com
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

If asid_cache(cpu) overflows, there may be two tasks with the same
asid. It is a risk that the two different tasks may have the same
address space.

A process will update its asid to newer version only when switch_mm()
is called and matches the following condition:
    if ((cpu_context(cpu, next) ^ asid_cache(cpu))
                    & asid_version_mask(cpu))
            get_new_mmu_context(next, cpu);
If asid_cache(cpu) overflows, cpu_context(cpu,next) and asid_cache(cpu)
will be reset to asid_first_version(cpu), and start a new cycle. It
can result in two tasks that have the same ASID in the process list.

For example, in CONFIG_CPU_MIPS32_R2, task named A's asid on CPU1 is
0x100, and has been sleeping and been not scheduled. After a long period
of time, another running task named B's asid on CPU1 is 0xffffffff, and
asid cached in the CPU1 is 0xffffffff too, next task named C is forked,
when schedule from B to C on CPU1, asid_cache(cpu) will overflow, so C's
asid on CPU1 will be 0x100 according to get_new_mmu_context(). A's asid
is the same as C, if now A is rescheduled on CPU1, A's asid is not able
to renew according to 'if' clause, and the local TLB entry can't be
flushed too, A's address space will be the same as C.

If asid_cache(cpu) overflows, all of user space task's asid on this CPU
are able to set a invalid value (such as 0), it will avoid the risk.

Signed-off-by: Jiwei Sun <jiwei.sun@windriver.com>
---
 arch/mips/include/asm/mmu_context.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index ddd57ad..1f60efc 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -108,8 +108,15 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 #else
 		local_flush_tlb_all();	/* start new asid cycle */
 #endif
-		if (!asid)		/* fix version if needed */
+		if (!asid) {		/* fix version if needed */
+			struct task_struct *p;
+
+			for_each_process(p) {
+				if ((p->mm))
+					cpu_context(cpu, p->mm) = 0;
+			}
 			asid = asid_first_version(cpu);
+		}
 	}
 
 	cpu_context(cpu, mm) = asid_cache(cpu) = asid;
-- 
1.9.1
