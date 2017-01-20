Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jan 2017 11:18:06 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:46620 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993014AbdATKR7dsjTn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Jan 2017 11:17:59 +0100
To:     Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 00/13] Ingenic JZ4740 / JZ4780 pinctrl driver
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 20 Jan 2017 11:17:28 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
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
        linux-kernel@vger.kernel.org,
        Linux MIPS <linux-mips@linux-mips.org>,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        James Hogan <james.hogan@imgtec.com>
In-Reply-To: <CACRpkdaeu9OxaSPeOrkKtKNQGUQh4puCFw8A2h=xhqVdDWgoow@mail.gmail.com>
References: <20170117231421.16310-1-paul@crapouillou.net>
 <20170118071530.GA18989@ulmo.ba.sec>
 <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <CACRpkdaeu9OxaSPeOrkKtKNQGUQh4puCFw8A2h=xhqVdDWgoow@mail.gmail.com>
Message-ID: <775b4a87768de7263ce6ff9a38659334@mail.crapouillou.net>
X-Sender: paul@crapouillou.net
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56431
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

Le 2017-01-20 09:40, Linus Walleij a écrit :

> On Thu, Jan 19, 2017 at 12:19 PM, Paul Cercueil <paul@crapouillou.net> 
> wrote:
> 
>> The problem with pinctrl and PWM, is that the pinctrl API works by 
>> "states". A default state, sleep state, and basically any custom state 
>> that the devicetree provides. This works well until you need to 
>> control individually each pin; with 8 pins, you would need 2^8 states, 
>> each one corresponding to a given configuration.
> 
> I do not really understand, do you really use all 2^8 states in a given
> system?
> 
> The pin control states are to be used for practical situations, not
> for all theoretical situations.
> 
> You should define in your device tree the states that your
> particular system will use. Not all possible states on all possible
> systems.
> 

Well, that was if I wanted to dynamically set/unset the pin mux and
configuration when requesting/freeing a PWM. Then I'd need 2^x states
for X PWM pins.

Anyway, a static configuration works for me too. If at some point I
want dynamic configuration of the pins then I'll make the PWM driver
handle only one PWM pin and create one driver instance for each pin.

Regards,
-Paul
