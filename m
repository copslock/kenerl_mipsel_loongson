Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Sep 2017 11:39:27 +0200 (CEST)
Received: from mail-lf0-x22f.google.com ([IPv6:2a00:1450:4010:c07::22f]:57321
        "EHLO mail-lf0-x22f.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992604AbdIQJjVOk-OP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Sep 2017 11:39:21 +0200
Received: by mail-lf0-x22f.google.com with SMTP id a18so5562466lfl.13
        for <linux-mips@linux-mips.org>; Sun, 17 Sep 2017 02:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jnkFVZuCs8tCS72rnGKumg5zfRI8BEYKUCFYpr678Do=;
        b=PGoh4cd6Ps6Av8pYMJ4uQr4IHxAEZP5frtqQVt3+aUqL3QB/jliD0DPS1xp5R011r/
         4Gf3vvE9VtvRNVMj1A5xH8/BvMhoJNV+Neh7YeUbDJJ3jN2ZLVOcyTRzp3f7Dh9X83BM
         q+64DxGd+YVIuW4EdE/87PEJWmQbReqP0x8m4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jnkFVZuCs8tCS72rnGKumg5zfRI8BEYKUCFYpr678Do=;
        b=QKW4GrlRSw7go1B3RHHqL4s2v7PLnBNCbxivybwMlM/jIlHFZFfAtLcIChjO5asmwX
         LcGns8huq0BVcpfPlFhDjg88Mv0TdABXh5uTAhR8DFh5kUnfROv+HET7Mv8eZfpaiU+6
         V+3sJ0alDeO2+YKXs5MDPRYAI3ZblsNNAjnOzfij9QKpUZCeLELUkCiy1uuEeKM1DO7b
         MrfVGVYlVJMAiULbDn/usW5e639lb+MESVcDU6zoO1FbIXYltCR4SjhrW29YHUznAJy0
         w4Xmo/Mm+fVUnozTgDV8VrlJgKZiBbOhidT//8nGPIOHOlH3c3RrKI9NdsAntBcLTpWS
         b05g==
X-Gm-Message-State: AHPjjUjQLPeoir9SfJe/MdZSJTBNUEke4IadLOHH8Y1XkzgPDQctWRIr
        7/q98Ke3PqyWeatW
X-Google-Smtp-Source: AOwi7QCxFP77zq2rHe7EymrvY8tdC5bVPT/OV8/B1/GnedKUbtAIfN2HoqhBm/E1IgP44ExqeG/k3w==
X-Received: by 10.25.205.149 with SMTP id d143mr2012195lfg.147.1505641155348;
        Sun, 17 Sep 2017 02:39:15 -0700 (PDT)
Received: from fabina.bredbandsbolaget.se (c-2209e055.014-348-6c756e10.cust.bredbandsbolaget.se. [85.224.9.34])
        by smtp.gmail.com with ESMTPSA id t84sm974559lfi.21.2017.09.17.02.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Sep 2017 02:39:14 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        adi-buildroot-devel@lists.sourceforge.net,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/7] I2C GPIO to use gpiolibs open drain
Date:   Sun, 17 Sep 2017 11:38:59 +0200
Message-Id: <20170917093906.16325-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.13.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60037
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

This augments the I2C GPIO driver to use open drain emulation
or hardware support for open drain from the GPIO driver.

This version layers Geert Uytterhoeven's idea to use explicit
sda-gpios and scl-gpios for the GPIO lines, and strongly
encourage the (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN) flags to be
used in all device trees.

We have collected ACKs from the ARM SoC maintainers and the
MFD maintainer and are looking for testers to try this out.

Geert Uytterhoeven (1):
  dt-bindings: i2c: i2c-gpio: Add support for named gpios

Linus Walleij (6):
  i2c: gpio: Convert to use descriptors
  gpio: Make it possible for consumers to enforce open drain
  i2c: gpio: Enforce open drain through gpiolib
  i2c: gpio: Augment all boardfiles to use open drain
  i2c: gpio: Local vars in probe
  i2c: gpio: Add support for named gpios in DT

 Documentation/devicetree/bindings/i2c/i2c-gpio.txt |  32 +++-
 arch/arm/mach-ep93xx/core.c                        |  41 ++--
 arch/arm/mach-ep93xx/edb93xx.c                     |  15 +-
 arch/arm/mach-ep93xx/include/mach/platform.h       |   4 +-
 arch/arm/mach-ep93xx/simone.c                      |  12 +-
 arch/arm/mach-ep93xx/snappercl15.c                 |  12 +-
 arch/arm/mach-ep93xx/vision_ep9307.c               |   7 +-
 arch/arm/mach-ixp4xx/avila-setup.c                 |  17 +-
 arch/arm/mach-ixp4xx/dsmg600-setup.c               |  16 +-
 arch/arm/mach-ixp4xx/fsg-setup.c                   |  16 +-
 arch/arm/mach-ixp4xx/goramo_mlr.c                  |  24 +--
 arch/arm/mach-ixp4xx/ixdp425-setup.c               |  16 +-
 arch/arm/mach-ixp4xx/nas100d-setup.c               |  16 +-
 arch/arm/mach-ixp4xx/nslu2-setup.c                 |  16 +-
 arch/arm/mach-ks8695/board-acs5k.c                 |  15 +-
 arch/arm/mach-pxa/palmz72.c                        |  14 +-
 arch/arm/mach-pxa/viper.c                          |  27 ++-
 arch/arm/mach-sa1100/simpad.c                      |  14 +-
 arch/blackfin/mach-bf533/boards/blackstamp.c       |  19 +-
 arch/blackfin/mach-bf533/boards/ezkit.c            |  18 +-
 arch/blackfin/mach-bf533/boards/stamp.c            |  18 +-
 arch/blackfin/mach-bf561/boards/ezkit.c            |  18 +-
 arch/mips/alchemy/board-gpr.c                      |  23 ++-
 arch/mips/ath79/mach-pb44.c                        |  16 +-
 drivers/gpio/gpiolib.c                             |  13 ++
 drivers/i2c/busses/i2c-gpio.c                      | 213 ++++++++++-----------
 drivers/mfd/sm501.c                                |  49 ++---
 include/linux/gpio/consumer.h                      |   6 +
 include/linux/i2c-gpio.h                           |   4 -
 29 files changed, 423 insertions(+), 288 deletions(-)

-- 
2.13.5
