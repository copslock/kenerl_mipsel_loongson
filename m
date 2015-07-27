Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jul 2015 22:00:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10013 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011341AbbG0UAf7IJiX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jul 2015 22:00:35 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 957299C94D834;
        Mon, 27 Jul 2015 21:00:26 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 27 Jul 2015 21:00:30 +0100
Received: from localhost (10.100.200.213) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 27 Jul
 2015 21:00:29 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Matthew Fortune <matthew.fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        <linux-kernel@vger.kernel.org>,
        "Richard Weinberger" <richard@nod.at>,
        Andy Lutomirski <luto@amacapital.net>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@codesourcery.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 06/16] MIPS: skip odd double FP registers when copying FP32 sigcontext
Date:   Mon, 27 Jul 2015 12:58:17 -0700
Message-ID: <1438027107-24420-7-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1438027107-24420-1-git-send-email-paul.burton@imgtec.com>
References: <1438027107-24420-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.213]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48463
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

Changes in v2: None

 arch/mips/kernel/signal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 9c42c50..cc3a01f 100644
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
2.4.6
