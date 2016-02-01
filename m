Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 14:51:22 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56283 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011924AbcBANvGS4zgo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 14:51:06 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 95A2C1BFC93C0;
        Mon,  1 Feb 2016 13:50:58 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 1 Feb 2016 13:51:00 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 1 Feb 2016 13:50:59 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>,
        "James Hogan" <james.hogan@imgtec.com>
Subject: [PATCH 1/2] MIPS: Properly disable FPU in start_thread()
Date:   Mon, 1 Feb 2016 13:50:36 +0000
Message-ID: <1454334637-3860-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1454334637-3860-1-git-send-email-james.hogan@imgtec.com>
References: <1454334637-3860-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51586
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

start_thread() (called for execve(2)) clears the TIF_USEDFPU flag
without atomically disabling the FPU. With a preemptive kernel, an
unfortunately timed preemption after this could result in another
task (or KVM guest) being scheduled in with the FPU still enabled, since
lose_fpu_inatomic() only turns it off if TIF_USEDFPU is set.

Use lose_fpu(0) instead of the separate FPU / MSA management, which
should do the right thing (drop FPU properly and atomically without
saving state) and will be more future proof.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/process.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index f2975d4d1e44..eddd5fd6fdfa 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -65,12 +65,10 @@ void start_thread(struct pt_regs * regs, unsigned long pc, unsigned long sp)
 	status = regs->cp0_status & ~(ST0_CU0|ST0_CU1|ST0_FR|KU_MASK);
 	status |= KU_USER;
 	regs->cp0_status = status;
+	lose_fpu(0);
+	clear_thread_flag(TIF_MSA_CTX_LIVE);
 	clear_used_math();
-	clear_fpu_owner();
 	init_dsp();
-	clear_thread_flag(TIF_USEDMSA);
-	clear_thread_flag(TIF_MSA_CTX_LIVE);
-	disable_msa();
 	regs->cp0_epc = pc;
 	regs->regs[29] = sp;
 }
-- 
2.4.10
