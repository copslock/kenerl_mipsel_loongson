Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Nov 2014 23:12:15 +0100 (CET)
Received: from mail-qc0-f177.google.com ([209.85.216.177]:40855 "EHLO
        mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011908AbaKJWMM0WVdR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Nov 2014 23:12:12 +0100
Received: by mail-qc0-f177.google.com with SMTP id l6so6587460qcy.36
        for <multiple recipients>; Mon, 10 Nov 2014 14:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HVALiVKhhDGIKRYVg4Nbhp5us3XOLnnyPRT+EEkPWyQ=;
        b=SAvotvRLTAr4hAONXhX6ZansQmWN8k7LMA9eUZ/Gd+TigS5PyKzX7/ZAqrePYRn+Wu
         prFAchmDTyxJAyG/v7nvJbqjc7Wk8NxdTbHecESMU0ncF8VVRQHx604DEwWM6gquMdQL
         NonRxTFQlKtuxpeO1kBCtaxS8H7/3H3txWYblEK/TGIbZL3mJ3TYTTLQdsHewLsjDDQg
         6PzXmdEV7eTciLqLCR425r56S876wb89OYWgQFVzKiMttr5D2qGj/Qe+OE+/ufMv5lU/
         GvHclI0bs36itSOK7+tIN3LBwMusPisNpZeCOc0ajdurgO81IBZXvQK80KAe7r5rBnTB
         8zfw==
X-Received: by 10.224.80.71 with SMTP id s7mr12403471qak.35.1415657524221;
 Mon, 10 Nov 2014 14:12:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Mon, 10 Nov 2014 14:11:44 -0800 (PST)
In-Reply-To: <7hy4riogwt.fsf@deeprootsystems.com>
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
 <1415342669-30640-5-git-send-email-cernekee@gmail.com> <7hy4riogwt.fsf@deeprootsystems.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Mon, 10 Nov 2014 14:11:44 -0800
Message-ID: <CAJiQ=7CYjy-sWc-M3m2Mg8si8JacpDH=RPPm8S-Q4m88wk3Sqg@mail.gmail.com>
Subject: Re: [PATCH V4 04/14] genirq: Generic chip: Add big endian I/O accessors
To:     Kevin Hilman <khilman@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, linux-sh@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43972
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

On Mon, Nov 10, 2014 at 2:00 PM, Kevin Hilman <khilman@kernel.org> wrote:
> Kevin Cernekee <cernekee@gmail.com> writes:
>
>> Use io{read,write}32be if the caller specified IRQ_GC_BE_IO when creating
>> the irqchip.
>>
>> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
>
> I bisected a couple ARM boot failures in next-20141110 on atmel sama5 platforms down to
> this patch, though I'm not quite yet sure how it's causing the failure.
> I'm not getting any console output, so haven't been able to dig deeper
> yet.  Maybe the atmel maintainers (Cc'd) can help dig.
>
> I've confirmed that reverting $SUBJECT patch (commit
> b79055952badbd73710685643bab44104f2509ea2) on top of next-20141110 gets
> things booting again.
>
> Also, it only happens with sama5_defconfig, not with multi_v7_defconfig.

In drivers/irqchip/irq-atmel-aic-common.c I see:

        ret = irq_alloc_domain_generic_chips(domain, 32, 1, name,
                                             handle_level_irq, 0, 0,
                                             IRQCHIP_SKIP_SET_WAKE);

and IRQCHIP_SKIP_SET_WAKE is (1 << 4), same as IRQ_GC_BE_IO.

Is it possible that the caller is passing values intended for
irq_chip->flags into a function expecting
irq_domain_chip_generic->gc_flags ?
