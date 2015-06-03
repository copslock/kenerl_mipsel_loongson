Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2015 14:20:25 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:57550 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007004AbbFCMUWaoS0B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2015 14:20:22 +0200
Received: from localhost (p33062-ipbffx02marunouchi.tokyo.ocn.ne.jp [220.96.46.62])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F3413AE7;
        Wed,  3 Jun 2015 12:20:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Matthew Fortune <matthew.fortune@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 4.0 122/148] MIPS: fix FP mode selection in lieu of .MIPS.abiflags data
Date:   Wed,  3 Jun 2015 21:09:52 +0900
Message-Id: <20150603114210.701244562@linuxfoundation.org>
X-Mailer: git-send-email 2.4.2
In-Reply-To: <20150603114205.337615117@linuxfoundation.org>
References: <20150603114205.337615117@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47830
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

4.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit 620b155034570f577470cf5309f741bac6a6e32b upstream.

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
Patchwork: http://patchwork.linux-mips.org/patch/9978/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/elf.c |   32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

--- a/arch/mips/kernel/elf.c
+++ b/arch/mips/kernel/elf.c
@@ -76,14 +76,6 @@ int arch_elf_pt_proc(void *_ehdr, void *
 
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
@@ -104,9 +96,6 @@ int arch_elf_pt_proc(void *_ehdr, void *
 				  (char *)&abiflags,
 				  sizeof(abiflags));
 	} else {
-		/* FR=1 is really the only option for 64-bit */
-		state->overall_fp_mode = FP_FR1;
-
 		if (phdr64->p_type != PT_MIPS_ABIFLAGS)
 			return 0;
 		if (phdr64->p_filesz < sizeof(abiflags))
@@ -147,6 +136,7 @@ int arch_check_elf(void *_ehdr, bool has
 	struct elf32_hdr *ehdr = _ehdr;
 	struct mode_req prog_req, interp_req;
 	int fp_abi, interp_fp_abi, abi0, abi1, max_abi;
+	bool is_mips64;
 
 	if (!config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT))
 		return 0;
@@ -162,10 +152,22 @@ int arch_check_elf(void *_ehdr, bool has
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
