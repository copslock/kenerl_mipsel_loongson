Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g154gsZ11694
	for linux-mips-outgoing; Mon, 4 Feb 2002 20:42:54 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g154goA11686
	for <linux-mips@oss.sgi.com>; Mon, 4 Feb 2002 20:42:51 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 29CBA125C8; Mon,  4 Feb 2002 20:42:47 -0800 (PST)
Date: Mon, 4 Feb 2002 20:42:47 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Dominic Sweetman <dom@algor.co.uk>,
   GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
Message-ID: <20020204204247.A25254@lucon.org>
References: <20020201222657.A13339@nevyn.them.org> <1012676003.1563.6.camel@xyzzy.stargate.net> <20020202120354.A1522@lucon.org> <mailpost.1012680250.7159@news-sj1-1> <yov5ofj65elj.fsf@broadcom.com> <15454.22661.855423.532827@gladsmuir.algor.co.uk> <20020204083115.C13384@lucon.org> <15454.47823.837119.847975@gladsmuir.algor.co.uk> <20020204172857.A22337@lucon.org> <20020204215804.A2095@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020204215804.A2095@nevyn.them.org>; from dan@debian.org on Mon, Feb 04, 2002 at 09:58:04PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Feb 04, 2002 at 09:58:04PM -0500, Daniel Jacobowitz wrote:
> 
> > --- libc/linuxthreads/sysdeps/mips/pspinlock.c.llsc	Mon Feb  4 13:45:01 2002
> > +++ libc/linuxthreads/sysdeps/mips/pspinlock.c	Mon Feb  4 17:09:02 2002
> > @@ -40,7 +40,7 @@ __pthread_spin_lock (pthread_spinlock_t 
> >       "bnez	%1,1b\n\t"
> >       " li	%2,1\n\t"
> >       "sc	%2,%0\n\t"
> > -     "beqzl	%2,1b\n\t"
> > +     "beqz	%2,1b\n\t"
> >       " ll	%1,%3\n\t"
> >       ".set	pop"
> >       : "=m" (*lock), "=&r" (tmp1), "=&r" (tmp2)
> 
> Is that really what you meant to do?  The ll is now in the delay slot
> of the beqz.

Yes, it is ok since we don't care what ll does if the branch is not
taken.


H.J.
