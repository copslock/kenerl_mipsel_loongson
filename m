Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Feb 2007 14:30:22 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.236]:12199 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20037742AbXBEO0m (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Feb 2007 14:26:42 +0000
Received: by hu-out-0506.google.com with SMTP id 22so786032hug
        for <linux-mips@linux-mips.org>; Mon, 05 Feb 2007 06:25:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=uOnCGj6UufXct8AS/JvnhOmK6RA4pkUN9MfhgGPp9tv5fY8uHfwdT/cAYIHywwTNl4JbeFRRWP/X1ffwpf1Edb9VYMWKyCAdg3AiewjtqeM8+TrYFgAbMdn7KcOG7Xl8AekBUC4pToIG48uaB8wjizTrfPz249o1SUlffUlABPo=
Received: by 10.49.36.6 with SMTP id o6mr2274959nfj.1170685532207;
        Mon, 05 Feb 2007 06:25:32 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id a23sm27251211nfc.2007.02.05.06.25.30;
        Mon, 05 Feb 2007 06:25:31 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 302BE23F779; Mon,  5 Feb 2007 15:24:30 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 10/10] signal: do not inline handle_signal()
Date:	Mon,  5 Feb 2007 15:24:28 +0100
Message-Id: <11706854701492-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
In-Reply-To: <11706854683935-git-send-email-fbuihuu@gmail.com>
References: <11706854683935-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/signal.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 32d4022..229276a 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -484,7 +484,7 @@ give_sigsegv:
 	return -EFAULT;
 }
 
-static inline int handle_signal(unsigned long sig, siginfo_t *info,
+static int handle_signal(unsigned long sig, siginfo_t *info,
 	struct k_sigaction *ka, sigset_t *oldset, struct pt_regs *regs)
 {
 	int ret;
-- 
1.4.4.3.ge6d4
