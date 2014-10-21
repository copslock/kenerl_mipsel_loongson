Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 10:59:44 +0200 (CEST)
Received: from mail-yh0-f42.google.com ([209.85.213.42]:44926 "EHLO
        mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012007AbaJUI7lb8C8j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 10:59:41 +0200
Received: by mail-yh0-f42.google.com with SMTP id t59so1019426yho.15
        for <multiple recipients>; Tue, 21 Oct 2014 01:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Rqbuia/01eAcApccgn3C5vLzpdzWqo58hBxwi3PHjks=;
        b=yxqN4pOUEqCf54vD4PHLHK4wF8W+P4TsCHwuGyzXeOOt1DDhcqjRWOFpLmpvGey49L
         S7VCbWciM6Hx4IeexLDYbgGeAF7WOvxYJT/38naIhmHSaXKUtt4c36jBkv8QmHe49o3O
         0wIjvKFSg3pFKX7cjNVRB9pQ7Rv+Hvr40uFiBYAq4hHD9VyCZVHxjJOyZc45Eww/IQX1
         UfG8BvD9s1hqJrkD6M0SQ2+ydyGmQAfMaomGJrWgFQIUYvwZtKhILzwYebodjase6XHR
         QliKsWNQZoigJ/A7vspyPMXo7VthYyWheA8du1oKuc4OWTtul06t3a0UhfPv4m+7NSpn
         bbrA==
X-Received: by 10.236.201.102 with SMTP id a66mr47036688yho.1.1413881975261;
 Tue, 21 Oct 2014 01:59:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.170.153.196 with HTTP; Tue, 21 Oct 2014 01:59:15 -0700 (PDT)
In-Reply-To: <CACRpkda7XffyCvsG7CAMwF0qDW9bJ_m+xxFhhMAqd_r=O4B8+g@mail.gmail.com>
References: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
 <1410723213-22440-10-git-send-email-ryazanov.s.a@gmail.com>
 <CACRpkda3Cq+d47DMm018nAC7ThcHAOv-tOqEbNsUY1mOSnKyoA@mail.gmail.com>
 <CAHNKnsSj-=0aFHD574yRW9BpH1ONhy7K0NA8xri2ez6ab_MPMA@mail.gmail.com> <CACRpkda7XffyCvsG7CAMwF0qDW9bJ_m+xxFhhMAqd_r=O4B8+g@mail.gmail.com>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Tue, 21 Oct 2014 12:59:15 +0400
Message-ID: <CAHNKnsThQb8zstGhRJjFFJx6eKtFd-NZuK9wND-Puex2OCY=Hw@mail.gmail.com>
Subject: Re: [RFC 09/18] gpio: add driver for Atheros AR5312 SoC GPIO controller
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43418
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

2014-10-21 12:29 GMT+04:00 Linus Walleij <linus.walleij@linaro.org>:
> On Mon, Sep 29, 2014 at 10:43 PM, Sergey Ryazanov
> <ryazanov.s.a@gmail.com> wrote:
>> 2014-09-29 13:18 GMT+04:00 Linus Walleij <linus.walleij@linaro.org>:
>
>>>> +static u32 ar2315_gpio_intmask;
>>>> +static u32 ar2315_gpio_intval;
>>>> +static unsigned ar2315_gpio_irq_base;
>>>> +static void __iomem *ar2315_mem;
>>>
>>> Get rid of these local variables and put them into an allocated
>>> state container, see
>>> Documentation/driver-model/design-patterns.txt
>>>
>> AR2315 SoC contains only one GPIO unit, so there are no reasons to
>> increase driver complexity. But if you insist, I will add state
>> container.
>
> I insist. It makes the driver easier to maintain if it looks like
> most other drivers instead of using static locals.
>
No problem. I rewrite the driver using the state container.

>>> Convoluted, I would use an if() else construct rather than the ? operator.
>>>
>> Convoluted, but 3 lines shorter :) And checkpatch has no objections.
>
> True but it's me who is going to be maintaining this, not checkpatch.
>
I missed that. Added to my todo list.

BTW, the use of the irq_domain framework is required or I could
opencode some stuff?

> Yours,
> Linus Walleij

-- 
BR,
Sergey
