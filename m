Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Aug 2012 13:12:25 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:36857 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903551Ab2HELMT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Aug 2012 13:12:19 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 59FF78F63;
        Sun,  5 Aug 2012 13:12:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id opA-qMYVft-H; Sun,  5 Aug 2012 13:12:12 +0200 (CEST)
Received: from hauke.lan (unknown [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 7827987B9;
        Sun,  5 Aug 2012 13:12:12 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/3] MIPS: BCM47xx: use gpiolib
Date:   Sun,  5 Aug 2012 13:12:00 +0200
Message-Id: <1344165123-4640-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 34062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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
Return-Path: <linux-mips-bounce@linux-mips.org>

The original code implemented the GPIO interface itself and this caused
some problems. With this patch gpiolib is used.

This is based on mips/master.

Hauke Mehrtens (3):
  ssb: add function to return number of gpio lines
  bcma: add GPIO driver for SoCs
  MIPS: BCM47xx: rewrite GPIO handling and use gpiolib

 arch/mips/Kconfig                            |    2 +-
 arch/mips/bcm47xx/gpio.c                     |  208 ++++++++++++++++++++------
 arch/mips/bcm47xx/setup.c                    |    2 +
 arch/mips/bcm47xx/wgt634u.c                  |    7 +
 arch/mips/include/asm/mach-bcm47xx/bcm47xx.h |    2 +
 arch/mips/include/asm/mach-bcm47xx/gpio.h    |  151 +++----------------
 drivers/bcma/Kconfig                         |    5 +
 drivers/bcma/Makefile                        |    1 +
 drivers/bcma/driver_gpio.c                   |   90 +++++++++++
 drivers/bcma/scan.c                          |    4 +
 drivers/ssb/embedded.c                       |   12 ++
 include/linux/bcma/bcma.h                    |    5 +
 include/linux/bcma/bcma_driver_gpio.h        |   21 +++
 include/linux/ssb/ssb_embedded.h             |    4 +
 14 files changed, 339 insertions(+), 175 deletions(-)
 create mode 100644 drivers/bcma/driver_gpio.c
 create mode 100644 include/linux/bcma/bcma_driver_gpio.h

-- 
1.7.9.5
