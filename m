Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2018 03:20:26 +0200 (CEST)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:36787
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993497AbeEQBUSwTpwi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 May 2018 03:20:18 +0200
Received: by mail-qk0-x243.google.com with SMTP id l132-v6so2337760qke.3;
        Wed, 16 May 2018 18:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kKlULhrr8tBS6WKcB83pg6Dx8eIbLvf6X5KSbQgNgBM=;
        b=mJ2s26jIHSvbFGDoVyRaePckiteOHrgNWj0fjytumECn/WQXI679tcTfc0sZgGvi0v
         VD1vG63YkaNMbG9kVqakgh86XoXPxUaDtfUw+i3c5D9MooAR8ihLdyqppEHDVynFxQqO
         JkKig0anpYBy1WJMZHjIi2nk+1pX1g9b9O2VitEIiNt+cXtnCcghZT0FR+IsMMWpMcIN
         g0zyDHRcziNEYAYVgBNix8i9HccZzdxAn9ekmv/JljoNL8vsifS+LfayyGYTk4CqJdR9
         lSGMauedMgzBBbkbCGCnz4U/QM4FSopKOsxQHsnFKK91k4G1mFy9yr9y3b/OoMXH6ug/
         D4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=kKlULhrr8tBS6WKcB83pg6Dx8eIbLvf6X5KSbQgNgBM=;
        b=NaNIGqx6kgU1SbBR7ParMA8ikHVIibzKgn5DpfNHqtWAMbCyreG/UfEhZQ7xEbYrLC
         pvUVvbnKztDMMerViSIi5jPhZh7wQE1VZrXzPlaKVIMnp1KDH2pADCxp2v3Few0Oh47Y
         TaJ1qYNjzX9VrXe6xuSoJebJ8OkPZkHpE/zD0MLvAJebvmzBnr4Q/ohvlRhdqW11l9wk
         hh+JSms/q5WAU43AoIHJinHN/tTOAxsZ7Kpccllxn8zuRytAX0vRRGW8bli5Ha26mW/y
         LGlxodvW5HTfPfR0cpI/PVQkWdh3wxAr9tB9/vjUAu+zwN+iIvons0Udr2JoI/dcU+fA
         4ixA==
X-Gm-Message-State: ALKqPwcvU7IWZGilT/8fXXv+jTyn0edFrLBfmLocYvagjQT/buyhHHga
        bZtntSmuVWiqpg4iJIzgjBZQVnHiXviH0Tk098w=
X-Google-Smtp-Source: AB8JxZqzQ6nsBZBr/XMhXbm6VvxNKLpHVqXGAYBp/OvCuK5HXXYmTAFFKI4FG2asQM11UYPIL00taffH9GC4xM7knQk=
X-Received: by 2002:a37:6005:: with SMTP id u5-v6mr3163325qkb.32.1526520012606;
 Wed, 16 May 2018 18:20:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.185.3 with HTTP; Wed, 16 May 2018 18:20:12 -0700 (PDT)
In-Reply-To: <287ab070-0463-04a5-63fa-475c44752f56@gmail.com>
References: <20180504190530.1879-1-raj.khem@gmail.com> <e380a58d-fc9f-89e0-cc56-c3a0000a179b@mips.com>
 <287ab070-0463-04a5-63fa-475c44752f56@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 16 May 2018 21:20:12 -0400
X-Google-Sender-Auth: p36jRf1n4L8-E4-CBiyyFj--dxE
Message-ID: <CAK8P3a0NugcUSkLZkM8z1H8Xr2zpt0tFesSabu5hLKy8JbfYrA@mail.gmail.com>
Subject: Re: [PATCH] mips: Disable attribute-alias warnings
To:     Khem Raj <raj.khem@gmail.com>
Cc:     Matt Redfearn <matt.redfearn@mips.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Thu, May 10, 2018 at 12:03 PM, Khem Raj <raj.khem@gmail.com> wrote:
>
>
> On 5/10/18 2:34 AM, Matt Redfearn wrote:
>>
>> Hi Khem,
>>
>> On 04/05/18 20:05, Khem Raj wrote:
>>>
>>> This warning is seen with gcc-8
>>>
>>> error: 'sys_cachectl' alias between functions of incompatible types
>>> 'long int(char *, int,  int)'
>>> and 'long int(long int,  long int,  long int)'
>>>
>>> Signed-off-by: Khem Raj <raj.khem@gmail.com>
>>> Cc: Ralf Baechle <ralf@linux-mips.org>
>>> Cc: linux-mips@linux-mips.org
>>> ---
>>>   arch/mips/kernel/Makefile | 2 ++
>>>   arch/mips/mm/Makefile     | 1 +
>>>   2 files changed, 3 insertions(+)
>>>
>>> diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
>>> index f10e1e15e1c6..eb92e52eb3db 100644
>>> --- a/arch/mips/kernel/Makefile
>>> +++ b/arch/mips/kernel/Makefile
>>> @@ -2,6 +2,8 @@
>>>   #
>>>   # Makefile for the Linux/MIPS kernel.
>>>   #
>>> +CFLAGS_signal.o        += $(call cc-disable-warning, attribute-alias)
>>> +CFLAGS_syscall.o    += $(call cc-disable-warning, attribute-alias)
>>
>>
>> Rather than disabling the (potentially useful) warning for the whole
>> compilation unit, the better fix, I believe, would be something like Arnd
>> proposed https://patchwork.kernel.org/patch/10093317/ to disable it just for
>> the definition of the syscall entry point . Whatever happened to that RFC
>> Arnd?
>>
>
> I tend to agree. I think, I have also tested a patch where I am manually
> ignoring the warning via pragma around the function which essentially is
> similar to what Arnd has proposed only that Arnd's patch is generic

Sorry I never followed up on my initial patches. I still think we should do it
that way, but will need some more time until I can revisit them, as
I'm currently
travelling. If someone else wants to pick up my patches and post a
new version in the meantime, that would be greatly appreciated.

        Arnd
