Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4GC4J905147
	for linux-mips-outgoing; Wed, 16 May 2001 05:04:19 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4GC4HF05143
	for <linux-mips@oss.sgi.com>; Wed, 16 May 2001 05:04:17 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id FAA01081;
	Wed, 16 May 2001 05:04:10 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id FAA16238;
	Wed, 16 May 2001 05:04:07 -0700 (PDT)
Message-ID: <002d01c0de00$edf50d00$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Tommy S. Christensen" <tommy.christensen@eicon.com>,
   <linux-mips@oss.sgi.com>
References: <3B01A980.7C27BB9F@eicon.com>
Subject: Re: Exception handlers get overwritten, and more than you ever wanted to know about EJTAG
Date: Wed, 16 May 2001 14:08:24 +0200
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

My previous response was written at almost 2AM local time,
and I was too tired to go find my archives from May 1999
before responding.  I was also too tired to fully understand
the nature of the bug Tommy was describing.  I took it to mean
that the installation of the EJTAG KSEG0 vector was overwriting 
other installed vectors - which seems not to be the case.  By the 
light of day, I take it that the problem is in fact that the *templates*
for the exception vectors are linked into the kernel image
starting at location 0x80000280, and that therefore the
installation of the EJTAG pseudo-vector was overwriting
them *before* they could be installed.

In any case, Carsten had of course correctly installed the 
pseudo-vector at the location that we adoped at MIPS, 
0x80000300.  The fix is not to get rid of it, but as noted,
to make an allowance for it in the .fill directive at the 
beginning of the module.  I would actually recommend
that EJTAG support be a configure-able option, and in 
that case the .fill selected could be a function of wheter
EJTAG support will be provided.  It seems to me, however,
that the problem could also be solved by installing the
vectors in the right order - if the EJTAG vector had been
installed at 0x80000300 *after* the excep_vec0 had been
copied into place, it wouldn't have mattered.  So long as
the vectors are both assembled and installed in order of 
ascending vector addresses, one should be able to pack 
them in the linked binary with a .fill just big enough to allow 
for the largest excep_vec0.  I don't know that the increased
risk of miscalculation is worth the savings of a few hundred 
bytes, though.

To get back to the issue of EJTAG support, for those 
of you who are interested (and who are building platforms 
around chips that support EJTAG), the actual hardware 
vector used for Debug exceptions when there is no
probe attached is 0xbfc00480.  The code to transfer
control to a pseudo-vector at 0x80000300 looks like
this (the choice of temporary register is arbitrary, but
I actually recommend against using k0 or k1).

                            .noreorder (!)
0xbfc00480        mtc0 t0,COP_O_DESAVE
0xbfc00484        lui      t0,0x8000
0xbfc00488        ori     t0,0x0300
0xbfc0048c        jr        t0
0xbfc00490        mfc0 t0,COP_0_DESAVE

One important thing to understand about Debug
exceptions is that, while there are restrictions on 
how they can nest, they can otherwise occur at *any*
time.  Which is to say, even if EXL is set in the Status
register.  Which is to say, even in the middle of a
TLB miss or interrupt handler.  So the Debug exception
handler cannot use the kernel stack, nor should it be
premitted to modify any kernel data structure directly.

The pre-exception context must be saved and restored
from *somewhere*, and there is the further subtlety
that, depending on whether or not a probe is attached,
the context save RAM may be on-board or on-probe.
Now, the Debug exception handler can know whether
it was entered via a probe memory vector or a ROM
vector, so in the OpenBSD code, I created a convention
whereby the word immediately preceding the hardware
vector (0xbfc0047c in the case of the ROM vector)
contains a pointer to a pointer to a context save block.
Why a pointer-to-a-pointer?  Because a Debug exception
handler can explicitly allow itself to nest, and it is far
more efficient to update a pointer in RAM to the
next block than it would be to copy the saved 
contexts around.  While the pointer to the context save
block is modifiable, the pointer-to-the-pointer in ROM
is not, and requires yet another software convention.
For OpenBSD, I chose to put the RAM pointer in the
word immediately preceding the RAM pseudo-vector,
wich is to say 0xbfc0047c contains the value 0x800002fc,
and the startup code (or even the kernel linkage, if one
wanted to be EJTAG-sane from the moment the image
is loaded) needs to see to it that 0x800002fc points to
a reserved block of RAM big enough to hold the register
set, etc.  The debug handler, if it wants to allow for
reentrancy, must update 0x800002fc to point to a clean
save block before allowing any further exceptions.

0xbfc00480 is fixed by hardware, but the other
conventions -  pseudo-vector at 0x80000300,
pointer-to-pointer at 0xbfc0047c, pointer-to-context
at 0x800002fc - are software conventions.  If anyone
on this list sees problems, or a better way to do things,
speak now "or forever hold your peace".

            Regards,

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
