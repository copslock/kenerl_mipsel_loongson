Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 23:09:30 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:41790 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491818Ab1FFVJZ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Jun 2011 23:09:25 +0200
Received: by vws8 with SMTP id 8so4147810vws.36
        for <multiple recipients>; Mon, 06 Jun 2011 14:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=UZ4mu0vBLuRThT3RoJZHUOCQ7JEaDjz6UXDkJnWyBQU=;
        b=r+E2TiIXVr7moA5aOEa1zYMPk2mU4q4vmOOqaC710vOQv37HSklLxkjbvxNoRGTIYX
         nSFTBLhQkyOxywTaWRBcbQ0AtCL89wLr8ebTZU650sggPP/vyWve8nKogCn1TXIRrFug
         kRwEowofo0sq97t/4yD11haI/fOOczeRP5g84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=R4KqtHUsbLckGSIgYRZXgM7OtYjOOqVaE5q1YkFXwOKKhrcn13ywnHG/XwLAU79s66
         jsSv4F6k76/RutpO4BzdytH1HwrQs9E2/avdp7fyyvYNeYSRXr4qD+hNwuL0huzGyEvE
         bTmODVlWDCerpdUjRV+Ki8V6Tg4sW/1UrO6Ao=
Received: by 10.52.0.130 with SMTP id 2mr366357vde.180.1307394558065; Mon, 06
 Jun 2011 14:09:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.52.166.71 with HTTP; Mon, 6 Jun 2011 14:08:58 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1106061149460.13964@ionos>
References: <20110606033608.GA14686@localhost.mattst88> <alpine.LFD.2.02.1106061149460.13964@ionos>
From:   Matt Turner <mattst88@gmail.com>
Date:   Mon, 6 Jun 2011 17:08:58 -0400
Message-ID: <BANLkTinJvZ9-PVybUX=tB+n0z7VGyUgCGQ@mail.gmail.com>
Subject: Re: Regression: d6d5d5c breaks Broadcom BCM91250A
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4889

On Mon, Jun 6, 2011 at 5:53 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Sun, 5 Jun 2011, Matt Turner wrote:
>
>> Hi Thomas,
>>
>> Commit d6d5d5c4afd4c8bb4c5e3753a2141e9c3a874629 breaks boot-up on my
>> Broadcom BCM91250A. Reverting it solves the problem.
>>
>> I looked at the commit but nothing obviously wrong jumped out at me.
>
> The below should fix it.
>
> ----------------->
> Subject: MIPS: sb1250: Restore dropped irq_mask function
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Mon, 06 Jun 2011 11:51:43 +0200
>
> Commit d6d5d5c4a (MIPS: Sibyte: Convert to new irq_chip functions)
> removed the mask function which breaks irq_shutdown(). Restore it.
>
> Reported-by: Matt Turner <mattst88@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
> ---
> diff --git a/arch/mips/sibyte/sb1250/irq.c b/arch/mips/sibyte/sb1250/irq.c
> index be4460a..76ee045 100644
> --- a/arch/mips/sibyte/sb1250/irq.c
> +++ b/arch/mips/sibyte/sb1250/irq.c
> @@ -123,6 +123,13 @@ static int sb1250_set_affinity(struct irq_data *d, const struct cpumask *mask,
>  }
>  #endif
>
> +static void disable_sb1250_irq(struct irq_data *d)
> +{
> +       unsigned int irq = d->irq;
> +
> +       sb1250_mask_irq(sb1250_irq_owner[irq], irq);
> +}
> +
>  static void enable_sb1250_irq(struct irq_data *d)
>  {
>        unsigned int irq = d->irq;
> @@ -180,6 +187,7 @@ static struct irq_chip sb1250_irq_type = {
>        .name = "SB1250-IMR",
>        .irq_mask_ack = ack_sb1250_irq,
>        .irq_unmask = enable_sb1250_irq,
> +       .irq_mask = disable_sb1250_irq,
>  #ifdef CONFIG_SMP
>        .irq_set_affinity = sb1250_set_affinity
>  #endif

Yep, this fixes it. Have a

Tested-by: Matt Turner <mattst88@gmail.com>

Thanks!
Matt
