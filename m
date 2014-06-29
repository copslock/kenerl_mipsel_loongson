Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jun 2014 19:46:05 +0200 (CEST)
Received: from mail-wg0-f50.google.com ([74.125.82.50]:45276 "EHLO
        mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861524AbaF2Q5neGGvb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Jun 2014 18:57:43 +0200
Received: by mail-wg0-f50.google.com with SMTP id m15so6964250wgh.33
        for <linux-mips@linux-mips.org>; Sun, 29 Jun 2014 09:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=WFsKBWgsZO3EH+/5R9aALlZghUjA0vaT4iJrLjyCrvs=;
        b=HDWdBWJiyxRJdPNxjEBB/pwQhhHrW/yekWlCC6x23WK42Toti15dLI7yPJ6hajq54+
         uv4b4LXjOflqI3UNzrGFuwruN1YgCXHXR9ugOiN0pdWUkUpZ0tsr6MOn7SG6ehfvWB6c
         DXFwfZ3pDlPDW63UKe4D+wqUvOpU3nKXWY0Owoa6TJfsusFDj4jbxEiwjoXnxk3m2y/T
         ewmZq90Ekj+eKATgomBcpSWQ9DIp+ocrSGu5OkWzHMCax3CH2rltOE2jh3bQvFCopRNo
         +J2/ppRcfwqpunHUG8gz2D/GjHkubB+43V9P8ns2dLenB7UhmxNyiZ7DI2/U3UcJLEQ+
         rZ/g==
X-Received: by 10.180.149.175 with SMTP id ub15mr24455805wib.53.1404061057923;
        Sun, 29 Jun 2014 09:57:37 -0700 (PDT)
Received: from localhost.localdomain (p57A3421F.dip0.t-ipconnect.de. [87.163.66.31])
        by mx.google.com with ESMTPSA id kp5sm35585810wjb.30.2014.06.29.09.57.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 29 Jun 2014 09:57:37 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Mike Turquette <mturquette@linaro.org>,
        linux-kernel@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH 0/2] MIPS: Alchemy: common clk framework integration
Date:   Sun, 29 Jun 2014 18:57:33 +0200
Message-Id: <1404061055-89797-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.0
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40954
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

This is a request for comments for the below patches.

Patch 1 is a cleanup I came up with while writing patch 2.  I'm sending
        it along because the other one depends on some things introduced
        in it to compile cleanly.

Patch 2 adds COMMON_CLK support for all configurable internal
        clock sources on alchemy socs.

Please have a look!

Thanks a lot,
        Manuel Lauss

Manuel Lauss (2):
  MIPS: Alchemy: au1000 header file cleanup
  MIPS: Alchemy: common clock framework integration

 arch/mips/Kconfig                               |    1 +
 arch/mips/alchemy/board-mtx1.c                  |    4 +-
 arch/mips/alchemy/board-xxs1500.c               |    4 +-
 arch/mips/alchemy/common/Makefile               |    2 +-
 arch/mips/alchemy/common/clock.c                | 1113 ++++++++++
 arch/mips/alchemy/common/clocks.c               |  105 -
 arch/mips/alchemy/common/dbdma.c                |   22 +-
 arch/mips/alchemy/common/dma.c                  |   15 +-
 arch/mips/alchemy/common/irq.c                  |    4 +-
 arch/mips/alchemy/common/platform.c             |   12 +-
 arch/mips/alchemy/common/power.c                |   88 +-
 arch/mips/alchemy/common/setup.c                |   21 +-
 arch/mips/alchemy/common/time.c                 |   25 +-
 arch/mips/alchemy/common/usb.c                  |   10 +
 arch/mips/alchemy/devboards/db1000.c            |   19 +-
 arch/mips/alchemy/devboards/db1200.c            |   73 +-
 arch/mips/alchemy/devboards/db1300.c            |   10 +-
 arch/mips/alchemy/devboards/db1550.c            |   25 +-
 arch/mips/alchemy/devboards/pm.c                |   39 +-
 arch/mips/include/asm/mach-au1x00/au1000.h      | 2514 ++++++++++-------------
 arch/mips/include/asm/mach-au1x00/au1000_dma.h  |   51 +-
 arch/mips/include/asm/mach-au1x00/gpio-au1000.h |   66 +-
 arch/mips/pci/pci-alchemy.c                     |   85 +-
 drivers/mmc/host/au1xmmc.c                      |  194 +-
 drivers/mtd/nand/au1550nd.c                     |   52 +-
 drivers/net/ethernet/amd/au1000_eth.c           |  155 +-
 drivers/net/irda/au1k_ir.c                      |   48 +-
 drivers/rtc/rtc-au1xxx.c                        |   18 +-
 drivers/spi/spi-au1550.c                        |   66 +-
 drivers/video/fbdev/au1100fb.c                  |   19 +-
 drivers/video/fbdev/au1200fb.c                  |   34 +-
 sound/soc/au1x/psc-ac97.c                       |  140 +-
 sound/soc/au1x/psc-i2s.c                        |  100 +-
 sound/soc/au1x/psc.h                            |   22 +-
 34 files changed, 3017 insertions(+), 2139 deletions(-)
 create mode 100644 arch/mips/alchemy/common/clock.c
 delete mode 100644 arch/mips/alchemy/common/clocks.c

-- 
2.0.0
