Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Dec 2017 09:00:09 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:33018
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990410AbdLOIACMiFD0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Dec 2017 09:00:02 +0100
Received: by mail-wm0-x241.google.com with SMTP id g130so29560638wme.0
        for <linux-mips@linux-mips.org>; Fri, 15 Dec 2017 00:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexb-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UHTrDQk9k1IvxcCl5q3UFJEbRXDVovLlk/u7DPp4npA=;
        b=PVBIIrnI0ZU8rtfKwH4ZN0fIytJmsBul+I6m9tDW43vRejBNlBZVyC/DDo2ff/XJGO
         IkiDIAgpHBHbJ6O0b/EWRW/Uf2zkUxX0+SUXQf4kxLQPKzZ1+M7R+ZKNKh9JmFgjfVt7
         maFgfIf/d6F6IKdYm1EFbtWPKULwbPuMb8wp1yxbzjX2FNge7z2P3H8ZaT4ZGzqNFfPo
         bVtY2sFZsygbZ9DrsymavRUiKJIO/DKQvyKmu83GzP/kntwENGY177WdF6/576qnwQT8
         Fe8k0DD+HgBd65XtGyeqGSd2IYsxVwS2ivx/x2bWHWhtpa+wcNyG/X0L0aXlcADDEQid
         YbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UHTrDQk9k1IvxcCl5q3UFJEbRXDVovLlk/u7DPp4npA=;
        b=Ov4CySQwOPQS9WNnGi+LRAwIVwGwUUXKYjYvDVnQt8jxX23NYadWU3w2f9QT0Xy6gJ
         7ns6ILnxMN4xIZYavLV+g1/nsSKkSfo/9Z3mRae/uZ44ZMcCGFiZGWoyUbCK9uzwAdvb
         spd+bX71UkZP1i3bGiCuqbn66yUgXvX3zXXxq7TzIbGkbtuOS7EKZzw+NgnPWoVgSp0L
         z9p/nWf3LrgpcRi3LlG9FKDwlEu4GkHeHG4OA4wPDu44qghDP53B56dY7YkE0QzM//ZI
         HRbYGWys6en7mn0XgVZxQ5pN1dVFy8Q8cS09oJ2Adp+sN/dun8NmNuJvXnqUQrne4jyu
         KCXA==
X-Gm-Message-State: AKGB3mKYwqkL+gsEdF1p2iIA0v2foQgsXRBTyx1uEPKZch9GgTa7auu2
        +j6snZAZDloKYHreEA6RMuDi0rlxTHpDxmdap08sIw==
X-Google-Smtp-Source: ACJfBoumSAUVL8KoatN+nIX6wooW2BZfOaLv4v/mYyli2UGNqj5I3+HQrPXx+Ph1nlKlB9a5+H7PjvlliZR6qfzHM/U=
X-Received: by 10.28.26.139 with SMTP id a133mr4285662wma.90.1513324796464;
 Thu, 14 Dec 2017 23:59:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.157.195 with HTTP; Thu, 14 Dec 2017 23:59:15 -0800 (PST)
In-Reply-To: <CACRpkdZaaZArEhw3iWaQagrKa__+DcrzSY4i7PWNYwhUiNtm4A@mail.gmail.com>
References: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
 <20171208154618.20105-6-alexandre.belloni@free-electrons.com>
 <CACRpkdZ=+pFZYteq=wM=z-CGejY+dX_SqhtDbbGBn+q60arQ4w@mail.gmail.com>
 <CAOFm3uF_OjqK0cQ1A4Xkp8kZab+afqPsnF5rB9=a7Dym9jiU4w@mail.gmail.com> <CACRpkdZaaZArEhw3iWaQagrKa__+DcrzSY4i7PWNYwhUiNtm4A@mail.gmail.com>
From:   Philippe Ombredanne <pombredanne@nexb.com>
Date:   Fri, 15 Dec 2017 08:59:15 +0100
Message-ID: <CAOFm3uFsM5Bbb2V-HYKf1kJgHokjUkuRLTht+7gO=-sxJ50faA@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] pinctrl: Add Microsemi Ocelot SoC driver
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <pombredanne@nexb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pombredanne@nexb.com
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

Alexandre, Linux

On Fri, Dec 15, 2017 at 12:53 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Wed, Dec 13, 2017 at 10:23 AM, Philippe Ombredanne
> <pombredanne@nexb.com> wrote:
>> On Wed, Dec 13, 2017 at 9:15 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>>
>>> Wow never saw that before. OK I guess.
>>
>> That's the new thing. Less legalese boilerplate, and more code for the
>> better IMHO.
>>
>> You can check the doc patches from Thomas for details [1]
>>
>> [1] https://lkml.org/lkml/2017/12/4/934
>
> Yeah I'm aware of this part, but I didn't see that combined license
> before.
>
> What is the reason for not just using GPL 2 here?

Linus,
That'a a question for Alexandre that submitted this patch in the first
place, not me.

Alexandre?

-- 
Cordially
Philippe Ombredanne
