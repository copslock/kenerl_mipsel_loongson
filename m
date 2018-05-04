Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 May 2018 01:53:18 +0200 (CEST)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:44540
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992457AbeEDXxLEFNFn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 May 2018 01:53:11 +0200
Received: by mail-qt0-x244.google.com with SMTP id d3-v6so29540372qtp.11;
        Fri, 04 May 2018 16:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ikhEBQEZYOec3YIXOUZkwgOJOVNAnF7bU/6voAfwOSc=;
        b=PTp3hqGgutmslLW91BrhFI9krg7/BTnZlklRdrDn5nYER1j31e9qYbn9jRmjew58AT
         OHBhHvCZRcd3VBJfP0pVjHwwtxuTPPamsfj/KVvCmwXxeNzfglqR7z01zpaoUGjErfth
         RCm878hhszUEtkiZKGIcwYw4kUcyPdSkHxFraj7a93MmUr6dFjvw/1EFIt4Li8kRWuHP
         LbEo/YTmUT2NMbPSNBWMUFdgsKYwiLO8EyBIBhB4Eq7iJUbqhIUzK5nOUrbijZsFI12h
         qP3SeUIgXCRbcWHtINW/Kl7CSn1quOzEsHe1lyqQaJr82Ap1JHwERyu7k8I1t0qzFpeX
         qWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ikhEBQEZYOec3YIXOUZkwgOJOVNAnF7bU/6voAfwOSc=;
        b=f0E86jWzeGZccBfNGGSbO8Z4qH62qKbVMpiT7CCRp9A0FVWHm913DVF/CT/ueagblj
         /M5yZG5PIozgM4BW/9ZwpaveP6PsOSnMie8+sditxM0UH/qgCAZsb3dnYFQ3dqd2EWxU
         TqJVxqVuNz+y5sLm6LSUiRlBY13nL/LRGcDxXHY2nwWD5Q/etVTYflGHLykEYniLtDS1
         ANCFTk2IrHY/c1vN/17HmIa46PxxtBNGW1FrVUYKmx3Z/19gZnfOyov4sQLUVA8BJHr1
         QErm0Z7DswVnbLQDnHSrJAHCpQh49Z6uK0dpv+sfgvGmLgNod6hWjQc3za9lYZnVEmAJ
         WvyQ==
X-Gm-Message-State: ALQs6tD70At+gqgk8ijesT6CjAQZJVJIzeThCbEeda6sFhAzLyyKSv1V
        5Vu59Q+KYnmHbl3FwTDjGnVISd/w6r8XgmA/b0Y=
X-Google-Smtp-Source: AB8JxZpgC/qkEraY/SpJfa2cUge20P9wkx0MGEndY6PmgUKBnh8SUynzW76EhW+Y0pVQAQ8WiRf2Gyfbg+1phZqnZy8=
X-Received: by 2002:a0c:bda4:: with SMTP id n36-v6mr22943054qvg.151.1525477984523;
 Fri, 04 May 2018 16:53:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.185.3 with HTTP; Fri, 4 May 2018 16:53:04 -0700 (PDT)
In-Reply-To: <20180504132432.GA30458@jamesdev>
References: <20180502215107.GA9884@saruman> <CAK8P3a2y2EA1g099DXOHkfevQb=6zuWmVOq9C_wVTQ8zrAMx8w@mail.gmail.com>
 <20180504132432.GA30458@jamesdev>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 4 May 2018 19:53:04 -0400
X-Google-Sender-Auth: qYL0jqhWVMIwwebPTbFPvDv-iWQ
Message-ID: <CAK8P3a1BvG+jHAmQu2j-_Gmmxc4s_KbccUGP0jvPGq6L+vtjdw@mail.gmail.com>
Subject: Re: Introducing a nanoMIPS port for Linux
To:     James Hogan <jhogan@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Matthew Fortune <Matthew.Fortune@mips.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63874
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

On Fri, May 4, 2018 at 9:24 AM, James Hogan <jhogan@kernel.org> wrote:
> On Thu, May 03, 2018 at 06:40:07PM -0400, Arnd Bergmann wrote:
>> On Wed, May 2, 2018 at 5:51 PM, James Hogan <jhogan@kernel.org> wrote:
>>
>> While I haven't looked at the individual changes, I wonder whether
>> it would be useful to make this new ABI use 64-bit time_t from
>> the start, using the new system calls that Deepa and I have been
>> posting recently.
>
> Personally I'm all for squeezing as much API cleanup in as possible
> before its merged, though obviously there'll be a point when the ABI may
> need to be frozen, at which point we'll mostly have to accept what we
> have within reason.
>
>> There are still a few things to be worked out:
>> only the first of four sets of syscall patches is merged so far,
>> and we have a couple of areas that will require further ABI changes
>> (sound, sockets, media and maybe a couple of smaller drivers),
>> so it depends on the overall timing. If you would otherwise merge
>> the patches quickly, then it may be better to just follow the existing
>> 32-bit architectures and add the 64-bit entry points when we do it
>> for everyone.
>
> I think it'll likely be a couple of cycles before it gets merged anyway.
> There's still work to do, and limited resources.

Ok, let's plan on getting the 64-bit time_t ABIs in place early enough
then. We will likely have very similar timing for the upcoming rv32
ABI on arch/riscv.

         Arnd
