Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2012 23:42:09 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:49874 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903509Ab2GXVkW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2012 23:40:22 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Stmq0-0003yA-Bi; Tue, 24 Jul 2012 16:40:16 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Douglas Leung <douglas@mips.com>, ralf@linux-mips.org,
        "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH] MIPS: Add microMIPS vdso support.
Date:   Tue, 24 Jul 2012 16:40:12 -0500
Message-Id: <1343166012-1759-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.11.1
X-archive-position: 33976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Douglas Leung <douglas@mips.com>

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/kernel/signal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index f2c09cf..51d13c1 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -35,6 +35,7 @@
 #include <asm/war.h>
 #include <asm/vdso.h>
 #include <asm/dsp.h>
+#include <asm/inst.h>
 
 #include "signal-common.h"
 
@@ -518,7 +519,12 @@ static void handle_signal(unsigned long sig, siginfo_t *info,
 	sigset_t *oldset = sigmask_to_save();
 	int ret;
 	struct mips_abi *abi = current->thread.abi;
+#ifdef CONFIG_CPU_MICROMIPS
+	void *vdso = (void *)
+		((unsigned int)current->mm->context.vdso | MIPS_ISA_MODE);
+#else
 	void *vdso = current->mm->context.vdso;
+#endif
 
 	if (regs->regs[0]) {
 		switch(regs->regs[2]) {
-- 
1.7.11.1
