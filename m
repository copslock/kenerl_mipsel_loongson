Received:  by oss.sgi.com id <S553681AbQJXPOe>;
	Tue, 24 Oct 2000 08:14:34 -0700
Received: from u-117.karlsruhe.ipdial.viaginterkom.de ([62.180.10.117]:51204
        "EHLO u-117.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553742AbQJXPOL>; Tue, 24 Oct 2000 08:14:11 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870348AbQJXPJj>;
        Tue, 24 Oct 2000 17:09:39 +0200
Date:   Tue, 24 Oct 2000 17:09:39 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     K.H.C.vanHouten@kpn.com
Cc:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: process lockups
Message-ID: <20001024170939.C7342@bacchus.dhis.org>
References: <20001024044736.B3397@bacchus.dhis.org> <200010240551.HAA02069@sparta.research.kpn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200010240551.HAA02069@sparta.research.kpn.com>; from K.H.C.vanHouten@research.kpn.com on Tue, Oct 24, 2000 at 07:51:42AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Oct 24, 2000 at 07:51:42AM +0200, Houten K.H.C. van (Karel) wrote:

> Aside from this I stil get 'bug in get_wchan' messages, but everything
> seems to run fine. I hope to test my current kernels on a 5000/150 and
> a 3100.

Try this untested fix for get_wchan.  The values in the ps axl column should
now be numbers that make sense as addresses.  Unless the `n' option is
also used ps will try to translate the address back into a symbol.  Cite
from ps(1):

[...]
       To  produce  the  WCHAN  field,  ps needs to read the Sys­
       tem.map file created when  the  kernel  is  compiled.  The
       search path is:
              $PS_SYSTEM_MAP
              /boot/System.map-`uname -r`
              /boot/System.map
              /lib/modules/`uname -r`/System.map
              /usr/src/linux/System.map
              /System.map
[...]

If that's working as planned please send me the WCHAN of any stuck process.
I need to know where they're stuck.

  Ralf

--- arch/mips/kernel/process.c	2000/10/05 01:18:43	1.21
+++ arch/mips/kernel/process.c	2000/10/24 14:54:29
@@ -203,18 +203,9 @@
 		return 0;
 
 	pc = thread_saved_pc(&p->thread);
-	if (pc == (unsigned long) interruptible_sleep_on
-	    || pc == (unsigned long) sleep_on) {
-		schedule_frame = ((unsigned long *)p->thread.reg30)[9];
-		return ((unsigned long *)schedule_frame)[15];
-	}
-	if (pc == (unsigned long) interruptible_sleep_on_timeout
-	    || pc == (unsigned long) sleep_on_timeout) {
-		schedule_frame = ((unsigned long *)p->thread.reg30)[9];
-		return ((unsigned long *)schedule_frame)[16];
-	}
 	if (pc >= first_sched && pc < last_sched) {
-		printk(KERN_DEBUG "Bug in %s\n", __FUNCTION__);
+		schedule_frame = ((unsigned long *)p->thread.reg30)[9];
+		return ((unsigned long *)schedule_frame)[11];
 	}
 
 	return pc;
