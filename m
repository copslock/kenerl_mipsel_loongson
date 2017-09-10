Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Sep 2017 23:44:52 +0200 (CEST)
Received: from mail-lf0-x22e.google.com ([IPv6:2a00:1450:4010:c07::22e]:38362
        "EHLO mail-lf0-x22e.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991599AbdIJVopCCLfu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 10 Sep 2017 23:44:45 +0200
Received: by mail-lf0-x22e.google.com with SMTP id q132so14376287lfe.5
        for <linux-mips@linux-mips.org>; Sun, 10 Sep 2017 14:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NPJnt6DBOZyDbXy7i482J3lzooUWfFSBp/M/l+4Dbh8=;
        b=jp/3LAPvQbClEMWTE4P//+aiHN4qx7JriZyGZlDNdASSRyBpG1h0K6VCkHz9bD9BqL
         /sanxFrPHfr29NvfePBvOj3K5UmUNZRS1npTmLLZG0hxqO68pzNyUcboQtp54yLTHR+z
         kjr4AgGp60dX5P4ZsGXNKaC0FcEwPJ5AgjFbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NPJnt6DBOZyDbXy7i482J3lzooUWfFSBp/M/l+4Dbh8=;
        b=LHYnk4Y91kK//r35WXuRQ87Kzfw1k1oDh1RUN5Ks0yLaxTjFDDQd7jzWT1r0VZX7JO
         UvQJGkkT3Zr2tN8kN8GZciNNjZaApAaMlkOj7BNhsuk4ve7eYBjVQCMnOc8Tau6MP/qe
         HpDp/bfCWu0BhS/pEyMwM+TMOK976Irts1b7eJvRIM5lBdZKglEWLGsjd6+iQJD90914
         2HKu0P5QP21PIBkRXcg0AVK8ZXDQjFAG2qtwVMfGJBSO18RpUpe812kETWC/wXnkPPPV
         s6tMzMy88C+8aFTQN3fShZv4Rm5THogLruPp/pn5xdKdSmk4GBm83uc2GyUkeqVH1Ec9
         DJ5Q==
X-Gm-Message-State: AHPjjUiqKpvZBck20NsYmZpGeAwcx4gj7WhB4EUyqKx9fhlf4RCDYrC7
        ndvmN4/UqMDGeisTZV61WA==
X-Google-Smtp-Source: AOwi7QDyf/JwYlqFfcj+Cx0MR/HOs43sn7Dc5+qe1OA9/UQt+4gsPNeuGp6qeFpkPUbZsNcE21Bp/Q==
X-Received: by 10.25.155.71 with SMTP id d68mr2481468lfe.181.1505079877815;
        Sun, 10 Sep 2017 14:44:37 -0700 (PDT)
Received: from fabina.bredbandsbolaget.se (c-2209e055.014-348-6c756e10.cust.bredbandsbolaget.se. [85.224.9.34])
        by smtp.gmail.com with ESMTPSA id c69sm1461546ljd.42.2017.09.10.14.44.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Sep 2017 14:44:37 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        adi-buildroot-devel@lists.sourceforge.net,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/5] I2C GPIO to use gpiolibs open drain
Date:   Sun, 10 Sep 2017 23:44:19 +0200
Message-Id: <20170910214424.14945-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.13.5
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59977
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

I recently looked at this driver when testing the I2C GPIO
on the Gemini platform.

It's one of the archectypical places in the kernel where we
have open coded open drain emulation, also without much
explanation. So I went in and fixed it.

The fix is pretty brutal changing all boards and one MFD
device using this, but I like the end result, making the
code much more readable and skipping the intermediate step
of looping through the old GPIO API.

It would be nice to get some testing and ACKs on this if
people agree.

I imagine Wolfram would use the whole thing into the I2C
tree but I could also carry a branch in GPIO to be merged
through the GPIO tree if it is preferred (like e.g. Wolfram
want me to get the heat for any regressions, hehe).

Linus Walleij (5):
  i2c: gpio: Convert to use descriptors
  gpio: Make it possible for consumers to enforce open drain
  i2c: gpio: Enforce open drain through gpiolib
  i2c: gpio: Augment all boardfiles to use open drain
  i2c: gpio: Local vars in probe

 arch/arm/mach-ep93xx/core.c                  |  41 +++---
 arch/arm/mach-ep93xx/edb93xx.c               |  15 +--
 arch/arm/mach-ep93xx/include/mach/platform.h |   4 +-
 arch/arm/mach-ep93xx/simone.c                |  12 +-
 arch/arm/mach-ep93xx/snappercl15.c           |  12 +-
 arch/arm/mach-ep93xx/vision_ep9307.c         |   7 +-
 arch/arm/mach-ixp4xx/avila-setup.c           |  17 ++-
 arch/arm/mach-ixp4xx/dsmg600-setup.c         |  16 ++-
 arch/arm/mach-ixp4xx/fsg-setup.c             |  16 ++-
 arch/arm/mach-ixp4xx/goramo_mlr.c            |  24 +---
 arch/arm/mach-ixp4xx/ixdp425-setup.c         |  16 ++-
 arch/arm/mach-ixp4xx/nas100d-setup.c         |  16 ++-
 arch/arm/mach-ixp4xx/nslu2-setup.c           |  16 ++-
 arch/arm/mach-ks8695/board-acs5k.c           |  15 ++-
 arch/arm/mach-pxa/palmz72.c                  |  14 +-
 arch/arm/mach-pxa/viper.c                    |  27 +++-
 arch/arm/mach-sa1100/simpad.c                |  14 +-
 arch/blackfin/mach-bf533/boards/blackstamp.c |  19 ++-
 arch/blackfin/mach-bf533/boards/ezkit.c      |  18 ++-
 arch/blackfin/mach-bf533/boards/stamp.c      |  18 ++-
 arch/blackfin/mach-bf561/boards/ezkit.c      |  18 ++-
 arch/mips/alchemy/board-gpr.c                |  23 +++-
 arch/mips/ath79/mach-pb44.c                  |  16 ++-
 drivers/gpio/gpiolib.c                       |  13 ++
 drivers/i2c/busses/i2c-gpio.c                | 184 +++++++++++----------------
 drivers/mfd/sm501.c                          |  49 +++----
 include/linux/gpio/consumer.h                |   6 +
 include/linux/i2c-gpio.h                     |   4 -
 28 files changed, 372 insertions(+), 278 deletions(-)

-- 
2.13.5
