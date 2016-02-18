Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Feb 2016 00:21:01 +0100 (CET)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:32923 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012873AbcBRXU7WRc9y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Feb 2016 00:20:59 +0100
Received: by mail-ob0-f177.google.com with SMTP id jq7so91674599obb.0
        for <linux-mips@linux-mips.org>; Thu, 18 Feb 2016 15:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2j610x9WseUfAs+nq/4dMWuJ5zgIRvDGM5g9R9kWxOc=;
        b=Xmh/AXvfJyLHY7ZPYF+F84etIJ+qgXBOp+mQMNCxJcL2oY0ppSB35aYAFZyGC1P7Ns
         rAjfxx/31hCPPWjXEzpf7oD/Kh7H4/CQwVe6Lpgs/n6BUHJb/qR4Khm9TBCoZRfbBvhJ
         O7kr8PoaCHTRpgglAUMV1XLRaorR12bDC/U9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2j610x9WseUfAs+nq/4dMWuJ5zgIRvDGM5g9R9kWxOc=;
        b=K/kM+SO09RHU5C4x3HNYw0V/hjnYeF2bjDRZKypFI9FpTUKbtvbSBGHbDkKdiIm2dl
         BkbnjUQVR8kS6uebMl6U4KSuuVvrPBKJN/FQKfgtLpiRG18IFqVsp1FwtPKFAQTWuSip
         Gixl+af0LeEq8kLAOZ20drrdOUIujWaAnwBKvt5La/GFWOVlzbrd9RWOKaknT5GClECV
         b0DCNzxj7mlYSUXKN66GbdWmu0PN7KdUvKu27t82vwmiNY2r4Zs/1HZsnxPkJ0JR8fjp
         d3hY1VnjBsXv1DfgbbfIRrFfJqzhbDC8ryoYrTWWHMYxmG38fa6jjzYr9gOg037dEyPp
         xuBw==
X-Gm-Message-State: AG10YORaWqEBBGRKsqXjH1I1mkXAdlG82Y4nkOph8bld3b7PFQn2dd4KIOJGtYSIz/j/mLr5Gcm42a1c+a4b52O8
MIME-Version: 1.0
X-Received: by 10.182.241.134 with SMTP id wi6mr8717813obc.81.1455837653653;
 Thu, 18 Feb 2016 15:20:53 -0800 (PST)
Received: by 10.182.55.105 with HTTP; Thu, 18 Feb 2016 15:20:53 -0800 (PST)
In-Reply-To: <1455637261-2920972-3-git-send-email-arnd@arndb.de>
References: <455637086-2794174-1-git-send-email-arnd@arndb.de>
        <1455637261-2920972-1-git-send-email-arnd@arndb.de>
        <1455637261-2920972-3-git-send-email-arnd@arndb.de>
Date:   Fri, 19 Feb 2016 00:20:53 +0100
Message-ID: <CACRpkdZEvuA2H7WaFtYtzOTRoZo1t5wpHu+O2oHGudoK63F8Gg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] gpio: ks8695: remove irq_to_gpio function
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Tue, Feb 16, 2016 at 4:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The ks8695 gpio driver has its own copy of the irq_to_gpio()
> function. This is completely unused in the mainline kernel
> after we converted all remaining users several years ago,
> so we can remove the definition as well.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.

Yours,
Linus Walleij
