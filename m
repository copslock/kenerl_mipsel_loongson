Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Feb 2017 00:25:34 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35490 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993891AbdBOXZX72Zho (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Feb 2017 00:25:23 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1ce8U3-0002JX-AT; Wed, 15 Feb 2017 22:55:35 +0000
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1ce8Tj-00030W-Rj; Wed, 15 Feb 2017 22:55:15 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "Marcin Nowakowski" <marcin.nowakowski@imgtec.com>,
        linux-mips@linux-mips.org
Date:   Wed, 15 Feb 2017 22:41:40 +0000
Message-ID: <lsq.1487198500.942486776@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 113/306] MIPS: ptrace: Fix regs_return_value for
 kernel context
In-Reply-To: <lsq.1487198498.99718322@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.40-rc1 review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/ptrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -70,7 +70,7 @@ static inline int is_syscall_success(str
 
 static inline long regs_return_value(struct pt_regs *regs)
 {
-	if (is_syscall_success(regs))
+	if (is_syscall_success(regs) || !user_mode(regs))
 		return regs->regs[2];
 	else
 		return -regs->regs[2];
