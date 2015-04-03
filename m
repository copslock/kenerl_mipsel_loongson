Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:27:17 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27008399AbbDCWYlHJd5X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:24:41 +0200
Date:   Fri, 3 Apr 2015 23:24:41 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: [PATCH 13/48] MIPS: ELF: Drop `get_fp_abi'
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504030233280.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

Commit 46490b57 [MIPS: kernel: elf: Improve the overall ABI and FPU mode 
checks] reduced `get_fp_abi' to an elaborate pass-through.  Drop it 
then.

Cc: Markos Chandras <markos.chandras@imgtec.com>
Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-get-fp-abi.diff
Index: linux/arch/mips/kernel/elf.c
===================================================================
--- linux.orig/arch/mips/kernel/elf.c	2015-04-02 20:18:51.786524000 +0100
+++ linux/arch/mips/kernel/elf.c	2015-04-02 20:27:53.523178000 +0100
@@ -131,16 +131,6 @@ int arch_elf_pt_proc(void *_ehdr, void *
 	return 0;
 }
 
-static inline unsigned get_fp_abi(int in_abi)
-{
-	/* If the ABI requirement is provided, simply return that */
-	if (in_abi != MIPS_ABI_FP_UNKNOWN)
-		return in_abi;
-
-	/* Unknown ABI */
-	return MIPS_ABI_FP_UNKNOWN;
-}
-
 int arch_check_elf(void *_ehdr, bool has_interpreter,
 		   struct arch_elf_state *state)
 {
@@ -151,10 +141,10 @@ int arch_check_elf(void *_ehdr, bool has
 	if (!config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT))
 		return 0;
 
-	fp_abi = get_fp_abi(state->fp_abi);
+	fp_abi = state->fp_abi;
 
 	if (has_interpreter) {
-		interp_fp_abi = get_fp_abi(state->interp_fp_abi);
+		interp_fp_abi = state->interp_fp_abi;
 
 		abi0 = min(fp_abi, interp_fp_abi);
 		abi1 = max(fp_abi, interp_fp_abi);
