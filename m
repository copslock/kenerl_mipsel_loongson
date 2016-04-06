Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2016 14:11:10 +0200 (CEST)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35849 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025537AbcDFMLI6LkE4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Apr 2016 14:11:08 +0200
Received: by mail-pa0-f68.google.com with SMTP id k3so199222pav.3;
        Wed, 06 Apr 2016 05:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=iQww6NvfM1/+34l6/MN8qGxcweQQs+sSrEbvcimIJps=;
        b=Mp26bptTNO45j5gdIq7nTwxJ87aNfQ2/O31d/FVuXtxwwxc/Pw1/xVFZSVelA9YQ7p
         F2vwQSpoiDZHtqlsiIPi5EA6vebGhbKY7WXQJvtVbiMOXCvg6roEdK2DmtZrTz2P5G0A
         HkeIJNPI+SIALK6UPpRZ02EZ8ENYSruh6KHkwXa2soy0EsqAzy8Yfqqb1NII98vK+Y9E
         dGrO94yA707a+OSd6PqtJlccx9y79BlWc4F3k20qsPkiUtmXIIpIHJAIII6QRTY+f+Uy
         i8BAwyiB58KT7St4PvGjlHja5a1KROtFApymuv5l2Nqjm4OI1elkGf/gN6TMuVBwFQ2r
         13KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iQww6NvfM1/+34l6/MN8qGxcweQQs+sSrEbvcimIJps=;
        b=bB/RndPivoaL67edM6OIdpin4/OlcI/+ueNqQSe5b/7i28rxAg5+syWk7cUp9umveE
         MgJj0EYha3bf1w7YcHUeK3vXc88usSLJtHoLxWKdbLoppXd4L7us8TpDt6nPFeIWcWGT
         pP+G07QKv4/lu6nI466VVzfnqt9QwgwUOfpm6GV230fb4xUcoOFWtKXCoYdvoAEiho0+
         8aWZmBN0FM/PwlK/BGbcivfLR+I4qc2x35Nv7nmIJDbOPIuaR+uehhoOIfxhbNeiLWQz
         6Ii/SVKJxCeedvNm/xrrVQkfVi01xe5Gv9jmmns2tOz628sdlfbQRXyF+984IwE7y7u+
         spYw==
X-Gm-Message-State: AD7BkJIiATy5BZqL6PsNz0j3xWZES0zOh5yAYzpxXxnSvvvofCffWbgQTS2eQqKWLXXa1Q==
X-Received: by 10.66.251.10 with SMTP id zg10mr70338271pac.1.1459944662778;
        Wed, 06 Apr 2016 05:11:02 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id 3sm4676177pfn.59.2016.04.06.05.10.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 05:11:01 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH 0/7] MIPS: Loongson1B: add NAND, DMA and GPIO support
Date:   Wed,  6 Apr 2016 20:09:30 +0800
Message-Id: <1459944577-6423-1-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

From: Kelvin Cheung <keguang.zhang@gmail.com>

This patchset is to add NAND, DMA and GPIO support for Loongson1B,
and moreover, include some updates/fixes.

This applies on top of mips-for-linux-next.

Thanks!

Kelvin Cheung (7):
  clk: Loongson1: Update clocks of Loongson1B
  cpufreq: Loongson1: Update cpufreq of Loongson1B
  dmaengine: Loongson1: add Loongson1 dmaengine driver
  mtd: nand: add Loongson1 NAND driver
  gpio: Loongson1: add Loongson1 GPIO driver
  MIPS: Loongson1B: Some updates/fixes for LS1B
  MAINTAINERS: add Loongson1 architecture entry

 MAINTAINERS                                       |   9 +
 arch/mips/Kconfig                                 |   2 +
 arch/mips/configs/loongson1b_defconfig            | 125 +++++
 arch/mips/configs/ls1b_defconfig                  | 110 -----
 arch/mips/include/asm/mach-loongson32/cpufreq.h   |   1 -
 arch/mips/include/asm/mach-loongson32/dma.h       |  25 +
 arch/mips/include/asm/mach-loongson32/irq.h       |   1 -
 arch/mips/include/asm/mach-loongson32/loongson1.h |   4 +-
 arch/mips/include/asm/mach-loongson32/nand.h      |  30 ++
 arch/mips/include/asm/mach-loongson32/platform.h  |  14 +-
 arch/mips/include/asm/mach-loongson32/regs-clk.h  |  24 +-
 arch/mips/include/asm/mach-loongson32/regs-mux.h  |  84 ++--
 arch/mips/include/asm/mach-loongson32/regs-pwm.h  |  12 +-
 arch/mips/loongson32/common/platform.c            | 105 ++++-
 arch/mips/loongson32/common/reset.c               |  13 +-
 arch/mips/loongson32/common/time.c                |  27 +-
 arch/mips/loongson32/ls1b/board.c                 |  67 ++-
 drivers/clk/Makefile                              |   2 +-
 drivers/clk/clk-loongson1.c                       | 163 +++++++
 drivers/clk/clk-ls1x.c                            | 162 -------
 drivers/cpufreq/Makefile                          |   2 +-
 drivers/cpufreq/loongson1-cpufreq.c               | 230 +++++++++
 drivers/cpufreq/ls1x-cpufreq.c                    | 222 ---------
 drivers/dma/Kconfig                               |   9 +
 drivers/dma/Makefile                              |   1 +
 drivers/dma/loongson1-dma.c                       | 546 ++++++++++++++++++++++
 drivers/gpio/Kconfig                              |   7 +
 drivers/gpio/Makefile                             |   1 +
 drivers/gpio/gpio-loongson1.c                     | 102 ++++
 drivers/mtd/nand/Kconfig                          |   8 +
 drivers/mtd/nand/Makefile                         |   1 +
 drivers/mtd/nand/loongson1_nand.c                 | 522 +++++++++++++++++++++
 32 files changed, 2041 insertions(+), 590 deletions(-)
 create mode 100644 arch/mips/configs/loongson1b_defconfig
 delete mode 100644 arch/mips/configs/ls1b_defconfig
 create mode 100644 arch/mips/include/asm/mach-loongson32/dma.h
 create mode 100644 arch/mips/include/asm/mach-loongson32/nand.h
 create mode 100644 drivers/clk/clk-loongson1.c
 delete mode 100644 drivers/clk/clk-ls1x.c
 create mode 100644 drivers/cpufreq/loongson1-cpufreq.c
 delete mode 100644 drivers/cpufreq/ls1x-cpufreq.c
 create mode 100644 drivers/dma/loongson1-dma.c
 create mode 100644 drivers/gpio/gpio-loongson1.c
 create mode 100644 drivers/mtd/nand/loongson1_nand.c

-- 
1.9.1
