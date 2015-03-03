Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Mar 2015 14:06:32 +0100 (CET)
Received: from mail-yh0-f50.google.com ([209.85.213.50]:40907 "EHLO
        mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006861AbbCCNGbPefK8 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Mar 2015 14:06:31 +0100
Received: by yhot59 with SMTP id t59so18082890yho.7
        for <linux-mips@linux-mips.org>; Tue, 03 Mar 2015 05:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=TjRanJmaNAF28/YbVilBJgcGHJFOiK9LGLp972Htx7s=;
        b=Xm3ieU+tf36HM+i9HW24RxQw7//8MKWFftIY1MISB9oLVoEOIeRVtKJCzS8f4sJmYk
         pFkwSABtj9huONEKI1zGWnADw6gJCjIbVYeFS5ZIscZdwqwt6ZhYMoVbAmll0+uSeQaz
         dFTcgI8v1GNhrJkDzFsroXbeviO6PapF1IE/U/2JcgrvAYblOOwptUwA7SK9oxsQOg23
         COkMfGe0gh2IP5CBSMOMQi92yPUWQ6tgwblTRQinkLMs9JnWrD5xLeLsTWYbE8yUYn/R
         kUuurjKRb/QfqgQryc1Gh9uMhsGPG3+a7HvRndvP63nopHupyViKrrqsVbCKOQdwnlf8
         /C+A==
X-Received: by 10.236.96.232 with SMTP id r68mr31263378yhf.73.1425387985997;
 Tue, 03 Mar 2015 05:06:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.170.186.67 with HTTP; Tue, 3 Mar 2015 05:06:05 -0800 (PST)
In-Reply-To: <CACna6rx+3TbNfLmT1Br-JjhDnTQLrFFtVzfmid=yOdBfcOwHoA@mail.gmail.com>
References: <CACna6rx+3TbNfLmT1Br-JjhDnTQLrFFtVzfmid=yOdBfcOwHoA@mail.gmail.com>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Tue, 3 Mar 2015 17:06:05 +0400
Message-ID: <CAHNKnsRKFSutwKHtOY9QZTqBr_+2q4atuo=mg7QOBj35ipuUYQ@mail.gmail.com>
Subject: Re: Looking for an idea/workaround for using MIPS ioremap_nocache
 (__ioremap) in IRQ
To:     =?ISO-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

Hello Rafał,

2015-02-16 10:35 GMT+03:00 Rafał Miłecki <zajec5@gmail.com>:
> Hi,
>
> Once I've hit
> BUG_ON(in_interrupt());
> when hacking PCI drivers locally on MIPS board. I see the problem but
> don't know the solution.
>
> 1) I think "read" and "write" of struct pci_ops should be safe to call
> in IRQ handler
> 2) In drivers/bcma/driver_pci_host.c we use ioremap_nocache
>
> This causes a problem for boards with 2 PCI(e) cards. The base address
> for the 2nd card is
> #define BCMA_SOC_PCI1_CFG               0x44000000U
> which doesn't allow MIPS to use KSEG1.
>
> As the result forwardtrace looks like this:
> 1) ioremap_nocache
> 2) __ioremap_mode
> 3) __ioremap
> 4) get_vm_area
> 5) __get_vm_area_node
> And then we can hit BUG_ON(in_interrupt());
>
> Can you see any solution for this? Currently there isn't any mainline
> code triggering this problem, but it would be nice to have everything
> working anyway.
>
Why do you need to read the PCI configuration space in the interrupt
handler? As you wrote, it uncommon that driver tries to do that.
Usually the PCI configuration read/updated during device
initialization stage (by the PCI core and by a device driver) and then
you interact with the I/O memory and not with the configuration space.

>
> As one of workarounds I was thinking about mapping whole space early.
> Unfortunately there are many possible registers (0xffff), few PCI
> functions (0x30000), many possible PCI devices (0xf80000). It's way to
> big space I guess to keep it mapped all the time.
>
Actual number of slots is much less than 0xf80000, so if you know it
(e.g. from DT) then you could do remapping earlier during the PCI
controller initialization.

-- 
Sergey
