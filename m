Received:  by oss.sgi.com id <S553778AbRALHUP>;
	Thu, 11 Jan 2001 23:20:15 -0800
Received: from mx.mips.com ([206.31.31.226]:52366 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553770AbRALHUE>;
	Thu, 11 Jan 2001 23:20:04 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id XAA03011;
	Thu, 11 Jan 2001 23:19:56 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id XAA14739;
	Thu, 11 Jan 2001 23:19:53 -0800 (PST)
Message-ID: <001e01c07c68$96155f80$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Jun Sun" <jsun@mvista.com>, <linux-mips@oss.sgi.com>
References: <3A5E7FFB.79925DF9@mvista.com>
Subject: Re: broken RM7000 in CVS ...
Date:   Fri, 12 Jan 2001 08:23:30 +0100
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

Yes, arguably the mips_cpu structure could also contain
a descriptor of the MMU routines to bind, and it probably
would have if it would have been a simple matter of an
address/length of a vector to copy.  But heck, it could
be a function pointer as well, I suppose.

Anyway, I'm not surprised if there was something off
somewhere in the RM7000 descriptor.  I did a first
cut based on an old copy of the QED spec - I had no
hardware to test it on - and there was no pretention
of putting in full RM7000 support in the kernel when
I did the decriptor, it was more a matter of showing
what a 3-cache CPU would look like!

            Kevin K.

----- Original Message -----
From: "Jun Sun" <jsun@mvista.com>
To: <linux-mips@oss.sgi.com>
Sent: Friday, January 12, 2001 4:54 AM
Subject: broken RM7000 in CVS ...


>
> I saw mips_cpu structure is introduced to the CVS tree.  That is a really
good
> thing, although many places need to be improved.
>
> An initial try found the following bug.  There are probably more down the
> road. :-)
>
> Jun
>
> diff -Nru linux/arch/mips/mm/loadmmu.c.orig linux/arch/mips/mm/loadmmu.c
> --- linux/arch/mips/mm/loadmmu.c.orig   Thu Jan 11 19:32:11 2001
> +++ linux/arch/mips/mm/loadmmu.c        Thu Jan 11 19:48:06 2001
> @@ -59,6 +59,11 @@
>                 printk("Loading MIPS32 MMU routines.\n");
>                 ld_mmu_mips32();
>  #endif
> +#if defined(CONFIG_CPU_RM7000)
> +               printk("Loading RM7000 MMU routines.\n");
> +               ld_mmu_rm7k();
> +#endif
> +
>         } else switch(mips_cpu.cputype) {
>  #ifdef CONFIG_CPU_R3000
>         case CPU_R2000:
> @@ -74,13 +79,6 @@
>         case CPU_R5432:
>                 printk("Loading R5432 MMU routines.\n");
>                 ld_mmu_r5432();
> -               break;
> -#endif
> -
> -#if defined(CONFIG_CPU_RM7000)
> -       case CPU_RM7000:
> -               printk("Loading RM7000 MMU routines.\n");
> -               ld_mmu_rm7k();
>                 break;
>  #endif
