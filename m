Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4FKJhnC031791
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 15 May 2002 13:19:43 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4FKJhF7031790
	for linux-mips-outgoing; Wed, 15 May 2002 13:19:43 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4FKJQnC031780;
	Wed, 15 May 2002 13:19:26 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id NAA29093;
	Wed, 15 May 2002 13:19:14 -0700
Message-ID: <3CE2C260.5070307@mvista.com>
Date: Wed, 15 May 2002 13:17:36 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, ralf@oss.sgi.com,
   linux-mips@oss.sgi.com, linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] smp sched typo
Content-Type: multipart/mixed;
 boundary="------------000503080306050607030009"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


This is a multi-part message in MIME format.
--------------000503080306050607030009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Linus,

I found this bug in 2.4 kernel. I have verified that the bug exists on MIPS 
SMP and PPC SMP, but not on i386 SMP.  See the detailed explanation inside the 
patch.

2.5 sched.c has been re-written quite a bit and does not have this problem.


http://linux.junsun.net/patches/generic/submitted/020515-2.4.18-smp-sched-typo.patch

Jun


--------------000503080306050607030009
Content-Type: text/plain;
 name="020515-2.4.18-smp-sched-typo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="020515-2.4.18-smp-sched-typo.patch"


Gcc will optimizie out the whole 'if' branch on platforms where
cycles_t is not unsigned long long (such as MIPS, PPC).

The symptom for this bug is not fatal - perhaps that is ther reason
why nobody has found it so far.  Higher priority process will be delayed
to start its execution.  One of my tests shows on a heavy-loaded system 
the delay is about 5 to 6 jiffies.  

Jun, 020515

diff -Nru link/kernel/sched.c.orig link/kernel/sched.c
--- link/kernel/sched.c.orig	Fri Dec 21 09:42:04 2001
+++ link/kernel/sched.c	Wed May 15 12:38:12 2002
@@ -282,7 +282,7 @@
 				target_tsk = tsk;
 			}
 		} else {
-			if (oldest_idle == -1ULL) {
+			if (oldest_idle == (cycles_t)-1) {
 				int prio = preemption_goodness(tsk, p, cpu);
 
 				if (prio > max_prio) {

--------------000503080306050607030009--
