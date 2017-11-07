Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2017 20:11:09 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:59336 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992312AbdKGTLBI4tmM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Nov 2017 20:11:01 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 07 Nov 2017 19:10:06 +0000
Received: from [10.20.78.212] (10.20.78.212) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Tue, 7 Nov 2017
 11:08:29 -0800
Date:   Tue, 7 Nov 2017 19:09:20 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Djordje Todorovic <djordje.todorovic@rt-rk.com>,
        James Hogan <james.hogan@mips.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: [PATCH] MIPS: Fix an n32 core file generation regset support
 regression
Message-ID: <alpine.DEB.2.00.1710272036270.3886@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1510081805-321459-16728-14612-7
X-BESS-VER: 2017.12-r1709122024
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186681
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

Fix a commit 7aeb753b5353 ("MIPS: Implement task_user_regset_view.") 
regression, then activated by commit 6a9c001b7ec3 ("MIPS: Switch ELF 
core dumper to use regsets.)", that caused n32 processes to dump o32 
core files by failing to set the EF_MIPS_ABI2 flag in the ELF core file 
header's `e_flags' member:

$ file tls-core
tls-core: ELF 32-bit MSB executable, MIPS, N32 MIPS64 rel2 version 1 (SYSV), [...]
$ ./tls-core
Aborted (core dumped)
$ file core
core: ELF 32-bit MSB core file MIPS, MIPS-I version 1 (SYSV), SVR4-style
$ 

Previously the flag was set as the result of a:

#define ELF_CORE_EFLAGS EF_MIPS_ABI2

statement placed in arch/mips/kernel/binfmt_elfn32.c, however in the 
regset case, i.e. when CORE_DUMP_USE_REGSET is set, ELF_CORE_EFLAGS is 
no longer used by `fill_note_info' in fs/binfmt_elf.c, and instead the 
`->e_flags' member of the regset view chosen is.  We have the views 
defined in arch/mips/kernel/ptrace.c, however only an o32 and an n64 
one, and the latter is used for n32 as well.  Consequently an o32 core 
file is incorrectly dumped from n32 processes (the ELF32 vs ELF64 class 
is chosen elsewhere, and the 32-bit one is correctly selected for n32).

Correct the issue then by defining an n32 regset view and using it as 
appropriate.  Issue discovered in GDB testing.

Cc: stable@vger.kernel.org # 3.13+
Fixes: 7aeb753b5353 ("MIPS: Implement task_user_regset_view.")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
---
 arch/mips/kernel/ptrace.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

linux-mips-regset-view-n32-e-flags-abi2-init.diff
Index: linux-sfr/arch/mips/kernel/ptrace.c
===================================================================
--- linux-sfr.orig/arch/mips/kernel/ptrace.c	2017-10-27 04:55:34.000000000 +0100
+++ linux-sfr/arch/mips/kernel/ptrace.c	2017-10-27 20:07:14.933716000 +0100
@@ -618,6 +618,19 @@ static const struct user_regset_view use
 	.n		= ARRAY_SIZE(mips64_regsets),
 };
 
+#ifdef CONFIG_MIPS32_N32
+
+static const struct user_regset_view user_mipsn32_view = {
+	.name		= "mipsn32",
+	.e_flags	= EF_MIPS_ABI2,
+	.e_machine	= ELF_ARCH,
+	.ei_osabi	= ELF_OSABI,
+	.regsets	= mips64_regsets,
+	.n		= ARRAY_SIZE(mips64_regsets),
+};
+
+#endif /* CONFIG_MIPS32_N32 */
+
 #endif /* CONFIG_64BIT */
 
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)
@@ -629,6 +642,10 @@ const struct user_regset_view *task_user
 	if (test_tsk_thread_flag(task, TIF_32BIT_REGS))
 		return &user_mips_view;
 #endif
+#ifdef CONFIG_MIPS32_N32
+	if (test_tsk_thread_flag(task, TIF_32BIT_ADDR))
+		return &user_mipsn32_view;
+#endif
 	return &user_mips64_view;
 #endif
 }
