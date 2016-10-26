Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Oct 2016 14:33:49 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:44677 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992836AbcJZMdM6ccdn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Oct 2016 14:33:12 +0200
Received: from localhost (pes75-3-78-192-101-3.fbxo.proxad.net [78.192.101.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AA5A694D;
        Wed, 26 Oct 2016 12:33:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 053/112] MIPS: ptrace: Fix regs_return_value for kernel context
Date:   Wed, 26 Oct 2016 14:22:36 +0200
Message-Id: <20161026122307.043285041@linuxfoundation.org>
X-Mailer: git-send-email 2.10.1
In-Reply-To: <20161026122304.797016625@linuxfoundation.org>
References: <20161026122304.797016625@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/ptrace.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -152,7 +152,7 @@ static inline int is_syscall_success(str
 
 static inline long regs_return_value(struct pt_regs *regs)
 {
-	if (is_syscall_success(regs))
+	if (is_syscall_success(regs) || !user_mode(regs))
 		return regs->regs[2];
 	else
 		return -regs->regs[2];
