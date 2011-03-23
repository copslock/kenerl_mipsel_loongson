Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 20:55:52 +0100 (CET)
Received: from mail.perches.com ([173.55.12.10]:4246 "EHLO mail.perches.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491880Ab1CWTzt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Mar 2011 20:55:49 +0100
Received: from Joe-Laptop.home (unknown [192.168.1.162])
        by mail.perches.com (Postfix) with ESMTP id 7776424368;
        Wed, 23 Mar 2011 11:55:29 -0800 (PST)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 0/2] Fix resource size miscalculations
Date:   Wed, 23 Mar 2011 12:55:35 -0700
Message-Id: <cover.1300909445.git.joe@perches.com>
X-Mailer: git-send-email 1.7.4.2.g597a6.dirty
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
Precedence: bulk
X-list: linux-mips

Use resource_size a few places

Joe Perches (2):
  trivial: treewide: Fix iomap resource size miscalculations
  trivial: arm: mach-u300/gpio: Fix mem_region resource size miscalculations

 arch/arm/mach-u300/gpio.c         |    7 +++----
 arch/arm/mach-ux500/mbox-db5500.c |    6 ++----
 arch/mips/rb532/gpio.c            |    2 +-
 drivers/video/msm/mddi.c          |    2 +-
 drivers/watchdog/bcm63xx_wdt.c    |    2 +-
 5 files changed, 8 insertions(+), 11 deletions(-)

-- 
1.7.4.2.g597a6.dirty
