Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Feb 2017 18:14:40 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:38686 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993133AbdBIROd7Ikxp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Feb 2017 18:14:33 +0100
To:     Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 04/14] GPIO: Add gpio-ingenic driver
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 09 Feb 2017 18:14:32 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux MIPS <linux-mips@linux-mips.org>,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        James Hogan <james.hogan@imgtec.com>
In-Reply-To: <CACRpkdaqQ2==B1_o-Ru81Nbu_kUF+Kxn=XFYms-1e=nAtHiJ4A@mail.gmail.com>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net>
 <20170125185207.23902-5-paul@crapouillou.net>
 <CACRpkdaqQ2==B1_o-Ru81Nbu_kUF+Kxn=XFYms-1e=nAtHiJ4A@mail.gmail.com>
Message-ID: <b032ad924ae905ce4fd11535d08c29a8@mail.crapouillou.net>
X-Sender: paul@crapouillou.net
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56744
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

Hi,

> What some drivers do when they just get/set a bit in a register
> to get/set or set the direction of a GPIO, is to select GPIO_GENERIC
> and just bgpio_init() with the right iomem pointers, then the core
> will register handlers for get, set, set_direcition callback and
> get_direction and your driver can just focus on the remainders.

GPIO_GENERIC and bgpio_init() would work for my .set() / .get() 
callbacks,
not for my .direction_input() / .direction_output() callbacks which need
to set more than one register.

> If you're not just replacing these with GPIO_GENERIC, please also
> include a .get_direction() callback.

My .direction_input() and .direction_output() callbacks just call into
the pinctrl driver, using pinctrl_gpio_direction_[in,out]put().
I didn't find a way to get the direction info from the pinctrl driver,
is that something that the core should provide?

Thanks,
-Paul
