Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f75Aqk017868
	for linux-mips-outgoing; Sun, 5 Aug 2001 03:52:46 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f75AqfV17857;
	Sun, 5 Aug 2001 03:52:41 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id DAA09072;
	Sun, 5 Aug 2001 03:52:26 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id DAA06212;
	Sun, 5 Aug 2001 03:52:25 -0700 (PDT)
Message-ID: <004f01c11d9d$595ca7c0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>, <ppopov@mvista.com>,
   "Carsten Langgaard" <carstenl@mips.com>
Cc: "MIPS/Linux List \(SGI\)" <linux-mips@oss.sgi.com>
References: <3B53679A.4020809@mvista.com> <3B53D22D.D8913C09@mips.com> <3B53D4DB.2090809@mvista.com> <3B53D895.30D92792@mips.com> <3B53DB71.8040501@mvista.com> <3B53DCDA.ECAB628E@mips.com> <3B53E00F.4070904@mvista.com> <3B53E654.325D030@mips.com> <3B53E79F.80409@mvista.com> <3B53ECA3.2BD2104E@mips.com> <3B53EF8B.8010003@mvista.com> <3B53F42C.6F409B70@mips.com> <3B53F5A7.8020705@mvista.com> <3B53F6E2.FE19F0CA@mips.com> <006b01c11cee$b54cfbc0$0deca8c0@Ulysses>
Subject: Re: FPU Emulation and Signals - An Alternative Fix
Date: Sun, 5 Aug 2001 12:56:55 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> So I submit the following for your consideration.
> In the FP emulator, when we set up the trampoline, we set
> up the following above  the user stack:
> 
>             Instruction-to-be-executed
>             AdELOAD (unaligned load of r0 off of r0)
>             Magic-cookie-that-is-an-unimplemented-instruction
>             EPC-to-use-on-completion
> 
> Rather than use thread.desmul_epc as a flag to indicate
> to the unaligned access handler that there is emulation
> going on, the unaligned access handler would test to see
> if the unaligned access instruction itself was the AdELOAD,
> and that it is followed by the magic cookie, and if so, treat 
> that as an indication to stuff the value following the sequence
> (as indicated by EPC, modulo branch delays) into the EPC 
> and return.   This way, one could nest an arbitrary number of 
> emulation/signal/emulation sequences, and they should unroll 
> correctly.  The further magic cookie is needed since, even though 
> it's a completely useless instruction, the AdELOAD could be 
> encountered for other reasons, as a misguided attempt
> at cache prefetch, or by executing crashme. It's a useless instruction 
> to emulate, having r0 as the destination, but the normal Linux semantics 
> as I understand them would be to turn it  into a very expensive 
> no-op and continue in what might otherwise be safe and sane 
> execution.  With the addtional code word after the AdELOAD 
> (and before the EPC) on  the dsemul stack that would be (more-or-less) 
> guaranteed  to really be an illegal instruction, the only risk we would 
> be taking would be to have a  program really containing the 
> unaligned nonsense load followed by the  illegal instruction 
> blow up, not on the illegal instruction, but by picking up a bogus 
> EPC.  Not perfect.  But maybe the lesser of several evils.

One further embellishment and one further alternative to
consider:  The thread data field currently used to store the
post-trampoline EPC value can be renamed and used
instead as a counter of the "depth" of FP branch delay
slot emulation.  If the count is zero, the unaligned access
trap does not look for the magic sequence described 
above, and just emulates the AdELOAD instruction.
Unfortunately, a signal handler that invokes a longjmp
will not return to the trampoline, not invoke the associated
trap, and thus not decrement the counter, so a non-zero count 
cannot be taken as absolute proof that a branch emulation is
pending.  The hack would further reduce the probability
of a "naturally occurring" AdELOAD/MagicCookie
sequence being mishandled, not eliminate the possibility.

The scheme proposed above allows arbitrary recursion
(a Good Thing) but also misdiagnosis of a wildly improbable
but conceptually possible error condition (a Bad Thing).
An alternative - still in conjunction with the proposed
gap-between-user-stack-and-signal-stack technique - 
would be to replace the single EPC storage location
in the thread data with, say, three storage locations
and an additional variable that serves as a sort of
"stack pointer" for the EPCs.  In this model, the EPCs
are kept off the user stack and no magic cookies are
needed.  If nesting of FP branch emulation exceeds
three, the process gets nailed with a fatal error.
This would not allow arbitrary recursion and would
increase the static size of the thread data structure
(Bad Things), but would, within the constraints of the
allowed depth of recursion, create no ambiguous 
situations (a Good Thing).   Any comments or declarations
of preference?   I guess it boils down to the question of
what is more probable, a naturally occurring sequence
of AdELOAD/MagicCookie or a 4-way nesting of
signals delivered in the branch emulation delay trampoline
window.  Both strike me as unlikely, but I feel more
confident about my estimate of the former than of the later.

Sorry to bore 95% of you to tears with this stuff, but
it really does matter to some of us, and I don't presume
to know exactly who on the list could have valuable
input.

            Regards,

            Kevin K.
