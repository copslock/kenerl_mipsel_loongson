Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g152waS09788
	for linux-mips-outgoing; Mon, 4 Feb 2002 18:58:36 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g152wRA09781
	for <linux-mips@oss.sgi.com>; Mon, 4 Feb 2002 18:58:27 -0800
Received: from drow by nevyn.them.org with local (Exim 3.34 #1 (Debian))
	id 16Xvo4-0000Yy-00; Mon, 04 Feb 2002 21:58:04 -0500
Date: Mon, 4 Feb 2002 21:58:04 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Dominic Sweetman <dom@algor.co.uk>,
   GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
Message-ID: <20020204215804.A2095@nevyn.them.org>
Mail-Followup-To: "H . J . Lu" <hjl@lucon.org>,
	Dominic Sweetman <dom@algor.co.uk>,
	GNU C Library <libc-alpha@sources.redhat.com>,
	linux-mips@oss.sgi.com
References: <20020201151513.A15913@lucon.org> <20020201222657.A13339@nevyn.them.org> <1012676003.1563.6.camel@xyzzy.stargate.net> <20020202120354.A1522@lucon.org> <mailpost.1012680250.7159@news-sj1-1> <yov5ofj65elj.fsf@broadcom.com> <15454.22661.855423.532827@gladsmuir.algor.co.uk> <20020204083115.C13384@lucon.org> <15454.47823.837119.847975@gladsmuir.algor.co.uk> <20020204172857.A22337@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020204172857.A22337@lucon.org>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Feb 04, 2002 at 05:28:57PM -0800, H . J . Lu wrote:
> On Mon, Feb 04, 2002 at 04:46:07PM +0000, Dominic Sweetman wrote:
> > 
> > H . J . Lu (hjl@lucon.org) writes:
> > 
> > > I can change glibc not to use branch-likely without using nop. But it
> > > may require one or two instructions outside of the loop. Should I do
> > > it given what we know now?
> > 
> > I would not recommend using "branch likely" in assembler coding, if
> > that's what you're asking.
> > 
> 
> Here is a patch to remove branch likely. But I couldn't find a way
> not to fill the delay slot with nop. BTW, is that safe to remove
> ".set noreorder"?

You mean, if there is nothing which can be put there?  Yes, it's safe.

> --- libc/linuxthreads/sysdeps/mips/pspinlock.c.llsc	Mon Feb  4 13:45:01 2002
> +++ libc/linuxthreads/sysdeps/mips/pspinlock.c	Mon Feb  4 17:09:02 2002
> @@ -40,7 +40,7 @@ __pthread_spin_lock (pthread_spinlock_t 
>       "bnez	%1,1b\n\t"
>       " li	%2,1\n\t"
>       "sc	%2,%0\n\t"
> -     "beqzl	%2,1b\n\t"
> +     "beqz	%2,1b\n\t"
>       " ll	%1,%3\n\t"
>       ".set	pop"
>       : "=m" (*lock), "=&r" (tmp1), "=&r" (tmp2)

Is that really what you meant to do?  The ll is now in the delay slot
of the beqz.

> --- libc/linuxthreads/sysdeps/mips/pt-machine.h.llsc	Mon Feb  4 13:45:01 2002
> +++ libc/linuxthreads/sysdeps/mips/pt-machine.h	Mon Feb  4 17:09:36 2002
> @@ -66,7 +66,7 @@ __compare_and_swap (long int *p, long in
>       " move	%0,$0\n\t"
>       "move	%0,%4\n\t"
>       "sc	%0,%2\n\t"
> -     "beqzl	%0,1b\n\t"
> +     "beqz	%0,1b\n\t"
>       " ll	%1,%5\n\t"
>       ".set	pop\n"
>       "2:\n\t"

Ditto.


> @@ -89,7 +89,7 @@ compare_and_swap (volatile long int *p, 
>       " move	%0,$0\n\t"
>       "move	%0,%4\n\t"
>       "sc	%0,%2\n\t"
> -     "beqzl	%0,1b\n\t"
> +     "beqz	%0,1b\n\t"
>       " ll	%1,%5\n\t"
>       ".set	pop\n"
>       "2:\n\t"

Ditto.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
