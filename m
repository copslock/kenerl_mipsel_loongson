Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Feb 2003 06:30:23 +0000 (GMT)
Received: from zok.SGI.COM ([IPv6:::ffff:204.94.215.101]:48049 "EHLO
	zok.sgi.com") by linux-mips.org with ESMTP id <S8225223AbTBDGaX>;
	Tue, 4 Feb 2003 06:30:23 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by zok.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h145bCKp029649;
	Mon, 3 Feb 2003 21:37:13 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id RAA17577; Tue, 4 Feb 2003 17:30:14 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h146TlMd027359;
	Tue, 4 Feb 2003 17:29:48 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h146TiTu027357;
	Tue, 4 Feb 2003 17:29:44 +1100
Date: Tue, 4 Feb 2003 17:29:44 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: wakkerma@debian.org
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Subject: [patch] remove bogus "struct sigaction"
Message-ID: <20030204062944.GC27302@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

Hi Wichert,

Somebody made their own "struct new_sigaction".  God knows why.

It should be #ifdef'd if it's actually useful to someone (right?),
but it's incompatible with linux-mips.  My patch... using the
struct sigaction out of the standard #includes... Works For Me TM.

Cheers,
Andrew


diff -rpu strace-4.4/signal.c strace-4.4-fixed/signal.c
--- strace-4.4/signal.c	Sun Aug 19 22:06:50 2001
+++ strace-4.4-fixed/signal.c	Thu Jan 23 23:30:59 2003
@@ -1363,26 +1363,11 @@ typedef struct siginfo
 } siginfo_t;
 #endif
 
-/* Structure describing the action to be taken when a signal arrives.  */
-struct new_sigaction
-{
-	union
-	{
-		__sighandler_t __sa_handler;
-		void (*__sa_sigaction) (int, siginfo_t *, void *);
-	}
-	__sigaction_handler;
-	unsigned long sa_flags;
-	void (*sa_restorer) (void);
-	unsigned long int sa_mask[2];
-};
-
-
 	int
 sys_rt_sigaction(tcp)
 	struct tcb *tcp;
 {
-	struct new_sigaction sa;
+	struct sigaction sa;
 	sigset_t sigset;
 	long addr;
 
@@ -1399,7 +1384,7 @@ sys_rt_sigaction(tcp)
 	else if (umove(tcp, addr, &sa) < 0)
 		tprintf("{...}");
 	else {
-		switch ((long) sa.__sigaction_handler.__sa_handler) {
+		switch ((long) sa.sa_handler) {
 			case (long) SIG_ERR:
 				tprintf("{SIG_ERR}");
 				break;
@@ -1410,8 +1395,7 @@ sys_rt_sigaction(tcp)
 				tprintf("{SIG_IGN}");
 				break;
 			default:
-				tprintf("{%#lx, ",
-						(long) sa.__sigaction_handler.__sa_handler);
+				tprintf("{%#lx, ", (long) sa.sa_handler);
 				sigemptyset(&sigset);
 #ifdef LINUXSPARC
 				if (tcp->u_arg[4] <= sizeof(sigset))
