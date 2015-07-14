Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 10:55:56 +0200 (CEST)
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38900 "EHLO
        mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008889AbbGNIzz1ILcx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2015 10:55:55 +0200
Received: by wicmv11 with SMTP id mv11so8348610wic.1;
        Tue, 14 Jul 2015 01:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+My4a8HYjOaFCJWBUaQ1VCP2h+49nSkxWYGeUtjkf7w=;
        b=AEgjRWLXx7dycq87P4dbQiEETJTM0y0w9Yq90MUmaVu6JNZc7LC0C0ahOTqHYnEG7t
         qZHHdNdvNvC0FLS8OghVqrYA6ovkf8iuWJ8Lic7m+ft6W2sNG5aVsAuh+QckuryFKfa3
         YeqFiDqolTs7Y4d/vNL+/Y+K7kxnPA+GLLJDLd9wXl+s+slkIgYmjKwKDLCKp70WHj/a
         DPJj5ZPybarBEZK/U6pBpXtWdRETbHYbChhCxYUmQinUSfQhIMPQqksnEOJeCQbpJ2CZ
         XN8WOR8da3xrvPdjVR92JLWP78WhnKhnizxzSVnrwZGwN1slh3N5AIvIcOjowQhBjov8
         vIuw==
X-Received: by 10.194.172.8 with SMTP id ay8mr17534058wjc.106.1436864147798;
 Tue, 14 Jul 2015 01:55:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.248.193 with HTTP; Tue, 14 Jul 2015 01:55:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1507141012360.20072@nanos>
References: <20150713200602.799079101@linutronix.de> <20150713200715.113667554@linutronix.de>
 <CAOLZvyEEzWRU2RoMODPg13TMgi9jLGOUmp=AuBUA230KmgKODQ@mail.gmail.com> <alpine.DEB.2.11.1507141012360.20072@nanos>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Tue, 14 Jul 2015 10:55:08 +0200
Message-ID: <CAOLZvyHxZdphtT6rw73=J-_HnFueNcmtxMCHZ-K=JsJt+UHKkg@mail.gmail.com>
Subject: Re: [patch 08/12] MIPS/alchemy: Remove pointless irqdisable/enable
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Tue, Jul 14, 2015 at 10:16 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 14 Jul 2015, Manuel Lauss wrote:
>
>> On Mon, Jul 13, 2015 at 10:46 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> > bcsr_csc_handler() is a cascading interrupt handler. It has a
>> > disable_irq_nosync()/enable_irq() pair around the generic_handle_irq()
>> > call. The value of this disable/enable is zero because its a complete
>> > noop:
>> >
>> > disable_irq_nosync() merily increments the disable count without
>> > actually masking the interrupt. enable_irq() soleley decrements the
>> > disable count without touching the interrupt chip. The interrupt
>> > cannot arrive again because the complete call chain runs with
>> > interrupts disabled.
>> >
>> > Remove it.
>>
>> Is there another patch this one depends on?  The DB1300 board doesn't
>
> No.
>
>> boot (i.e. interrupts from the cpld aren't serviced) with this patch applied:
>> (irq 136 is the first serviced by the bcsr cpld):
>>
>> irq 136: nobody cared (try booting with the "irqpoll" option)
>
> That's weird. Looking deeper, enable_irq() actually calls
> chip->unmask() unconditionally. So it seems the chip is sensitive to
> that.
>
> Does the following patch on top fix things again?
>
> Thanks,
>
>         tglx
> ----
> diff --git a/arch/mips/alchemy/devboards/bcsr.c b/arch/mips/alchemy/devboards/bcsr.c
> index 3a24f2d6ecfd..ec47abe580c6 100644
> --- a/arch/mips/alchemy/devboards/bcsr.c
> +++ b/arch/mips/alchemy/devboards/bcsr.c
> @@ -88,8 +88,11 @@ EXPORT_SYMBOL_GPL(bcsr_mod);
>  static void bcsr_csc_handler(unsigned int irq, struct irq_desc *d)
>  {
>         unsigned short bisr = __raw_readw(bcsr_virt + BCSR_REG_INTSTAT);
> +       struct irq_chip *chip = irq_desc_get_chip(d);
>
> +       chained_irq_enter(chip, d);
>         generic_handle_irq(bcsr_csc_base + __ffs(bisr));
> +       chained_irq_exit(chip, d);
>  }
>
>  static void bcsr_irq_mask(struct irq_data *d)


Yes.  Add #include <linux/irqchip/chained_irq.h> on top and it works again.
This hardware is problematic, an older variant with identical verilog
code in the cpld's
irq unit works fine without this.

Thanks,
    Manuel
