Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2007 14:22:44 +0000 (GMT)
Received: from wa-out-1112.google.com ([209.85.146.181]:17114 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20026595AbXKMOWg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Nov 2007 14:22:36 +0000
Received: by wa-out-1112.google.com with SMTP id m16so1928597waf
        for <linux-mips@linux-mips.org>; Tue, 13 Nov 2007 06:22:33 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=sQ3GpZ4vug4Vtccj2keecegQirki9C/rqb9NIXF6mnM=;
        b=SYHq9hmi/2eXj3ZwMlrNYmvkEJaNicm2tOIm3qCUavmRyyzo0o2O3eKfyCphVD0E2EwxMzvWmj2DWpH86q35C4JAaBL1TSdLt9Bi/HfBad0zY1PWnvmeAse3Q8bH4jIqObNLs+JeKxaJv3SNOlPkDc+Ow8xAtcbTmNNapajWSr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S+rX8YT2U0gUVzKoCqvrO8mOWZjyIbxY1I7+3Qu5nm18p88LPVmHldztYKPD2nySTLuTLjyo3TtxcX+qJurXCAhyzlBHkJ+Inv7lf82oY97gi3Y42DOiSGkbU97nP6aIbel4hANdmgCgZxMQ/uTvEoo1pCSe/E+8HltSLo/uM5s=
Received: by 10.114.79.1 with SMTP id c1mr164621wab.1194963753816;
        Tue, 13 Nov 2007 06:22:33 -0800 (PST)
Received: by 10.35.80.12 with HTTP; Tue, 13 Nov 2007 06:22:33 -0800 (PST)
Message-ID: <cda58cb80711130622u7ef77870iae407f7c8054e9da@mail.gmail.com>
Date:	Tue, 13 Nov 2007 15:22:33 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: Cannot unwind through MIPS signal frames with ICACHE_REFILLS_WORKAROUND_WAR
Cc:	"Andrew Haley" <aph-gcc@littlepinkcloud.com>,
	"David Daney" <ddaney@avtrex.com>, linux-mips@linux-mips.org,
	"Richard Sandiford" <rsandifo@nildram.co.uk>, gcc@gcc.gnu.org
In-Reply-To: <20071113140036.GA7650@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <473957B6.3030202@avtrex.com>
	 <18233.36645.232058.964652@zebedee.pink>
	 <20071113121036.GA6582@linux-mips.org>
	 <cda58cb80711130514x16356ea3x4069616c9ee3caac@mail.gmail.com>
	 <20071113140036.GA7650@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On Nov 13, 2007 3:00 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
>
> On Tue, Nov 13, 2007 at 02:14:58PM +0100, Franck Bui-Huu wrote:
>
> > > > David Daney writes:
> > > >  > With the current kernel (2.6.23.1) in my R5000 based O2 it seems
> > > >  > impossible for GCC's exception unwinding machinery to unwind through
> > > >  > signal frames.  The cause of the problems is the
> > > >  > ICACHE_REFILLS_WORKAROUND_WAR which puts the sigcontext at an almost
> > > >  > impossible to determine offset from the signal return trampoline.  The
> > > >  > unwinder depends on being able to find the sigcontext given a known
> > > >  > location of the trampoline.
> > > >  >
> > > >  > It seems there are a couple of possible solutions:
> > > >  >
> > > >  > 1) The comments in war.h indicate the problem only exists in R7000
> > > >  > and E9000 processors.  We could turn off the workaround if the
> > > >  > kernel is configured for R5000.  That would help me, but not those
> > > >  > with the effected systems.
> > > >  >
> > > >  > 2) In the non-workaround case, the siginfo immediately follows the
> > > >  > trampoline and the first member is the signal number.  For the
> > > >  > workaround case the first word following the trampoline is zero.
> > > >  > We could replace this with the offset to the sigcontext which is
> > > >  > always a small negative value.  The unwinder could then distinguish
> > > >  > the two cases (signal numbers are positive and the offset
> > > >  > negative).  If we did this, the change would have to be coordinated
> > > >  > with GCC's unwinder (in libgcc_s.so.1).
> > > >  >
> > > >  > Thoughts?
> > > >
> > > > The best solution is to put the unwinder info in the kernel.  Does
> > > > MIPS use a vDSO ?
> > >
> > > No though we should.
> > >
> > > Another reason is to get rid of the classic trampoline the kernel installs
> > > on the stack.  On some multiprocessor systems it requires a cacheflush
> > > operation to be performed on all processors which is expensive.  Having
> > > the trampoline in a vDSO would solve that.
> > >
> >
> > And the stack wouldn't need to have exec permission anymore.
>
> Oh?
>
> extern void frob(void (*)(void));
>
> int foo(void)
> {
>         int x;
>
>         void bar(void)
>         {
>                 x++;
>         }
>
>         frob(&bar);
>         print("x is %d\n", x);
> }
>
> Compile and enjoy.
>

Sorry Ralf, I missed your point.

-- 
               Franck
