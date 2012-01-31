Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 15:09:27 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:60356 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904018Ab2AaOIc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2012 15:08:32 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id C6A233530EB;
        Tue, 31 Jan 2012 15:08:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XcHQn37hyoQ2; Tue, 31 Jan 2012 15:08:31 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 565AD3101FA;
        Tue, 31 Jan 2012 15:08:31 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 0/2] MIPS: BCM63XX: misc cleanup
Date:   Tue, 31 Jan 2012 15:08:06 +0100
Message-Id: <1328018888-5533-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
X-archive-position: 32347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This patch set contains some small cleanups. This is the preliminary serie
of other changes.

Florian Fainelli (2):
  MIPS: BCM63XX: fix platform_devices id
  MIPS: BCM63XX: be consistent in clock bits enable naming

 arch/mips/bcm63xx/clk.c                           |    6 ++--
 arch/mips/bcm63xx/dev-dsp.c                       |    2 +-
 arch/mips/bcm63xx/dev-wdt.c                       |    2 +-
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |   36 ++++++++++----------
 4 files changed, 23 insertions(+), 23 deletions(-)

-- 
1.7.5.4
