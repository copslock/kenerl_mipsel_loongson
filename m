Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Apr 2015 14:30:17 +0200 (CEST)
Received: from smtp1-g21.free.fr ([212.27.42.1]:55049 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007043AbbDSMaQjy4MU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 Apr 2015 14:30:16 +0200
Received: from localhost.localdomain (unknown [85.177.79.58])
        (Authenticated sender: albeu)
        by smtp1-g21.free.fr (Postfix) with ESMTPA id 6708F9400D4;
        Sun, 19 Apr 2015 14:27:55 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] MIPS: ath79: Various small fix to prepare OF support
Date:   Sun, 19 Apr 2015 14:29:59 +0200
Message-Id: <1429446604-15403-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

First re-run of this serie of misc fix and preparation for OF support on ATH79.

 * Dropped the bad PCI patch
 * Moved the patch to use the common clk API out of the OF support serie
   into this one.

Alban Bedel (5):
  MIPS: ath79: Enable ZBOOT support
  MIPS: ath79: Add a missing new line in log message
  MIPS: ath79: Correctly name the defines for the PLL_FB register
  MIPS: ath79: Improve the DDR controller interface
  MIPS: ath79: Use the common clk API

 arch/mips/Kconfig                              |   2 +
 arch/mips/ath79/clock.c                        |  35 +-----
 arch/mips/ath79/common.c                       |  35 +++++-
 arch/mips/ath79/common.h                       |   1 +
 arch/mips/ath79/irq.c                          | 147 ++++++-------------------
 arch/mips/ath79/setup.c                        |   5 +-
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |  12 +-
 arch/mips/include/asm/mach-ath79/ath79.h       |   3 +-
 arch/mips/pci/pci-ar71xx.c                     |  10 +-
 9 files changed, 85 insertions(+), 165 deletions(-)

-- 
2.0.0
