Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 May 2017 13:22:07 +0200 (CEST)
Received: from mail-oi0-x243.google.com ([IPv6:2607:f8b0:4003:c06::243]:33294
        "EHLO mail-oi0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992127AbdE2LWAx8cuO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 May 2017 13:22:00 +0200
Received: by mail-oi0-x243.google.com with SMTP id h4so11003432oib.0;
        Mon, 29 May 2017 04:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=wZwMPX4pXOPKNdf92AFbdGQernWolb1LqEy5OSCnDXM=;
        b=A27j3a3MxG0xNoihFdNB1Jn9AHc+zseQLw30C+h33d2Q9vh11TwYgqU6q9b4lpuNRn
         vXS/Ubu18luEMnG9/QjxwTBZdZIiyH6AGwFt59zgXp148ulVEoPWxBT1huH9ekGw/gKv
         Tvc/tmqqSaiRjONCsbEuJO2mZ4fMRJBxDVBqu2JYulgK+ysc1HxzLCsAUR4ulziG0ocT
         tvN7mUkujg+eqNOJGGoVhY4o3Yw9MPZxLvoZyqXw0z0ltNG8LmM2eiZP17zyNALdDneG
         LzaCoAx2VQSoackt1JbXnEC8PGRo3L/Z5F3qV7nJGXxA5FzZo+xpNZ7iuHihGXiwYGkX
         e+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=wZwMPX4pXOPKNdf92AFbdGQernWolb1LqEy5OSCnDXM=;
        b=qi5HeJ6bknUIEeyZrv989r1iJ9809AZqUX2BkR8DG4bTJ0s3NdfmoEIuoejFW79tWY
         tPNk8b1a2cNloh3czkyQioQWSW51rworB4uKCrh2KGTH9ufqiGlQT/D5dwx2IL1lvk3l
         1GO5xVVLXHofWiLohKaGxMwVCdPOwgvjAQjvddUe2q47xfA1/4Kb1yMty5+OwcXto43r
         pvbAAbEMBAqFnmSZ0pD3iPy2Z3mmOJjlodnmbAqRFTuHX5eZKrnf727Gj7sj3l3jJiEI
         Kvk4ytNVl+B/djd25Zc72WAwN4tyfRkNbZLv5elt5T18WpuR2D7W6BVvK6EpBbM0Bsge
         dAzg==
X-Gm-Message-State: AODbwcD6YhfO0zKDfQR4v1ALSGgQoTtVzc2LpcaH6zryjsjhse1qNVAd
        5PiEIF88/l9HArosaWKVHGvivIqPUg==
X-Received: by 10.202.97.86 with SMTP id v83mr5874396oib.113.1496056915001;
 Mon, 29 May 2017 04:21:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.66.2 with HTTP; Mon, 29 May 2017 04:21:54 -0700 (PDT)
In-Reply-To: <20170529105509.GC2192@mai>
References: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org>
 <1495879129-28109-2-git-send-email-daniel.lezcano@linaro.org>
 <CAK8P3a3QACHYqtCO1z_FpW0nXEtx356wCDha_=SNXU872=q1UQ@mail.gmail.com>
 <20170529084809.GA2192@mai> <CAK8P3a1Kv_RhKL43ie6co_N5pDXvRHd7Uq8g70qt80WkxuhzLw@mail.gmail.com>
 <20170529105509.GC2192@mai>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 May 2017 13:21:54 +0200
X-Google-Sender-Auth: sxhqAzksCpXXrJOJhU4rLaWH1Fs
Message-ID: <CAK8P3a3MdvWMJyVqE63Ur330mC2wPZO7nFXjd_LukbTjiZtGdg@mail.gmail.com>
Subject: Re: [PATCH 2/7] clocksource: Rename CLOCKSOURCE_OF_DECLARE
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Michal Simek <monstr@monstr.eu>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ley Foon Tan <lftan@altera.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>,
        =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <kernel@pengutronix.de>,
        Joachim Eastwood <manabian@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Richard Cochran <rcochran@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Noam Camus <noamca@mellanox.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "open list:ARM/STI ARCHITECTURE" <kernel@stlinux.com>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        "moderated list:ARM/OXNAS platform support" 
        <linux-oxnas@lists.tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Mon, May 29, 2017 at 12:55 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On Mon, May 29, 2017 at 11:57:25AM +0200, Arnd Bergmann wrote:
>> On Mon, May 29, 2017 at 10:48 AM, Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:
>> Things that could go wrong include:
>>
>> - A platform maintainer wants to add a new platform and has a for-next
>>   branch that gets merged into linux-next, with parts of it going through
>>   different maintainers, and now they have to choose between a branch
>>   that doesn't build without the timer branch, or one that break for-next
>>   unless Stephen applies a fixup
>>
>> - Some architecture maintainer didn't get the memo and adds an instance of
>>   CLOCKSOUCE_OF_DECLARE in architecture specific code without asking
>>   having the patch reviewed first
>>
>> - A platform has a branch with complex cross-tree dependencies and
>>   it need to get merged in an unconventional way.
>>
>> - You make a mistake and accidentally merge one driver for an unusual
>>   architecture that escapes your test matrix.
>>
>> While those all are unlikely to happen in a particular merge window, they do
>> happen occasionally and tend to cause a lot of pain.
>
> Hmm, that sounds scary :)
>
> There is no guarantee, when removing the alias, none of the above happens,
> right?

No, it's just both less likely and easier to work around.

> If the timer branch is in linux-next, that could be caugth before any of the
> above happens, no?

linux-next will find most of these problems, but it will still be more work
for the people that run into build failures when testing linux-next.

     Arnd
