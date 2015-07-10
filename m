Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2015 17:03:00 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59477 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010035AbbGJPCnYf5Wp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jul 2015 17:02:43 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E7DE2783BC044;
        Fri, 10 Jul 2015 16:02:34 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 10 Jul 2015 16:02:37 +0100
Received: from localhost (10.100.200.2) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 10 Jul
 2015 16:02:36 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Matthew Fortune <matthew.fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@codesourcery.com>
Subject: [PATCH 06/16] MIPS: skip odd double FP registers when copying FP32 sigcontext
Date:   Fri, 10 Jul 2015 16:00:15 +0100
Message-ID: <1436540426-10021-7-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1436540426-10021-1-git-send-email-paul.burton@imgtec.com>
References: <1436540426-10021-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.2]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48182
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

When a task uses 32 bit floating point, the odd indexed 32b register
values are stored in bits 63:32 of the preceding even indexed 64b
FP register field in saved context. Thus there is no point in
preserving the odd indexed 64b register fields since they hold no
valid context. This patch will cause them to be skipped, as is
already done in arch/mips/kernel/signal32.c.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/signal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 76f9136..23913ad 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -69,8 +69,9 @@ static int copy_fp_to_sigcontext(void __user *sc)
 	uint32_t __user *csr = sc + abi->off_sc_fpc_csr;
 	int i;
 	int err = 0;
+	int inc = test_thread_flag(TIF_32BIT_FPREGS) ? 2 : 1;
 
-	for (i = 0; i < NUM_FPU_REGS; i++) {
+	for (i = 0; i < NUM_FPU_REGS; i += inc) {
 		err |=
 		    __put_user(get_fpr64(&current->thread.fpu.fpr[i], 0),
 			       &fpregs[i]);
@@ -87,9 +88,10 @@ static int copy_fp_from_sigcontext(void __user *sc)
 	uint32_t __user *csr = sc + abi->off_sc_fpc_csr;
 	int i;
 	int err = 0;
+	int inc = test_thread_flag(TIF_32BIT_FPREGS) ? 2 : 1;
 	u64 fpr_val;
 
-	for (i = 0; i < NUM_FPU_REGS; i++) {
+	for (i = 0; i < NUM_FPU_REGS; i += inc) {
 		err |= __get_user(fpr_val, &fpregs[i]);
 		set_fpr64(&current->thread.fpu.fpr[i], 0, fpr_val);
 	}
-- 
2.4.4
