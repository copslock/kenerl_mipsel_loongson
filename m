Received:  by oss.sgi.com id <S553669AbRCKQQq>;
	Sun, 11 Mar 2001 08:16:46 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:5125 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553659AbRCKQQW>;
	Sun, 11 Mar 2001 08:16:22 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 4A3607FE; Sun, 11 Mar 2001 17:16:10 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id A0176EFC1; Sun, 11 Mar 2001 19:16:39 +0100 (CET)
Date:   Sun, 11 Mar 2001 19:16:39 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: Illegal instruction - a workaround or fix ?
Message-ID: <20010311191639.A8587@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Hi,
i seem to get the illegal instruction stuff killed when
doing this.

diff -u -r1.17 sysmips.c
--- arch/mips/kernel/sysmips.c	2001/02/09 21:05:46	1.17
+++ arch/mips/kernel/sysmips.c	2001/03/11 16:11:30
@@ -111,13 +111,14 @@
 
 		((struct pt_regs *)&cmd)->regs[2] = tmp;
 		((struct pt_regs *)&cmd)->regs[7] = 0;
-
+#if 0
 		__asm__ __volatile__(
 			"move\t$29, %0\n\t"
 			"j\to32_ret_from_sys_call"
 			: /* No outputs */
 			: "r" (&cmd));
 		/* Unreached */
+#endif
 	}
 
 	case MIPS_FIXADE:


Could someone please explain me the difference betweeen "handle_sys"
which leads to "o32_ret_from_sys_call" and ... which leads to
"ret_from_sys_call".

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
