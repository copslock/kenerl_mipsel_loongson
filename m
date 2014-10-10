Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 09:49:56 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:46026
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27011042AbaJJHtybJ672 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Oct 2014 09:49:54 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 0/4] add mt7620n and mt7628an support
Date:   Fri, 10 Oct 2014 09:49:44 +0200
Message-Id: <1412927388-60721-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

MT7620n is the small version of MT7620a with a smaller package and a few
peripherals missing. MT7628an is the new low cost version of the MT7620.

Also fix early_printk so that it allows more SoCs. MT7628an has a different irq
register layout. Make the driver load the register map from DT.


John Crispin (4):
  MIPS: ralink: cleanup early_printk
  MIPS: ralink: allow loading irq registers from the devicetree
  MIPS: ralink: add support for MT7620n
  MIPS: ralink: add mt7628an support

 arch/mips/include/asm/mach-ralink/mt7620.h |   18 +-
 arch/mips/ralink/Kconfig                   |    2 +-
 arch/mips/ralink/early_printk.c            |   45 +++--
 arch/mips/ralink/irq.c                     |   34 +++-
 arch/mips/ralink/mt7620.c                  |  282 +++++++++++++++++++++++-----
 5 files changed, 305 insertions(+), 76 deletions(-)

-- 
1.7.10.4
