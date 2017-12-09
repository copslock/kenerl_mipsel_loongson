Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Dec 2017 22:04:16 +0100 (CET)
Received: from mail-it0-x234.google.com ([IPv6:2607:f8b0:4001:c0b::234]:38876
        "EHLO mail-it0-x234.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990421AbdLIVEJbrM05 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Dec 2017 22:04:09 +0100
Received: by mail-it0-x234.google.com with SMTP id r6so9313740itr.3
        for <linux-mips@linux-mips.org>; Sat, 09 Dec 2017 13:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Bod7kIHrz0OfXlOC8BH24PF/a38T6dyLGxw8FEo5BIs=;
        b=RNygVlDZcKr7TydcwipdDp9N1/hQXgI5dtW9xJyDLQuoXFb6bDeYNnTai8wYZGvxnU
         H6wgeTayuBlWzxS0BnBaxMg7CJuHHHyZD3CdxnFt9VfuFAdkQ1RfqN6kroxr0dcd1uRV
         noR+CZSDYC/3GYwQZch2s3So9zTQvGD6UcY3RrwAULmmilSleGn1jSfFRSYOfoaHHB/u
         KiylHbTvlI2pb7kXpYwdPzSVt0wW7YLBncC2/SKnA2Q/O+SKH0TpH+CBdYBhDfoyBFsQ
         J1O0bhXnY/eVRqa4FuQXXOG+Y6otA4VxLbC1hqI9vgCyKOzjemwcCRcyArCaeV/Q8FoO
         1e9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Bod7kIHrz0OfXlOC8BH24PF/a38T6dyLGxw8FEo5BIs=;
        b=uHBZVOw2+sEk4M8EqNlIbtm36uttB7slNd5N1Fji90pX+oplY5K5gRtUgpb93+6X5T
         8dAdqJpv50WOxHB3oBVBjU5n+tTdaIIQLIqzCcyj3S5vBFSwe/4JsywsjiBsEQFoUgwn
         PoQEjguiWH99OSm6yzUZz1BoyFtVXGK2wbPSErt+Dyp0aqqh1X798Gd9pSquAiJZT1b5
         EZ5pwADGYBJR16ALky1BVRzBE5WqtpcJueApP7zRzsr6+dh2eaKCycVg3Rlkc5bkecMX
         AIkGGuIJUMaeMi25ijKHEbbcBqz/hCgVR2hac/vSwnfFJtassW95dNaXwjCRs8uJIzer
         QjgQ==
X-Gm-Message-State: AKGB3mKim99O6v/qlyyPYKCScyWQPkv+JmPH2axfNqgN8g0f2MNQ9HoW
        n6Os7eGHXn5pZs2ESo92AyGzCbTsJlH9ZM4Mjnc=
X-Google-Smtp-Source: AGs4zMblZeNToTLQTS9VAnbluc9X5vfBKN44pGi7iwHTJtXIhv2lByL5PHYyuYixjAb9l2bW7FONn0a4C+oQt5RHI4s=
X-Received: by 10.36.189.140 with SMTP id x134mr12233578ite.26.1512853442971;
 Sat, 09 Dec 2017 13:04:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.152.46 with HTTP; Sat, 9 Dec 2017 13:03:42 -0800 (PST)
In-Reply-To: <1512767781.25033.30.camel@gmail.com>
References: <CAEdQ38HcOgAT6wJWWKY3P0hzYwkBGSQkRSQ2a=eaGmD6c6rwXA@mail.gmail.com>
 <CAEdQ38G4VTXDGOarmmTac=hP92VJbQHRFxQTaSWQ3j4d63pogg@mail.gmail.com>
 <CAEdQ38HcPswBk3pUHzQerFZ=4KjPc5nVYTqNnGQNMk7QbPXuOQ@mail.gmail.com>
 <CANn89iJKGRLVNAE99JWiyXcOXveytkjbQAiZ9XPiJc6fyEdFVA@mail.gmail.com>
 <1512741164.25033.28.camel@gmail.com> <CAEdQ38HEduSTY38Noj4peaMN_G++5sLJfqzCMkd3M4pPNTpU_Q@mail.gmail.com>
 <1512767781.25033.30.camel@gmail.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Sat, 9 Dec 2017 13:03:42 -0800
Message-ID: <CAEdQ38H+jUF3OXpe13Vfm=QZE3iHa=B7PpXkpbek1PnY2E1u5w@mail.gmail.com>
Subject: Re: NFS corruption, fixed by echo 1 > /proc/sys/vm/drop_caches --
 next debugging steps?
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        linux-nfs@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
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

On Fri, Dec 8, 2017 at 1:16 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> On Fri, 2017-12-08 at 12:26 -0800, Matt Turner wrote:
>>
>> Thanks for the quick reply!
>>
>> I tried the patch on top of master, but unfortunately the corruption
>> still occurs.
>
> You might try replacing in sbdma_add_rcvbuffer()
>
> sb_new = netdev_alloc_skb(dev, size);
>
> by
>
> sb_new = alloc_skb(size, GFP_ATOMIC);
>
> Maybe the device does not like having a frame spanning 2 pages.

No such luck. I also gave changing the page size from 16K to 4K a shot
without success.
