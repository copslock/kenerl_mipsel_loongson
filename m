Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6UK9tP11503
	for linux-mips-outgoing; Mon, 30 Jul 2001 13:09:55 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6UK9rV11500
	for <linux-mips@oss.sgi.com>; Mon, 30 Jul 2001 13:09:53 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id NAA14209;
	Mon, 30 Jul 2001 13:09:44 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id NAA10048;
	Mon, 30 Jul 2001 13:09:29 -0700 (PDT)
Message-ID: <07dd01c11934$32334860$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "Ralf Baechle" <ralf@uni-koblenz.de>,
   "Thiemo Seufer" <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: <linux-mips@oss.sgi.com>
References: <Pine.GSO.3.96.1010730202132.18438A-100000@delta.ds2.pg.gda.pl>
Subject: Re: [PATCH] wrong use of compute_return_epc() in /mips/kernel/traps.c
Date: Mon, 30 Jul 2001 22:13:55 +0200
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

Many years ago, I went to a lot of effort to see to it that
FP exceptions on the Fairchild Clipper passed enough
information up through SIGFPE to allow full userland
emulation or fixup and replay-on-return of the operation
on floating point faults (entertaining because there was
a seperate FP PC). And of course no one ever used it!   ;-)

I missed the beginning of this thread, but it looks from the
patch as if this is really about handling integer overflow
exceptions, not FP exceptions.  That's unfortunate.
To begin with you are correct in that we should be
passing the EPC value at the exception (and certainly not
the result  of invoking compute_return_epc(), much less
its side effects!), and the state of the BD bit from the
Cause register, either abstracted into a variable in the
info structure or as a flat-out copy of the Cause register.
I would recommend the former as being less of a security
hole.  Yes, we could blow that off and make the user
decode for branches himself, but it's tacky. But what's
more pernicious is the fact that, being an integer exception,
it could have resulted from an overflow of any of the GPRs,
including those that will be used by the low-level library
code dispatching the signal to the user, and in the generated
code of the user's own signal handler.  If we actually want
to allow the user to fix the operation and saturate (or whatever)
the destination register, enough of the trap context needs
to be passed up to the signal handler *and* back down
on the signal return to allow that manipulation, followed
by a resumption of execution at the instruction following
the one that generated the trap.

            Been there, done that, got the coffee mug,

            Kevin K.

----- Original Message -----
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Ralf Baechle" <ralf@uni-koblenz.de>; "Thiemo Seufer"
<ica2_ts@csv.ica.uni-stuttgart.de>
Cc: <linux-mips@oss.sgi.com>
Sent: Monday, July 30, 2001 8:46 PM
Subject: Re: [PATCH] wrong use of compute_return_epc() in
/mips/kernel/traps.c


> On Tue, 24 Jul 2001, Thiemo Seufer wrote:
>
> > somebody made wrong assumptions about how compute_return_epc() works.
>
>  It was me, I admit...  Thanks for pointing it out.
>
> > I've speculated below how the right solution might look, but I
> > don't know enough about signal handling to be sure.
>
>  I think the following fix is sufficient -- let's just pass EPC and let
> the userland handle it.  You don't normally want a "break" in a branch
> delay slot -- such a sequence is of questionable utility.  But if it is to
> be handled, the KISS approach gives the userland a chance to handle an
> exception gracefully.  One may want to emulate overflows somehow, for
> example.  Also the code is shorter.
>
>  Ralf, please apply it.
>
>   Maciej
>
> --
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
>
> patch-mips-2.4.5-20010730-break-1
> diff -up --recursive --new-file linux.macro/arch/mips/kernel/traps.c
linux/arch/mips/kernel/traps.c
> --- linux.macro/arch/mips/kernel/traps.c Tue Jul 24 04:26:34 2001
> +++ linux/arch/mips/kernel/traps.c Mon Jul 30 18:26:03 2001
> @@ -378,7 +378,7 @@ asmlinkage void do_bp(struct pt_regs *re
>   info.si_code = FPE_INTOVF;
>   info.si_signo = SIGFPE;
>   info.si_errno = 0;
> - info.si_addr = (void *)compute_return_epc(regs);
> + info.si_addr = (void *)regs->cp0_epc;
>   force_sig_info(SIGFPE, &info, current);
>   break;
>   default:
> @@ -418,7 +418,7 @@ asmlinkage void do_tr(struct pt_regs *re
>   info.si_code = FPE_INTOVF;
>   info.si_signo = SIGFPE;
>   info.si_errno = 0;
> - info.si_addr = (void *)compute_return_epc(regs);
> + info.si_addr = (void *)regs->cp0_epc;
>   force_sig_info(SIGFPE, &info, current);
>   break;
>   default:
>
