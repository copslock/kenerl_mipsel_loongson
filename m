Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2016 00:30:58 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:32958 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042519AbcFEWY6k8zX6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2016 00:24:58 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D3C8394E;
        Sun,  5 Jun 2016 22:24:49 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.5 021/128] MIPS: Fix sigreturn via VDSO on microMIPS kernel
Date:   Sun,  5 Jun 2016 15:22:56 -0700
Message-Id: <20160605222321.886753957@linuxfoundation.org>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160605222321.183131188@linuxfoundation.org>
References: <20160605222321.183131188@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53879
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

4.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 13eb192d10bcc9ac518d57356179071d603bcb4e upstream.

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
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13348/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/signal.c |    8 --------
 1 file changed, 8 deletions(-)

--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -770,15 +770,7 @@ static void handle_signal(struct ksignal
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
