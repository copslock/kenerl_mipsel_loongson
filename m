Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2007 14:14:37 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.229]:36987 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20048474AbXAXOLA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Jan 2007 14:11:00 +0000
Received: by hu-out-0506.google.com with SMTP id 22so152657hug
        for <linux-mips@linux-mips.org>; Wed, 24 Jan 2007 06:09:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=j7zmXYIetjEJIkLrI+/JTb7UWlU1N98F36IHafWdKD1q83f7v6+Bhhy0hCyMDa0B+o7xGyLTP+gAmXOcGGjqlCPL7mTTatwupElLoYNv0QgNf+mSS0vw+t6HYIWnyY64VFrMA78Da5TdwWw8HgoNezTzxBRwiixN4OXKY1J1DvY=
Received: by 10.49.92.18 with SMTP id u18mr2922105nfl.1169647796501;
        Wed, 24 Jan 2007 06:09:56 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id c10sm6571043nfb.2007.01.24.06.09.50;
        Wed, 24 Jan 2007 06:09:52 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 20F9323F776; Wed, 24 Jan 2007 15:12:12 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 8/8] signal32: no need to save c0_status register in setup_sigcontext32()
Date:	Wed, 24 Jan 2007 15:12:11 +0100
Message-Id: <11696479323375-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
In-Reply-To: <11696479312279-git-send-email-fbuihuu@gmail.com>
References: <11696479312279-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13801
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
