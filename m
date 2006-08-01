Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Aug 2006 10:31:35 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.190]:5656 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133606AbWHAJ2M (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 1 Aug 2006 10:28:12 +0100
Received: by nf-out-0910.google.com with SMTP id q29so210810nfc
        for <linux-mips@linux-mips.org>; Tue, 01 Aug 2006 02:28:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JGKP7v/vpfeN/YctW7iD1o6G0vjUa4uF3k7prgerrl+9OUexfUrlMuZGA5l0FDhLkycxjQvje83iF1nbo8FFxqnOdYAX16fG7jBUXButKSSqUs0ou3cUlfUGIgL+D1UIW54pChtpZE+QF5+438BbpOLHLN+BcP2TkunN8QXU6pk=
Received: by 10.49.75.2 with SMTP id c2mr390280nfl;
        Tue, 01 Aug 2006 02:28:12 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id g1sm159770nfe.2006.08.01.02.28.11;
        Tue, 01 Aug 2006 02:28:12 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id D961723F772; Tue,  1 Aug 2006 11:27:18 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	anemo@mba.ocn.ne.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 4/7] Remove unused MODULE_RANGE macro.
Date:	Tue,  1 Aug 2006 11:27:14 +0200
Message-Id: <11544244381454-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
In-Reply-To: <11544244373398-git-send-email-vagabon.xyz@gmail.com>
References: <11544244373398-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12144
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
