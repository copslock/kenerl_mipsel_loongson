Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jul 2014 15:23:12 +0200 (CEST)
Received: from mail-wi0-f182.google.com ([209.85.212.182]:44167 "EHLO
        mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860317AbaGCNXGEOM3w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jul 2014 15:23:06 +0200
Received: by mail-wi0-f182.google.com with SMTP id bs8so2213262wib.15
        for <linux-mips@linux-mips.org>; Thu, 03 Jul 2014 06:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=UDY27CVLx6/7fqWN2slo7v67Qt3AF+07gHSKJ1nWt0Y=;
        b=gsVb5OJy7iTT3GWZH4oKLlV+Qnk/cGjmwR+SJKoIokK5rcipoo2c5PqrK6EfE4wEt0
         aAeT3DZ2HmWRye0aRtiqRjmt4mdrA+6CpkLknfTdNh0quUdUQLvuAVk/nyAGvPkf0TF8
         TJp5EAnettEyJvHnnuAoJaa9BfhXy0t3fWaPCbjdLeWWB0yoEaXNKZexL105alfhGenm
         z78stFvaIzk6oWC1XBpWBLg0hbeJeBTTCtp7PDtOwGDgMbIhUltrMKj4YAD3l0754T6J
         alQ3/+ICtoKxarO567dOG+ofgrtulEZ7CEU4MIpQpyxVynchrjNWV4UbH6iGyO1KV6Zm
         MIPA==
X-Received: by 10.194.120.129 with SMTP id lc1mr5036344wjb.16.1404393776329;
        Thu, 03 Jul 2014 06:22:56 -0700 (PDT)
Received: from localhost.localdomain (p57A34891.dip0.t-ipconnect.de. [87.163.72.145])
        by mx.google.com with ESMTPSA id ev9sm67079017wic.24.2014.07.03.06.22.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Jul 2014 06:22:55 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Mike Turquette <mturquette@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH v2 00/11] MIPS: Alchemy: clock framework support
Date:   Thu,  3 Jul 2014 15:22:31 +0200
Message-Id: <1404393762-858019-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.0
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Hello,

Here's another round of patches which expose the configurable parts
of the onchip clocktree of Alchemy SoCs to the common clock framework.

v2: split original patch #2 into a clock framework patch and multiple
    driver adjustment patches, suggested by Mike Turquette.

patch #1 is a big(ger) cleanup of the au1000.h header which presented
         itself during preparation of the other patches.  It's required
         for the others to compile.
patch #2 adds the clock framework integration,
patches #3-#11 adjust various setup files and drivers to use the clock
         framework to get at required clocks and frequencies.

The whole series has been tested on DB1300 and DB1500 boards (i.e. the
 newest variant and an older one with the inflexible dividers), every-
 thing works as before.

Example clock tree dumps:  All clocks listed here have been set up by
firmware.

db1300 ~ # cat /sys/kernel/debug/clk/clk_summary
   clock                         enable_cnt  prepare_cnt        rate   accuracy
--------------------------------------------------------------------------------
 root_clk                                 3            3    12000000          0
    auxpll2_clk                           1            1   756000000          0
       fg5_clk                            0            0   252000000          0
          maebsa_clk                      0            0   252000000          0
       fg4_clk                            0            0   189000000          0
          maempe_clk                      0            0   189000000          0
       fg3_clk                            0            0   252000000          0
          gpemgp_clk                      0            0   252000000          0
       fg2_clk                            1            1   189000000          0
          EXTCLK1                         1            1    47250000          0
       fg1_clk                            0            0   756000000          0
       fg0_clk                            0            0   756000000          0
    auxpll_clk                            1            1   192000000          0
       EXTCLK0                            0            0   192000000          0
       lcd_intclk                         1            1    96000000          0
    cpu_clk                               1            1   660000000          0
       sysbus_clk                         1            1   330000000          0
          mem_clk                         0            0   330000000          0
          periph_clk                      3            3   165000000          0
             lr_clk                       0            0   165000000          0


db1500 ~ # cat /sys/kernel/debug/clk/clk_summary
   clock                         enable_cnt  prepare_cnt        rate   accuracy
--------------------------------------------------------------------------------
 root_clk                                 2            2    12000000          0 
    auxpll_clk                            2            2   384000000          0 
       EXTCLK1                            0            0   384000000          0 
       EXTCLK0                            0            0   384000000          0 
       fg2_clk                            1            1    64000000          0 
          pci_clko                        1            1    64000000          0 
       fg1_clk                            1            1    96000000          0 
          usbh_clk                        1            1    48000000          0 
          usbd_clk                        0            0    48000000          0 
    cpu_clk                               1            1   396000000          0 
       fg5_clk                            0            0   198000000          0 
       fg4_clk                            0            0   198000000          0 
       fg3_clk                            0            0   198000000          0 
       fg0_clk                            0            0   198000000          0 
       sysbus_clk                         1            1   198000000          0 
          mem_clk                         0            0    99000000          0 
          periph_clk                      1            1    99000000          0 
             lr_clk                       0            0    99000000          0 


Feedback very much appreciated!

Thank you,
        Manuel Lauss

Manuel Lauss (11):
  MIPS: Alchemy: au1000 header file cleanup
  MIPS: Alchemy: clock framework integration of onchip clocks
  MIPS: Alchemy: platform: use clk framework for uarts
  MIPS: Alchemy: usb: use clk framework
  MIPS: Alchemy: pci: use clk framework to enable PCI clock
  MIPS: Alchemy: db1200: use clk framework
  MIPS: Alchemy: irda: use clk framework
  MIPS: Alchemy: au1100fb: use clk framework
  MIPS: Alchemy: au1200fb: use clk framework
  MIPS: Alchemy: au1xmmc: use clk framework
  MIPS: Alchemy: remove old clock support

 arch/mips/Kconfig                               |    1 +
 arch/mips/alchemy/board-mtx1.c                  |    4 +-
 arch/mips/alchemy/board-xxs1500.c               |    4 +-
 arch/mips/alchemy/common/Makefile               |    4 +-
 arch/mips/alchemy/common/clock.c                | 1097 ++++++++++
 arch/mips/alchemy/common/clocks.c               |  105 -
 arch/mips/alchemy/common/dbdma.c                |   22 +-
 arch/mips/alchemy/common/dma.c                  |   15 +-
 arch/mips/alchemy/common/irq.c                  |    4 +-
 arch/mips/alchemy/common/platform.c             |   15 +-
 arch/mips/alchemy/common/power.c                |   88 +-
 arch/mips/alchemy/common/setup.c                |   18 +-
 arch/mips/alchemy/common/time.c                 |   25 +-
 arch/mips/alchemy/common/usb.c                  |   47 +-
 arch/mips/alchemy/devboards/db1000.c            |   19 +-
 arch/mips/alchemy/devboards/db1200.c            |   64 +-
 arch/mips/alchemy/devboards/db1300.c            |   10 +-
 arch/mips/alchemy/devboards/db1550.c            |   25 +-
 arch/mips/alchemy/devboards/pm.c                |   39 +-
 arch/mips/include/asm/mach-au1x00/au1000.h      | 2515 ++++++++++-------------
 arch/mips/include/asm/mach-au1x00/au1000_dma.h  |   51 +-
 arch/mips/include/asm/mach-au1x00/gpio-au1000.h |   66 +-
 arch/mips/pci/pci-alchemy.c                     |   88 +-
 drivers/mmc/host/au1xmmc.c                      |  197 +-
 drivers/mtd/nand/au1550nd.c                     |   52 +-
 drivers/net/ethernet/amd/au1000_eth.c           |  155 +-
 drivers/net/irda/au1k_ir.c                      |   48 +-
 drivers/rtc/rtc-au1xxx.c                        |   18 +-
 drivers/spi/spi-au1550.c                        |   66 +-
 drivers/video/fbdev/au1100fb.c                  |   39 +-
 drivers/video/fbdev/au1100fb.h                  |    1 +
 drivers/video/fbdev/au1200fb.c                  |   47 +-
 sound/soc/au1x/psc-ac97.c                       |  140 +-
 sound/soc/au1x/psc-i2s.c                        |  100 +-
 sound/soc/au1x/psc.h                            |   22 +-
 35 files changed, 3064 insertions(+), 2147 deletions(-)
 create mode 100644 arch/mips/alchemy/common/clock.c
 delete mode 100644 arch/mips/alchemy/common/clocks.c

-- 
2.0.0
