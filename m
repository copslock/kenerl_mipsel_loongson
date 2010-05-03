Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 May 2010 22:47:49 +0200 (CEST)
Received: from gateway06.websitewelcome.com ([67.18.55.3]:49384 "HELO
        gateway06.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492086Ab0ECUrp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 May 2010 22:47:45 +0200
Received: (qmail 4716 invoked from network); 3 May 2010 20:51:36 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway06.websitewelcome.com with SMTP; 3 May 2010 20:51:36 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=SqLlIE6wVtHL6P/lfTCgpPIsJxbaQlcgEEzbBU4BWNIQKozwI0OPNJAHSRTk9n1XwwVfhtacP3Rw4IWP21xJ8aVtriL1dg/aZazDXgy2+fqcgd8cK7otH8gYv9EtFS3F;
Received: from 216-239-45-4.google.com ([216.239.45.4]:9164 helo=epiktistes.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1O92Y9-0004XK-1B; Mon, 03 May 2010 15:47:33 -0500
Message-ID: <4BDF366E.5000501@paralogos.com>
Date:   Mon, 03 May 2010 13:47:42 -0700
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.24 (X11/20100317)
MIME-Version: 1.0
To:     Shane McDonald <mcdonald.shane@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Unexpected behaviour when catching SIGFPE on FPU-less system
References: <E1O8lDn-0000Sk-86@localhost>
In-Reply-To: <E1O8lDn-0000Sk-86@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Sorry about my previous message having escaped with no value added.

I think you need to look at just what it is that your feclearexcept() 
does.  From the strace information, it looks as if it may be that the 
FPU emulator is erroneously throwing an exception in response to some 
manipulation of the emulated FPU registers by feclearexcept(), so that 
it's taking a second FP exception within the signal handler.  That's the 
simplest explanation for the macroscopic behavior, anyway.

          Regards,

          Kevin K.

Shane McDonald wrote:
> I have run into some strange behaviour involving using the FPU
> emulation software in the MIPS kernel when trying to handle
> a divide-by-zero-caused floating point exception.
>
> I have come up with a simple test case to demonstrate this problem.
> --
> #include <stdio.h>
> #include <stdlib.h>
> #include <signal.h>
> #include <fenv.h>
> #include <setjmp.h>
>
> void fpe_handler(int);
>
> jmp_buf env;
>
> main()
> {
> 	double x;
>
> 	feenableexcept( FE_DIVBYZERO );
> 	signal( SIGFPE, fpe_handler );
>
> 	if ( setjmp( env ) == 0 )
> 	{
> 		printf( "About to try calculation\n" );
> 	
> 		x = 5.0 / 0.0;
> 		printf( "Value is %f\n", x );
> 	}
> 	else
> 	{
> 		printf( "Calculation causes divide by zero\n" );
> 	}
> }
>
> void fpe_handler(int x)
> {
> 	feclearexcept( FE_DIVBYZERO );
> 	longjmp( env, 1 );
> }
> --
>
> The program sets up to generate a SIGFPE when a divide-by-zero occurs,
> rather than setting the result to infinity.  Then, I've created a
> handler to catch the exception, and the end result is to print out
> the "Calculation causes divide by zero" message.
>
> I have two MIPS-based systems, both running Debian Etch.  One of the
> systems is a PMC-Sierra RM7035C-based system, which includes an FPU.  My
> other system is a PMC-Sierra MSP7120-based system, which does not
> include an FPU.  The RM7035C system is running the 2.6.34-rc6 kernel,
> but the MSP7120 system is running 2.6.28.
>
> When I run this program on the system with the FPU, I see the results
> that I expect to see.  The program outputs:
>
>     About to try calculation
>     Calculation causes divide by zero
>
> I see the same results when I run the program on an x86 Debian Etch system.
>
> When I run the program on the system without the FPU, I see:
>
>     About to try calculation
>     Floating point exception
>
> So, it appears that the floating point exception is not caught.
> However, when I run strace, the last few lines of output are:
>
>     old_mmap(NULL, 65536, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2ace9000
>     write(1, "About to try calculation\n"..., 25About to try calculation
>     ) = 25
>     --- SIGFPE (Floating point exception) @ 0 (0) ---
>     --- SIGFPE (Floating point exception) @ 0 (0) ---
>     +++ killed by SIGFPE +++
>
> Running it on the system with the FPU, I see:
>
>     old_mmap(NULL, 65536, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2ace5000
>     write(1, "About to try calculation\n"..., 25About to try calculation
>     ) = 25
>     --- SIGFPE (Floating point exception) @ 0 (0) ---
>     write(1, "Calculation causes divide by zero"..., 34Calculation causes divide by zero
>     ) = 34
>     exit_group(34)                          = ?
>
> After poking around for a while, and trying to account for differences
> between the systems (endianness, FPUness, kernel version), I believe the
> problem is related to the lack of FPU.  If I run the RM7035C with a
> disabled FPU (kernel parameter nofpu), I see the same results as on
> the FPU-less MSP7120.  So, I suspect this difference in behaviour
> is caused by the FPU emulation software.
>
> Now, I don't know if this is a problem, but it does seem strange.
> My level of understanding of the FPU emulation software is very low,
> so I'm not quite sure where to look.
>
> This isn't actually something that I typically do.  I noticed this
> problem when trying to understand why the Debian package "yorick"
> failed to build (see
> http://lists.debian.org/debian-mips/2010/04/msg00019.html).
>
> I'd appreciate any insight that anyone can provide.  Thanks!
>
> Shane McDonald
>
>   
