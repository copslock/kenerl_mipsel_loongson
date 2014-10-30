Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 16:25:34 +0100 (CET)
Received: from mail-qg0-f53.google.com ([209.85.192.53]:62510 "EHLO
        mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012304AbaJ3PZdE3K3R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 16:25:33 +0100
Received: by mail-qg0-f53.google.com with SMTP id z107so4076517qgd.26
        for <multiple recipients>; Thu, 30 Oct 2014 08:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NUGTpNQyI4omEEGwxopWBBXoPgKewRDjmuO5356mQrQ=;
        b=S/LzZLiWGc1KkgtRgJI8RVuPHCimsrCu4k00x5m0aFBxi1wsmYXCfNC1EaH8IzSMGL
         YFy/LaEtiVIsNApM8azbElh+dvmvheHZU4WjCEd0wSstDXidstSBoKgSIaUAcHlFchTo
         JJCrxfLvMhGT+uyomMoTNxJqjQcupAh3mQ4IgiYS2yA8prDpTsJxVGhm71z0WJkVkxRR
         XP/OIU8XKsFTVmntDwUuYRI/4rzgibUF+sIKucYiDhGU4zkMw53yIs97Q7ebqZWih1+W
         ybh24catgt2oEYvQPnYZqqJOPI1Vs7kUrasYaisVOENF7A0+RWiAmrx/3y2l3koHwWyy
         3C3w==
X-Received: by 10.224.69.67 with SMTP id y3mr27487486qai.76.1414682723597;
 Thu, 30 Oct 2014 08:25:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Thu, 30 Oct 2014 08:25:03 -0700 (PDT)
In-Reply-To: <1879572.mbc2eHiUuo@wuerfel>
References: <1414635488-14137-1-git-send-email-cernekee@gmail.com>
 <2294092.AHz8W66sEP@wuerfel> <alpine.DEB.2.11.1410301142010.5308@nanos> <1879572.mbc2eHiUuo@wuerfel>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Thu, 30 Oct 2014 08:25:03 -0700
Message-ID: <CAJiQ=7BZpDM8fxzJj_bSfHMuWTQ2eFerWkXz0inxJy9O6p4d=A@mail.gmail.com>
Subject: Re: [PATCH V2 02/15] sh: Eliminate unused irq_reg_{readl,writel} accessors
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43786
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

On Thu, Oct 30, 2014 at 3:48 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 30 October 2014 11:43:00 Thomas Gleixner wrote:
>> On Thu, 30 Oct 2014, Arnd Bergmann wrote:
>>
>> > On Wednesday 29 October 2014 19:17:55 Kevin Cernekee wrote:
>> > > Defining these macros way down in arch/sh/.../irq.c doesn't cause
>> > > kernel/irq/generic-chip.c to use them.  As far as I can tell this code
>> > > has no effect.
>> > >
>> > > Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
>> >
>> > Actually it overrides the 32-bit accessors with 16-bit accessors,
>> > which does seem intentional and certainly has an effect.
>>
>> Not really. Neither arch/sh/boards/mach-se/7343/irq.c nor
>> arch/sh/boards/mach-se/7722/irq.c actually use
>> irq_reg_readl/writel. They simply define it.
>
> Ah, that makes things easier. I looked at the commits that introduced
> them, and even then they were unused. Probably an artifact from an
> earlier version of the patch which did not get merged.

I suspect that the intention was to put them into the machine's
<irq.h> so that generic-chip.c would pick them up.  The sh irq.c files
do call ioread16/iowrite16 themselves, and like bcm7120-l2, they
utilize irq_gc_mask_{set,clr}_bit from generic-chip.c.

This may be something for the maintainers (Paul?) to double-check, but
if the submission worked as-is, maybe overriding the I/O accessors
wasn't actually needed.  Or maybe there are subtle and unfortunate
side effects on adjacent registers.
