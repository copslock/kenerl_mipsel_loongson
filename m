Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4FNin024262
	for linux-mips-outgoing; Tue, 15 May 2001 16:44:49 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4FNimF24259
	for <linux-mips@oss.sgi.com>; Tue, 15 May 2001 16:44:48 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id QAA26137;
	Tue, 15 May 2001 16:44:39 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id QAA00432;
	Tue, 15 May 2001 16:44:36 -0700 (PDT)
Message-ID: <00bf01c0dd99$9c94b4e0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Tommy S. Christensen" <tommy.christensen@eicon.com>,
   <linux-mips@oss.sgi.com>
References: <3B01A980.7C27BB9F@eicon.com>
Subject: Re: Exception handlers get overwritten
Date: Wed, 16 May 2001 01:48:49 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I don't know who checked in the EJTAG vector stuff,
but a few words of explanation and advice are in order.
MIPS32/MIPS64 CPUs have optional support for 
EJTAG, which introduces a "Debug" mode of
execution which is similar to, but not identical to,
Kernel mode.  The only way into Debug mode is
to take a Debug exception - not to be confused with
a breakpoint or watchpoint exception.  These are
caused either by EJTAG hardware breakpoints
being hit, or by an external assertion on the EJTAG
interface.  When the CPU enters Debug mode, it
transfers either to a location in the EJTAG pseudo
memory (an overlay of high physical memory that
maps to packet transactions on the JTAG interface)
or to the boot ROM vector area.  They can never
vector directly to the 0x80000000 page!

Now, since the hardware breakpoint channels are
potentially a cool feature to be able to exploit from
an OS - they allow breakpoints in ROM code, for
example - I once prototyped and debugged the necessary 
code in OpenBSD to allow the kernel to be invoked
from a Debug exception, and to allow the kernel to
"call down" into the Debug mode code to set breakpoints,
etc..  To do this, one *must* have support in the boot 
ROM of the platform.   The boot ROM exception vector 
can take advantage of the EJTAG scratch register to
save enough context to transfer control, intact, to
a pseudo-vector in the OS vector page (one of those
rare occasions where the jump delay slot is a lifesaver).  
The location of that pseudo-vector is purely a software 
convention, and should be chosen to be beyond *any* 
hardware vectors, including those for the MIPS32/64 
and Nevada dedicated hardware interrupt vectors.

I've been meaning for some time now to re-implement
the OpenBSD EJTAG hooks in Linux, but have simply
never had the time.  It sounds like someone else has
started down that path without having looked at all the
issues.  I'll try to dig out my old example ROM vector code 
and post it to the newsgroup (it's only a few lines), along
with the EJTAG kernel interface code from OpenBSD
to serve as an example.

            Kevin K.

----- Original Message ----- 
From: "Tommy S. Christensen" <tommy.christensen@eicon.com>
To: <linux-mips@oss.sgi.com>
Sent: Wednesday, May 16, 2001 12:11 AM
Subject: Exception handlers get overwritten


> With LOADADDR set to 0x80000000, except_vec0_r4600 and
> except_vec0_nevada are overwritten in trap_init() before they
> get installed at KSEG0.
> 
> The fix is easy:
> 
> diff -u -r1.53 traps.c
> --- arch/mips/kernel/traps.c    2001/04/08 13:24:27     1.53
> +++ arch/mips/kernel/traps.c    2001/05/15 21:39:56
> @@ -837,7 +837,9 @@
>          * Copy the EJTAG debug exception vector handler code to it's
> final
>          * destination.
>          */
> +#ifdef WHONEEDSTLB
>         memcpy((void *)(KSEG0 + 0x300), &except_vec_ejtag_debug, 0x80);
> +#endif
> 
>         /*
>          * Only some CPUs have the watch exceptions or a dedicated
> 
> 
> OK, a kinder fix would be something like:
> 
> diff -u -r1.25 head.S
> --- arch/mips/kernel/head.S     2001/05/04 20:43:25     1.25
> +++ arch/mips/kernel/head.S     2001/05/15 21:39:40
> @@ -44,7 +44,7 @@
>          * FIXME: Use the initcode feature to get rid of unused handler
>          * variants.
>          */
> -       .fill   0x280
> +       .fill   0x380
>  /*
>   * This is space for the interrupt handlers.
>   * After trap_init() they are located at virtual address KSEG0.
> 
> 
> I wonder why this never hit anybody else ...
> 
> Regards,
> Tommy Christensen
