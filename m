Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2007 14:17:29 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.185]:53557 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20044419AbXAWOQC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Jan 2007 14:16:02 +0000
Received: by nf-out-0910.google.com with SMTP id l24so237969nfc
        for <linux-mips@linux-mips.org>; Tue, 23 Jan 2007 06:16:02 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=D6r9pIvOD70kP1pMcKMldDNYhD0I6Oz5ixOVwXnCLvxp06walou6IwYMdUbxfCe7atzdUGt6D9+81/3mHtvae69URteT7fZF6hNWDnI9/nznVL8y1Zj3pfXLVZgqvZSE6g2M0uROld88EKmBJux8Jkl/PgepqB53BRjCtkoASQU=
Received: by 10.48.217.11 with SMTP id p11mr1095725nfg.1169561762179;
        Tue, 23 Jan 2007 06:16:02 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id a23sm2692049nfc.2007.01.23.06.16.01;
        Tue, 23 Jan 2007 06:16:01 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 03EAE23F773; Tue, 23 Jan 2007 15:18:24 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 5/7] signal: test return value of install_sigtramp()
Date:	Tue, 23 Jan 2007 15:18:21 +0100
Message-Id: <1169561903723-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
In-Reply-To: <1169561903878-git-send-email-fbuihuu@gmail.com>
References: <1169561903878-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/signal.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 468c74d..133ef74 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -187,7 +187,7 @@ int install_sigtramp(unsigned int __user *tramp, unsigned int syscall)
 	 */
 
 	err = __put_user(0x24020000 + syscall, tramp + 0);
-	err |= __put_user(0x0000000c          , tramp + 1);
+	err |= __put_user(0x0000000c         , tramp + 1);
 	if (ICACHE_REFILLS_WORKAROUND_WAR) {
 		err |= __put_user(0, tramp + 2);
 		err |= __put_user(0, tramp + 3);
@@ -403,7 +403,7 @@ int setup_frame(struct k_sigaction * ka, struct pt_regs *regs,
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		goto give_sigsegv;
 
-	install_sigtramp(frame->sf_code, __NR_sigreturn);
+	err |= install_sigtramp(frame->sf_code, __NR_sigreturn);
 
 	err |= setup_sigcontext(regs, &frame->sf_sc);
 	err |= __copy_to_user(&frame->sf_mask, set, sizeof(*set));
@@ -450,7 +450,7 @@ int setup_rt_frame(struct k_sigaction * ka, struct pt_regs *regs,
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		goto give_sigsegv;
 
-	install_sigtramp(frame->rs_code, __NR_rt_sigreturn);
+	err |= install_sigtramp(frame->rs_code, __NR_rt_sigreturn);
 
 	/* Create siginfo.  */
 	err |= copy_siginfo_to_user(&frame->rs_info, info);
-- 
1.4.4.3.ge6d4
