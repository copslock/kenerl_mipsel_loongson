Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Dec 2017 00:53:42 +0100 (CET)
Received: from mail-it0-x241.google.com ([IPv6:2607:f8b0:4001:c0b::241]:44695
        "EHLO mail-it0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990410AbdLNXxcOM5qK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Dec 2017 00:53:32 +0100
Received: by mail-it0-x241.google.com with SMTP id b5so15528712itc.3
        for <linux-mips@linux-mips.org>; Thu, 14 Dec 2017 15:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mOquwnKxR3ZFVYjXadbhKIIjqLzqPIA1PsJxuxe2G3U=;
        b=ETW9zwkGTD/cFKiJWf95tVscVvGto3SgQJn/EY8pGzzfOeR1lVMHLfpek2NlExh9or
         npGavhP2EhWRL273ZYXmRmsE9HiJ326GENfmX2rd1gZCIKwkc3wAr9s/eKzPB7jQ4Wxz
         0K1DW/yJ3ilcIC1263rLUFdTzuLtxxQZ2K3No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mOquwnKxR3ZFVYjXadbhKIIjqLzqPIA1PsJxuxe2G3U=;
        b=JLxYGP8CeNJAjqJZQrL6QBL76ohlnQPsuXHNoR1faDlWZJ1jBW+3MqOvpT16XudWFP
         Ffx4cfj0n8QjO8JVfoV3J2Ei/HcbUlQ3HQPxb1GjuTOnlOqdznCikkJ8ffPnaDOujkzV
         umDJypbuROW3jn50UBl1CjYigC1P1rDm0Uwjcjll/FirXzGO3Sii932oX8wzdBIy9HGH
         sCARUnYAOKriT2XOoicwoVKZ8liYswdQvTqf7tZlYRS4/5yGQ1k8GzOjt9TBnePho9sa
         tGWnYze3JdU7pYHQC2HJKK6I3m4fBbQ7uc8bLe9pEDHSItGkRCU7qBS6vkVz8eNdlz3d
         YPqg==
X-Gm-Message-State: AKGB3mJXBLmTZ/o4tH3S3j900mfPIh+ffN3Zx7jg8weD3aEdtCL9ev1a
        f83MgBgoGdV/ME8LUTObzinjjLvSq7H8f9RTxQ9F2g==
X-Google-Smtp-Source: ACJfBouJPpR37hD1fdyoU9euNAU1JJI9jE7/bxnHG1trnemG9DwMntDcwLhDSic3n9appUpN+dbK/cvu05fgPCA0qMQ=
X-Received: by 10.107.170.148 with SMTP id g20mr9169404ioj.175.1513295605550;
 Thu, 14 Dec 2017 15:53:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.87.84 with HTTP; Thu, 14 Dec 2017 15:53:25 -0800 (PST)
In-Reply-To: <CAOFm3uF_OjqK0cQ1A4Xkp8kZab+afqPsnF5rB9=a7Dym9jiU4w@mail.gmail.com>
References: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
 <20171208154618.20105-6-alexandre.belloni@free-electrons.com>
 <CACRpkdZ=+pFZYteq=wM=z-CGejY+dX_SqhtDbbGBn+q60arQ4w@mail.gmail.com> <CAOFm3uF_OjqK0cQ1A4Xkp8kZab+afqPsnF5rB9=a7Dym9jiU4w@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 15 Dec 2017 00:53:25 +0100
Message-ID: <CACRpkdZaaZArEhw3iWaQagrKa__+DcrzSY4i7PWNYwhUiNtm4A@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] pinctrl: Add Microsemi Ocelot SoC driver
To:     Philippe Ombredanne <pombredanne@nexb.com>
Cc:     Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61471
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

On Wed, Dec 13, 2017 at 10:23 AM, Philippe Ombredanne
<pombredanne@nexb.com> wrote:
> On Wed, Dec 13, 2017 at 9:15 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>
>> Wow never saw that before. OK I guess.
>
> That's the new thing. Less legalese boilerplate, and more code for the
> better IMHO.
>
> You can check the doc patches from Thomas for details [1]
>
> [1] https://lkml.org/lkml/2017/12/4/934

Yeah I'm aware of this part, but I didn't see that combined license
before.

What is the reason for not just using GPL 2 here?

Yours,
Linus Walleij
