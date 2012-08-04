Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Aug 2012 18:01:50 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:42792 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903387Ab2HDQBo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 4 Aug 2012 18:01:44 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 42FA423C005D;
        Sat,  4 Aug 2012 18:01:42 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v3 0/4] MIPS: ath79: various fixes
Date:   Sat,  4 Aug 2012 18:01:23 +0200
Message-Id: <1344096087-25044-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
X-archive-position: 34053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

This set contains four fixes for the ath79 platform, and it is
based on v3.6-rc1.

v3:
  - rebase against v3.6-rc1
  - add two more patches


Gabor Juhos (4):
  MIPS: ath79: fix number of GPIO lines for AR724[12]
  MIPS: ath79: use correct IRQ number for the OHCI controller on AR7240
  MIPS: ath79: select HAVE_CLK
  MIPS: ath79: don't override CPU ASE features

 arch/mips/Kconfig                                        |    1 +
 arch/mips/ath79/dev-usb.c                                |    2 ++
 arch/mips/ath79/gpio.c                                   |    6 ++++--
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h           |    3 ++-
 arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h |    8 --------
 5 files changed, 9 insertions(+), 11 deletions(-)

--
1.7.10
