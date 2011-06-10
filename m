Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2011 15:10:15 +0200 (CEST)
Received: from grimli.r00tworld.net ([83.169.44.195]:58620 "EHLO
        mail.r00tworld.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1490990Ab1FJNKK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jun 2011 15:10:10 +0200
Received: by mail.r00tworld.net (Postfix, from userid 1000)
        id C9FBC115901B4; Fri, 10 Jun 2011 15:10:04 +0200 (CEST)
From:   Mathias Krause <minipli@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Mathias Krause <minipli@googlemail.com>
Subject: [PATCH] mips, exec: remove redundant addr_limit assignment
Date:   Fri, 10 Jun 2011 15:10:04 +0200
Message-Id: <1307711404-9745-1-git-send-email-minipli@googlemail.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <BANLkTinv1teZEHMK0qymaVdcxPOErpqSyg@mail.gmail.com>
References: <BANLkTinv1teZEHMK0qymaVdcxPOErpqSyg@mail.gmail.com>
References: <BANLkTiknCeAxe30MJdVTxDom+ko8+EDQ4A@mail.gmail.com> <1307642718-22257-1-git-send-email-minipli@googlemail.com> <20110609155630.0f734351.akpm@linux-foundation.org>
X-archive-position: 30317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: minipli@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9155

The address limit is already set in flush_old_exec() via set_fs(USER_DS)
so this assignment is redundant.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 arch/mips/kernel/process.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index d2112d3..a8d53e5 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -103,7 +103,6 @@ void start_thread(struct pt_regs * regs, unsigned long pc, unsigned long sp)
 		__init_dsp();
 	regs->cp0_epc = pc;
 	regs->regs[29] = sp;
-	current_thread_info()->addr_limit = USER_DS;
 }
 
 void exit_thread(void)
-- 
1.5.6.5
