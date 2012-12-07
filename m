Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 06:07:54 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:60318 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824772Ab2LGFFyDKpsy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2012 06:05:54 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Tgq8B-0007MA-MI; Thu, 06 Dec 2012 23:05:47 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Douglas Leung <douglas@mips.com>, ralf@linux-mips.org,
        "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH v99,07/13] MIPS: microMIPS: Add vdso support.
Date:   Thu,  6 Dec 2012 23:05:31 -0600
Message-Id: <1354856737-28678-8-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1354856737-28678-1-git-send-email-sjhill@mips.com>
References: <1354856737-28678-1-git-send-email-sjhill@mips.com>
X-archive-position: 35217
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

Support vdso in microMIPS mode.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/kernel/signal.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index b6aa770..3dc23cd 100644
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
1.7.9.5
