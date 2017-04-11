Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Apr 2017 14:52:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55517 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990514AbdDKMwH6bQvW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Apr 2017 14:52:07 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 02F22C04EB887;
        Tue, 11 Apr 2017 13:51:59 +0100 (IST)
Received: from LDT-J-COWGILL.le.imgtec.org (10.150.130.85) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 11 Apr 2017 13:52:01 +0100
From:   James Cowgill <James.Cowgill@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     <James.Cowgill@imgtec.com>
Subject: [PATCH] MIPS: avoid BUG warning in arch_check_elf
Date:   Tue, 11 Apr 2017 13:51:07 +0100
Message-ID: <20170411125108.30107-1-James.Cowgill@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.85]
Return-Path: <James.Cowgill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Cowgill@imgtec.com
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

arch_check_elf contains a usage of current_cpu_data that will call
smp_processor_id() with preemption enabled and therefore triggers a
"BUG: using smp_processor_id() in preemptible" warning when an fpxx
executable is loaded.

As a follow-up to commit b244614a60ab ("MIPS: Avoid a BUG warning during
prctl(PR_SET_FP_MODE, ...)"), apply the same fix to arch_check_elf by
using raw_current_cpu_data instead. The rationale quoted from the previous
commit:

"It is assumed throughout the kernel that if any CPU has an FPU, then
all CPUs would have an FPU as well, so it is safe to perform the check
with preemption enabled - change the code to use raw_ variant of the
check to avoid the warning."

Fixes: 46490b572544 ("MIPS: kernel: elf: Improve the overall ABI and FPU mode checks")
Signed-off-by: James Cowgill <James.Cowgill@imgtec.com>
CC: <stable@vger.kernel.org> # 4.0+
---
 arch/mips/kernel/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
index 6430bff21fff..5c429d70e17f 100644
--- a/arch/mips/kernel/elf.c
+++ b/arch/mips/kernel/elf.c
@@ -257,7 +257,7 @@ int arch_check_elf(void *_ehdr, bool has_interpreter, void *_interp_ehdr,
 	else if ((prog_req.fr1 && prog_req.frdefault) ||
 		 (prog_req.single && !prog_req.frdefault))
 		/* Make sure 64-bit MIPS III/IV/64R1 will not pick FR1 */
-		state->overall_fp_mode = ((current_cpu_data.fpu_id & MIPS_FPIR_F64) &&
+		state->overall_fp_mode = ((raw_current_cpu_data.fpu_id & MIPS_FPIR_F64) &&
 					  cpu_has_mips_r2_r6) ?
 					  FP_FR1 : FP_FR0;
 	else if (prog_req.fr1)
-- 
2.11.0
