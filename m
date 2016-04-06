Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2016 14:35:38 +0200 (CEST)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35653 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026142AbcDFMfg4axeZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Apr 2016 14:35:36 +0200
Received: by mail-pa0-f65.google.com with SMTP id zy2so3963643pac.2;
        Wed, 06 Apr 2016 05:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=AIJh0imCAjbOxqfP1fGOk8FxDK1SYx3ZQb1SXW+fmY8=;
        b=hq9oG6/lLt3eu/gI59pCGSDj5myY6RL1B5w3VcDz3NVwz+Zik69tEpulw4LWqDBJZZ
         qo7ez1Ylce+qJEW4QtUJg2NCEilhncntnBPKjkjNTRuxS0OipiYvygDd7K0xUtTJ8j96
         nO8qjTNXYv7zxHpUUMzdrxzxz268gvp6pNJXEHXaTyMBINYkl9H9EaHzKJ6nieljfCph
         ZU2vEYYBbBSNz//CkM2XjXFiEkgc5Mht8hkeEEmVlUpQy+S5ebeUeroVQ7+3ibSnoDWT
         KpT1rE4Kz77rh95dMyb885/6I3hOs74NzLpnKDTk0rF8J8Sgw1l0m9prUiHsw1pRpmXS
         yj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AIJh0imCAjbOxqfP1fGOk8FxDK1SYx3ZQb1SXW+fmY8=;
        b=gRs3kMEkYUwrpHKeDiP3G8Rkb4xKeeBHCpl06LaWbA0VlItQtQFisKElTO35rhrNsh
         Rj3m1c3LtSYQapRlg+LTMMNX+n1KpFq++rKIr8b27QOz8ORfhNC00J5UJ+JO2YtoK/wp
         IKHw6iQk2CPLXWU1ury7Sde48aqqUF9/fP7v8erpTdX5olZS+SfkISD5DM39UQNwWX2h
         nFi+nlmyY2TL/bqmGPJRsc8T7JF+TJTqBOh+Pd+2m+q0YdQMs+SXb1wDMuj7/WvuyeyB
         8jje4Gqw5dz27bNJhmjt2wWkMYQQh+l4KkVBT2CmkXAZkwGLCdyq0MLNWfGPxk+wTre/
         6fNA==
X-Gm-Message-State: AD7BkJJ5Am6/UE/TW9x7Pojaywa7QMsj8Ct+BOevamW0foPEEpBQbYb3KyoPK/hUkv2xvw==
X-Received: by 10.66.255.65 with SMTP id ao1mr47093291pad.38.1459946131137;
        Wed, 06 Apr 2016 05:35:31 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id 27sm4851789pfo.58.2016.04.06.05.35.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 05:35:30 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-mtd@lists.infradead.org
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
Subject: [PATCH V1 0/7] MIPS: Loongson1B: add NAND, DMA and GPIO support
Date:   Wed,  6 Apr 2016 20:34:48 +0800
Message-Id: <1459946095-7637-1-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52906
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

Changelog:

V1: Fix coding style of loongson1_nand.c.
    Add 'Signed-off-by' line for patch#7.
---

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
 drivers/mtd/nand/loongson1_nand.c                 | 519 ++++++++++++++++++++
 32 files changed, 2038 insertions(+), 590 deletions(-)
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
