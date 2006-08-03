Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Aug 2006 08:31:25 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.189]:59516 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133467AbWHCHaM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Aug 2006 08:30:12 +0100
Received: by nf-out-0910.google.com with SMTP id q29so939690nfc
        for <linux-mips@linux-mips.org>; Thu, 03 Aug 2006 00:30:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HrZEZiAVwBPyXLa7GKYEzr0Yv0lEt3KBkPOg1d/nNOnC+/OZhRDfyLPe81/lDKzC3kzL6EmQO9BpadFPdVgOFqSF7gxwFVL3+vhRm93egBVwppQtQ9w1cm1/tDtqSav6ekJwkREuY1DXSYlel+sq4Rccto4aHCF4uGY87xxRYzE=
Received: by 10.49.10.3 with SMTP id n3mr3367816nfi;
        Thu, 03 Aug 2006 00:30:12 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id p43sm664044nfa.2006.08.03.00.30.11;
        Thu, 03 Aug 2006 00:30:12 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 6F51523F76F; Thu,  3 Aug 2006 09:29:21 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	anemo@mba.ocn.ne.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 2/7] Remove unused MODULE_RANGE macro.
Date:	Thu,  3 Aug 2006 09:29:16 +0200
Message-Id: <11545901612122-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
In-Reply-To: <11545901611096-git-send-email-vagabon.xyz@gmail.com>
References: <11545901611096-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 arch/mips/kernel/traps.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 7aa9dfc..4a11a3d 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -73,11 +73,6 @@ void (*board_nmi_handler_setup)(void);
 void (*board_ejtag_handler_setup)(void);
 void (*board_bind_eic_interrupt)(int irq, int regset);
 
-/*
- * These constant is for searching for possible module text segments.
- * MODULE_RANGE is a guess of how much space is likely to be vmalloced.
- */
-#define MODULE_RANGE (8*1024*1024)
 
 static void show_trace(unsigned long *stack)
 {
-- 
1.4.2.rc2
