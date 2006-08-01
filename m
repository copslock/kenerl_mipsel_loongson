Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Aug 2006 10:33:10 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.191]:24343 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133623AbWHAJ2O (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 1 Aug 2006 10:28:14 +0100
Received: by nf-out-0910.google.com with SMTP id q29so210807nfc
        for <linux-mips@linux-mips.org>; Tue, 01 Aug 2006 02:28:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PDwvOdAg5EJLCVDJjq4rGJXjQT8s5W6ljylUggLkZ5dFg3oWLW2cuIwMuZ0nPHSEigWGOx1d8hccJXx+Yci5rMGTz4VA3fBVVIzZ7bwvfUxGicUMEkR9S4+dOSMIyutowxLcENnbEi1L4o+R7FITk2cHRJnmZ/XHHgk7mmbtUzc=
Received: by 10.49.21.8 with SMTP id y8mr399251nfi;
        Tue, 01 Aug 2006 02:28:14 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id x24sm688777nfb.2006.08.01.02.28.13;
        Tue, 01 Aug 2006 02:28:13 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 345D523F774; Tue,  1 Aug 2006 11:27:19 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	anemo@mba.ocn.ne.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 6/7] Fix dump_stack()
Date:	Tue,  1 Aug 2006 11:27:16 +0200
Message-Id: <1154424439852-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
In-Reply-To: <11544244373398-git-send-email-vagabon.xyz@gmail.com>
References: <11544244373398-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

When CONFIG_KALLSYMS is not set stack local is not initialized. Therefore
show_trace() won't display anything useful. This patch uses
prepare_frametrace() to setup the stack pointer before calling
show_trace().

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 arch/mips/kernel/traps.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 15fa445..07191a6 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -203,17 +203,10 @@ void show_stack(struct task_struct *task
  */
 void dump_stack(void)
 {
-	unsigned long stack;
+	struct pt_regs regs;
 
-#ifdef CONFIG_KALLSYMS
-	if (!raw_show_trace) {
-		struct pt_regs regs;
-		prepare_frametrace(&regs);
-		show_backtrace(current, &regs);
-		return;
-	}
-#endif
-	show_trace(&stack);
+	prepare_frametrace(&regs);
+	show_backtrace(current, &regs);
 }
 
 EXPORT_SYMBOL(dump_stack);
-- 
1.4.2.rc2
