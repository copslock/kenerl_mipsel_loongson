Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Nov 2012 23:25:08 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:55033 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824768Ab2KXWYu5QuU6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Nov 2012 23:24:50 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id C67308F71;
        Sat, 24 Nov 2012 23:24:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CJSRzCIQDN6d; Sat, 24 Nov 2012 23:24:29 +0100 (CET)
Received: from hauke-desktop.lan (unknown [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 4F5558F60;
        Sat, 24 Nov 2012 23:24:27 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linville@tuxdriver.com
Cc:     linux-wireless@vger.kernel.org, wim@iguana.be,
        linux-watchdog@vger.kernel.org, castet.matthieu@free.fr,
        biblbroks@sezampro.rs, m@bues.ch, zajec5@gmail.com,
        linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/15] watchdog/bcm47xx/bcma/ssb: add support for SoCs with PMU
Date:   Sat, 24 Nov 2012 23:24:00 +0100
Message-Id: <1353795855-22236-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 35108
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

This patch series improves the watchdog driver used on the Broadcom 
bcm47xx SoCs.
The watchdog driver does not access the functions directly any more, 
but it registers as a platform device driver and ssb and bcma are 
registering a device for this watchdog driver.
This also adds support for SoCs with a power management unit (PMU), 
which have different clock rates.

This code is currently based on the wireless-testing/master tree by 
John Linville, because there are some changes in ssb and bcma in that 
tree queued for 3.8 which will conflict with these changes, if this 
would be based on an other tree. I have no problem with rebasing this 
onto any other tree.

Hauke Mehrtens (15):
  watchdog: bcm47xx_wdt.c: convert to watchdog core api
  watchdog: bcm47xx_wdt.c: use platform device
  watchdog: bcm47xx_wdt.c: rename ops methods
  watchdog: bcm47xx_wdt.c: rename wdt_timeout to timeout
  watchdog: bcm47xx_wdt.c: add hard timer
  bcma: add bcma_chipco_alp_clock
  bcma: set the pmu watchdog if available
  bcma: add methods for watchdog driver
  bcma: register watchdog driver
  ssb: get alp clock from devices with PMU
  ssb: set the pmu watchdog if available
  ssb: add methods for watchdog driver
  ssb: extif: add check for max value in watchdog
  ssb: extif: add methods for watchdog driver
  ssb: register watchdog driver

 drivers/bcma/bcma_private.h                 |    2 +
 drivers/bcma/driver_chipcommon.c            |  114 ++++++++-
 drivers/bcma/main.c                         |    8 +
 drivers/ssb/driver_chipcommon.c             |   99 +++++++-
 drivers/ssb/driver_chipcommon_pmu.c         |   27 +++
 drivers/ssb/driver_extif.c                  |   24 +-
 drivers/ssb/embedded.c                      |   35 +++
 drivers/ssb/main.c                          |    8 +
 drivers/ssb/ssb_private.h                   |   31 +++
 drivers/watchdog/Kconfig                    |    1 +
 drivers/watchdog/bcm47xx_wdt.c              |  339 ++++++++++++---------------
 include/linux/bcm47xx_wdt.h                 |   28 +++
 include/linux/bcma/bcma_driver_chipcommon.h |    7 +-
 include/linux/ssb/ssb.h                     |    2 +
 include/linux/ssb/ssb_driver_chipcommon.h   |    5 +-
 include/linux/ssb/ssb_driver_extif.h        |   10 +-
 16 files changed, 522 insertions(+), 218 deletions(-)
 create mode 100644 include/linux/bcm47xx_wdt.h

-- 
1.7.10.4
