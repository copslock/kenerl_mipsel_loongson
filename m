Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Feb 2005 14:05:49 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:61197 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225373AbVBWOFd>; Wed, 23 Feb 2005 14:05:33 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 320ABF5978; Wed, 23 Feb 2005 15:05:24 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 00898-04; Wed, 23 Feb 2005 15:05:24 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id E0E3AE1CB4; Wed, 23 Feb 2005 15:05:23 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j1NE5MQW018863;
	Wed, 23 Feb 2005 15:05:22 +0100
Date:	Wed, 23 Feb 2005 14:05:28 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>, libc-alpha@sources.redhat.com
Cc:	Jim Gifford <maillist@jg555.com>, linux-mips@linux-mips.org
Subject: Re: Building GLIBC 2.3.4 on MIPS
In-Reply-To: <421BD616.4030101@avtrex.com>
Message-ID: <Pine.LNX.4.61L.0502231300200.11922@blysk.ds.pg.gda.pl>
References: <421BCF34.90308@jg555.com> <421BD616.4030101@avtrex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/700/Fri Feb  4 00:33:15 2005
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 22 Feb 2005, David Daney wrote:

> > I'm trying to build the current glibc with my RaQ2, everything builds ok,
> > until I start compiling strace.
> > 
> > syscall.c: In function `dumpio':
> > syscall.c:449: error: `SYS_read' undeclared (first use in this function)
> > syscall.c:449: error: (Each undeclared identifier is reported only once
> > syscall.c:449: error: for each function it appears in.)
> > syscall.c:465: error: `SYS_write' undeclared (first use in this function)
> > syscall.c: In function `syscall_fixup':
> > syscall.c:1265: warning: unused variable `pid'
> > syscall.c: In function `trace_syscall':
> > syscall.c:2481: error: `SYS_exit' undeclared (first use in this function)
> > make[1]: *** [syscall.o] Error 1
> > make[1]: Leaving directory `/usr/src/strace-4.5.9'
> > make: *** [all] Error 2
> > 
> > Which leads me to check syscall.h, then I noticed a big difference from
> > my x86 version to this version, all the SYS_ entries are missing.  Did I
> > build it wrong or is this a glibc issue, due to the addition of the
> > mips32 and mips64 directories.
> > 
> > Here is my bug report with the glibc folks for everyone's reference.
> > http://sources.redhat.com/bugzilla/show_bug.cgi?id=758
> > 
> 
> 
> It seems that you might need some (but not all) of the patch I posted here:
> 
> http://www.linux-mips.org/archives/linux-mips/2004-10/msg00068.html
> 
> Specifically I think you will need at least the parts that add
> 
> #include <sgidefs.h>
> 
> To many of the .h files.  Basically any file that uses the symbol _MIPS_SIM
> and friends needs to either directly or indirectly include sgidefs.h
> 
> You may also need:
> 
> http://www.linux-mips.org/archives/linux-mips/2004-10/msg00142.html
> 
> And something like this:
> 
> http://sources.redhat.com/ml/libc-alpha/2004-11/msg00165.html

 The culprit is elsewhere.  The glibc's syscall number translator script 
doesn't work with asm-mips/unistd.h as of Linux 2.6 (you could have 
probably used 2.4 headers instead; I'm not sure if that is compatible with 
"--enable-kernel=2.6.0", though).  A correct fix has been prepared and 
proposed by Richard Sandiford and is available here: 
"http://sourceware.org/ml/libc-alpha/2004-11/msg00097.html".  I would 
expect this patch to have been applied before 2.3.4, but apparently this 
hasn't happened.  That's regrettable and I fear it's the result of glibc 
being somewhat inadequately maintained for MIPS/Linux these days, sigh...

 I'm not sure what the maintenance plan is for the 2.3 branch of glibc, 
but if 2.3.5 is ever going to happen, the Richard's patch is one of the 
must-have additions.

  Maciej
