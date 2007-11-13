Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2007 14:03:44 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:64134 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026526AbXKMODm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Nov 2007 14:03:42 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lADE0bJQ007714;
	Tue, 13 Nov 2007 14:00:57 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lADE0aD7007713;
	Tue, 13 Nov 2007 14:00:36 GMT
Date:	Tue, 13 Nov 2007 14:00:36 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Andrew Haley <aph-gcc@littlepinkcloud.com>,
	David Daney <ddaney@avtrex.com>, linux-mips@linux-mips.org,
	Richard Sandiford <rsandifo@nildram.co.uk>, gcc@gcc.gnu.org
Subject: Re: Cannot unwind through MIPS signal frames with
	ICACHE_REFILLS_WORKAROUND_WAR
Message-ID: <20071113140036.GA7650@linux-mips.org>
References: <473957B6.3030202@avtrex.com> <18233.36645.232058.964652@zebedee.pink> <20071113121036.GA6582@linux-mips.org> <cda58cb80711130514x16356ea3x4069616c9ee3caac@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80711130514x16356ea3x4069616c9ee3caac@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 13, 2007 at 02:14:58PM +0100, Franck Bui-Huu wrote:

> > > David Daney writes:
> > >  > With the current kernel (2.6.23.1) in my R5000 based O2 it seems
> > >  > impossible for GCC's exception unwinding machinery to unwind through
> > >  > signal frames.  The cause of the problems is the
> > >  > ICACHE_REFILLS_WORKAROUND_WAR which puts the sigcontext at an almost
> > >  > impossible to determine offset from the signal return trampoline.  The
> > >  > unwinder depends on being able to find the sigcontext given a known
> > >  > location of the trampoline.
> > >  >
> > >  > It seems there are a couple of possible solutions:
> > >  >
> > >  > 1) The comments in war.h indicate the problem only exists in R7000
> > >  > and E9000 processors.  We could turn off the workaround if the
> > >  > kernel is configured for R5000.  That would help me, but not those
> > >  > with the effected systems.
> > >  >
> > >  > 2) In the non-workaround case, the siginfo immediately follows the
> > >  > trampoline and the first member is the signal number.  For the
> > >  > workaround case the first word following the trampoline is zero.
> > >  > We could replace this with the offset to the sigcontext which is
> > >  > always a small negative value.  The unwinder could then distinguish
> > >  > the two cases (signal numbers are positive and the offset
> > >  > negative).  If we did this, the change would have to be coordinated
> > >  > with GCC's unwinder (in libgcc_s.so.1).
> > >  >
> > >  > Thoughts?
> > >
> > > The best solution is to put the unwinder info in the kernel.  Does
> > > MIPS use a vDSO ?
> >
> > No though we should.
> >
> > Another reason is to get rid of the classic trampoline the kernel installs
> > on the stack.  On some multiprocessor systems it requires a cacheflush
> > operation to be performed on all processors which is expensive.  Having
> > the trampoline in a vDSO would solve that.
> >
> 
> And the stack wouldn't need to have exec permission anymore.

Oh?

extern void frob(void (*)(void));

int foo(void)
{
	int x;

	void bar(void)
	{
		x++;
	}

	frob(&bar);
	print("x is %d\n", x);
}

Compile and enjoy.

  Ralf
