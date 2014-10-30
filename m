Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 20:24:42 +0100 (CET)
Received: from mail-qg0-f43.google.com ([209.85.192.43]:40321 "EHLO
        mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012329AbaJ3TYlc5FbV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 20:24:41 +0100
Received: by mail-qg0-f43.google.com with SMTP id f51so4520490qge.16
        for <multiple recipients>; Thu, 30 Oct 2014 12:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gqExm+Duij9xLRhxKkZsaNZWi7IoUVpm9RDwDcqBK2E=;
        b=Dwm4zQ5tFm6+9Tt0ug+rERaYfuCleYEaKzHb4sM/4hXH31JWtkRnNmzjoKaD1UCgAP
         qwcHoJ9VEawhu+aO3Eg5Q0hlLB6PK9GsVJ+vqdERymm83cAGQGZ/Yr0i3tth34nh+bL0
         4btHP9BGhnFjxhZ44/DncmPrMRVI1lLbOtvzpT2x4hJVVztEaU7OJAcKMGKtzS01DfVq
         8+F6Tm8MZXbG5eJSs/zxGIP/gm7gDxNGxpUPpDe4iY+fKnglyfxuPNj9DrY/BmrvxFBO
         igKzsx67rRFcps+g9TcyShG4pYIWNHqI5FjRVHOv6rVfM5pAERalOBbTlM0rRduUJyKE
         NOeA==
X-Received: by 10.224.79.146 with SMTP id p18mr28100509qak.67.1414697062936;
 Thu, 30 Oct 2014 12:24:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Thu, 30 Oct 2014 12:24:02 -0700 (PDT)
In-Reply-To: <54521C65.8060603@cogentembedded.com>
References: <1414635488-14137-1-git-send-email-cernekee@gmail.com>
 <1414635488-14137-9-git-send-email-cernekee@gmail.com> <54521C65.8060603@cogentembedded.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Thu, 30 Oct 2014 12:24:02 -0700
Message-ID: <CAJiQ=7BekWsmcDfQ-oKXAza_pEXHNFCQAisvo2m+D7Km2t_meQ@mail.gmail.com>
Subject: Re: [PATCH V2 08/15] irqchip: bcm7120-l2: Eliminate bad IRQ check
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Thu, Oct 30, 2014 at 4:09 AM, Sergei Shtylyov wrote:
>> diff --git a/drivers/irqchip/irq-bcm7120-l2.c
>> b/drivers/irqchip/irq-bcm7120-l2.c
>> index b9f4fb8..49d8f3d 100644
>> --- a/drivers/irqchip/irq-bcm7120-l2.c
>> +++ b/drivers/irqchip/irq-bcm7120-l2.c
>
> [...]
>>
>> @@ -51,19 +49,12 @@ static void bcm7120_l2_intc_irq_handle(unsigned int
>> irq, struct irq_desc *desc)
>>         chained_irq_enter(chip, desc);
>>
>>         status = __raw_readl(b->base + IRQSTAT);
>> -
>> -       if (status == 0) {
>> -               do_bad_IRQ(irq, desc);
>> -               goto out;
>> -       }
>> -
>>         do {
>
>
>    I think this needs to now become:
>
>         while (status) {
>
>>                 irq = ffs(status) - 1;
>>                 status &= ~(1 << irq);
>
>
>    In case 'status' is 0, 'irq' will be equal to -1. How does the shift by
> negative value work?
>
>>                 generic_handle_irq(irq_find_mapping(b->domain, irq));
>>         } while (status);

That's a good point.  We need to check for 0 somehow.

This code gets replaced in patch 13/15 anyway, but I'll fix it in the
next round.

Thanks!
