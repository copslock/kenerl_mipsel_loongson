Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2012 04:46:17 +0200 (CEST)
Received: from mail-la0-f49.google.com ([209.85.215.49]:44690 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870443Ab2JHCqKdZFhV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Oct 2012 04:46:10 +0200
Received: by mail-la0-f49.google.com with SMTP id z14so1859661lag.36
        for <multiple recipients>; Sun, 07 Oct 2012 19:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LH6lR2octL4Gc1jWAB6ViKVJi89IFE9kA8uNsp3rY28=;
        b=qkd5qXXQhyiWisGQ7t/ePa6xJp0OtPQU4iZ1vn3DHEGnLIbWRrQ0RxOTPKaJ+XagAS
         xjq//WfuXL2UIcA//239lY9tMKLoyYa2xRuvy0A77fix9s8a4Kr/NGqDbnPlEyee3stz
         7v7eaSO0OK2/3llDvoiLW5uOd7nPaaR7/TGCBZhUSvsndycrpgpZk66Yq/oDByIIjfW8
         SzrwQVS9CE5qCK/CmgWcQ/FT/Zws+L040/9T1jSrRfoR7nlzVlqqfwrETltTZ3lsZxHf
         Jjv2ThU2i5ZavMtiPSa4y3g7vIYcDmcX0/gCbiF7Xrhe/GIFnnK/g61h1JeZkyB7L53r
         so0Q==
Received: by 10.152.112.233 with SMTP id it9mr12002106lab.40.1349664364711;
 Sun, 07 Oct 2012 19:46:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.114.12.138 with HTTP; Sun, 7 Oct 2012 19:45:44 -0700 (PDT)
In-Reply-To: <20121004191308.GB7228@avionic-0098.mockup.avionic-design.de>
References: <1349330819-11924-1-git-send-email-thierry.reding@avionic-design.de>
 <506DA487.9070400@metafoo.de> <20121004182931.GA7228@avionic-0098.mockup.avionic-design.de>
 <506DDA16.8070604@metafoo.de> <20121004191308.GB7228@avionic-0098.mockup.avionic-design.de>
From:   Eric Miao <eric.y.miao@gmail.com>
Date:   Mon, 8 Oct 2012 10:45:44 +0800
Message-ID: <CAMPhdO-PiKwYstKrGwdhrUG3+KWhPioAtzPVqtk52vss-4M+iw@mail.gmail.com>
Subject: Re: [PATCH] pwm: Get rid of HAVE_PWM
To:     Thierry Reding <thierry.reding@avionic-design.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Shawn Guo <shawn.guo@linaro.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bryan Wu <bryan.wu@canonical.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Ashish Jangam <ashish.jangam@kpitcummins.com>,
        Andrew Jones <drjones@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eric.y.miao@gmail.com
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

On Fri, Oct 5, 2012 at 3:13 AM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> On Thu, Oct 04, 2012 at 08:48:54PM +0200, Lars-Peter Clausen wrote:
>> On 10/04/2012 08:29 PM, Thierry Reding wrote:
>> > On Thu, Oct 04, 2012 at 05:00:23PM +0200, Lars-Peter Clausen wrote:
>> >> On 10/04/2012 08:06 AM, Thierry Reding wrote:
>> >>> [...]
>> >>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> >>> index 331d574..b38f23d 100644
>> >>> --- a/arch/mips/Kconfig
>> >>> +++ b/arch/mips/Kconfig
>> >>> @@ -219,7 +219,8 @@ config MACH_JZ4740
>> >>>   select GENERIC_GPIO
>> >>>   select ARCH_REQUIRE_GPIOLIB
>> >>>   select SYS_HAS_EARLY_PRINTK
>> >>> - select HAVE_PWM
>> >>> + select PWM
>> >>> + select PWM_JZ4740
>> >>>   select HAVE_CLK
>> >>>   select GENERIC_IRQ_CHIP
>> >>
>> >> I'm not sure if this is such a good idea, not all jz4740 based board
>> >> necessarily require PWM.
>> >
>> > This really only restores previous behaviour. But I agree that this is
>> > potentially not what we want. Maybe we should just not select this for
>> > any boards but rather leave it up to some default configuration. If so
>> > the patch can be made simpler by just removing the HAVE_PWM entries.
>>
>> At least for JZ4740 I think that is the better solution.
>
> Okay, I'll give other people the chance to comment on this. Especially
> for PXA there are many boards that use the PWM for backlight and it
> would be interesting to hear from them how they want this to be handled.

I'd say the original intention to introduce HAVE_PWM (although PXA
makes a lot use of this, but I remember Russell was the first to propose
this), is for board config to indicate its potential usage of the PWM or
rather if PWM is available for use on the board, and then leave the
developer another config option to build or not-to-build.

Personally I think removing HAVE_PWM will simplify the code a bit
and that's a good thing, on the other hand, how to keep a certain level
of flexibility mentioned above remains a small question. I guess with
device tree, this can be mitigated a bit.
