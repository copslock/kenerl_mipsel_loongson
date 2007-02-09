Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Feb 2007 15:10:37 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.235]:9350 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038786AbXBIPJh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Feb 2007 15:09:37 +0000
Received: by qb-out-0506.google.com with SMTP id e12so191989qba
        for <linux-mips@linux-mips.org>; Fri, 09 Feb 2007 07:08:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=EpKEZKzApItiYyEeQxtHFvtW9ZzyopOa7K2EUJHrq6dVatBT1M/4ytMRxYK61kl6fgabURU4t3BM7VLG/+SqlxsQ+lpvT8aHNdsEVVMHvwG2si5dhys15F8qahTLxqZ5APsOkBHU/UWCNaRGrZ5cvc171/tnyC3eInltaXM67Kc=
Received: by 10.65.224.11 with SMTP id b11mr15913224qbr.1171033715671;
        Fri, 09 Feb 2007 07:08:35 -0800 (PST)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id f15sm3694233qba.2007.02.09.07.08.33;
        Fri, 09 Feb 2007 07:08:34 -0800 (PST)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id A6BED23F76F; Fri,  9 Feb 2007 16:07:39 +0100 (CET)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, anemo@mba.ocn.ne.jp,
	Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 3/3] signal.c: fix gcc warning on 32 bits kernel
Date:	Fri,  9 Feb 2007 16:07:38 +0100
Message-Id: <11710336591652-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.4.3.ge6d4
In-Reply-To: <1171033658561-git-send-email-fbuihuu@gmail.com>
References: <1171033658561-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

This hack prevents gcc to produce the following warning:

  CC      arch/mips/kernel/signal.o
arch/mips/kernel/signal.c: In function `sys_sigaction':
arch/mips/kernel/signal.c:266: warning: cast to pointer from integer of different size

This warning is due to the following line:

	__get_user(new_ka.sa.sa_handler, &act->sa_handler);

Indeed when __get_user() is expanded it produces the following
code:

	switch (sizeof(*(&act->sa_handler))) {
	... [snip] ...
	case 8: {
		unsigned long long __gu_tmp;
		__asm__ __volatile__(
			"1: lw      %1, (%3)                  \n"
			"2: lw      %D1, 4(%3)                \n"
			"   move    %0, $0                    \n"
			"3: .section        .fixup,\"ax\"     \n"
			"4: li      %0, %4                    \n"
			"   move    %1, $0                    \n"
			"   move    %D1, $0                   \n"
			"   j       3b                        \n"
			"   .previous                         \n"
			"   .section        __ex_table,\"a\"  \n"
			"   " ".word" "     1b, 4b            \n"
			"   " ".word" "     2b, 4b            \n"
			"   .previous                         \n"
			: "=r" (__gu_err), "=&r" (__gu_tmp)
			: "0" (0), "r" ((&act->sa_handler)), "i" (-14));

		(((new_ka.sa.sa_handler))) = (__typeof__(*((&act->sa_handler)))) __gu_tmp;
		};
		break;
	default:
		__get_user_unknown();
		break;
	}

which actually try to do:

	new_ka.sa.sa_handler = (__sighandler_t) __gu_tmp;

Here we try to cast an 'unsigned long long' into a 32 bits pointer and
that's the reason of the warning.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/kernel/signal.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index a3c04d0..ac8a05a 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -260,15 +260,17 @@ asmlinkage int sys_sigaction(int sig, const struct sigaction __user *act,
 
 	if (act) {
 		old_sigset_t mask;
+		unsigned long tmp; /* fix a gcc warning */
 
 		if (!access_ok(VERIFY_READ, act, sizeof(*act)))
 			return -EFAULT;
-		err |= __get_user(new_ka.sa.sa_handler, &act->sa_handler);
+		err |= __get_user(tmp, (unsigned long *)&act->sa_handler);
 		err |= __get_user(new_ka.sa.sa_flags, &act->sa_flags);
 		err |= __get_user(mask, &act->sa_mask.sig[0]);
 		if (err)
 			return -EFAULT;
 
+		new_ka.sa.sa_handler = (__sighandler_t)tmp;
 		siginitset(&new_ka.sa.sa_mask, mask);
 	}
 
-- 
1.4.4.3.ge6d4
