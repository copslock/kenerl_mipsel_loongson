Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 16:25:27 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:4448 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825311AbaA0PYrhYsHf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 16:24:47 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 05/15] mips: replace hardcoded 32 with NUM_FPU_REGS in ptrace
Date:   Mon, 27 Jan 2014 15:23:04 +0000
Message-ID: <1390836194-26286-6-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1390836194-26286-1-git-send-email-paul.burton@imgtec.com>
References: <1390836194-26286-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_27_15_24_42
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39099
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

NUM_FPU_REGS just makes it clearer what's going on, rather than the
magic hard coded 32.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/kernel/signal.c   | 4 ++--
 arch/mips/kernel/signal32.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index e0178e1..0f97c7d 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -69,7 +69,7 @@ static int copy_fp_to_sigcontext(struct sigcontext __user *sc)
 	int i;
 	int err = 0;
 
-	for (i = 0; i < 32; i++) {
+	for (i = 0; i < NUM_FPU_REGS; i++) {
 		err |=
 		    __put_user(get_fpr64(&current->thread.fpu.fpr[i], 0),
 			       &sc->sc_fpregs[i]);
@@ -85,7 +85,7 @@ static int copy_fp_from_sigcontext(struct sigcontext __user *sc)
 	int err = 0;
 	u64 fpr_val;
 
-	for (i = 0; i < 32; i++) {
+	for (i = 0; i < NUM_FPU_REGS; i++) {
 		err |= __get_user(fpr_val, &sc->sc_fpregs[i]);
 		set_fpr64(&current->thread.fpu.fpr[i], 0, fpr_val);
 	}
diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index aec5821..bae2e6e 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -84,7 +84,7 @@ static int copy_fp_to_sigcontext32(struct sigcontext32 __user *sc)
 	int err = 0;
 	int inc = test_thread_flag(TIF_32BIT_FPREGS) ? 2 : 1;
 
-	for (i = 0; i < 32; i += inc) {
+	for (i = 0; i < NUM_FPU_REGS; i += inc) {
 		err |=
 		    __put_user(get_fpr64(&current->thread.fpu.fpr[i], 0),
 			       &sc->sc_fpregs[i]);
@@ -101,7 +101,7 @@ static int copy_fp_from_sigcontext32(struct sigcontext32 __user *sc)
 	int inc = test_thread_flag(TIF_32BIT_FPREGS) ? 2 : 1;
 	u64 fpr_val;
 
-	for (i = 0; i < 32; i += inc) {
+	for (i = 0; i < NUM_FPU_REGS; i += inc) {
 		err |= __get_user(fpr_val, &sc->sc_fpregs[i]);
 		set_fpr64(&current->thread.fpu.fpr[i], 0, fpr_val);
 	}
-- 
1.8.5.3
