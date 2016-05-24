Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2016 10:35:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23332 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027917AbcEXIfa3SNuX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 May 2016 10:35:30 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 7128D3B2886CF;
        Tue, 24 May 2016 09:35:22 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 24 May 2016 09:35:24 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 24 May 2016 09:35:24 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        <linux-mips@linux-mips.org>, <stable@vger.kernel.org>
Subject: [PATCH 1/2] MIPS: Fix sigreturn via VDSO on microMIPS kernel
Date:   Tue, 24 May 2016 09:35:10 +0100
Message-ID: <1464078911-21468-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1464078911-21468-1-git-send-email-james.hogan@imgtec.com>
References: <1464078911-21468-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

In microMIPS kernels, handle_signal() sets the isa16 mode bit in the
vdso address so that the sigreturn trampolines (which are offset from
the VDSO) get executed as microMIPS.

However commit ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
changed the offsets to come from the VDSO image, which already have the
isa16 mode bit set correctly since they're extracted from the VDSO
shared library symbol table.

Drop the isa16 mode bit handling from handle_signal() to fix sigreturn
for cores which support both microMIPS and normal MIPS. This doesn't fix
microMIPS only cores, since the VDSO is still built for normal MIPS, but
thats a separate problem.

Fixes: ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.4.x-
---
 arch/mips/kernel/signal.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index ab042291fbfd..ae4231452115 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -770,15 +770,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	sigset_t *oldset = sigmask_to_save();
 	int ret;
 	struct mips_abi *abi = current->thread.abi;
-#ifdef CONFIG_CPU_MICROMIPS
-	void *vdso;
-	unsigned long tmp = (unsigned long)current->mm->context.vdso;
-
-	set_isa16_mode(tmp);
-	vdso = (void *)tmp;
-#else
 	void *vdso = current->mm->context.vdso;
-#endif
 
 	if (regs->regs[0]) {
 		switch(regs->regs[2]) {
-- 
2.4.10
