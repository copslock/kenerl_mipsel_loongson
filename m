Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Sep 2012 20:12:29 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:46286 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903296Ab2I2SMW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 Sep 2012 20:12:22 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 447798F65;
        Sat, 29 Sep 2012 20:12:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dgVPMojn+ifT; Sat, 29 Sep 2012 20:12:17 +0200 (CEST)
Received: from hauke.lan (unknown [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id D226887B9;
        Sat, 29 Sep 2012 20:12:16 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, john@phrozen.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/5] MIPS: BCM47XX: mostly sprom fixes
Date:   Sat, 29 Sep 2012 20:12:01 +0200
Message-Id: <1348942326-27195-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 34558
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

This patch series fixes some problems on the BCM47xx SoCs.

Hauke Mehrtens (5):
  MIPS: BCM47XX: ignore last memory page
  MIPS: BCM47XX: improve memory size detection
  MIPS: BCM47xx: read out full board data
  MIPS: BCM47XX: read sprom without prefix if no ieee80211 core
  MIPS: BCM47xx: sprom: read values without prefix as fallback

 arch/mips/bcm47xx/prom.c                     |   24 +-
 arch/mips/bcm47xx/setup.c                    |   11 +-
 arch/mips/bcm47xx/sprom.c                    |  780 +++++++++++++++-----------
 arch/mips/include/asm/mach-bcm47xx/bcm47xx.h |    4 +-
 4 files changed, 474 insertions(+), 345 deletions(-)

-- 
1.7.9.5
