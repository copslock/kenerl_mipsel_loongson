Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2017 00:18:06 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:34564 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993909AbdAQXPVx2W7A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jan 2017 00:15:21 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        james.hogan@imgtec.com
Subject: [PATCH 00/13] Ingenic JZ4740 / JZ4780 pinctrl driver
Date:   Wed, 18 Jan 2017 00:14:08 +0100
Message-Id: <20170117231421.16310-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1484694890; bh=F2V6/oa8tg5zyLKnVi/wPT6MPzzB4pAVPwZ7HoqtSzI=; h=From:To:Cc:Subject:Date:Message-Id; b=o/1FQXefCIFEfRvLzppNhESy8JO0TlsebM5Uxw9Wv20XqfdMC6bSNDL1Ch1Hax5OtFDMhfktnPNe5gz2DoohRL7Ksv0JWj3hOE8FlchIbBK4vOUqKp9esJSbXuE04s0cTRtKvqqwz+AyNTGktSUI5Jq9tc2TOTcI5g9Cloxtdno=
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56377
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

This set of patches introduces a new pinctrl driver for the Ingenic
JZ4740 and JZ4780, which handles pin configuration, pin muxing and
GPIO config for those MIPS SoCs.

The initial driver was developed by to Paul Burton, so I'll expect his
Signed-Off-By to be added to each patch. It has been severely modified
and improved by myself, notably to add support for the JZ4740 (the
initial non-upstream driver only handled the JZ4780).

I successfully tested it on Imagination Technologies' CI20 board (JZ4780),
as well as on the Dingoo A320 chinese handheld console (JZ4740).

One patch in this series add a pinctrl configuration for some drivers
instanciated in the QI LB60 devicetree. Since I don't own this device,
this one patch was not tested.

Some words about the driver itself:
- pinctrl-ingenic.c contains the core functions that can be shared
  across all Ingenic SoCs,
- pinctrl-jz4740.c contains the JZ4740-specific low-level functions and
  the jz4740-pinctrl driver,
- pinctrl-jz4780.c contains the JZ4780-specific low-level functions and
  the jz4780-pinctrl driver.

The reason behind using a common file sharing core functions and backend
ops for each SoC version, is that the pin/GPIO controllers of the Ingenic
SoCs are extremely similar across SoC versions, except that some have the
registers shuffled around. Making a distinct separation permits the reuse
of large parts of the driver to support the two SoC versions.

One problem still unresolved: the pinctrl framework does not allow us to
configure each pin on demand (someone please prove me wrong), when the
various PWM channels are requested or released. For instance, the PWM
channels can be configured from sysfs, which would require all PWM pins
to be configured properly beforehand for the PWM function, eventually
causing conflicts with other platform or board drivers.

The proper solution here would be to modify the pwm-jz4740 driver to
handle only one PWM channel, and create an instance of this driver
for each one of the 8 PWM channels. Then, it could use the pinctrl
framework to dynamically configure the PWM pin it controls.

Until this can be done, the only jz4740 board supported upstream
(Qi lb60) could configure all of its connected PWM pins in PWM function
mode, if those are not used by other drivers nor by GPIOs on the
board. The only jz4780 board upstream (CI20) does not yet support the
PWM driver.
