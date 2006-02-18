Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Feb 2006 15:15:05 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:5648 "EHLO sorrow.cyrius.com")
	by ftp.linux-mips.org with ESMTP id S8133534AbWBRPOy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 18 Feb 2006 15:14:54 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id C40AC64D59; Sat, 18 Feb 2006 15:21:37 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 465068D5D; Sat, 18 Feb 2006 15:21:30 +0000 (GMT)
Date:	Sat, 18 Feb 2006 15:21:30 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: Oops with git: do_signal32 on 64-bit
Message-ID: <20060218152130.GZ20785@deprecation.cyrius.com>
References: <20060217225216.GA15781@deprecation.cyrius.com> <20060218.220701.25910111.anemo@mba.ocn.ne.jp> <20060218145545.GX20785@deprecation.cyrius.com> <20060219.000633.63740163.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219.000633.63740163.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Atsushi Nemoto <anemo@mba.ocn.ne.jp> [2006-02-19 00:06]:
> tbm> Done now, and tested on Cobalt.
> Looks good for me, except one point.
> Since do_signal() return void now, do_signal32 also should return void.

You're right, thanks.  Ralf has done this in a separate commit so I've
attached a new patch rather than adding this to the last one.  Also,
this one isn't as urgent and doesn't need to make 1.6.16 while the
other one does.

> Also, I think prototypes of do_signal() variant should be in
> asm/signal.h or so to avoid such mistake in the future, but this
> might be an another patch ...

Maybe you or Ralf can do that.


From: Martin Michlmayr <tbm@cyrius.com>

[PATCH] [MIPS] Make do_signal32 return void.

do_signal has been changed to return void since the "return value is
ignored everywhere".  Convert do_signal32 accordingly.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

---

--- a/arch/mips/kernel/signal32.c~	2006-02-18 15:17:33.000000000 +0000
+++ b/arch/mips/kernel/signal32.c	2006-02-18 15:18:24.000000000 +0000
@@ -4,7 +4,7 @@
  * for more details.
  *
  * Copyright (C) 1991, 1992  Linus Torvalds
- * Copyright (C) 1994 - 2000  Ralf Baechle
+ * Copyright (C) 1994 - 2000, 2006  Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  */
 #include <linux/cache.h>
@@ -800,7 +800,7 @@
 	return ret;
 }
 
-int do_signal32(struct pt_regs *regs)
+void do_signal32(struct pt_regs *regs)
 {
 	struct k_sigaction ka;
 	sigset_t *oldset;
@@ -813,7 +813,7 @@
 	 * if so.
 	 */
 	if (!user_mode(regs))
-		return 1;
+		return;
 
 	if (try_to_freeze())
 		goto no_signal;
@@ -866,8 +866,6 @@
 		clear_thread_flag(TIF_RESTORE_SIGMASK);
 		sigprocmask(SIG_SETMASK, &current->saved_sigmask, NULL);
 	}
-
-	return 0;
 }
 
 asmlinkage int sys32_rt_sigaction(int sig, const struct sigaction32 *act,

-- 
Martin Michlmayr
http://www.cyrius.com/
