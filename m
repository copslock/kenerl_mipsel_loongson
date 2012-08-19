Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Aug 2012 22:53:39 +0200 (CEST)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:57742 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901170Ab2HSUxc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Aug 2012 22:53:32 +0200
Received: by eekc13 with SMTP id c13so1302747eek.36
        for <multiple recipients>; Sun, 19 Aug 2012 13:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Lo+oKXb+x5p01o9UBWSHaCyBPxs/W6V8LaXBZIR65OI=;
        b=IYdwnknno7Pt19gKcXJizipFl/iiDO//johp4U+nw6JVqUZsM3bh8Kx0Qh/Ex5klpY
         uwzRKUBe7omewy0GFHXMcJPDSsblLG+b+Laj/vr+IPedtCLqtnYvSiJU/aiLyraXBN3B
         +fMqnJE+rtRLYHa0MeM11qN6GZiAkHghkPmY5VJ+yO3Uc1LP99vMUMepPmyv6KR3FDDJ
         ig3NMrPEfMDAbGToxVRHxVWxuJVqxVPdhLVMUvoxURY63TmD0fXIogYfjmlwXqwTEtid
         XLx0b4Q6VaBkzerKqyomELomJ6kN2SCq8YLvnwYhmC0z5YtngaEDRN7rkJtiq25bpCU7
         BDhQ==
MIME-Version: 1.0
Received: by 10.14.203.73 with SMTP id e49mr5805167eeo.27.1345409606949; Sun,
 19 Aug 2012 13:53:26 -0700 (PDT)
Received: by 10.14.179.71 with HTTP; Sun, 19 Aug 2012 13:53:26 -0700 (PDT)
In-Reply-To: <20120819201714.GA3152@breakpoint.cc>
References: <97cb21b8063a02a9664baf8b749ae200@localhost>
        <20120819201714.GA3152@breakpoint.cc>
Date:   Sun, 19 Aug 2012 13:53:26 -0700
Message-ID: <CAJiQ=7CADk_75U5=OQH8vXA=xtj-U=TbBhXzC8JfUGbYEKmxng@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: bcm63xx UDC driver
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc:     balbi@ti.com, ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34281
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sun, Aug 19, 2012 at 1:17 PM, Sebastian Andrzej Siewior
<sebastian@breakpoint.cc> wrote:
> On Sat, Aug 18, 2012 at 10:18:01AM -0700, Kevin Cernekee wrote:
>
> This is a quick look :)

Thanks for the review.

>> +     for (i = 0; i < NUM_IUDMA; i++)
>> +             if (udc->iudma[i].irq == irq)
>> +                     iudma = &udc->iudma[i];
>> +     BUG_ON(!iudma);
>
> This is rough. Please don't do this. Bail out in probe or print an error here
> and return with IRQ_NONE and time will close this irq.

OK, I will change it to warn + return IRQ_NONE, instead of BUG().

That situation shouldn't ever happen anyway.  It would mean that our
ISR is getting called with somebody else's IRQ number, or the iudma
structs were corrupted.

Probe does bail out if any of the IRQ resources are missing.

>> +     for (i = 0; i < NUM_IUDMA + 1; i++) {
>> +             int irq = platform_get_irq(pdev, i);
>> +             if (irq < 0) {
>> +                     dev_err(dev, "missing IRQ resource #%d\n", i);
>> +                     goto out_uninit;
>> +             }
>> +             if (devm_request_irq(dev, irq,
>> +                 i ? &bcm63xx_udc_data_isr : &bcm63xx_udc_ctrl_isr,
>> +                 0, dev_name(dev), udc) < 0) {
>> +                     dev_err(dev, "error requesting IRQ #%d\n", irq);
>> +                     goto out_uninit;
>> +             }
>> +             if (i > 0)
>> +                     udc->iudma[i - 1].irq = irq;
>> +     }
>
> According to this code, i in iudma[] can be in 1..5. You could have more than
> one IRQ. The comment above this for loop is point less. So I think if you can
> only have _one_ idma irq than you could remove the for loop in
> bcm63xx_udc_data_isr().

There are 6 IUDMA channels, and each one always has a dedicated
interrupt line.  IRQ resource #0 is the control (vbus/speed/cfg/etc.)
IRQ, and IRQ resources #1-6 are the IUDMA (IN/OUT data) IRQs.  Maybe
it would be good to add a longer comment to clarify this?

An earlier iteration of the code had passed in an IRQ range, which
worked for 6328, but then it was pointed out that the IRQ numbers are
not contiguous on all platforms.  So 7 individual resources are indeed
necessary.
