Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jul 2010 22:12:58 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:35824 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492718Ab0G0UMv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jul 2010 22:12:51 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 6CF6C85DC;
        Tue, 27 Jul 2010 22:12:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jmzCMVIZaSVK; Tue, 27 Jul 2010 22:12:51 +0200 (CEST)
Received: from localhost.localdomain (host-091-097-249-197.ewe-ip-backbone.de [91.97.249.197])
        by hauke-m.de (Postfix) with ESMTPSA id BB3E87E2C;
        Tue, 27 Jul 2010 22:12:50 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/4] MIPS: BCM47xx: Platfrom updates from OpenWRT
Date:   Tue, 27 Jul 2010 22:12:42 +0200
Message-Id: <1280261566-8247-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips

This series contains some patches for the Broadcom bcm47xx platform.
Most of these patches have been in OpenWRT for some time and they
should be stable. This work is intended for 2.6.36.

Hauke Mehrtens (4):
  MIPS: BCM47xx: Really fix 128MB RAM problem
  MIPS: BCM47xx: Fill values for b43 into ssb sprom
  MIPS: BCM47xx: Activate SSB_B43_PCI_BRIDGE by default
  MIPS: BCM47xx: Setup and register serial early

 arch/mips/Kconfig         |    1 +
 arch/mips/bcm47xx/prom.c  |   22 ++++--
 arch/mips/bcm47xx/setup.c |  168 ++++++++++++++++++++++++++++++++++++---------
 3 files changed, 149 insertions(+), 42 deletions(-)
