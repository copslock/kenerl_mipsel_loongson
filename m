Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Nov 2012 13:07:35 +0100 (CET)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:47529 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824761Ab2KNMHeBdAhn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Nov 2012 13:07:34 +0100
Received: by mail-ob0-f177.google.com with SMTP id eh20so291048obb.36
        for <multiple recipients>; Wed, 14 Nov 2012 04:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8b9IfMonOjkwSL0HAqDA9FNELfIncJsRHGK5sHlF9jk=;
        b=HMxO7qtRdVqQQgB0v+euNEaG/wU39hYTNqNNKriOHqiM+qeWMrset6Khyp+fYOs/ND
         2SpUQQkS5zbG1evZT2fCWIqte9NwrdAtPaET0GTYR3fYcUh5n9d3ZnkUn8TkXPHFkDmM
         BwqKLIhK0oS0MY6MyZ+Io4b+9i9MjRxHmW5pnYq3NCuCA45b01+RuXk6Wguen9JUlV2g
         1gBth1Rwj0y6wfiv1Pn1EYPR7CjavDBYoum/bxpNLyMKlbrDMItnd/D/Mh6oL4xXplin
         VXE4pGnG1s76L1FGuWbAaTDthRcafp/FKb3Z7jQpYWh4OkcNaShrT5xyioUP4UE1aG6d
         M1Qg==
Received: by 10.60.24.7 with SMTP id q7mr19556521oef.108.1352894847632; Wed,
 14 Nov 2012 04:07:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.76.28.70 with HTTP; Wed, 14 Nov 2012 04:07:07 -0800 (PST)
In-Reply-To: <1352719094.10405.18.camel@sakura.staff.proxad.net>
References: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com> <1352719094.10405.18.camel@sakura.staff.proxad.net>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Wed, 14 Nov 2012 13:07:07 +0100
Message-ID: <CAOiHx==1UxrmxB5kyeDQPF4HBYxY9h4Ha8mWErwm6znX=y75OA@mail.gmail.com>
Subject: Re: [RFC] MIPS: BCM63XX: add initial Device Tree support
To:     mbizon@freebox.fr
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 12 November 2012 12:18, Maxime Bizon <mbizon@freebox.fr> wrote:
> On Sun, 2012-11-11 at 13:50 +0100, Jonas Gorski wrote:
>
>> This patch series adds initial Device Tree support to BCM63XX by adding
>> bindings for interrupts, GPIOs and clocks to Device Tree. Finally it adds
>> one "real" user, the serial driver, to the device tree boards.
>
>>  51 files changed, 1993 insertions(+), 392 deletions(-)
>
> I've already said what I think privately to you but I will do it again
>
> The bcm63xx code base is IMO quite clean. It does not suffer from code
> duplication, and god it would have taken far less time to write it the
> "bad" way.

The non-DT way of defining boards will not go away soon - see how all
changes are done with keeping "backward" compatibility in mind: I
don't remove the old device registration code, I don't remove any
fields from the board struct, I added compatibility dts for when there
is only a board struct, no board specific dts file.

> We have only *one* register file for all the SOCs, only the different
> bits are visible.
>
> We can even build a single kernel that support all SOCs/boards.

That's not going to change with Device Tree, and I'm trying my best to
keep this.

> So what's the *point* of this ?

Not having to update board_bcm963xx.{c,h} because some vendor decided
to add e.g. a previously unused gpio-bitbanged device. Not having to
modify the kernel but just attach a (externally build) dtb to the
kernel to support a new board. Ideally in the far future even using a
CFE provided dtb. I'm sure there are more reasons.

> You *cannot* abstract hardware, you just can't guess now what the next
> SOC peculiarity will be.

And nobody wants to do that. But - as Kevin already mentioned - it
would be nice if we get similar SoCs we already know about supported
with the same code; or at least , like BCM33xx, BCM68xx or maybe even
BCM7xxx (never looked at them, so I can't tell how viable that is).

>> Quoting your patch "BCM63XX: switch to common clock and Device Tree"
>
> +Required properties:
> +- compatible: one of
> +  a) "brcm,bcm63xx-clock"
> +  Standard BCM63XX clock.
>
> cool a nice abstraction, one register bit = one clock
>
> +  b) "brcm,bcm63xx-sar-clock"
> +  SAR/ATM clock, which requires a reset of the SAR/ATM block.
> +  c) "brcm,bcm63xx-enetsw-clock"
> +  Generic ethernet switch clock, which requires a reset of the block.
> +  d) "brcm,bcm6368-enetsw-clock"
> +  BCM6368 ethernet switch clock, which requires additional clocks to be
> +  enabled during reset.
>
> oops that abstraction did not fly because after enabling this particular
> clock on this SOC you also need to toggle other bits.

These special clocks are so that the original behaviour of the clocks
is kept.  I'd rather argue that the reset code does not belong into
the clock code, and is actually the responsibility of the driver. It
would make the clock code much simpler.

There will be exactly one consumer each for the enetsw/sar clocks; the
drivers themselves. And since the drivers itself aren't upstream yet,
it should be no problem modifying them to reset the cores instead of
relying on the clock code to do that for them. then we can implement
the reset call abstract enough so the entsw just expects a list of
clocks through DT that need to be enabled during reset - without
having to care about which exact clocks these are (and it will be zero
except for two SoCs).


What would you suggest? Please no "don't use Device Tree", as I don't
think we can avoid that. I'm struggling to find something you are fine
with.

> that list is going to get longer and longer and at the end won't mean anything.

BCM681x needs additional special handling, yes, but that's it
currently. Neither BCM6362 nor BCM63168 have/need this. And there is
no problem adding new support code in the kernel as needed. Nobody
expects older kernels to work with newer SoCs. But as stated earlier,
older kernels should work with newer boards.

> and this is supposed to be a *STABLE* API
>
> We don't add syscall everyday, because we have to support them forever.
> Why would it be ok to add such abstractions that prevent further code
> refactoring because they are fixed in stone ?

I wouldn't treat this as stable until we got it into a satisfactory
state with everything supported. Heck, I wouldn't even treat this as
stable until Broadcom ships it in their SDKs to customers with CFEs
providing DTBs to the kernel.

What do you want to do, keep it out of the kernel until everything is
supported, working and "polished up", then posting a big patch bomb? I
don't think this will work well and will just cause pain for everyone.


Jonas
