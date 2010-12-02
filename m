Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2010 13:00:48 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:55454 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493201Ab0LBMAl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Dec 2010 13:00:41 +0100
Received: by eyd9 with SMTP id 9so4155593eyd.36
        for <multiple recipients>; Thu, 02 Dec 2010 04:00:41 -0800 (PST)
Received: by 10.213.26.15 with SMTP id b15mr652720ebc.13.1291291241409;
        Thu, 02 Dec 2010 04:00:41 -0800 (PST)
Received: from [192.168.2.2] ([91.79.87.12])
        by mx.google.com with ESMTPS id v56sm412806eeh.2.2010.12.02.04.00.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 04:00:40 -0800 (PST)
Message-ID: <4CF789F9.2030608@mvista.com>
Date:   Thu, 02 Dec 2010 14:58:49 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
MIME-Version: 1.0
To:     Anoop P A <anoop.pa@gmail.com>
CC:     kevink@paralogos.com, linux-mips@linux-mips.org,
        David Howells <dhowells@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC 3/3] VSMP support for MSP71xx family
References: <1291220637.31413.20.camel@paanoop1-desktop>
In-Reply-To: <1291220637.31413.20.camel@paanoop1-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 01-12-2010 19:23, Anoop P A wrote:

>> From 5bfd3ba210e521df2b493862446b4535bcdb0cdf Mon Sep 17 00:00:00 2001
> Message-Id:
> <5bfd3ba210e521df2b493862446b4535bcdb0cdf.1291219118.git.anoop.pa@gmail.com>
> In-Reply-To:<cover.1291219118.git.anoop.pa@gmail.com>
> References:<cover.1291219118.git.anoop.pa@gmail.com>
> From: Anoop P A<anoop.pa@gmail.com>
> Date: Wed, 1 Dec 2010 21:08:37 +0530
> Subject: [RFC 3/3] VSMP support for MSP71xx family.
> Cc: anoop.pa@gmail.com

    Don't include this header please -- it will have to be edited out anyway 
when applying the patch.

> followig

    Following.

> patches

    Patches? I see only one.

> setup vectored interrupt in msp_irq.c and
> register vsmp_ops from msp_setup.c.
> It also changes get_c0_compare_int to return corresponding vpe timer
> interrupt.

> Signed-off-by: Anoop P A<anoop.pa@gmail.com>
[...]

> diff --git a/arch/mips/pmc-sierra/msp71xx/msp_irq.c
> b/arch/mips/pmc-sierra/msp71xx/msp_irq.c
> index 734d598..e9144c8 100644
> --- a/arch/mips/pmc-sierra/msp71xx/msp_irq.c
> +++ b/arch/mips/pmc-sierra/msp71xx/msp_irq.c
[...]
> @@ -29,6 +27,19 @@ extern void msp_slp_irq_dispatch(void);
>   extern void msp_cic_irq_init(void);
>   extern void msp_cic_irq_dispatch(void);
>
> +/* VSMP support init */
> +extern void msp_vsmp_int_init(void);
> +
> +/* vectored interrupt implementation */
> +
> +/* SW0/1 interrupts are used for SMP/SMTC */
> +static inline void mac0_int_dispatch(void) { do_IRQ(MSP_INT_MAC0); }
> +static inline void mac1_int_dispatch(void) { do_IRQ(MSP_INT_MAC1); }
> +static inline void mac2_int_dispatch(void) { do_IRQ(MSP_INT_SAR); }

    You probably forgot a space here...

> +static inline void usb_int_dispatch(void)  { do_IRQ(MSP_INT_USB);  }
> +static inline void sec_int_dispatch(void)  { do_IRQ(MSP_INT_SEC);  }
> +
> +
>   /*
>    * The PMC-Sierra MSP interrupts are arranged in a 3 level cascaded
>    * hierarchical system.  The first level are the direct MIPS interrupts
> @@ -96,29 +107,51 @@ asmlinkage void plat_irq_dispatch(struct pt_regs
> *regs)

    Your patch is line wrapped.

>   void __init arch_init_irq(void)
>   {
> +	/* assume we'll be using vectored interrupt mode except in UP mode*/

    You forgot a spce before */.

>   	/* setup the 2nd-level SLP register based interrupt controller */
> +	/* VSMP /SMTC support support is not enabled for SLP */

    The preferred style for the multiline comments is this:

/*
  * bla
  * bla
  */

WBR, Sergei
