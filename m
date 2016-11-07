Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 14:05:47 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:51604 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991344AbcKGNFlAoZqu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Nov 2016 14:05:41 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B2DB6ACEC;
        Mon,  7 Nov 2016 13:05:40 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 36/72] MIPS: ptrace: Fix regs_return_value for kernel context
Date:   Mon,  7 Nov 2016 14:04:43 +0100
Message-Id: <75393dbe932eec4d00d15faa5cb18a512d1d7bfe.1478523828.git.jslaby@suse.cz>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <0f3caac741164dcff670ae0f4d1cfcb0a7026a1c.1478523828.git.jslaby@suse.cz>
References: <0f3caac741164dcff670ae0f4d1cfcb0a7026a1c.1478523828.git.jslaby@suse.cz>
In-Reply-To: <cover.1478523828.git.jslaby@suse.cz>
References: <cover.1478523828.git.jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

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
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/include/asm/ptrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index 5e6cd0947393..a288de2199d8 100644
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
2.10.2
