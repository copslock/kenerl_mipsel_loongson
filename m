Received:  by oss.sgi.com id <S553696AbRBGTjY>;
	Wed, 7 Feb 2001 11:39:24 -0800
Received: from [12.44.186.158] ([12.44.186.158]:1275 "EHLO hermes.mvista.com")
	by oss.sgi.com with ESMTP id <S553691AbRBGTjI>;
	Wed, 7 Feb 2001 11:39:08 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f17JYr820473;
	Wed, 7 Feb 2001 11:34:53 -0800
Message-ID: <3A81A3DC.E75E6045@mvista.com>
Date:   Wed, 07 Feb 2001 11:37:00 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Alan Cox <alan@lxorguk.ukuu.org.uk>
CC:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com,
        ralf@oss.sgi.com
Subject: Re: NON FPU cpus - way to go
References: <E14QZie-00011I-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Alan Cox wrote:
> 
> >  The i386 way seems reasonable, IMHO.  Have a configure option to enable
> > an FPU emulator.  Panic upon boot if no FP hardware is available and no
> > emulator is compiled in.
> 
> Its an interesting question whether it belongs in the kernel or libc.
> Discuss ;)
> 

I favor the libc approach as it is faster.

Unfortunately I don't think glibc for MIPS can be configured with
--without-fp.  I modified a patch to get glibc 2.0.6 working for no-fp config,
but it is not a clean one.  Is anybody working on that for the latest glibc
2.2?

> Also we missed a trick on the x86 and I want to fix that one day, which is
> to have an __fpu ELF segment so if you boot an FPU emu kernel on an fpu
> box you regain 47K

Ironically for MIPS you MUST have the FPU emulater when the CPU actually has a
FPU. :-)

Jun
