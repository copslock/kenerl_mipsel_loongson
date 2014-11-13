Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 20:08:42 +0100 (CET)
Received: from mail-qc0-f176.google.com ([209.85.216.176]:40096 "EHLO
        mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013529AbaKMTIeDVA8e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Nov 2014 20:08:34 +0100
Received: by mail-qc0-f176.google.com with SMTP id x3so11711555qcv.35
        for <linux-mips@linux-mips.org>; Thu, 13 Nov 2014 11:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EmTyISJDKQonI8ekfhwES2dj5kteORIZqQCCppLUEs0=;
        b=eifiCKBrtmxtmuh/jl0myQGR2ZzfDjS/9QLMJ52Fk9uN7uk0JoXhI9Foz3+0rTPnVM
         LgFG/5IWuJiyptwSfSayzFEBN2ASptIe3vMR6mCB9t9Nmn3na/ZTHwJ07gLgCXeFPK5X
         gD66+YCvYf5mRorgL4hj+Yb7E+UISAe9c1TtBU5XTi0famSFCymdn9TPi826hjAxYXJB
         mLM+nFVcXP9DtzwcDdyPgpB6pmwAmIxiPDTAGZv+LnsxuPQOwy1JC+OAE7OzWBHVtc9y
         fD5nr72K4kUX5/yOr5QnoJL+g6MGpO8hipf/5p0Utf51xp7prilw7Eh8DqliqXXKBta7
         EpWg==
X-Received: by 10.224.115.82 with SMTP id h18mr5353461qaq.76.1415905708257;
 Thu, 13 Nov 2014 11:08:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Thu, 13 Nov 2014 11:08:08 -0800 (PST)
In-Reply-To: <4606459.kh8mb8TEgZ@wuerfel>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
 <3356477.HitZEsNa4H@wuerfel> <CAJiQ=7AFr5vR+FEc8B3CAZLb5GYujNxtaz7TU2FU0D3oModZ7w@mail.gmail.com>
 <4606459.kh8mb8TEgZ@wuerfel>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Thu, 13 Nov 2014 11:08:08 -0800
Message-ID: <CAJiQ=7DoFk7ZSjHygaMWHyBTpxJFbQX4onh2xqixaqORQODsVg@mail.gmail.com>
Subject: Re: [PATCH/RFC 5/8] serial: pxa: Make the driver buildable for
 BCM7xxx set-top platforms
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>,
        Rob Herring <robh@kernel.org>, daniel@zonque.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        robert.jarzmik@free.fr, Grant Likely <grant.likely@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44142
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

On Thu, Nov 13, 2014 at 1:42 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> TTY naming is a mess today, and you seem to be caught in the middle
> of it trying to work around the inherent problems. Extending the PXA
> driver is an interesting approach since as you say it's a very nice
> clean subset of the 8250 driver, but that doesn't mean that it's
> a good long-term strategy, as we will likely have more chips with
> 8250 variants.
>
> Some of the ways forward that I can see are:
>
> - (your approach) use and extend the pxa serial driver for new SoCs,
>   possibly migrate some of the existing users of 8250 to use that
>   and leave 8250 alone.
>
> - fix the problem you see in a different way, and get the 8250 driver
>   to solve your problem. Possibly integrate the pxa driver back into
>   8250 in eventually, as we did with the omap driver.

Do you think it might make sense to come up with a set of guidelines
that ensure that SoCs using a non-serial8250 driver (like pxa) on
16550-compatible hardware can be easily moved back to serial8250
someday?

e.g. maybe I should be adding a reg-shift property to my pxa DT entry.
It isn't necessary for pxa.c, but if we ever move to serial8250 it
will be necessary.

> - Do a fresh start for a general-purpose soc-type 8250 driver, using
>   tty_port instead of uart_port as the abstraction layer.

Hmm, does that mean we can't use the serial_core.c helpers?

>   Use that for
>   all new socs instead of extending the 8250 driver more, possibly
>   migrating some of the existing 8250 users.

One nice thing about a brand new driver is that we can use dynamic
major/minor numbers unconditionally without breaking existing users.
If either pxa.c or bcm63xx_uart.c had used dynamic numbers, I could
drop Tushar's original workaround.

Another advantage is that we can assume all users have DT, simplifying
the probe function.

Would it be helpful to split parts of pxa.c and/or serial8250 into a
"lib8250", similar to libahci, that can be called by many different
implementations (some of which have special features like DMA
support)?
