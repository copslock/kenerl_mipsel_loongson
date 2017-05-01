Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 May 2017 23:37:14 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:60484 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993989AbdEAVgTRnqxG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 May 2017 23:36:19 +0200
Received: from localhost (unknown [107.14.56.132])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4DA4AC45;
        Mon,  1 May 2017 21:36:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Cowgill <James.Cowgill@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.10 51/62] MIPS: Avoid BUG warning in arch_check_elf
Date:   Mon,  1 May 2017 14:35:04 -0700
Message-Id: <20170501212732.753761151@linuxfoundation.org>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170501212730.774855694@linuxfoundation.org>
References: <20170501212730.774855694@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57844
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

4.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Cowgill <James.Cowgill@imgtec.com>

commit c46f59e90226fa5bfcc83650edebe84ae47d454b upstream.

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
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15951/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/elf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kernel/elf.c
+++ b/arch/mips/kernel/elf.c
@@ -257,7 +257,7 @@ int arch_check_elf(void *_ehdr, bool has
 	else if ((prog_req.fr1 && prog_req.frdefault) ||
 		 (prog_req.single && !prog_req.frdefault))
 		/* Make sure 64-bit MIPS III/IV/64R1 will not pick FR1 */
-		state->overall_fp_mode = ((current_cpu_data.fpu_id & MIPS_FPIR_F64) &&
+		state->overall_fp_mode = ((raw_current_cpu_data.fpu_id & MIPS_FPIR_F64) &&
 					  cpu_has_mips_r2_r6) ?
 					  FP_FR1 : FP_FR0;
 	else if (prog_req.fr1)
