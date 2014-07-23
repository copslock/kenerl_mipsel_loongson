Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 16:40:55 +0200 (CEST)
Received: from mail-we0-f179.google.com ([74.125.82.179]:53374 "EHLO
        mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842452AbaGWOhRzT1PB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 16:37:17 +0200
Received: by mail-we0-f179.google.com with SMTP id u57so1298697wes.38
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 07:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=VL2YsoGc8OaD7Gtnn+YBUgc0pFvmetxCRIs0WeZTklw=;
        b=SHDq3cIPbO0P2MHT1J5uiOMLXkm6K9lzE9QkxpRjt6DhMiWO7b9BlJraj6Y8s2RKpi
         aJmJ6ErfXqjo1ZvnW2ph8eqxTqv2xsKfN0/sxYQJHlQy9wqdUk+8Yw1617iEIPdQi5lh
         mZso2D+fXEgEVmE9RudQoQvQrNk0CPQOvQMxr11YihArqkFc3U851+fWCFpzgXwRZVTO
         SPRqiTQa2VFLxvD3KNYPyGtaFeBrTIAEo7NoaDONiKWQlGzcRJOOuaCV2hGhEXAQzwrU
         lcivPnX04XCpCVnLBoSioa9WSFmSPkCeaf3ejaEPIhoEhNdK8t3d+lfqcN2tDvH/lz09
         xf+g==
X-Received: by 10.194.86.225 with SMTP id s1mr2418368wjz.21.1406126232520;
        Wed, 23 Jul 2014 07:37:12 -0700 (PDT)
Received: from localhost.localdomain (p57A349C7.dip0.t-ipconnect.de. [87.163.73.199])
        by mx.google.com with ESMTPSA id ex4sm10196560wic.2.2014.07.23.07.37.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 07:37:11 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 00/10] MIPS: Alchemy: common clk framework support
Date:   Wed, 23 Jul 2014 16:36:47 +0200
Message-Id: <1406126217-471265-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41536
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

This set of patches introduces common clk framework support for
on-chip peripherals.

patch #1  adds the core clk support for SoC-internal configurable
	  clk sources,
patches #2-#9 add clk fwk support to various drivers
patch #10 removes the old basic clk support.

Tested on DB1300, DB1200 and DB1500.

Applies on top of the Alchemy cleanup series I sent to the
MIPS list earlier.

Manuel Lauss (10):
  MIPS: Alchemy: clock framework integration of onchip clocks
  MIPS: Alchemy: platform: use clk framework for uarts
  MIPS: Alchemy: usb: use clk framework
  MIPS: Alchemy: pci: use clk framework to enable PCI clock
  MIPS: Alchemy: db1x00: use clk framework
  MIPS: Alchemy: irda: use clk framework
  MIPS: Alchemy: au1100fb: use clk framework
  MIPS: Alchemy: au1200fb: use clk framework
  MIPS: Alchemy: au1xmmc: use clk framework
  MIPS: Alchemy: remove old clock support

 arch/mips/Kconfig                          |    1 +
 arch/mips/alchemy/common/Makefile          |    4 +-
 arch/mips/alchemy/common/clock.c           | 1094 ++++++++++++++++++++++++++++
 arch/mips/alchemy/common/clocks.c          |  105 ---
 arch/mips/alchemy/common/platform.c        |   13 +-
 arch/mips/alchemy/common/setup.c           |   15 -
 arch/mips/alchemy/common/usb.c             |   47 +-
 arch/mips/alchemy/devboards/db1000.c       |   14 +
 arch/mips/alchemy/devboards/db1200.c       |   50 +-
 arch/mips/alchemy/devboards/db1300.c       |    7 +
 arch/mips/alchemy/devboards/db1550.c       |   13 +
 arch/mips/include/asm/mach-au1x00/au1000.h |   87 +--
 arch/mips/pci/pci-alchemy.c                |   24 +-
 drivers/mmc/host/au1xmmc.c                 |   31 +-
 drivers/net/irda/au1k_ir.c                 |   48 +-
 drivers/video/fbdev/au1100fb.c             |   36 +-
 drivers/video/fbdev/au1100fb.h             |    1 +
 drivers/video/fbdev/au1200fb.c             |   50 +-
 18 files changed, 1360 insertions(+), 280 deletions(-)
 create mode 100644 arch/mips/alchemy/common/clock.c
 delete mode 100644 arch/mips/alchemy/common/clocks.c

-- 
2.0.1
