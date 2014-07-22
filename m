Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 18:50:03 +0200 (CEST)
Received: from mail-oi0-f51.google.com ([209.85.218.51]:49771 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6862922AbaGVPIU3mjPc convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Jul 2014 17:08:20 +0200
Received: by mail-oi0-f51.google.com with SMTP id g201so4481409oib.38
        for <linux-mips@linux-mips.org>; Tue, 22 Jul 2014 08:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6F9DtjLujJQcTK8y18GnURvYA9tFY/3cKFdaUjAhalg=;
        b=I9VmFh6PJEsrAClZC/0PnVYxtoyUs/SmYaVzPIs9cLMFaZX9qlOuYIQ59U0j9/l5/D
         kFoMtEvL2sRGu+CAnK5bBC0oxKaEIDVpG8LgMtHbRQK6QkGRrsGzB89wOkHvNYwdPy+o
         K5SUgztOiOnouYoraslbYKGhSedmzaXPK7iWvTfoLTN/lzryO2Vla/xar9/enxXnvGyp
         u+uT49RA3eGTkdNFL7SpzZ2qgP8Y/bJHUdmsMCBm4xQ/YY5iJm6bGQxntKkjzH6gC9+v
         BZWfY52txh/EyQz68pfdTsnyXP02SSpg0+sw/nXUGdZqFIDZNXfNzj7qq5ARBCWX1yhM
         35uw==
X-Gm-Message-State: ALoCoQlxiQX5x2AM/QMKwlZctx8OV1y5okb4zKBkXQPJZVaDDjodsmEpedAT/8hM2QKWitHXYPom
MIME-Version: 1.0
X-Received: by 10.182.135.164 with SMTP id pt4mr46895896obb.81.1406041693991;
 Tue, 22 Jul 2014 08:08:13 -0700 (PDT)
Received: by 10.182.33.100 with HTTP; Tue, 22 Jul 2014 08:08:13 -0700 (PDT)
In-Reply-To: <1405197014-25225-4-git-send-email-berthe.ab@gmail.com>
References: <CACRpkda6mzVdaN0cvOxpbsxWyCv2nGyDXOjZg_5aT8u7SSQeUw@mail.gmail.com>
        <1405197014-25225-1-git-send-email-berthe.ab@gmail.com>
        <1405197014-25225-4-git-send-email-berthe.ab@gmail.com>
Date:   Tue, 22 Jul 2014 17:08:13 +0200
Message-ID: <CACRpkdasp9bLULT7NJM9nYX58rRSsQKXFddOLz9Ah6kp-j-3=Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] driver:gpio remove all usage of gpio_remove retval in driver
From:   Linus Walleij <linus.walleij@linaro.org>
To:     abdoulaye berthe <berthe.ab@gmail.com>,
        "arm@kernel.org" <arm@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bryan Wu <cooloney@gmail.com>,
        Mauro Carvalho Chehab <m.chehab@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Michael Buesch <m@bues.ch>,
        Greg KH <gregkh@linuxfoundation.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Alexandre Courbot <gnurou@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41462
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

On Sat, Jul 12, 2014 at 10:30 PM, abdoulaye berthe <berthe.ab@gmail.com> wrote:

Heads up. Requesting ACKs for this patch or I'm atleast warning that it will be
applied. We're getting rid of the return value from gpiochip_remove().

> this remove all reference to gpio_remove retval in all driver
> except pinctrl and gpio. the same thing is done for gpio and
> pinctrl in two different patches.
>
> Signed-off-by: abdoulaye berthe <berthe.ab@gmail.com>
(...)

I think this patch probably needs to be broken down per-subsystem as it
hits all over the map. But let's start requesting ACKs for the
individual pieces.
Actually I think it will be OK to merge because there is likely not much churn
around these code sites.

I'm a bit torn between just wanting a big patch for this hitting drivers/gpio
and smaller patches hitting one subsystem at a time. We should be able
to hammer this in one switch strike.

>  arch/arm/common/scoop.c                        | 10 ++--------

ARM SoC folks, can you ACK this?

>  arch/mips/txx9/generic/setup.c                 |  4 ++--

Ralf can you ACK this?

>  arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c |  3 ++-

Benji, can you ACK this?

>  arch/sh/boards/mach-x3proto/gpio.c             |  6 ++----

Aha noone can ACK this, whatever...

>  drivers/bcma/driver_gpio.c                     |  3 ++-

Rafał can you ACK this?

>  drivers/hid/hid-cp2112.c                       |  6 ++----

Jiri can you ACK this?

>  drivers/input/keyboard/adp5588-keys.c          |  4 +---
>  drivers/input/keyboard/adp5589-keys.c          |  4 +---
>  drivers/input/touchscreen/ad7879.c             | 10 +++-------

Dmitry can you ACK this?

>  drivers/leds/leds-pca9532.c                    | 10 ++--------
>  drivers/leds/leds-tca6507.c                    |  7 ++-----

Bryan can you ACK this?

>  drivers/media/dvb-frontends/cxd2820r_core.c    | 10 +++-------

Mauro can you ACK this?

(Hm that looks weird. Mental note to look closer at this.)

>  drivers/mfd/asic3.c                            |  3 ++-
>  drivers/mfd/htc-i2cpld.c                       |  8 +-------
>  drivers/mfd/sm501.c                            | 17 +++--------------
>  drivers/mfd/tc6393xb.c                         | 13 ++++---------
>  drivers/mfd/ucb1x00-core.c                     |  8 ++------

Lee/Sam can either of you ACK this?

>  drivers/pinctrl/pinctrl-abx500.c               | 15 +++------------
>  drivers/pinctrl/pinctrl-exynos5440.c           |  6 +-----
>  drivers/pinctrl/pinctrl-msm.c                  | 10 +++-------
>  drivers/pinctrl/pinctrl-nomadik.c              |  2 +-
>  drivers/pinctrl/pinctrl-samsung.c              | 14 ++++----------

Abdoulaye: these should be in the other patch for pinctrl.

>  drivers/platform/x86/intel_pmic_gpio.c         |  3 +--

Matthew can you ACK this?

>  drivers/ssb/driver_gpio.c                      |  3 ++-

Michael can you (A) ACK this and
(B) think of moving this driver to drivers/gpio... Patches welcome.

>  drivers/staging/vme/devices/vme_pio2_gpio.c    |  4 +---
>  drivers/tty/serial/max310x.c                   | 10 ++++------

Greg can you ACK this?

>  drivers/video/fbdev/via/via-gpio.c             | 10 +++-------

Tomi can you ACK this?

>  sound/soc/codecs/wm5100.c                      |  5 +----
>  sound/soc/codecs/wm8903.c                      |  6 +-----
>  sound/soc/codecs/wm8962.c                      |  5 +----
>  sound/soc/codecs/wm8996.c                      |  6 +-----

Liam || Mark can you ACK this?

Yours,
Linus Walleij
