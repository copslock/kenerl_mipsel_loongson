Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2018 01:20:13 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:52124 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993981AbeGXXUHrUXYu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jul 2018 01:20:07 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 00/21] Ingenic JZ47xx TCU patchset v5
Date:   Wed, 25 Jul 2018 01:19:37 +0200
Message-Id: <20180724231958.20659-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532474406; bh=p7W0EZb/337WwscyN+pftnx9XCmwFkd1dB5EmPWxQGI=; h=From:To:Cc:Subject:Date:Message-Id; b=XP/tsVav1RnoGs8vcNnWreqM41pZMgYNTTFZNW6otNTz6tIE0ei8waIFMSEuYndVeJO8QLVSaiD+eYU+9bqLlo7GRRR0Jsun/AZO1XMVfIQJeksQdvqjkdWmlo4EKqkFozjiQaOGw29YG2sR3l/jsmkkdekM935Aj5EE7HDigzg=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65099
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

This is the V5 of my patchset that adds support to the Timer/Counter
Unit (TCU) present on Ingenic JZ47xx SoCs.

Way too much has changed since V4, we went from 8 patches in V4 up to
21 patches in V5.
I did not know if I had to submit it as V5 or start a new series.
In doubt, I sent a V5.

Very succint description of the changes:

- The interrupt, clocks, clocksource drivers have been merged into one;
  ingenic-timer now inits the TCU clocks, handles the interrupts,
  provides a system timer and optionally also a clocksource and
  sched_clock. The TCU channel #0 will be used as system timer, unless
  another channel is specified from devicetree.

- The simple-mfd and syscon are gone. The ingenic-timer driver will
  probe the drivers registered as children in the devicetree.

- The watchdog driver was updated to use the WDT clock and regmap
  provided by ingenic-timer. This breaks the devicetree ABI, but as
  explained in the corresponding commit message, right now all Ingenic
  boards compile the devicetree into the kernel anyway - so it's better
  to update it now before it's too late.

- The PWM driver was updated to use the TCU timer clocks as well as the
  regmap provided by ingenic-timer. Unused devicetree compatible strings
  were removed (the driver was never probed from devicetree), and
  support for the JZ4725B has been added.

- A new ingenic-ost driver was added, which provides a clocksource and
  a sched_clock that are more accurate than the ones provided by
  ingenic-timer (32 or 64-bit vs. 16-bit). It is not available on every
  SoC.

- Mostly tested on the JZ4725B and JZ4770. It would be great if somebody
  could test on the JZ4780 and JZ4740.

Thanks,
-Paul
