Received:  by oss.sgi.com id <S305157AbQCQSRr>;
	Fri, 17 Mar 2000 10:17:47 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:53366 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQCQSR3>; Fri, 17 Mar 2000 10:17:29 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id KAA03129; Fri, 17 Mar 2000 10:20:54 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA84981
	for linux-list;
	Fri, 17 Mar 2000 10:02:58 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA82666;
	Fri, 17 Mar 2000 10:02:56 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id KAA08491;
	Fri, 17 Mar 2000 10:02:56 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14546.29520.79790.413087@liveoak.engr.sgi.com>
Date:   Fri, 17 Mar 2000 10:02:56 -0800 (PST)
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     "SGI Linux Alias" <linux@cthulhu.engr.sgi.com>
Subject: Re: Include coherency problem, sigaction and otherwise
In-Reply-To: <00b801bf902c$ddb30140$0ceca8c0@satanas.mips.com>
References: <00b801bf902c$ddb30140$0ceca8c0@satanas.mips.com>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Kevin D. Kissell writes:
 > Invesitgating some non-fatal but odd behaviour, we
 > have traced it to the fact that the defintions of various
 > sigaction flags are defined for MIPS/Linux user code
 > in /usr/include/sigaction.h, but defined for the kernel in
 > /usr/include/asm/signal.h, and that the two definitions
 > are not consistent.  Does anyone know how this
 > came about?  
 > 
 > I have the impresson that the /usr/include stuff in the 
 > "Hard Hat" distribution for MIPS is keyed to a 2.0.x kernel, 
 > and that an update of /usr/include (as opposed to a downgrade 
 > of the kernel headers) may be in order.    Frankly, I don't like 
 > the fact that the user and kernel includes don't pull everything 
 > out of common files in include/linux and include/asm - I suppose 
 > it must have been to reduce the number of compilations
 > that depend on kernel includes - but I don't see that
 > we can do much about that from here in MIPS-land.

      As near as I can tell, at least for glibc-2.1.1-7, there
is not machine-dependent <bits/sigaction.h> for mips, so the
generic one is used, and the definitions are incompatible with the
MIPS ABI.  The Linux kernel, on the other hand, is compatible with the
MIPS ABI.  The cure is to supply a MIPS-specific <bits/sigaction.h>.
In particular, we need for mips:

/* Bits in `sa_flags'.  */
#if defined __USE_UNIX98 || defined __USE_MISC
# define SA_ONSTACK	0x0001	/* Take signal on signal stack.  */
# define SA_RESTART	0x0004	/* Restart syscall on signal return.  */
#endif
#define	SA_NOCLDSTOP	0x20000	/* Don't send SIGCHLD when children stop.  */

instead of the generic:

/* Bits in `sa_flags'.  */
#if defined __USE_UNIX98 || defined __USE_MISC
# define SA_ONSTACK	0x0001	/* Take signal on signal stack.  */
# define SA_RESTART	0x0002	/* Restart syscall on signal return.  */
#endif
#define	SA_NOCLDSTOP	0x0008	/* Don't send SIGCHLD when children stop.  */

This is just a symptom of the somewhat weak MIPS support in glibc and
binutils.

The generic source file is 

    glibc/sysdeps/generic/bits/sigaction.h

and the MIPS source file would be

    glibc/sysdeps/mips/bits/sigaction.h

THere are probably other incompatibilities to be weeded out.
