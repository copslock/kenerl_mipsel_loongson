Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2015 12:53:00 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53712 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012549AbbEFKw6uglu4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2015 12:52:58 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 04419CF84614E;
        Wed,  6 May 2015 11:52:53 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 6 May 2015 11:52:54 +0100
Received: from localhost (192.168.159.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 6 May
 2015 11:52:53 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Matthew Fortune <matthew.fortune@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, <stable@vger.kernel.org>
Subject: [PATCH] MIPS: fix FP mode selection in lieu of .MIPS.abiflags data
Date:   Wed, 6 May 2015 11:52:32 +0100
Message-ID: <1430909552-1680-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.3.7
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.94]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Commit 46490b572544 ("MIPS: kernel: elf: Improve the overall ABI and FPU
mode checks") reworked the ELF FP ABI mode selection logic, but when
CONFIG_MIPS_O32_FP64_SUPPORT is enabled it breaks the use of binaries
which have no PT_MIPS_ABIFLAGS program header & associated
.MIPS.abiflags section.

A default mode is selected based upon whether the ELF contains MIPS32 or
MIPS64 code, but that selection is made in arch_elf_pt_proc.
arch_elf_pt_proc only executes when a PT_MIPS_ABIFLAGS program header is
found. If one is not found then arch_elf_pt_proc is never called, and no
default overall_fp_mode value is selected. When arch_check_elf is
called, both abi0 & abi1 are MIPS_ABI_FP_UNKNOWN which leads to both
prog_req & interp_req being set to none_req. none_req matches none of
the conditions for mode selection at the end of arch_check_elf, so
overall_fp_mode is left untouched. Finally once mips_set_personality_fp
is called the BUG() in the default case is then hit & the kernel likely
panics.

Fix this by moving the selection of a default overall mode to the start
of arch_check_elf, which runs once per ELF executed regardless of
whether it has a PT_MIPS_ABIFLAGS program header.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Matthew Fortune <matthew.fortune@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # v4.0+
---
 arch/mips/kernel/elf.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
index d2c09f6..f20cedc 100644
--- a/arch/mips/kernel/elf.c
+++ b/arch/mips/kernel/elf.c
@@ -76,14 +76,6 @@ int arch_elf_pt_proc(void *_ehdr, void *_phdr, struct file *elf,
 
 	/* Lets see if this is an O32 ELF */
 	if (ehdr32->e_ident[EI_CLASS] == ELFCLASS32) {
-		/* FR = 1 for N32 */
-		if (ehdr32->e_flags & EF_MIPS_ABI2)
-			state->overall_fp_mode = FP_FR1;
-		else
-			/* Set a good default FPU mode for O32 */
-			state->overall_fp_mode = cpu_has_mips_r6 ?
-				FP_FRE : FP_FR0;
-
 		if (ehdr32->e_flags & EF_MIPS_FP64) {
 			/*
 			 * Set MIPS_ABI_FP_OLD_64 for EF_MIPS_FP64. We will override it
@@ -104,9 +96,6 @@ int arch_elf_pt_proc(void *_ehdr, void *_phdr, struct file *elf,
 				  (char *)&abiflags,
 				  sizeof(abiflags));
 	} else {
-		/* FR=1 is really the only option for 64-bit */
-		state->overall_fp_mode = FP_FR1;
-
 		if (phdr64->p_type != PT_MIPS_ABIFLAGS)
 			return 0;
 		if (phdr64->p_filesz < sizeof(abiflags))
@@ -147,6 +136,7 @@ int arch_check_elf(void *_ehdr, bool has_interpreter,
 	struct elf32_hdr *ehdr = _ehdr;
 	struct mode_req prog_req, interp_req;
 	int fp_abi, interp_fp_abi, abi0, abi1, max_abi;
+	bool is_mips64;
 
 	if (!config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT))
 		return 0;
@@ -162,10 +152,22 @@ int arch_check_elf(void *_ehdr, bool has_interpreter,
 		abi0 = abi1 = fp_abi;
 	}
 
-	/* ABI limits. O32 = FP_64A, N32/N64 = FP_SOFT */
-	max_abi = ((ehdr->e_ident[EI_CLASS] == ELFCLASS32) &&
-		   (!(ehdr->e_flags & EF_MIPS_ABI2))) ?
-		MIPS_ABI_FP_64A : MIPS_ABI_FP_SOFT;
+	is_mips64 = (ehdr->e_ident[EI_CLASS] == ELFCLASS64) ||
+		    (ehdr->e_flags & EF_MIPS_ABI2);
+
+	if (is_mips64) {
+		/* MIPS64 code always uses FR=1, thus the default is easy */
+		state->overall_fp_mode = FP_FR1;
+
+		/* Disallow access to the various FPXX & FP64 ABIs */
+		max_abi = MIPS_ABI_FP_SOFT;
+	} else {
+		/* Default to a mode capable of running code expecting FR=0 */
+		state->overall_fp_mode = cpu_has_mips_r6 ? FP_FRE : FP_FR0;
+
+		/* Allow all ABIs we know about */
+		max_abi = MIPS_ABI_FP_64A;
+	}
 
 	if ((abi0 > max_abi && abi0 != MIPS_ABI_FP_UNKNOWN) ||
 	    (abi1 > max_abi && abi1 != MIPS_ABI_FP_UNKNOWN))
-- 
2.3.6
