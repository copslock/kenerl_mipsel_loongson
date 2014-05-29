Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2014 00:14:45 +0200 (CEST)
Received: from mail-ie0-f173.google.com ([209.85.223.173]:49010 "EHLO
        mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822139AbaE2WOmyAoC0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 May 2014 00:14:42 +0200
Received: by mail-ie0-f173.google.com with SMTP id lx4so976663iec.32
        for <linux-mips@linux-mips.org>; Thu, 29 May 2014 15:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=09c17/A3pLAVGsbU1GAQ0JUAxGggE5EMikyr25WvqsE=;
        b=0/RcwyW+HKqMUBLcLVH/3kpNsW53VZY3FwlYYjZSwZ3xlSJuTAjQTM7lFMiUTqPk45
         jIHT5IVQlkZiKtAu/gtwCK92/PhgLqvicAi2u1tI+HNKX1QNRwBQ/WHW3oMMDHmrOoMY
         ZJMslm/j3+XepCzDHJFH3YI0or9p+SJYJDJc9ouHTVyyfxWqXnFadIFaJfHXG38TJar4
         wd1QrDub4owEXh4HURF5PjTuXgeiaAap8A37bZyB+OwI6ODqvBUQtTt8saTgTW98yTQk
         cOimlL3bA7lL9NNWtN9+/qX3Wc+WWUBsw1PlyJGYTCPgZFUmYrBPYIblG6o8cA4DnTgP
         0UGQ==
X-Received: by 10.50.61.141 with SMTP id p13mr340304igr.38.1401401676731;
        Thu, 29 May 2014 15:14:36 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id b8sm545158igx.3.2014.05.29.15.14.34
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 29 May 2014 15:14:36 -0700 (PDT)
Message-ID: <5387B149.20408@gmail.com>
Date:   Thu, 29 May 2014 15:14:33 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     abdoulaye berthe <berthe.ab@gmail.com>
CC:     linus.walleij@linaro.org, gnurou@gmail.com, m@bues.ch,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
        linux-samsungsoc@vger.kernel.org, spear-devel@list.st.com,
        platform-driver-x86@vger.kernel.org, netdev@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH] gpio: removes all usage of gpiochip_remove retval
References: <1401400492-26175-1-git-send-email-berthe.ab@gmail.com>
In-Reply-To: <1401400492-26175-1-git-send-email-berthe.ab@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 05/29/2014 02:54 PM, abdoulaye berthe wrote:

Did you forget a changelog explaining why this is either needed, or even 
a good idea?  I joined the conversation late and don't know why you are 
doing this.

Thanks,
David Daney



> Signed-off-by: abdoulaye berthe <berthe.ab@gmail.com>
> ---
>   arch/arm/common/scoop.c                        | 10 ++--------
>   arch/mips/txx9/generic/setup.c                 |  4 ++--
>   arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c |  3 ++-
>   arch/sh/boards/mach-x3proto/gpio.c             |  6 ++----
>   drivers/bcma/driver_gpio.c                     |  3 ++-
>   drivers/gpio/gpio-74x164.c                     |  8 +++-----
>   drivers/gpio/gpio-adnp.c                       |  9 +--------
>   drivers/gpio/gpio-adp5520.c                    |  8 +-------
>   drivers/gpio/gpio-adp5588.c                    |  6 +-----
>   drivers/gpio/gpio-amd8111.c                    |  3 +--
>   drivers/gpio/gpio-arizona.c                    |  3 ++-
>   drivers/gpio/gpio-cs5535.c                     |  8 +-------
>   drivers/gpio/gpio-da9052.c                     |  3 ++-
>   drivers/gpio/gpio-da9055.c                     |  3 ++-
>   drivers/gpio/gpio-dwapb.c                      |  2 +-
>   drivers/gpio/gpio-em.c                         |  5 +----
>   drivers/gpio/gpio-f7188x.c                     | 18 ++----------------
>   drivers/gpio/gpio-generic.c                    |  3 ++-
>   drivers/gpio/gpio-grgpio.c                     |  4 +---
>   drivers/gpio/gpio-ich.c                        |  9 +--------
>   drivers/gpio/gpio-it8761e.c                    |  6 +-----
>   drivers/gpio/gpio-janz-ttl.c                   |  8 +-------
>   drivers/gpio/gpio-kempld.c                     |  3 ++-
>   drivers/gpio/gpio-lp3943.c                     |  3 ++-
>   drivers/gpio/gpio-lynxpoint.c                  |  5 +----
>   drivers/gpio/gpio-max730x.c                    | 12 ++++--------
>   drivers/gpio/gpio-max732x.c                    |  7 +------
>   drivers/gpio/gpio-mc33880.c                    | 11 +++--------
>   drivers/gpio/gpio-mc9s08dz60.c                 |  3 ++-
>   drivers/gpio/gpio-mcp23s08.c                   | 26 +++++++-------------------
>   drivers/gpio/gpio-ml-ioh.c                     |  8 ++------
>   drivers/gpio/gpio-msm-v2.c                     |  5 +----
>   drivers/gpio/gpio-mxc.c                        |  2 +-
>   drivers/gpio/gpio-octeon.c                     |  3 ++-
>   drivers/gpio/gpio-palmas.c                     |  3 ++-
>   drivers/gpio/gpio-pca953x.c                    |  7 +------
>   drivers/gpio/gpio-pcf857x.c                    |  4 +---
>   drivers/gpio/gpio-pch.c                        | 10 ++--------
>   drivers/gpio/gpio-rc5t583.c                    |  3 ++-
>   drivers/gpio/gpio-rcar.c                       |  5 +----
>   drivers/gpio/gpio-rdc321x.c                    |  7 ++-----
>   drivers/gpio/gpio-sch.c                        | 16 +++-------------
>   drivers/gpio/gpio-sch311x.c                    |  6 ++----
>   drivers/gpio/gpio-sodaville.c                  |  4 +---
>   drivers/gpio/gpio-stmpe.c                      |  8 +-------
>   drivers/gpio/gpio-sx150x.c                     |  7 ++-----
>   drivers/gpio/gpio-syscon.c                     |  3 ++-
>   drivers/gpio/gpio-tb10x.c                      |  5 +----
>   drivers/gpio/gpio-tc3589x.c                    |  8 +-------
>   drivers/gpio/gpio-timberdale.c                 |  5 +----
>   drivers/gpio/gpio-tps6586x.c                   |  3 ++-
>   drivers/gpio/gpio-tps65910.c                   |  3 ++-
>   drivers/gpio/gpio-tps65912.c                   |  3 ++-
>   drivers/gpio/gpio-ts5500.c                     |  6 +++---
>   drivers/gpio/gpio-twl4030.c                    |  4 +---
>   drivers/gpio/gpio-twl6040.c                    |  3 ++-
>   drivers/gpio/gpio-ucb1400.c                    |  2 +-
>   drivers/gpio/gpio-viperboard.c                 | 10 +++-------
>   drivers/gpio/gpio-vx855.c                      |  3 +--
>   drivers/gpio/gpio-wm831x.c                     |  3 ++-
>   drivers/gpio/gpio-wm8350.c                     |  3 ++-
>   drivers/gpio/gpio-wm8994.c                     |  3 ++-
>   drivers/hid/hid-cp2112.c                       |  6 ++----
>   drivers/input/keyboard/adp5588-keys.c          |  4 +---
>   drivers/input/keyboard/adp5589-keys.c          |  4 +---
>   drivers/input/touchscreen/ad7879.c             | 10 +++-------
>   drivers/leds/leds-pca9532.c                    | 10 ++--------
>   drivers/leds/leds-tca6507.c                    |  7 ++-----
>   drivers/media/dvb-frontends/cxd2820r_core.c    | 10 +++-------
>   drivers/mfd/asic3.c                            |  3 ++-
>   drivers/mfd/htc-i2cpld.c                       |  8 +-------
>   drivers/mfd/sm501.c                            | 17 +++--------------
>   drivers/mfd/tc6393xb.c                         | 13 ++++---------
>   drivers/mfd/ucb1x00-core.c                     |  8 ++------
>   drivers/pinctrl/pinctrl-abx500.c               | 15 +++------------
>   drivers/pinctrl/pinctrl-adi2.c                 |  9 ++++-----
>   drivers/pinctrl/pinctrl-as3722.c               | 11 ++---------
>   drivers/pinctrl/pinctrl-baytrail.c             |  5 +----
>   drivers/pinctrl/pinctrl-coh901.c               | 10 ++--------
>   drivers/pinctrl/pinctrl-exynos5440.c           |  6 +-----
>   drivers/pinctrl/pinctrl-msm.c                  | 11 ++---------
>   drivers/pinctrl/pinctrl-nomadik.c              |  2 +-
>   drivers/pinctrl/pinctrl-rockchip.c             | 16 ++++------------
>   drivers/pinctrl/pinctrl-samsung.c              | 14 ++++----------
>   drivers/pinctrl/pinctrl-sunxi.c                |  3 +--
>   drivers/pinctrl/sh-pfc/gpio.c                  |  9 +++------
>   drivers/pinctrl/spear/pinctrl-plgpio.c         |  3 +--
>   drivers/pinctrl/vt8500/pinctrl-wmt.c           |  9 ++-------
>   drivers/platform/x86/intel_pmic_gpio.c         |  3 +--
>   drivers/ssb/driver_gpio.c                      |  3 ++-
>   drivers/staging/vme/devices/vme_pio2_gpio.c    |  4 +---
>   drivers/tty/serial/max310x.c                   | 10 ++++------
>   drivers/video/fbdev/via/via-gpio.c             | 10 +++-------
>   sound/soc/codecs/wm5100.c                      |  5 +----
>   sound/soc/codecs/wm8903.c                      |  6 +-----
>   sound/soc/codecs/wm8962.c                      |  5 +----
>   sound/soc/codecs/wm8996.c                      |  6 +-----
>   97 files changed, 182 insertions(+), 460 deletions(-)
>
[...]
