Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Feb 2017 20:26:19 +0100 (CET)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:28230 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992735AbdBET0NIITwB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 5 Feb 2017 20:26:13 +0100
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id v15JLj16008168;
        Sun, 5 Feb 2017 20:21:45 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux@roeck-us.net
Cc:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3.10 063/319] MIPS: ptrace: Fix regs_return_value for kernel context
Date:   Sun,  5 Feb 2017 20:20:50 +0100
Message-Id: <1486322486-8024-34-git-send-email-w@1wt.eu>
X-Mailer: git-send-email 2.8.0.rc2.1.gbe9624a
In-Reply-To: <1486322486-8024-1-git-send-email-w@1wt.eu>
References: <1486322486-8024-1-git-send-email-w@1wt.eu>
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w@1wt.eu
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

From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>

commit 74f1077b5b783e7bf4fa3007cefdc8dbd6c07518 upstream.

Currently regs_return_value always negates reg[2] if it determines
the syscall has failed, but when called in kernel context this check is
invalid and may result in returning a wrong value.

This fixes errors reported by CONFIG_KPROBES_SANITY_TEST

Fixes: d7e7528bcd45 ("Audit: push audit success and retcode into arch ptrace.h")
Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14381/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/mips/include/asm/ptrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index 5e6cd09..a288de2 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -73,7 +73,7 @@ static inline int is_syscall_success(struct pt_regs *regs)
 
 static inline long regs_return_value(struct pt_regs *regs)
 {
-	if (is_syscall_success(regs))
+	if (is_syscall_success(regs) || !user_mode(regs))
 		return regs->regs[2];
 	else
 		return -regs->regs[2];
-- 
2.8.0.rc2.1.gbe9624a
