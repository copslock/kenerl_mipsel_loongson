Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Aug 2015 13:45:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41814 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011359AbbHTLpgnlNUm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Aug 2015 13:45:36 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 54E4A6280921C
        for <linux-mips@linux-mips.org>; Thu, 20 Aug 2015 12:45:28 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 20 Aug 2015 12:45:30 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.168) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 20 Aug 2015 12:45:30 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
Subject: [PATCH 1/2] MIPS: asm: signal.h: Fix traditional signal handling for o32 on 64-bit kernels
Date:   Thu, 20 Aug 2015 12:45:21 +0100
Message-ID: <1440071122-24971-2-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1440071122-24971-1-git-send-email-markos.chandras@imgtec.com>
References: <1440071122-24971-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.168]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

CONFIG_TRAD_SIGNALS is used to denote that legacy signal handlers are
supported (ie !SA_SIGINFO). However, this symbol is only available on
32-bit kernels, so o32 running on 64-bit kernels with !SA_SIGINFO was
treated as if SA_SIGINFO was set so there was extra overhead setting up
the signal handling code within the kernel. o32 should work in the same
way for both 32-bit and 64-bit kernels so we fix the sig_uses_siginfo
definition to allow traditional signal handling for o32 even on 64-bit
kernels. This has been tested booting a MIPS32R6 userland on a 64-bit
MIPS64R6 kernel.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/signal.h | 8 +++-----
 arch/mips/kernel/signal.c      | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/signal.h b/arch/mips/include/asm/signal.h
index 003e273eff4c..cedc53b0ab69 100644
--- a/arch/mips/include/asm/signal.h
+++ b/arch/mips/include/asm/signal.h
@@ -12,11 +12,9 @@
 #include <uapi/asm/signal.h>
 
 
-#ifdef CONFIG_TRAD_SIGNALS
-#define sig_uses_siginfo(ka)	((ka)->sa.sa_flags & SA_SIGINFO)
-#else
-#define sig_uses_siginfo(ka)	(1)
-#endif
+#define sig_uses_siginfo(abi, ka)		\
+	(((ka)->sa.sa_flags & SA_SIGINFO) ||	\
+	 (!config_enabled(CONFIG_TRAD_SIGNALS) && !(abi)->setup_frame))
 
 #include <asm/sigcontext.h>
 #include <asm/siginfo.h>
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 359fb5829f66..be3ac5f7cbbb 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -801,7 +801,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 		regs->regs[0] = 0;		/* Don't deal with this again.	*/
 	}
 
-	if (sig_uses_siginfo(&ksig->ka))
+	if (sig_uses_siginfo(abi, &ksig->ka))
 		ret = abi->setup_rt_frame(vdso + abi->rt_signal_return_offset,
 					  ksig, regs, oldset);
 	else
-- 
2.5.0
