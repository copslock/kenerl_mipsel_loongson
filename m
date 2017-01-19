Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2017 12:25:35 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:56658 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993014AbdASLZYyMciU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Jan 2017 12:25:24 +0100
To:     Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 13/13] MIPS: jz4740: Remove custom GPIO code
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 19 Jan 2017 12:24:54 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        james.hogan@imgtec.com
In-Reply-To: <20170118072751.GC18989@ulmo.ba.sec>
References: <20170117231421.16310-1-paul@crapouillou.net>
 <20170117231421.16310-14-paul@crapouillou.net>
 <20170118072751.GC18989@ulmo.ba.sec>
Message-ID: <b88d4818b42ae6b0853e5c01d4121c47@mail.crapouillou.net>
X-Sender: paul@crapouillou.net
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Le 2017-01-18 08:27, Thierry Reding a écrit :

> On Wed, Jan 18, 2017 at 12:14:21AM +0100, Paul Cercueil wrote:
> 
>> All the drivers for the various hardware elements of the jz4740 SoC 
>> have been modified to use the pinctrl framework for their pin 
>> configuration needs. As such, this platform code is now unused and can 
>> be deleted. Signed-off-by: Paul Cercueil <paul@crapouillou.net> --- 
>> arch/mips/include/asm/mach-jz4740/gpio.h | 371 ---------------------- 
>> arch/mips/jz4740/Makefile | 2 - arch/mips/jz4740/gpio.c | 519 
>> ------------------------------- 3 files changed, 892 deletions(-) 
>> delete mode 100644 arch/mips/jz4740/gpio.c
> 
> Have you considered how this could best be merged? It's probably 
> easiest
> to take all of this through the MIPS tree because we have an addition 
> of
> the pinctrl that would be a replacement for the GPIO code, while at the
> same time a bunch of drivers rely on the JZ4740 GPIO code for 
> successful
> compilation.
> 
> That's slightly complicated by the number of drivers, so needs a lot of
> coordination, but it's not the worst I've seen.
> 
> Maybe one other solution that would make the transition easier would be
> to stub out the GPIO functions if the pinctrl driver is enabled, and do
> the removal of the mach-jz4740/gpio.h after all drivers have been 
> merged
> through their corresponding subsystem trees. That way all drivers 
> should
> remain compilable and functional at runtime, while still having the
> possibility to merge through the subsystem trees.
> 
> That said, the whole series is fairly simple, so merging everything
> through the MIPS tree sounds like the easiest way to go.
> 
> Thierry

I think it would make sense to merge it through the MIPS tree, yes,
considering that the patches for the drivers in the other subsystems are
quite small, and that they just remove code (well, except the pinctrl
driver itself). Besides, the files modified are not touched very often
so the chances of breakage are pretty low.

-Paul
