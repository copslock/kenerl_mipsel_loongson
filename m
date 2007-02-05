Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Feb 2007 14:27:32 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.239]:6823 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20037720AbXBEO0c (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Feb 2007 14:26:32 +0000
Received: by hu-out-0506.google.com with SMTP id 22so786009hug
        for <linux-mips@linux-mips.org>; Mon, 05 Feb 2007 06:25:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=ro2fPTVNIypzqD8326Wodu4ZSphcbtRZVCr8VPb/Ci8YGPqQCGEwgdjhIlPh7KJQB5/2Y9Q33/whGobnlyr62+dPe2pJJ5peaU9Usmr/ySiknpumOB+LYzavpxIBjHXqCXWxaQ8hIEZH+tLNY/hn9QJ1sTe9JmvqfjGdSXZ8lHM=
Received: by 10.49.29.2 with SMTP id g2mr2279285nfj.1170685531335;
        Mon, 05 Feb 2007 06:25:31 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id l22sm27267860nfc.2007.02.05.06.25.30;
        Mon, 05 Feb 2007 06:25:30 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id AE13B23F774; Mon,  5 Feb 2007 15:24:29 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 5/10] signal: test return value of install_sigtramp()
Date:	Mon,  5 Feb 2007 15:24:23 +0100
Message-Id: <1170685469385-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
In-Reply-To: <11706854683935-git-send-email-fbuihuu@gmail.com>
References: <11706854683935-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13930
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
index 41033be..5245135 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -184,7 +184,7 @@ int install_sigtramp(unsigned int __user *tramp, unsigned int syscall)
 	 */
 
 	err = __put_user(0x24020000 + syscall, tramp + 0);
-	err |= __put_user(0x0000000c          , tramp + 1);
+	err |= __put_user(0x0000000c         , tramp + 1);
 	if (ICACHE_REFILLS_WORKAROUND_WAR) {
 		err |= __put_user(0, tramp + 2);
 		err |= __put_user(0, tramp + 3);
@@ -400,7 +400,7 @@ int setup_frame(struct k_sigaction * ka, struct pt_regs *regs,
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		goto give_sigsegv;
 
-	install_sigtramp(frame->sf_code, __NR_sigreturn);
+	err |= install_sigtramp(frame->sf_code, __NR_sigreturn);
 
 	err |= setup_sigcontext(regs, &frame->sf_sc);
 	err |= __copy_to_user(&frame->sf_mask, set, sizeof(*set));
@@ -447,7 +447,7 @@ int setup_rt_frame(struct k_sigaction * ka, struct pt_regs *regs,
 	if (!access_ok(VERIFY_WRITE, frame, sizeof (*frame)))
 		goto give_sigsegv;
 
-	install_sigtramp(frame->rs_code, __NR_rt_sigreturn);
+	err |= install_sigtramp(frame->rs_code, __NR_rt_sigreturn);
 
 	/* Create siginfo.  */
 	err |= copy_siginfo_to_user(&frame->rs_info, info);
-- 
1.4.4.3.ge6d4
