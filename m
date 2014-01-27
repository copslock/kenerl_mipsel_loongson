Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 16:29:53 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:4494 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824283AbaA0P26A1ex9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 16:28:58 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 13/15] mips: dumb MSA FP exception handler
Date:   Mon, 27 Jan 2014 15:23:12 +0000
Message-ID: <1390836194-26286-14-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1390836194-26286-1-git-send-email-paul.burton@imgtec.com>
References: <1390836194-26286-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_27_15_28_52
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39107
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

This patch adds a simple handler for MSA FP exceptions which delivers a
SIGFPE to the running task. In the future it should probably be extended
to re-execute the instruction with the MSACSR.NX bit set in order to
generate results for any elements which did not cause an exception
before delivering the SIGFPE signal.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/kernel/genex.S |  1 +
 arch/mips/kernel/traps.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 278a49b..7365cd6 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -475,6 +475,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	BUILD_HANDLER cpu cpu sti silent		/* #11 */
 	BUILD_HANDLER ov ov sti silent			/* #12 */
 	BUILD_HANDLER tr tr sti silent			/* #13 */
+	BUILD_HANDLER msa_fpe msa_fpe sti silent	/* #14 */
 	BUILD_HANDLER fpe fpe fpe silent		/* #15 */
 	BUILD_HANDLER ftlb ftlb none silent		/* #16 */
 	BUILD_HANDLER msa msa sti silent		/* #21 */
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index e609c89..88db702 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -78,6 +78,7 @@ extern asmlinkage void handle_ri_rdhwr(void);
 extern asmlinkage void handle_cpu(void);
 extern asmlinkage void handle_ov(void);
 extern asmlinkage void handle_tr(void);
+extern asmlinkage void handle_msa_fpe(void);
 extern asmlinkage void handle_fpe(void);
 extern asmlinkage void handle_ftlb(void);
 extern asmlinkage void handle_msa(void);
@@ -1250,6 +1251,16 @@ out:
 	exception_exit(prev_state);
 }
 
+asmlinkage void do_msa_fpe(struct pt_regs *regs)
+{
+	enum ctx_state prev_state;
+
+	prev_state = exception_enter();
+	die_if_kernel("do_msa_fpe invoked from kernel context!", regs);
+	force_sig(SIGFPE, current);
+	exception_exit(prev_state);
+}
+
 asmlinkage void do_msa(struct pt_regs *regs)
 {
 	enum ctx_state prev_state;
@@ -2105,6 +2116,7 @@ void __init trap_init(void)
 	set_except_vector(11, handle_cpu);
 	set_except_vector(12, handle_ov);
 	set_except_vector(13, handle_tr);
+	set_except_vector(14, handle_msa_fpe);
 
 	if (current_cpu_type() == CPU_R6000 ||
 	    current_cpu_type() == CPU_R6000A) {
-- 
1.8.5.3
