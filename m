Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Feb 2007 14:28:01 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.233]:5799 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20037715AbXBEO0c (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Feb 2007 14:26:32 +0000
Received: by hu-out-0506.google.com with SMTP id 22so786011hug
        for <linux-mips@linux-mips.org>; Mon, 05 Feb 2007 06:25:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=eHmTgSEj1bGZKd1GIgzN9ch5/pjaAxlF0kGm2Be9/44dCoOdG2d8sjakVtSE5RNEgJjGVmW/VpG4M8vhVFE/qYxrGQaW5YNMO3Fh+PHRLE14WSs/lkjb2Nngei6RbA0SWYOp28H2eK9oJpX97pD+4j1FmMjpNcpoFelZwgccc54=
Received: by 10.48.48.18 with SMTP id v18mr2279253nfv.1170685531584;
        Mon, 05 Feb 2007 06:25:31 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id k23sm27230792nfc.2007.02.05.06.25.30;
        Mon, 05 Feb 2007 06:25:30 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id DCFC823F777; Mon,  5 Feb 2007 15:24:29 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 8/10] signal32: no need to save c0_status register in setup_sigcontext32()
Date:	Mon,  5 Feb 2007 15:24:26 +0100
Message-Id: <11706854691838-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
In-Reply-To: <11706854683935-git-send-email-fbuihuu@gmail.com>
References: <11706854683935-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

All the information in the MIPS c0_status register is priviledged.
Nothing that would constitute part of the thread context.

The one flag one could possibly argument about might be c0_status.fr
but none of the ABIs or tools or application software can make use
of it.

So for consistency with restore_sigcontext32(), which does not
restore c0_status register, this patch remove the saving part.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/signal32.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index 5d102ef..0994d6e 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -170,7 +170,6 @@ static int setup_sigcontext32(struct pt_regs *regs,
 	int i;
 
 	err |= __put_user(regs->cp0_epc, &sc->sc_pc);
-	err |= __put_user(regs->cp0_status, &sc->sc_status);
 
 	err |= __put_user(0, &sc->sc_regs[0]);
 	for (i = 1; i < 32; i++)
-- 
1.4.4.3.ge6d4
