Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Sep 2016 15:16:53 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:37312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991960AbcIPNQqyx5qj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Sep 2016 15:16:46 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 89A17205DF
        for <linux-mips@linux-mips.org>; Fri, 16 Sep 2016 13:16:43 +0000 (UTC)
Received: from mail-io0-f177.google.com (mail-io0-f177.google.com [209.85.223.177])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F4122056D
        for <linux-mips@linux-mips.org>; Fri, 16 Sep 2016 13:16:41 +0000 (UTC)
Received: by mail-io0-f177.google.com with SMTP id m79so25135616ioo.3
        for <linux-mips@linux-mips.org>; Fri, 16 Sep 2016 06:16:41 -0700 (PDT)
X-Gm-Message-State: AE9vXwPFIGTkqlBsEhqPrJeInLYmyLCCPKo1Lyz9Fre/9Ch4OmVlBCuvLCLQCRIa3TJzFo0cudd8xXJet9z9/w==
X-Received: by 10.107.63.11 with SMTP id m11mr25501045ioa.56.1474031800428;
 Fri, 16 Sep 2016 06:16:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.33.87 with HTTP; Fri, 16 Sep 2016 06:16:39 -0700 (PDT)
In-Reply-To: <57DBEBC8.7000209@arm.com>
References: <CAMuHMdVW1eTn20=EtYcJ8hkVwohaSuH_yQXrY2MGBEvZ8fpFOg@mail.gmail.com>
 <1473980577.17787.21.camel@gmail.com> <57DBA464.9010506@arm.com>
 <1474023805.17258.10.camel@gmail.com> <57DBEBC8.7000209@arm.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 16 Sep 2016 15:16:39 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfwk43hVmC8=2gt9ke6Az5bWAsV4AierWiYscKo6_aj3w@mail.gmail.com>
Message-ID: <CAJKOXPfwk43hVmC8=2gt9ke6Az5bWAsV4AierWiYscKo6_aj3w@mail.gmail.com>
Subject: Re: genirq: Setting trigger mode 0 for irq 11 failed (txx9_irq_set_type+0x0/0xb8)
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Alban Browaeys <alban.browaeys@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Kukjin Kim <kgene@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <krzk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: krzk@kernel.org
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

On Fri, Sep 16, 2016 at 2:55 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> +Krzystof, Kukjin,
>
> On 16/09/16 12:03, Alban Browaeys wrote:
>> Le vendredi 16 septembre 2016 à 08:51 +0100, Marc Zyngier a écrit :
>>> Hi Alban,
>>>
>>> On 16/09/16 00:02, Alban Browaeys wrote:
>>>> I am seeing this on arm odroid u2 devicetree :
>>>> genirq: Setting trigger mode 0 for irq 16 failed
>>>> (gic_set_type+0x0/0x64)
>>>
>>> Passing IRQ_TYPE_NONE to a cascading interrupt is risky at best...
>>> Can you point me to the various DTs and their failing interrupts?
>>
>> mine is:
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos4412-odroidu3.dts
>>
>> I got a report of this issue to another odroid :
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos4412-odroidx2.dts
>>
>>
>>
>> they both get their settings from :
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos4412.dtsi
>>
>> relevant in the chain are:
>> - combiner modified:
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos4x12.dtsi#n460
>
> How wonderful. This section is an utter pile of crap. Really.
> Having 0 as the trigger is illegal, and the valid values are fully
> documented in the GIC binding. No wonder things start breaking.


+CC Marek Szyprowski,

Yes, that is interesting pile. Lately we stomped into it as well... I
started fixing this today but didn't finish it yet.

> And that's from the following stuff:
>
>         &pinctrl_0 {
>                 compatible = "samsung,exynos4x12-pinctrl";
>                 reg = <0x11400000 0x1000>;
>                 interrupts = <0 47 0>;
>         };
>
>         &pinctrl_1 {
>                 compatible = "samsung,exynos4x12-pinctrl";
>                 reg = <0x11000000 0x1000>;
>                 interrupts = <0 46 0>;
>
>                 wakup_eint: wakeup-interrupt-controller {
>                         compatible = "samsung,exynos4210-wakeup-eint";
>                         interrupt-parent = <&gic>;
>                         interrupts = <0 32 0>;
>                 };
>         };
>
>         [...]
>
>         &pinctrl_3 {
>                 compatible = "samsung,exynos4x12-pinctrl";
>                 reg = <0x106E0000 0x1000>;
>                 interrupts = <0 72 0>;
>         };
>
> which perpetuates this fine tradition...
>
> At that stage, I'm not sure I should care. Does the workaround make your
> platform usable? The Samsung maintainers should really try and fix their
> DT, because it is a miracle this has made it that far.

Miracle or coincidence. :)

Thanks Geert and Alban for bringing this up, I'll add also yours reported-by.

Best regards,
Krzysztof
