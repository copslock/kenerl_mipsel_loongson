Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBSMNrU10874
	for linux-mips-outgoing; Fri, 28 Dec 2001 14:23:53 -0800
Received: from gans.physik3.uni-rostock.de (gans.physik3.uni-rostock.de [139.30.44.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBSMNkg10871
	for <linux-mips@oss.sgi.com>; Fri, 28 Dec 2001 14:23:47 -0800
Received: (from tim@localhost)
	by gans.physik3.uni-rostock.de (8.11.0/8.11.0/SuSE Linux 8.11.0-0.4) id fBSLNg203506;
	Fri, 28 Dec 2001 22:23:42 +0100
Date: Fri, 28 Dec 2001 22:23:42 +0100
From: Tim Schmielau <tim@physik3.uni-rostock.de>
Message-Id: <200112282123.fBSLNg203506@gans.physik3.uni-rostock.de>
To: ralf@gnu.org
Subject: [patch] fix compares of jiffies
Cc: linux-mips@oss.sgi.com, tim@physik3.uni-rostock.de
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Dear Linux kernel code maintainer,

some weeks ago in the course of a discussion on lkml
(see http://www.uwsg.indiana.edu/hypermail/linux/kernel/0110.3/1553.html
and follow-ups) linux kernels of the 2.4 series turned out to sometime
lock up after 497.1 days of uptime, when the "jiffies" variable wraps
back to zero.

Checking the kernel code, I found a number of places where jiffies
were compared in a way that seems to break when they wrap. For these,
I made up patches to use the macros "time_before()" or "time_after()"
that are supposed to handle wraparound correctly.

For a small part of the patches, I believe you to be the relevant kernel code
maintainer. Appended to this email you will find some lines explaining
why I decided to mail or cc: you on this (an extract of the copyright notice
or the MAINTAINERS file), followed by the patch itself. If I mailed you
in error, please drop me a short note.

I kindly ask you to approve the correctness of the patch, and pass it on to
the relevant people for inclusion into the mainline kernel.

Thanks,
Tim Schmielau (tim@physik3.uni-rostock.de)



MIPS
P:	Ralf Baechle
M:	ralf@gnu.org
W:	http://oss.sgi.com/mips/mips-howto.html
L:	linux-mips@oss.sgi.com
S:	Maintained


--- linux-2.4.18-pre1/arch/mips/baget/vacserial.c	Sun Sep  9 19:43:01 2001
+++ linux-2.4.18-pre1-jiffies64/arch/mips/baget/vacserial.c	Fri Dec 28 14:57:14 2001
@@ -1785,7 +1785,7 @@
 		schedule_timeout(char_time);
 		if (signal_pending(current))
 			break;
-		if (timeout && ((orig_jiffies + timeout) < jiffies))
+		if (timeout && time_after(jiffies, orig_jiffies + timeout))
 			break;
 	}
 	current->state = TASK_RUNNING;
