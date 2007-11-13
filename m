Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2007 15:04:52 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:20933 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026717AbXKMPEp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Nov 2007 15:04:45 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lADF1mZV008513;
	Tue, 13 Nov 2007 15:02:08 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lADF1kZ2008512;
	Tue, 13 Nov 2007 15:01:46 GMT
Date:	Tue, 13 Nov 2007 15:01:46 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Andrew Haley <aph-gcc@littlepinkcloud.com>,
	David Daney <ddaney@avtrex.com>, linux-mips@linux-mips.org,
	Richard Sandiford <rsandifo@nildram.co.uk>, gcc@gcc.gnu.org
Subject: Re: Cannot unwind through MIPS signal frames with
	ICACHE_REFILLS_WORKAROUND_WAR
Message-ID: <20071113150146.GC7650@linux-mips.org>
References: <473957B6.3030202@avtrex.com> <18233.36645.232058.964652@zebedee.pink> <20071113121036.GA6582@linux-mips.org> <cda58cb80711130514x16356ea3x4069616c9ee3caac@mail.gmail.com> <20071113140036.GA7650@linux-mips.org> <cda58cb80711130622u7ef77870iae407f7c8054e9da@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80711130622u7ef77870iae407f7c8054e9da@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 13, 2007 at 03:22:33PM +0100, Franck Bui-Huu wrote:

> > > And the stack wouldn't need to have exec permission anymore.
> >
> > Oh?
> >
> > extern void frob(void (*)(void));
> >
> > int foo(void)
> > {
> >         int x;
> >
> >         void bar(void)
> >         {
> >                 x++;
> >         }
> >
> >         frob(&bar);
> >         print("x is %d\n", x);
> > }
> >
> > Compile and enjoy.
> >
> 
> Sorry Ralf, I missed your point.

This piece of code compiles to something that copies a trampoline to the
stack.  The address of that trampoline is what is then passed as argument
to frob().

Old versions of glibc were probable the most notorious users of trampolines.
Objective C also generates them.  Since a cacheflush that is a syscall is
required performance is less than great.

Which means the libc() cacheflush() function is another candidate for a
vDSO, it can be optimized by using SYNCI on some configurations.

  Ralf
