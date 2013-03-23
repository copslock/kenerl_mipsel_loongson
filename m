Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Mar 2013 14:07:54 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:54699 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823005Ab3CWNHxdMM8H (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Mar 2013 14:07:53 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t488r6iu0bs1; Sat, 23 Mar 2013 14:07:19 +0100 (CET)
Received: from shaker64.lan (dslb-088-073-029-203.pools.arcor-ip.net [88.73.29.203])
        by arrakis.dune.hu (Postfix) with ESMTPSA id CB6B1280129;
        Sat, 23 Mar 2013 14:07:18 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mtd@lists.infradead.org
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org
Subject: [PATCH 0/3] fix NVRAM partition size if larger than expected
Date:   Sat, 23 Mar 2013 14:07:46 +0100
Message-Id: <1364044070-10486-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 35945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Some device vendors use a larger nvram size than expected. While Broadcom
has defined it as 64K max, devices with 128K have been seen in the wild.
Luckily they properly set the nvram's PSI size to the correct value, so
we can use that to size the nvram partion.

Yes it's a bit confusing as there are two nvrams, one with a fixed layout
with in the bootloader, with the size information about the other.

Since 2 of 3 patches are for the mtd tree, this patchset should go there
(but it applies to both l2-mtd and mips-next fine).

Jonas Gorski (3):
  MTD: bcm63xxpart: use size macro for CFE block size
  MIPS: BCM63XX: export PSI size from nvram
  MTD: bcm63xxpart: use nvram for PSI size

 arch/mips/bcm63xx/nvram.c                          |   11 +++++++++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h |    2 ++
 drivers/mtd/bcm63xxpart.c                          |    9 ++++++---
 3 files changed, 19 insertions(+), 3 deletions(-)

-- 
1.7.10.4
