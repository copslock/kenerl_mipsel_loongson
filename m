Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g56ID0nC021875
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 6 Jun 2002 11:13:00 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g56ID02S021874
	for linux-mips-outgoing; Thu, 6 Jun 2002 11:13:00 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g56ICnnC021869
	for <linux-mips@oss.sgi.com>; Thu, 6 Jun 2002 11:12:50 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id LAA16577
	for <linux-mips@oss.sgi.com>; Thu, 6 Jun 2002 11:14:43 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id LAA14030;
	Thu, 6 Jun 2002 11:14:39 -0700 (PDT)
Message-ID: <007501c20d86$f339b7a0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Kjeld Borch Egevang" <kjelde@mips.com>,
   "linux-mips mailing list" <linux-mips@oss.sgi.com>
References: <Pine.LNX.4.44.0206061657510.25647-100000@coplin19.mips.com>
Subject: Re: Float crash. Fix in exit_thread()
Date: Thu, 6 Jun 2002 20:21:15 +0200
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

It's been a while since I worked on the code,
but I'm not sure why last_task_used_math
needs to be cleared if there is no FPU.
The way the FPU emulator was integrated,
the FPU register storage *is* the thread
context, so if there is no FPU, there was no 
FPU context switching, lazy or otherwise.  
Sounds like someone broke this.

Beyond that, the CFC1 instruction is presumably
there because in the R4000 (at least) it is specified
as the means to force the FP pipeline to drain
before the context switch.  I would suppose this
would be done in Linux to avoid mis-attribution
of FP exceptions. (See chapter 6 of the R4000 
User's manual, page 160 in the Second Edition).

            Kevin K.

----- Original Message ----- 
From: "Kjeld Borch Egevang" <kjelde@mips.com>
To: "linux-mips mailing list" <linux-mips@oss.sgi.com>
Sent: Thursday, June 06, 2002 5:06 PM
Subject: Float crash. Fix in exit_thread()


> I'm running on a system with no FPU. Now, I've got a program do_float 
> which seems to work fine. But if I enter:
> 
> /bin/echo hello; ./do_float
> 
> it terminates with a bus error or FP error. The bug is in exit_thread(). 
> Can anyone explain to me, what good the "cfc1 $0,$31" does?
> 
> 
> Here is the patch:
> 
> RCS file: /cvs/linux/arch/mips/kernel/process.c,v
> retrieving revision 1.36
> diff -u -r1.36 process.c
> --- process.c   2002/05/29 18:36:28     1.36
> +++ process.c   2002/06/06 14:51:32
> @@ -54,9 +54,11 @@
>  void exit_thread(void)
>  {
>         /* Forget lazy fpu state */
> -       if (last_task_used_math == current && mips_cpu.options & MIPS_CPU_FPU) {
> -               __enable_fpu();
> -               __asm__ __volatile__("cfc1\t$0,$31");
> +       if (last_task_used_math == current) {
> +               if (mips_cpu.options & MIPS_CPU_FPU) {
> +                       __enable_fpu();
> +                       __asm__ __volatile__("cfc1\t$0,$31");
> +               }
>                 last_task_used_math = NULL;
>         }
>  }
> @@ -64,9 +66,11 @@
>  void flush_thread(void)
>  {
>         /* Forget lazy fpu state */
> -       if (last_task_used_math == current && mips_cpu.options & MIPS_CPU_FPU) {
> -               __enable_fpu();
> -               __asm__ __volatile__("cfc1\t$0,$31");
> +       if (last_task_used_math == current) {
> +               if (mips_cpu.options & MIPS_CPU_FPU) {
> +                       __enable_fpu();
> +                       __asm__ __volatile__("cfc1\t$0,$31");
> +               }
>                 last_task_used_math = NULL;
>         }
>  }
> 
> 
> 
> /Kjeld
> 
> 
> -- 
> _    _ ____  ___                       Mailto:kjelde@mips.com
> |\  /|||___)(___    MIPS Denmark       Direct: +45 44 86 55 85
> | \/ |||    ____)   Lautrupvang 4 B    Switch: +45 44 86 55 55
>   TECHNOLOGIES      DK-2750 Ballerup   Fax...: +45 44 86 55 56
>                     Denmark            http://www.mips.com/
> 
> 
