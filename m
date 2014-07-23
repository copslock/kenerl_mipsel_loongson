Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 16:36:58 +0200 (CEST)
Received: from mail-we0-f179.google.com ([74.125.82.179]:50746 "EHLO
        mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822058AbaGWOgquwEMG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 16:36:46 +0200
Received: by mail-we0-f179.google.com with SMTP id u57so1297997wes.38
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 07:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=68M9FAsgigSkGbEAzEB8JxHG/RNEYdJ6srNvHdpc+qQ=;
        b=Ou41g5RmgBb8F7qxhZFIqnzkv59DT2nzqqcJk+sQAWF8TXLkInS0QVM4jpuhncmM5b
         IIonnzip+Gw/cK5YIc3QVyhQhfwqlH5z63NP9IwubFQ1X2Yp9qpaDuoheVB+GX73N/gE
         AhP16BDAS+kBAmwU+DD9SHMmVyROAFB+sEiOXuezskSNxoBJkY6Ay0w/6uTXQhf5KIk6
         MpDWjYnW2UXIbKkC12WH8GliH2C9Ob2D+NouMjqFNsYbP/PDgeSz4yOUhqBiSNKf+BDn
         k+oJET+4lQrzRWmRTSanSGsHJm+hXCRJKUuPhykuJ2AtkijQvV6DbCZKQs1BLAvJ/XQP
         su5g==
X-Received: by 10.194.189.230 with SMTP id gl6mr2511245wjc.118.1406126201465;
        Wed, 23 Jul 2014 07:36:41 -0700 (PDT)
Received: from localhost.localdomain (p57A349C7.dip0.t-ipconnect.de. [87.163.73.199])
        by mx.google.com with ESMTPSA id h3sm6717751wjz.48.2014.07.23.07.36.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 07:36:40 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 0/6] MIPS: Alchemy: au1000 header cleaning
Date:   Wed, 23 Jul 2014 16:36:20 +0200
Message-Id: <1406126186-471228-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41529
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

This patchseries removes a few unused register definitions from
the au1000.h header, changes registers to offsets from block
base and finally removes the au_read/au_write and au_sync*
functions.

A large part of the change is the move of all c-code (enums, structs,
inline functions) below the register definitions so that the
helpers to access SYS_ and MEM_ blocks actually compile (they
depend on block base address definitions).

Run-tested on a few DB1xx boards, compile tested MTX-1 and GPR targets.

Manuel Lauss (6):
  MIPS: Alchemy: au1000.h: remove unused register definitions
  MIPS: Alchemy: move ethernet registers to ethernet driver
  MIPS: Alchemy: au1000.h move C-code after register definitions.
  MIPS: Alchemy: introduce helpers to access SYS register block.
  MIPS: Alchemy: add helpers to access static memory ctrl registers.
  MIPS: Alchemy: remove au_read/write/sync

 arch/mips/alchemy/board-mtx1.c                  |    4 +-
 arch/mips/alchemy/board-xxs1500.c               |    4 +-
 arch/mips/alchemy/common/clocks.c               |    6 +-
 arch/mips/alchemy/common/dbdma.c                |   22 +-
 arch/mips/alchemy/common/dma.c                  |   15 +-
 arch/mips/alchemy/common/irq.c                  |    5 +-
 arch/mips/alchemy/common/platform.c             |    2 +-
 arch/mips/alchemy/common/power.c                |   74 +-
 arch/mips/alchemy/common/time.c                 |   23 +-
 arch/mips/alchemy/devboards/db1000.c            |    5 +-
 arch/mips/alchemy/devboards/db1200.c            |   21 +-
 arch/mips/alchemy/devboards/db1300.c            |    2 +-
 arch/mips/alchemy/devboards/db1550.c            |   14 +-
 arch/mips/alchemy/devboards/pm.c                |   39 +-
 arch/mips/include/asm/mach-au1x00/au1000.h      | 2546 ++++++++++-------------
 arch/mips/include/asm/mach-au1x00/au1000_dma.h  |   50 +-
 arch/mips/include/asm/mach-au1x00/gpio-au1000.h |   56 +-
 drivers/mmc/host/au1xmmc.c                      |  169 +-
 drivers/mtd/nand/au1550nd.c                     |   29 +-
 drivers/net/ethernet/amd/au1000_eth.c           |  149 +-
 drivers/rtc/rtc-au1xxx.c                        |   18 +-
 drivers/spi/spi-au1550.c                        |   66 +-
 drivers/video/fbdev/au1100fb.c                  |   15 +-
 drivers/video/fbdev/au1200fb.c                  |   37 +-
 sound/soc/au1x/psc-ac97.c                       |  140 +-
 sound/soc/au1x/psc-i2s.c                        |  100 +-
 sound/soc/au1x/psc.h                            |   22 +-
 27 files changed, 1719 insertions(+), 1914 deletions(-)

-- 
2.0.1
