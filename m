Received:  by oss.sgi.com id <S553798AbRAOGUz>;
	Sun, 14 Jan 2001 22:20:55 -0800
Received: from ns4.Sony.CO.JP ([202.238.80.4]:17926 "EHLO ns4.sony.co.jp")
	by oss.sgi.com with ESMTP id <S553793AbRAOGUq>;
	Sun, 14 Jan 2001 22:20:46 -0800
Received: from mail3.sony.co.jp (gatekeeper10.Sony.CO.JP [202.238.80.24])
	by ns4.sony.co.jp (R8) with ESMTP id PAA74200;
	Mon, 15 Jan 2001 15:20:43 +0900 (JST)
Received: from mail3.sony.co.jp (localhost [127.0.0.1])
	by mail3.sony.co.jp (R8) with ESMTP id f0F6Kho25039;
	Mon, 15 Jan 2001 15:20:43 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail3.sony.co.jp (R8) with ESMTP id f0F6KhS25035;
	Mon, 15 Jan 2001 15:20:43 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.27.209.5]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id PAA10741; Mon, 15 Jan 2001 15:21:23 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.27.210.135]) by imail.sm.sony.co.jp (8.8.8/3.7W) with ESMTP id PAA24013; Mon, 15 Jan 2001 15:20:12 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.8.8/FreeBSD) with ESMTP id PAA19005; Mon, 15 Jan 2001 15:20:11 +0900 (JST)
To:     aj@suse.de
CC:     linux-mips@oss.sgi.com
Subject: pthread_sighander() of glibc-2.2 breaks stack
X-Mailer: Mew version 1.94.1 on Emacs 19.34 / Mule 2.3 (SUETSUMUHANA)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010115152011L.machida@sm.sony.co.jp>
Date:   Mon, 15 Jan 2001 15:20:11 +0900
From:   Hiroyuki Machida <machida@sm.sony.co.jp>
X-Dispatcher: imput version 990905(IM130)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Hello Andreas,

I had a experience that pthread_sighander() of current glibc-2.2 
breaks stack. I tracked down the problem, and finally found the
mismatch  between kenrel and glibc-2.2. 

Current kernel pass following args to the signal handler for the 
case of not SA_SIGINFO specified.
	a0	signal number
	a1	0 (cause code?)
	a2	pointer to sigcontext struct

But, the pthread_sighander() of glibc-2.2 expects;
	1st arg.	signal number
	2nd arg.	sigcontext struct itself (not pointer)

Patches attached below. Please apply.

Thanks.

---
Hiroyuki Machida
Creative Station		SCE Inc.


=== ChangeLog entry.

   * sysdeps/unix/sysv/linux/mips/register-dump.h (REGISTER_DUMP):
    Change type of CTX to (struct sigcontext *).

   * sysdeps/unix/sysv/linux/mips/sigcontextinfo.h (GET_PC): Likewise.
    (GET_FRAME): Likewise (GET_STACK): Likewise.
    (SIGCONTEXT): Likewise. Add 2nd arg _CODE.
    (SIGCONTEXT_EXTRA_ARGS): Add 2nd arg _CODE.


===================================================================
--- sysdeps/unix/sysv/linux/mips/register-dump.h.ORG	2000/10/25 05:00:53	1.1
+++ sysdeps/unix/sysv/linux/mips/register-dump.h	2001/01/12 13:03:30	1.2
@@ -105,4 +105,4 @@ register_dump (int fd, struct sigcontext
 }
 
 
-#define REGISTER_DUMP register_dump (fd, &ctx)
+#define REGISTER_DUMP register_dump (fd, ctx)
===================================================================
--- sysdeps/unix/sysv/linux/mips/sigcontextinfo.h.ORG	2000/10/25 05:00:53	1.1
+++ sysdeps/unix/sysv/linux/mips/sigcontextinfo.h	2001/01/12 13:03:31	1.2
@@ -18,8 +18,8 @@
    Boston, MA 02111-1307, USA.  */
 
 
-#define SIGCONTEXT struct sigcontext
-#define SIGCONTEXT_EXTRA_ARGS
-#define GET_PC(ctx)	((void *) ctx.sc_pc)
-#define GET_FRAME(ctx)	((void *) ctx.sc_regs[30])
-#define GET_STACK(ctx)	((void *) ctx.sc_regs[29])
+#define SIGCONTEXT unsigned long _code, struct sigcontext *
+#define SIGCONTEXT_EXTRA_ARGS _code,
+#define GET_PC(ctx)	((void *) ctx->sc_pc)
+#define GET_FRAME(ctx)	((void *) ctx->sc_regs[30])
+#define GET_STACK(ctx)	((void *) ctx->sc_regs[29])
