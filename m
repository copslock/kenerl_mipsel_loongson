Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3OEr2b21446
	for linux-mips-outgoing; Tue, 24 Apr 2001 07:53:02 -0700
Received: from colo.asti-usa.com (IDENT:root@colo.asti-usa.com [205.252.89.99])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3OEr1M21443
	for <linux-mips@oss.sgi.com>; Tue, 24 Apr 2001 07:53:01 -0700
Received: from lineo.com (hal.uk.zentropix.com [212.74.13.151])
	by colo.asti-usa.com (8.9.3/8.9.3) with ESMTP id LAA29765;
	Tue, 24 Apr 2001 11:01:23 -0400
Message-ID: <3AE5943A.E1B91C25@lineo.com>
Date: Tue, 24 Apr 2001 15:56:58 +0100
From: Ian Soanes <ians@lineo.com>
Organization: Lineo UK
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Rivers <rivers@lexmark.com>
CC: Fabrice Bellard <bellard@email.enst.fr>, linux-mips@oss.sgi.com
Subject: Re: gdb single step ?
References: <Pine.GSO.4.02.10104241544480.9515-100000@donjuan.enst.fr> <3AE588AA.5874E870@lineo.com> <200104241438.KAA00987@interlock2.lexmark.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Martin,

I seem to have confused everyone (including myself)...

I'm also talking about user mode... my references to the kernel stub
code only refer to the single_step() function... I borrowed and adapted
it for use in gdbserver... for user mode.

Sorry, I'll go and stand in the corner for a while...
Ian

Martin Rivers wrote:
> 
> Ian,
> 
> I'm confused.  The gdbserver stuff I gave you was all directed at user mode
> stuff too.  I don't do any kernel debug with gdbserver.
> 
> martin
> 
> >
> > Fabrice Bellard wrote:
> > >
> > > Hi!
> > >
> > > I was speaking about gdb support in user mode, not the gdb stub in the
> > > kernel. Does someone use gdb to debug user space programs on linux-mips ?
> > > Maybe someone added the PTRACE_SINGLESTEP command of the ptrace syscall in
> > > recent mips kernel, but I do not have it in my kernel (linux-2.4.0 on sgi
> > > site).
> > >
> > > I patched gdb 5.0 so that single step on mips is correctly supported in
> > > user mode. I also modified gdbserver so that it works when you debug mips
> > > code in user mode.
> > >
> >
> > <snip>
> >
> > Hi Fabrice,
> >
> > I know you meant user mode... it's just that I had some success adapting
> > the kernel stub code for use in Martin's gdbserver for debugging user
> > mode code. I guess now we have 2 gdbservers :-)
> >
> > Best regards,
> > Ian
