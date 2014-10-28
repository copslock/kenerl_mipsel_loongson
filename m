Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 12:26:06 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41607 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011574AbaJ1L0FSNf91 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2014 12:26:05 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7B52B856A2A19
        for <linux-mips@linux-mips.org>; Tue, 28 Oct 2014 11:25:56 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 28 Oct
 2014 11:25:58 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 28 Oct 2014 11:25:58 +0000
Received: from pburton-laptop.home (192.168.159.114) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 28 Oct
 2014 11:25:57 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <stable@vger.kernel.org # v3.15+>
Subject: [PATCH] MIPS: fix EVA & non-SMP non-FPU FP context signal handling
Date:   Tue, 28 Oct 2014 11:25:51 +0000
Message-ID: <1414495551-15955-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.1.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.114]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43621
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

The save_fp_context & restore_fp_context pointers were being assigned
to the wrong variables if either:

  - The kernel is configured for UP & runs on a system without an FPU,
    since b2ead5282885 "MIPS: Move & rename
    fpu_emulator_{save,restore}_context".

  - The kernel is configured for EVA, since ca750649e08c "MIPS: kernel:
    signal: Prevent save/restore FPU context in user memory".

This would lead to FP context being clobbered incorrectly when setting
up a sigcontext, then the garbage values being saved uselessly when
returning from the signal.

Fix by swapping the pointer assignments appropriately.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: stable@vger.kernel.org # v3.15+
---
 arch/mips/kernel/signal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index e1112be..8b1a84e 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -649,13 +649,13 @@ static int signal_setup(void)
 		save_fp_context = _save_fp_context;
 		restore_fp_context = _restore_fp_context;
 	} else {
-		save_fp_context = copy_fp_from_sigcontext;
-		restore_fp_context = copy_fp_to_sigcontext;
+		save_fp_context = copy_fp_to_sigcontext;
+		restore_fp_context = copy_fp_from_sigcontext;
 	}
 #endif /* CONFIG_SMP */
 #else
-	save_fp_context = copy_fp_from_sigcontext;;
-	restore_fp_context = copy_fp_to_sigcontext;
+	save_fp_context = copy_fp_to_sigcontext;
+	restore_fp_context = copy_fp_from_sigcontext;
 #endif
 
 	return 0;
-- 
2.0.4
