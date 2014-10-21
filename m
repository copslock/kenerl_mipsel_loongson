Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 10:29:35 +0200 (CEST)
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36331 "EHLO
        mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012007AbaJUI3dsG4de (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 10:29:33 +0200
Received: by mail-ig0-f179.google.com with SMTP id h18so890118igc.0
        for <linux-mips@linux-mips.org>; Tue, 21 Oct 2014 01:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=3ttcazI9p1EwJ3SpNCJQWpBLOhtHTeoBJ35v9NIYwfo=;
        b=dEgh7TwfLIKpjkzScsXgjIYHvVX/g0dTePEyWTHfwkEKBlZY2LO1uCuGL+LH03HQXH
         GIu2JfeIdXOXzNH/mO7qZTG2GwhCHzE5wgVF5qGFy3bz4wjq1jwyHVR0m0jJR2SNWyj/
         zPqZgfeDl0W2mkHowvV4z4Bn1+zfy7rdRjGqMveGgBoYrhwaW7UpfBgIFJ94cHzp02yy
         XRidlXHoDRjaZfFJkZCIIToVtOJlh913ZuCzFNbYguIwGV5jf7fNGL0rYfZqo3hz/2G4
         4d2G1VMianYZh6jybtuStufhURJzWiomBwSl9ZWQey8Bmh2/qryBfu/0L0+egctU4MtA
         O67w==
X-Gm-Message-State: ALoCoQkaM1l5v3yRHDWvuDGVizf557Bin75/pSltv8mZvL1AoZhYxqrYGuDyaRsstW7BkrgVmluy
MIME-Version: 1.0
X-Received: by 10.50.117.104 with SMTP id kd8mr24216424igb.3.1413880167350;
 Tue, 21 Oct 2014 01:29:27 -0700 (PDT)
Received: by 10.43.102.201 with HTTP; Tue, 21 Oct 2014 01:29:27 -0700 (PDT)
In-Reply-To: <CAHNKnsSj-=0aFHD574yRW9BpH1ONhy7K0NA8xri2ez6ab_MPMA@mail.gmail.com>
References: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
        <1410723213-22440-10-git-send-email-ryazanov.s.a@gmail.com>
        <CACRpkda3Cq+d47DMm018nAC7ThcHAOv-tOqEbNsUY1mOSnKyoA@mail.gmail.com>
        <CAHNKnsSj-=0aFHD574yRW9BpH1ONhy7K0NA8xri2ez6ab_MPMA@mail.gmail.com>
Date:   Tue, 21 Oct 2014 10:29:27 +0200
Message-ID: <CACRpkda7XffyCvsG7CAMwF0qDW9bJ_m+xxFhhMAqd_r=O4B8+g@mail.gmail.com>
Subject: Re: [RFC 09/18] gpio: add driver for Atheros AR5312 SoC GPIO controller
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Mon, Sep 29, 2014 at 10:43 PM, Sergey Ryazanov
<ryazanov.s.a@gmail.com> wrote:
> 2014-09-29 13:18 GMT+04:00 Linus Walleij <linus.walleij@linaro.org>:

>>> +static u32 ar2315_gpio_intmask;
>>> +static u32 ar2315_gpio_intval;
>>> +static unsigned ar2315_gpio_irq_base;
>>> +static void __iomem *ar2315_mem;
>>
>> Get rid of these local variables and put them into an allocated
>> state container, see
>> Documentation/driver-model/design-patterns.txt
>>
> AR2315 SoC contains only one GPIO unit, so there are no reasons to
> increase driver complexity. But if you insist, I will add state
> container.

I insist. It makes the driver easier to maintain if it looks like
most other drivers instead of using static locals.

>> Convoluted, I would use an if() else construct rather than the ? operator.
>>
> Convoluted, but 3 lines shorter :) And checkpatch has no objections.

True but it's me who is going to be maintaining this, not checkpatch.

Yours,
Linus Walleij
