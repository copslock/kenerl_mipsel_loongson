Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Nov 2015 01:47:01 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:65092 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012542AbbKMAqx2YQSl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Nov 2015 01:46:53 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 044449F33DCD0;
        Fri, 13 Nov 2015 00:46:42 +0000 (GMT)
Received: from [10.100.200.62] (10.100.200.62) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server id 14.3.235.1; Fri, 13 Nov 2015
 00:46:45 +0000
Date:   Fri, 13 Nov 2015 00:46:44 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/8] MIPS: Use a union to access the ELF file header
In-Reply-To: <alpine.DEB.2.00.1511111418430.7097@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1511130005520.7097@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1511111418430.7097@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.62]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Rewrite `arch_elf_pt_proc' and `arch_check_elf' using a union to access 
the ELF file header.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
linux-mips-elf-ehdr.diff
Index: linux-sfr-test/arch/mips/kernel/elf.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/elf.c	2015-09-04 22:46:08.374274000 +0100
+++ linux-sfr-test/arch/mips/kernel/elf.c	2015-09-04 22:47:56.448146000 +0100
@@ -68,15 +68,23 @@ static struct mode_req none_req = { true
 int arch_elf_pt_proc(void *_ehdr, void *_phdr, struct file *elf,
 		     bool is_interp, struct arch_elf_state *state)
 {
-	struct elf32_hdr *ehdr32 = _ehdr;
+	union {
+		struct elf32_hdr e32;
+		struct elf64_hdr e64;
+	} *ehdr = _ehdr;
 	struct elf32_phdr *phdr32 = _phdr;
 	struct elf64_phdr *phdr64 = _phdr;
 	struct mips_elf_abiflags_v0 abiflags;
+	bool elf32;
+	u32 flags;
 	int ret;
 
+	elf32 = ehdr->e32.e_ident[EI_CLASS] == ELFCLASS32;
+	flags = elf32 ? ehdr->e32.e_flags : ehdr->e64.e_flags;
+
 	/* Lets see if this is an O32 ELF */
-	if (ehdr32->e_ident[EI_CLASS] == ELFCLASS32) {
-		if (ehdr32->e_flags & EF_MIPS_FP64) {
+	if (elf32) {
+		if (flags & EF_MIPS_FP64) {
 			/*
 			 * Set MIPS_ABI_FP_OLD_64 for EF_MIPS_FP64. We will override it
 			 * later if needed
@@ -123,10 +131,17 @@ int arch_elf_pt_proc(void *_ehdr, void *
 int arch_check_elf(void *_ehdr, bool has_interpreter,
 		   struct arch_elf_state *state)
 {
-	struct elf32_hdr *ehdr = _ehdr;
+	union {
+		struct elf32_hdr e32;
+		struct elf64_hdr e64;
+	} *ehdr = _ehdr;
 	struct mode_req prog_req, interp_req;
 	int fp_abi, interp_fp_abi, abi0, abi1, max_abi;
-	bool is_mips64;
+	bool elf32;
+	u32 flags;
+
+	elf32 = ehdr->e32.e_ident[EI_CLASS] == ELFCLASS32;
+	flags = elf32 ? ehdr->e32.e_flags : ehdr->e64.e_flags;
 
 	if (!config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT))
 		return 0;
@@ -142,21 +157,18 @@ int arch_check_elf(void *_ehdr, bool has
 		abi0 = abi1 = fp_abi;
 	}
 
-	is_mips64 = (ehdr->e_ident[EI_CLASS] == ELFCLASS64) ||
-		    (ehdr->e_flags & EF_MIPS_ABI2);
+	if (elf32 && !(flags & EF_MIPS_ABI2)) {
+		/* Default to a mode capable of running code expecting FR=0 */
+		state->overall_fp_mode = cpu_has_mips_r6 ? FP_FRE : FP_FR0;
 
-	if (is_mips64) {
+		/* Allow all ABIs we know about */
+		max_abi = MIPS_ABI_FP_64A;
+	} else {
 		/* MIPS64 code always uses FR=1, thus the default is easy */
 		state->overall_fp_mode = FP_FR1;
 
 		/* Disallow access to the various FPXX & FP64 ABIs */
 		max_abi = MIPS_ABI_FP_SOFT;
-	} else {
-		/* Default to a mode capable of running code expecting FR=0 */
-		state->overall_fp_mode = cpu_has_mips_r6 ? FP_FRE : FP_FR0;
-
-		/* Allow all ABIs we know about */
-		max_abi = MIPS_ABI_FP_64A;
 	}
 
 	if ((abi0 > max_abi && abi0 != MIPS_ABI_FP_UNKNOWN) ||
