Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1MAifa29375
	for linux-mips-outgoing; Fri, 22 Feb 2002 02:44:41 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1MAiU929371
	for <linux-mips@oss.sgi.com>; Fri, 22 Feb 2002 02:44:30 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id BAA14818;
	Fri, 22 Feb 2002 01:44:24 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA15171;
	Fri, 22 Feb 2002 01:44:20 -0800 (PST)
Message-ID: <005801c1bb85$a9e9c980$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Jun Sun" <jsun@mvista.com>, <linux-mips@oss.sgi.com>
References: <3C75B181.C5A065A1@mvista.com>
Subject: Re: lazy fpu switch irrelavant to no-fpu case?
Date: Fri, 22 Feb 2002 10:45:14 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

In the very first cut at integrating the Algorithmics
emulator with Linux, the emulator actually contained
storage that represented the FPU registers, and FP
context management was meaningful.   Using thread
context storage directly for the FPU registers was
an optimisaton that I did after I got the code running,
and I didn't bother eliminating the last_task_used_math
setup, probably  on the basis that it wasn't costing much
and that it might still be useful in some way.  I don't
think you'll break anything by getting rid of it,
but I don't think you'll fix anything either.

As I stated in another message on the subject
of SMP problems observed with the FPU
emulator, while the basic mechanisms of
FP emulation should be SMP safe, there may
well be non-SMP artifcacts in the code. A cursory
inspection shows that there is a single
mips_fpu_emulator_private data structure for the
emulator, which contains statistics which risk
being screwed up  due to non-atomic increments
being used.  That ought to be fixed, but should not
cause any user-mode-visible problems.

But I also note that the emulator uses a single
global storage location for "ieee754_csr".
The kernel port of the code does copies between
the thread context image of the MIPS csr
and this global which are manifestly SMP
unsafe.  Could the bugs you're seeing be
explainable by corruption of rounding mode
and exception state?

            Regards,

            Kevin K.

----- Original Message -----
From: "Jun Sun" <jsun@mvista.com>
To: <linux-mips@oss.sgi.com>
Sent: Friday, February 22, 2002 3:48 AM
Subject: lazy fpu switch irrelavant to no-fpu case?


>
> It appears to me that lazy fpu switch has no relevancy to CPUs that don't
have
> FPU.
>
> If you do a scan, you will see last_task_used_math are used in four kernel
> files:
>
> ptrace.c
> process.c
> signal.c
> traps.c
>
> In the case of ptrace.c and process.c, the variable is used only when CPU
has
> FPU.
>
> In the case of traps.c (do_cpu()), it used redaundantly with another
condition
> checking.
>
> In the case of signal.c, no matter what last_task_used_math is, the same
code
> will be executed anyway.
>
> Now think about it, it actually makes sense - if we don't have hardware
FPU,
> why do we care of fpu context switch.
>
> Anyhow, the problem I am seeing with FPU/SMP case seems to be caused by
FPU
> emulation code itself, if we can assume it is not caused by fpu context
> switch.  Right now the FPU is not turned on on the box.
>
> The following patch cleans it up a little based on the above observation.
> Make sense?
>
> Jun
>
> diff -Nru linux/arch/mips/kernel/traps.c.orig
linux/arch/mips/kernel/traps.c
> --- linux/arch/mips/kernel/traps.c.orig Wed Jan 30 15:17:12 2002
> +++ linux/arch/mips/kernel/traps.c      Thu Feb 21 18:46:28 2002
> @@ -678,14 +678,11 @@
>         return;
>
>  fp_emul:
> -       if (last_task_used_math != current) {
> -               if (!current->used_math) {
> -                       fpu_emulator_init_fpu();
> -                       current->used_math = 1;
> -               }
> +       if (!current->used_math) {
> +               fpu_emulator_init_fpu();
> +               current->used_math = 1;
>         }
>         sig = fpu_emulator_cop1Handler(regs);
> -       last_task_used_math = current;
>         if (sig)
>                 force_sig(sig, current);
>         return;
>
