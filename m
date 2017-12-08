Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 21:27:19 +0100 (CET)
Received: from mail-io0-x231.google.com ([IPv6:2607:f8b0:4001:c06::231]:41582
        "EHLO mail-io0-x231.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990474AbdLHU1NCwnWX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Dec 2017 21:27:13 +0100
Received: by mail-io0-x231.google.com with SMTP id o2so199030ioe.8
        for <linux-mips@linux-mips.org>; Fri, 08 Dec 2017 12:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PD1FTep9S3zs1MDY62fLxL6s8lyjarET41DJmFd9Zhc=;
        b=VwqRb0aSqHbMQi4vk8eExf9UsOgDtoELxOB2pLLzxPvJFhnf9RPYbz33rnZ615h5B2
         wdl5c+4K8IjvcREBAVKASHyUOWFr6xcfcxDYLaucnZVqpxDArYzDyqTcSe/X5PRsw3Fe
         S4XdnFvM1WPoEIXNWSS/kO0Zq3RumaaNEncSpWD29YsxqzzkmqAfrk6epIZ7HD94kkCF
         p6do29beokHZsWleQaIq5hIG0yCVRY9teuIz0sTAtbC7w6eGO6AD7WXeXJE6iU9lWUi2
         4k4+a5KkP0SSD3puuIcDkYE+CuRbzDJHaPJakTMQTf2UYm9WCWxwVVfn9rp7IFc1Jvtm
         JSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PD1FTep9S3zs1MDY62fLxL6s8lyjarET41DJmFd9Zhc=;
        b=a8KkVnnv6voFJFSRI6UGeZZHDDUtxIt26+7bGdgBDF7ZifIHd6v8b27XeENdLhdKcz
         cqghxrDWtYnnqG8uYsncauxqUrLpLsUi1RQMmYInB6PdVf2yRf9K3F1uIdQJMXAiBSFW
         E/pWifSscak8Y8punKWiqq4SxKWqLpdZPDYOm10LO4G0WbBwVG8m7ECOeSV3nFXOKNgu
         COcdD2DSzRlXCSL+eAAShrQOoAwiRFaOMWTGPZ7hMwClAxYm04udqgcGTrhrwB31QxEk
         yb4EhIs3gzu0x0TXzg0youB4H8QipfzpibnlEk65I516vwMhkwc2cVXaIfR3SYnq0Lx+
         2N0Q==
X-Gm-Message-State: AJaThX7jHS0MhI9FfaBBnEcizBRB5rp5cRbw4AB7siTL4KAayppcVsF+
        Kp8nsWxRvPq1haTzWvIdwmodviz77Kt7NLPIWb0=
X-Google-Smtp-Source: AGs4zMaRTnRa9pMWUIPtfPRYoradytbnlnCvwe3hg41zjhiwLIh9PTGimuA3Xe/oVSHV/a+a/U7Z8gyM/ZiOB7XtMMQ=
X-Received: by 10.107.8.152 with SMTP id h24mr46908438ioi.155.1512764826564;
 Fri, 08 Dec 2017 12:27:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.152.46 with HTTP; Fri, 8 Dec 2017 12:26:46 -0800 (PST)
In-Reply-To: <1512741164.25033.28.camel@gmail.com>
References: <CAEdQ38HcOgAT6wJWWKY3P0hzYwkBGSQkRSQ2a=eaGmD6c6rwXA@mail.gmail.com>
 <CAEdQ38G4VTXDGOarmmTac=hP92VJbQHRFxQTaSWQ3j4d63pogg@mail.gmail.com>
 <CAEdQ38HcPswBk3pUHzQerFZ=4KjPc5nVYTqNnGQNMk7QbPXuOQ@mail.gmail.com>
 <CANn89iJKGRLVNAE99JWiyXcOXveytkjbQAiZ9XPiJc6fyEdFVA@mail.gmail.com> <1512741164.25033.28.camel@gmail.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Fri, 8 Dec 2017 12:26:46 -0800
Message-ID: <CAEdQ38HEduSTY38Noj4peaMN_G++5sLJfqzCMkd3M4pPNTpU_Q@mail.gmail.com>
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
X-archive-position: 61380
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

On Fri, Dec 8, 2017 at 5:52 AM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> On Fri, 2017-12-08 at 05:42 -0800, Eric Dumazet wrote:
>> On Thu, Dec 7, 2017 at 11:54 PM, Matt Turner <mattst88@gmail.com>
>> wrote:
>> > On Thu, Dec 7, 2017 at 11:00 PM, Matt Turner <mattst88@gmail.com>
>> > wrote:
>> > > On Sun, Mar 12, 2017 at 6:43 PM, Matt Turner <mattst88@gmail.com>
>> > > wrote:
>> > > > On a Broadcom BCM91250a MIPS system I can reliably trigger NFS
>> > > > corruption on the first file read.
>> > > >
>> > > > To demonstrate, I downloaded five identical copies of the gcc-
>> > > > 5.4.0
>> > > > source tarball. On the NFS server, they hash to the same value:
>> > > >
>> > > > server distfiles # md5sum gcc-5.4.0.tar.bz2*
>> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2
>> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.1
>> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.2
>> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.3
>> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.4
>> > > >
>> > > > On the MIPS system (the NFS client):
>> > > >
>> > > > bcm91250a-le distfiles # md5sum gcc-5.4.0.tar.bz2.2
>> > > > 35346975989954df8a8db2b034da610d  gcc-5.4.0.tar.bz2.2
>> > > > bcm91250a-le distfiles # md5sum gcc-5.4.0.tar.bz2*
>> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2
>> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.1
>> > > > 35346975989954df8a8db2b034da610d  gcc-5.4.0.tar.bz2.2
>> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.3
>> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.4
>> > > >
>> > > > The first file read will contain some corruption, and it is
>> > > > persistent until...
>> > > >
>> > > > bcm91250a-le distfiles # echo 1 > /proc/sys/vm/drop_caches
>> > > > bcm91250a-le distfiles # md5sum gcc-5.4.0.tar.bz2*
>> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2
>> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.1
>> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.2
>> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.3
>> > > > 4c626ac2a83ef30dfb9260e6f59c2b30  gcc-5.4.0.tar.bz2.4
>> > > >
>> > > > the caches are dropped, at which point it reads back properly.
>> > > >
>> > > > Note that the corruption is different across reboots, both in
>> > > > the size
>> > > > of the corruption and the location. I saw 1900~ and 1400~ byte
>> > > > sequences corrupted on separate occasions, which don't
>> > > > correspond to
>> > > > the system's 16kB page size.
>> > > >
>> > > > I've tested kernels from v3.19 to 4.11-rc1+ (master branch from
>> > > > today). All exhibit this behavior with differing frequencies.
>> > > > Earlier
>> > > > kernels seem to reproduce the issue less often, while more
>> > > > recent
>> > > > kernels reliably exhibit the problem every boot.
>> > > >
>> > > > How can I further debug this?
>> > >
>> > > I think I was wrong about the statement about kernels v3.19 to
>> > > 4.11-rc1+. I found out I couldn't reproduce with 4.7-rc1 and then
>> > > bisected to 4cd13c21b207e80ddb1144c576500098f2d5f882 ("softirq:
>> > > Let
>> > > ksoftirqd do its job"). Still reproduces with current tip of
>> > > Linus'
>> > > tree.
>> > >
>> > > Any ideas? The board's ethernet is an uncommon device supported
>> > > by
>> > > CONFIG_SB1250_MAC. Something about the ethernet driver maybe?
>> >
>> > With the patch reverted on master (reverts cleanly), NFS corruption
>> > no
>> > longer happens.
>>
>> Hi Matt.
>>
>> Thanks for bisecting.
>>
>> Patch simply exposes an existing bug more often by changing the way
>> driver functions are scheduled.
>>
>> Which is probably a good thing.
>>
>> sbmac_intr() looks extremely suspicious to me.
>>
>> A NAPI driver hard interrupt should simply schedule NAPI.
>>
>> Apparently, if sbmac_intr() can not grab NAPIF_STATE_SCHED bit, it
>> directly calls sbdma_rx_process() from
>> hard interrupt context.
>>
>> Insane really.
>
> Please try this fix (not compiled on my x86 laptop, and I had no coffee
> yet, so it might have some trivial errors)

Thanks for the quick reply!

I tried the patch on top of master, but unfortunately the corruption
still occurs.
