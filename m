Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 14:43:00 +0100 (CET)
Received: from mail-wr0-x22e.google.com ([IPv6:2a00:1450:400c:c0c::22e]:39580
        "EHLO mail-wr0-x22e.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990431AbdLHNmxkMkgZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Dec 2017 14:42:53 +0100
Received: by mail-wr0-x22e.google.com with SMTP id a41so10871260wra.6
        for <linux-mips@linux-mips.org>; Fri, 08 Dec 2017 05:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=byJ6j7fzTu11u/PghVHPHgIXmoZ//ii3/n5mj6THXVE=;
        b=wXBWyptZHKxW0OdjLNNisa5lYJk0/7J/hFn4QlvYhjDz60kvemyQXc+kQVfXyTYK6I
         V0fXc7rOOpw5uCTmuy5nW4PDPjT2afSl9V+kaBHDMbvDoz4/iIugvqqupus6sk1EyGvC
         K11t8PfLAgZ60OWnZevhhv0BVYijdFSaacCn0jUFUTHcawPpGNSIr7Hub0wQpe8e0Esc
         WmzvGoHHtSqWxPscn3OQrQmcKU+7FByoBGtS5sofS/1XmkSo94lfsDb5TYXm2LMV0vaR
         GfXSgOBStAC2e6p9r8R7TA953X8XiIZU8/xTN9HLK45dgpXCMWoknAxL8XdVhIG8cpuq
         JoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=byJ6j7fzTu11u/PghVHPHgIXmoZ//ii3/n5mj6THXVE=;
        b=fHByXnnR8Ne2CK3DnU/fx1BZzoaWUa8nvuckGGgtBwMjMqzeIgtwx1IKBZ2hhWt2a+
         gV7eLav39RQ73lV7lo7m2YNHts0Bw4/n9riPwodGrwjN9D3sWQZKGlUbDVQ3L/DKnB5H
         DOeTydGD3dpYkDov3T5kR8NXpF9Y1l8rNoYMEM1J0vqdwz3QO3qeDh92N5jciLIxEm0S
         r4igSaBD0m/Fyf8TCaGZ0+fogR1g5GYbXWZrWkWxz8wHRCcG3btOUWMpKuPQoGxr4WLT
         kv2muIOQYpGOOeDbF/1GbFYqIg2WG7biY0gpOaChk0K+tZ/f5jPUpRYD1IjLKJXjKSCC
         48IA==
X-Gm-Message-State: AJaThX7HCJJILdxEH8ote21H3FPsKZXK+WFE1lOE0rBizglKQhhtU8R9
        E8+MyvMYvczW1wx9RT8OGZCIumn+uRvhdTa27RIR6g==
X-Google-Smtp-Source: AGs4zMaEEIWsoOwVfwNADmnfMUYcl+t0B5mHvAYczswM8PtUEkJ2aCnpZqr2WsL0jnnij45N2bUCFT78BWJsgmqO1gs=
X-Received: by 10.223.166.51 with SMTP id k48mr26036685wrc.125.1512740567686;
 Fri, 08 Dec 2017 05:42:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.124.17 with HTTP; Fri, 8 Dec 2017 05:42:46 -0800 (PST)
In-Reply-To: <CAEdQ38HcPswBk3pUHzQerFZ=4KjPc5nVYTqNnGQNMk7QbPXuOQ@mail.gmail.com>
References: <CAEdQ38HcOgAT6wJWWKY3P0hzYwkBGSQkRSQ2a=eaGmD6c6rwXA@mail.gmail.com>
 <CAEdQ38G4VTXDGOarmmTac=hP92VJbQHRFxQTaSWQ3j4d63pogg@mail.gmail.com> <CAEdQ38HcPswBk3pUHzQerFZ=4KjPc5nVYTqNnGQNMk7QbPXuOQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 8 Dec 2017 05:42:46 -0800
Message-ID: <CANn89iJKGRLVNAE99JWiyXcOXveytkjbQAiZ9XPiJc6fyEdFVA@mail.gmail.com>
Subject: Re: NFS corruption, fixed by echo 1 > /proc/sys/vm/drop_caches --
 next debugging steps?
To:     Matt Turner <mattst88@gmail.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        linux-nfs@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <edumazet@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: edumazet@google.com
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

On Thu, Dec 7, 2017 at 11:54 PM, Matt Turner <mattst88@gmail.com> wrote:
> On Thu, Dec 7, 2017 at 11:00 PM, Matt Turner <mattst88@gmail.com> wrote:
>> On Sun, Mar 12, 2017 at 6:43 PM, Matt Turner <mattst88@gmail.com> wrote:
>>> On a Broadcom BCM91250a MIPS system I can reliably trigger NFS
>>> corruption on the first file read.
>>>
>>> To demonstrate, I downloaded five identical copies of the gcc-5.4.0
>>> source tarball. On the NFS server, they hash to the same value:
>>>
>>> server distfiles # md5sum gcc-5.4.0.tar.bz2*
>>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2
>>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.1
>>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.2
>>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.3
>>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.4
>>>
>>> On the MIPS system (the NFS client):
>>>
>>> bcm91250a-le distfiles # md5sum gcc-5.4.0.tar.bz2.2
>>> 35346975989954df8a8db2b034da610d  gcc-5.4.0.tar.bz2.2
>>> bcm91250a-le distfiles # md5sum gcc-5.4.0.tar.bz2*
>>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2
>>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.1
>>> 35346975989954df8a8db2b034da610d  gcc-5.4.0.tar.bz2.2
>>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.3
>>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.4
>>>
>>> The first file read will contain some corruption, and it is persistent until...
>>>
>>> bcm91250a-le distfiles # echo 1 > /proc/sys/vm/drop_caches
>>> bcm91250a-le distfiles # md5sum gcc-5.4.0.tar.bz2*
>>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2
>>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.1
>>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.2
>>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.3
>>> 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.4
>>>
>>> the caches are dropped, at which point it reads back properly.
>>>
>>> Note that the corruption is different across reboots, both in the size
>>> of the corruption and the location. I saw 1900~ and 1400~ byte
>>> sequences corrupted on separate occasions, which don't correspond to
>>> the system's 16kB page size.
>>>
>>> I've tested kernels from v3.19 to 4.11-rc1+ (master branch from
>>> today). All exhibit this behavior with differing frequencies. Earlier
>>> kernels seem to reproduce the issue less often, while more recent
>>> kernels reliably exhibit the problem every boot.
>>>
>>> How can I further debug this?
>>
>> I think I was wrong about the statement about kernels v3.19 to
>> 4.11-rc1+. I found out I couldn't reproduce with 4.7-rc1 and then
>> bisected to 4cd13c21b207e80ddb1144c576500098f2d5f882 ("softirq: Let
>> ksoftirqd do its job"). Still reproduces with current tip of Linus'
>> tree.
>>
>> Any ideas? The board's ethernet is an uncommon device supported by
>> CONFIG_SB1250_MAC. Something about the ethernet driver maybe?
>
> With the patch reverted on master (reverts cleanly), NFS corruption no
> longer happens.

Hi Matt.

Thanks for bisecting.

Patch simply exposes an existing bug more often by changing the way
driver functions are scheduled.

Which is probably a good thing.

sbmac_intr() looks extremely suspicious to me.

A NAPI driver hard interrupt should simply schedule NAPI.

Apparently, if sbmac_intr() can not grab NAPIF_STATE_SCHED bit, it
directly calls sbdma_rx_process() from
hard interrupt context.

Insane really.
