Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 11:28:30 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:60596 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990557AbdK1K2Im9CW- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 11:28:08 +0100
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BFA86AEF;
        Tue, 28 Nov 2017 10:28:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Djordje Todorovic <djordje.todorovic@rt-rk.com>,
        linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.4 18/96] MIPS: Fix an n32 core file generation regset support regression
Date:   Tue, 28 Nov 2017 11:22:27 +0100
Message-Id: <20171128100504.268469193@linuxfoundation.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171128100503.067621614@linuxfoundation.org>
References: <20171128100503.067621614@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@mips.com>

commit 547da673173de51f73887377eb275304775064ad upstream.

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

Fixes: 7aeb753b5353 ("MIPS: Implement task_user_regset_view.")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Djordje Todorovic <djordje.todorovic@rt-rk.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/17617/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/ptrace.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -650,6 +650,19 @@ static const struct user_regset_view use
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
@@ -661,6 +674,10 @@ const struct user_regset_view *task_user
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
