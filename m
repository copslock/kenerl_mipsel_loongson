Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jan 2013 18:14:29 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:45911 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817419Ab3ALRO3Ic016 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Jan 2013 18:14:29 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 38A788F62;
        Sat, 12 Jan 2013 18:14:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RfpghOZFfKTw; Sat, 12 Jan 2013 18:14:17 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 879908F61;
        Sat, 12 Jan 2013 18:14:17 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     wim@iguana.be
Cc:     linux-watchdog@vger.kernel.org, zajec5@gmail.com,
        linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v4 0/5] watchdog: bcm47xx_wdt.c: add support for SoCs with PMU
Date:   Sat, 12 Jan 2013 18:14:06 +0100
Message-Id: <1358010851-28077-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 35406
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

This patch series improves the functions for setting the watchdog 
driver for bcm47xx based SoCs using ssb and bcma. This makes the 
watchdog driver use the platform device provided by bcma or ssb.

This code is currently based on the linux-watchdog/master tree by 
Wim Van Sebroeck.

v4:
 * Just the parts changing the watchdog driver itself and not ssb or bcma.

v3:
 * Remove changes done to the watchdog driver so John could pull this 
   into wireless-testing, this sill works with the old watchdog driver. 
   The patches changing the watchdog driver will be send later.
   This was done to get this into 3.8 because Wim Van Sebroeck is 
   neither giving an Ack or a Nack on these patches and we want to do 
   more changes to bcma/ssb on top of these.

v2:
 * reword some commit messages
 * rebase on current wireless-testing/master with 
      "ssb: extif: fix compile errors" applied on top of it.
 * do not change value of WDT_SOFTTIMER_MAX
 * moved some small changes in the bcm47xx_wdt.c patches

Hauke Mehrtens (5):
  watchdog: bcm47xx_wdt.c: convert to watchdog core api
  watchdog: bcm47xx_wdt.c: use platform device
  watchdog: bcm47xx_wdt.c: rename ops methods
  watchdog: bcm47xx_wdt.c: rename wdt_time to timeout
  watchdog: bcm47xx_wdt.c: add hard timer

 drivers/watchdog/Kconfig       |    1 +
 drivers/watchdog/bcm47xx_wdt.c |  339 +++++++++++++++++-----------------------
 include/linux/bcm47xx_wdt.h    |    9 ++
 3 files changed, 154 insertions(+), 195 deletions(-)

-- 
1.7.10.4
