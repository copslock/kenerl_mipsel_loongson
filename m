Received:  by oss.sgi.com id <S553831AbQKCRzk>;
	Fri, 3 Nov 2000 09:55:40 -0800
Received: from gateway-490.mvista.com ([63.192.220.206]:21499 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553784AbQKCRza>;
	Fri, 3 Nov 2000 09:55:30 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id eA3HrT317793;
	Fri, 3 Nov 2000 09:53:29 -0800
Message-ID: <3A02FC13.338F4CF6@mvista.com>
Date:   Fri, 03 Nov 2000 09:55:31 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     "Kevin D. Kissell" <kevink@mips.com>
CC:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: "Setting flush to zero for ..." - what is the warning?
References: <3A0067C5.BA9E3174@mvista.com> <20001102040657.A17786@bacchus.dhis.org> <007d01c04585$25262e40$0deca8c0@Ulysses>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

"Kevin D. Kissell" wrote:
> 
> > On Wed, Nov 01, 2000 at 10:58:13AM -0800, Jun Sun wrote:
> >
> > > I ran some stress tests and start to get this warning.  It appears to be
> > > generated in do_fpe() routine.  See below.  I wonder why this is
> > > happening.  Can someone explain what is going on?  Thanks.
> >
> > It tells you the over-the-thumb-fp-mode has been activated ;-)
> 
> More seriously, there was (is, in 2.4 I guess) a hack by which,
> in a desperate attempt to avoid having to do the FP emulation
> in software, the kernel changed the FPU denorm handling mode
> and replayed the instruction, in hopes that the problem would
> go away (which it would for a subset of the unimplemented
> operation cases). This is not legal IEEE behaviour, as it turns out,
> but not many people cared.
>

I am reading between the lines.  Do you mean

1) even though the CPU (R5432 in this case) has a FPU, some instructions
(or under certain conditions) are NOT supported by the hardware?
2) So in those cases, software should do the job, but the existing 2.4
is not doing it right?
3) Can we summarize exactly what instructions (under what conditions)
are considered not supported by hardware?  Or is it too complicated to
summarieze in short?  Or should it be documented in CPU manual (which
may vary for different CPUs)

 
> > Somebody at MIPS is working on merging the necessary fp support software
> > into the kernel, so this problem should be solved soon.
> 
> Once we had bolted the Algorithmics FPU emulator into the kernel,
> the hack was no longer necessary.   To say that "somebody at MIPS
> is working on merging the necessary fp support software into the
> kernel" is perhaps a bit misleading.  The FPU emulator itself is in
> the oss.sgi.com repository, in the 2_2 branch, but I did not merge
> in the hacks to the kernel exception, context, signal, etc. handling.
> And there are several bug fixes that have been made since then.
> All the additional code is available on the ftp.mips.com server, and
> has been merged by others into 2.3/2.4, most notably by the VrLinux
> guys.
> 

If I understand correctly, FPU emulator is for the case where FPU is
completely absent.  Does it do the job we are talking about here?

Thanks.

Jun  
... totally ignorant about FPU
