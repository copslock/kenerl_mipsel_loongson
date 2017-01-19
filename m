Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2017 12:19:44 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:56354 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993179AbdASLTiDFDAn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Jan 2017 12:19:38 +0100
To:     Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 00/13] Ingenic JZ4740 / JZ4780 pinctrl driver
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 19 Jan 2017 12:19:36 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
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
In-Reply-To: <20170118071530.GA18989@ulmo.ba.sec>
References: <20170117231421.16310-1-paul@crapouillou.net>
 <20170118071530.GA18989@ulmo.ba.sec>
Message-ID: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
X-Sender: paul@crapouillou.net
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56414
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

Le 2017-01-18 08:15, Thierry Reding a écrit :

> On Wed, Jan 18, 2017 at 12:14:08AM +0100, Paul Cercueil wrote:
> [...]
> 
>> One problem still unresolved: the pinctrl framework does not allow us 
>> to configure each pin on demand (someone please prove me wrong), when 
>> the various PWM channels are requested or released. For instance, the 
>> PWM channels can be configured from sysfs, which would require all PWM 
>> pins to be configured properly beforehand for the PWM function, 
>> eventually causing conflicts with other platform or board drivers.
> 
> Still catching up on a lot of email, so I haven't gone through the
> entire series. But I don't think the above is true.
> 
> My understanding is that you can have separate pin groups for each
> pin (provided the hardware supports that) and then control each of
> these groups dynamically at runtime.
> 
> That is you could have the PWM driver's ->request() and ->free()
> call into the pinctrl framework to select the correct pinmux
> configuration as necessary.

Thanks for the feedback.

The problem with pinctrl and PWM, is that the pinctrl API works by 
"states".
A default state, sleep state, and basically any custom state that the 
devicetree
provides. This works well until you need to control individually each 
pin; with
8 pins, you would need 2^8 states, each one corresponding to a given 
configuration.

-Paul
