Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2014 20:39:31 +0100 (CET)
Received: from mail-qa0-f42.google.com ([209.85.216.42]:32916 "EHLO
        mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013863AbaKQTj2b-igg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Nov 2014 20:39:28 +0100
Received: by mail-qa0-f42.google.com with SMTP id j7so4170780qaq.1
        for <multiple recipients>; Mon, 17 Nov 2014 11:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VSYzD6eGFggyeHtMlmg0o7KnynJ3qnCGonPzaX6NVls=;
        b=WfqlAUUArDKdILs2AmuE1Xq/58ZZjnY3Ll4aM4TUl9l6N0pbc+trY1pQXyROE8BMYr
         pig1oNLzr8WGrzinF2h99ODNiKJ5+zCduRqiZwyyAo9iW4nRog2rXqvYuDpBExlqM6Tt
         JwyfWWEgAolb+UclHTq7Ql8tlmaHRqcg/Xg72RRtKkeMg5/ZAbTRMIOse9vDxJFUZy2T
         n7Uu5TK0IS+KnivXdLy6IZ4aqBY2DfYd+ltFuACD9Q2G6/DIobJIQahLnwVZh0NteZP2
         27PNjYcr0udA84aqxnAPOGDxlTT6Uv8UFL2TQUhto5xLZ2PChFWkrSmC3vijVh3Fn+OG
         lDyQ==
X-Received: by 10.140.48.11 with SMTP id n11mr36566763qga.1.1416253162638;
 Mon, 17 Nov 2014 11:39:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Mon, 17 Nov 2014 11:39:02 -0800 (PST)
In-Reply-To: <2911624.UJRs5QOPN5@wuerfel>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
 <3480616.V2TMJFc7uE@wuerfel> <CAJiQ=7A29-v5mo1ybvE2UodOZx-FoGeBTHYcTZuX-LaqRaF1Lw@mail.gmail.com>
 <2911624.UJRs5QOPN5@wuerfel>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Mon, 17 Nov 2014 11:39:02 -0800
Message-ID: <CAJiQ=7BH8K=Q+JcWTKSfn6xAteOF4B6jahMu_qVd-FyZWD3pjA@mail.gmail.com>
Subject: Re: [PATCH V2 22/22] MIPS: Add multiplatform BMIPS target
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jon Fraser <jfraser@broadcom.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44243
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

On Mon, Nov 17, 2014 at 10:46 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 17 November 2014 09:01:02 Kevin Cernekee wrote:
>> On Mon, Nov 17, 2014 at 4:16 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> Under arch/mips/bcm47xx I see a single mach type, but different builds
>> for BMIPS3300 (R1/SSB) versus MIPS 74K (R2/BCMA).
>
> At least in Kconfig, the two are not mutually exclusive, so I assumed
> you could enable them both at the same time.

Ah right, bcm47xx_defconfig doesn't actually enable
CONFIG_CPU_MIPS32_R2.  So it will still run on R1 CPUs like BMIPS3300.
On R2 systems it may lose a few optimizations/features.

I suspect that BCM47xx could use the BMIPS multiplatform kernel, if
somebody was willing to figure out how to convert board.c, leds.c,
etc.

>> > If you wanted to do that however, starting with BMIPS you'd have
>> > to make it possible to define a new platform without the
>> > arch/mips/include/asm/mach-bmips/ directory (this should be possible
>> > already, so the hardest part is done), replace all global function
>> > calls (arch_init_irq, prom_init, get_system_type,  ...) with generic
>> > platform-independent implementations or wrappers around per-platform
>> > callbacks, and move the Kconfig section for CONFIG_BMIPS_MULTIPLATFORM
>> > outside of the "System type" choice statement.
>>
>> Right.  The other question is how much support for legacy non-DT
>> bootloaders really belongs in a true multiplatform kernel, as this
>> stuff gets hairy fast.
>
> Yes, that's why I suggested following PowerPC rather than ARM in this
> regard.  If you move the boot loader abstraction into the decompressor
> instead of the platform code, you can avoid a lot of the problems.

One possible complication: for BCM63xx/BCM7xxx (MIPS) there is no
decompressor in the kernel.  The firmware loads an ELF image into
memory and jumps directly to kernel_entry.
