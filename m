Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Aug 2012 18:04:12 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:34707 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903468Ab2HDQEG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 4 Aug 2012 18:04:06 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 9193A23C0096;
        Sat,  4 Aug 2012 18:04:04 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v3 0/3] MIPS: ath79: allow to use USB on AR934x
Date:   Sat,  4 Aug 2012 18:03:54 +0200
Message-Id: <1344096237-25221-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
X-archive-position: 34058
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

This patch-set adds AR934x specific glue into the USB
platform device registration code. Additionally, it
registers the USB host controller device on the
DB120 board.

This depends on the following patch set:
v3 of 'MIPS: ath79: various fixes'

v3:
 - rebase aginas v3.6-rc1
 - fix AR934X_EHCI_SIZE

Gabor Juhos (3):
  MIPS: ath79: use a helper function for USB resource initialization
  MIPS: ath79: add USB platform setup code for AR934X
  MIPS: ath79: register USB host controller on the DB120 board

 arch/mips/ath79/dev-usb.c                      |   92 ++++++++++++++----------
 arch/mips/ath79/mach-db120.c                   |    2 +
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    7 ++
 3 files changed, 65 insertions(+), 36 deletions(-)

--
1.7.10
