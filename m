Received:  by oss.sgi.com id <S554065AbQLBNYW>;
	Sat, 2 Dec 2000 05:24:22 -0800
Received: from mx.mips.com ([206.31.31.226]:32159 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S554062AbQLBNYF>;
	Sat, 2 Dec 2000 05:24:05 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id FAA24254;
	Sat, 2 Dec 2000 05:23:59 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id FAA10228;
	Sat, 2 Dec 2000 05:23:56 -0800 (PST)
Message-ID: <007f01c05c63$9b517b20$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Florian Lohoff" <flo@rfc822.org>, <linux-mips@oss.sgi.com>
References: <20001202132748.A2002@paradigm.rfc822.org>
Subject: Re: [PATCH] DEC init_cycle_counter
Date:   Sat, 2 Dec 2000 14:26:54 +0100
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
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Only that if you adopted the CPU probe and configuration
scheme that we've been promulgating at MIPS, it would
already have been taken care of in kernel/cpu_probe.c, and
could be tested as (mips_cpu.options  & MIPS_CPU_COUNTER).
I believe I even checked in the headers and C file in the 2.2
repository, though I don't think I "wired it up" to replace the old
assembler spaghetti.

            Kevin K.

----- Original Message -----
From: "Florian Lohoff" <flo@rfc822.org>
To: <linux-mips@oss.sgi.com>
Sent: Saturday, December 02, 2000 1:27 PM
Subject: [PATCH] DEC init_cycle_counter


>
> Comments ?
>
> Index: time.c
> ===================================================================
> RCS file: /cvs/linux/arch/mips/dec/time.c,v
> retrieving revision 1.11
> diff -u -r1.11 arch/mips/dec/time.c
> --- arch/mips/dec/time.c 2000/11/23 02:00:49 1.11
> +++ arch/mips/dec/time.c 2000/12/02 12:20:09
> @@ -423,46 +423,6 @@
>   timer_interrupt(irq, dev_id, regs);
>  }
>
> -char cyclecounter_available;
> -
> -static inline void init_cycle_counter(void)
> -{
> - switch (mips_cputype) {
> - case CPU_UNKNOWN:
> - case CPU_R2000:
> - case CPU_R3000:
> - case CPU_R3000A:
> - case CPU_R3041:
> - case CPU_R3051:
> - case CPU_R3052:
> - case CPU_R3081:
> - case CPU_R3081E:
> - case CPU_R6000:
> - case CPU_R6000A:
> - case CPU_R8000: /* Not shure about that one, play safe */
> - cyclecounter_available = 0;
> - break;
> - case CPU_R4000PC:
> - case CPU_R4000SC:
> - case CPU_R4000MC:
> - case CPU_R4200:
> - case CPU_R4400PC:
> - case CPU_R4400SC:
> - case CPU_R4400MC:
> - case CPU_R4600:
> - case CPU_R10000:
> - case CPU_R4300:
> - case CPU_R4650:
> - case CPU_R4700:
> - case CPU_R5000:
> - case CPU_R5000A:
> - case CPU_R4640:
> - case CPU_NEVADA:
> - cyclecounter_available = 1;
> - break;
> - }
> -}
> -
>  struct irqaction irq0 = {timer_interrupt, SA_INTERRUPT, 0,
>   "timer", NULL, NULL};
>
> @@ -513,8 +473,6 @@
>   xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
>   xtime.tv_usec = 0;
>   write_unlock_irq(&xtime_lock);
> -
> - init_cycle_counter();
>
>   if (cyclecounter_available) {
>   write_32bit_cp0_register(CP0_COUNT, 0);
>
>
> --
> Florian Lohoff                  flo@rfc822.org             +49-5201-669912
>      Why is it called "common sense" when nobody seems to have any?
>
