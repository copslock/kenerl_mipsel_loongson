Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6JM3Jr24723
	for linux-mips-outgoing; Thu, 19 Jul 2001 15:03:19 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6JM3BV24719
	for <linux-mips@oss.sgi.com>; Thu, 19 Jul 2001 15:03:11 -0700
Received: from nevyn.them.org (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA05543
	for <linux-mips@oss.sgi.com>; Thu, 19 Jul 2001 15:02:51 -0700 (PDT)
	mail_from (drow@crack.them.org)
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 15NLDN-0006vL-00; Thu, 19 Jul 2001 14:20:09 -0700
Date: Thu, 19 Jul 2001 14:20:09 -0700
From: Daniel Jacobowitz <dan@debian.org>
To: Florian Lohoff <flo@rfc822.org>
Cc: libc-alpha@sources.redhat.com, Klaus Naumann <spock@mgnet.de>,
   Robert Einsle <robert@einsle.de>, linux-mips@oss.sgi.com
Subject: Re: Probs running ntp on an indy
Message-ID: <20010719142009.A26517@nevyn.them.org>
Mail-Followup-To: Florian Lohoff <flo@rfc822.org>,
	libc-alpha@sources.redhat.com, Klaus Naumann <spock@mgnet.de>,
	Robert Einsle <robert@einsle.de>, linux-mips@oss.sgi.com
References: <20010719192614.A22495@tuvok.allgaeu.org> <Pine.LNX.4.21.0107192223140.8136-100000@spock.mgnet.de> <20010719225137.B1599@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20010719225137.B1599@paradigm.rfc822.org>; from flo@rfc822.org on Thu, Jul 19, 2001 at 10:51:37PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 19, 2001 at 10:51:37PM +0200, Florian Lohoff wrote:
> On Thu, Jul 19, 2001 at 10:24:06PM +0200, Klaus Naumann wrote:
> > I know the problem but no solution. I suspect that it's a
> > problem of the poll function in Big Endian environments, because
> > I can reproduce this on my Indigo2 and on an Ultra 1 as well.
> 
> I remember seeing a patch concerning this problem - Something with
> rtsignals - But i cant seem to find it anymore.

That's probably this one.  I knew I'd let a patch slip.  Glibc folk, is
this OK?  The siginfo struct is different on MIPS.


-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer

--- glibc-2.2.3/sysdeps/unix/sysv/linux/mips/bits/siginfo.h.orig	Thu May 24 15:35:42 2001
+++ glibc-2.2.3/sysdeps/unix/sysv/linux/mips/bits/siginfo.h	Thu May 24 15:35:49 2001
@@ -45,9 +45,9 @@
 typedef struct siginfo
   {
     int si_signo;		/* Signal number.  */
+    int si_code;		/* Signal code.  */
     int si_errno;		/* If non-zero, an errno value associated with
 				   this signal, as defined in <errno.h>.  */
-    int si_code;		/* Signal code.  */
 
     union
       {
