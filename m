Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Aug 2013 10:42:15 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:55233 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816642Ab3H1IlxbPoEF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Aug 2013 10:41:53 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 9B7DF280240;
        Wed, 28 Aug 2013 10:41:17 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Wed, 28 Aug 2013 10:41:17 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 0/6] MIPS: ath79: clock fixes and improvements
Date:   Wed, 28 Aug 2013 10:41:41 +0200
Message-Id: <1377679307-429-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37697
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

Felix Fietkau (1):
  MIPS: ath79: fix ar933x watchdog clock

Gabor Juhos (5):
  MIPS: ath79: use local ref clock rate in ar934x_get_pll_freq
  MIPS: ath79: use a helper function to get system clock rates
  MIPS: ath79: use ath79_get_sys_clk_rate to get basic clock rates
  MIPS: ath79: use local variables for clock rates
  MIPS: ath79: switch to the clkdev framework

 arch/mips/Kconfig            |    1 +
 arch/mips/ath79/clock.c      |  258 ++++++++++++++++++++++++------------------
 arch/mips/ath79/common.h     |    2 +
 arch/mips/ath79/dev-common.c |   10 +-
 arch/mips/ath79/setup.c      |   23 +++-
 5 files changed, 173 insertions(+), 121 deletions(-)

--
1.7.10
