Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 19:56:22 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:4346 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824790Ab3FRR4SYsxI6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Jun 2013 19:56:18 +0200
Received: from [10.9.208.57] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 18 Jun 2013 10:50:19 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Tue, 18 Jun 2013 10:56:04 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Tue, 18 Jun 2013 10:56:04 -0700
Received: from fainelli-desktop.broadcom.com (
 dhcp-lab-brsc-244.bri.broadcom.com [10.178.5.244]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 376F6F2D72; Tue, 18
 Jun 2013 10:56:03 -0700 (PDT)
From:   "Florian Fainelli" <florian@openwrt.org>
To:     ralf@linux-mips.org
cc:     linux-mips@linux-mips.org, cernekee@gmail.com, jogo@openwrt.org,
        "Florian Fainelli" <florian@openwrt.org>
Subject: [PATCH 0/7] MIPS: BCM63XX: add support for the BCM3368
Date:   Tue, 18 Jun 2013 18:55:37 +0100
Message-ID: <1371578144-12794-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.8.1.2
MIME-Version: 1.0
X-WSS-ID: 7DDE42511R033441012-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

This patchset adds support for the Broadcom BCM3368 Cable Modem SoC
which is very similar to the existing BCM63XX DSL SoCs. Support for
the Netgear CVG834G is also included. A bit of infrastructure rework
was required to get the board specifics to work.

Florian Fainelli (7):
  MIPS: BCM63XX: remove bogus Kconfig selects
  MIPS: BCM63XX: select BOOT_RAW
  MIPS: BCM63XX: add support for BCM3368 Cable Modem
  MIPS: BCM63XX: recognize Cable Modem firmware format
  MIPS: BCM63XX: provide a MAC address for BCM3368 chips
  MIPS: BCM63XX: let board specify an external GPIO to reset PHY
  MIPS: BCM63XX: add support for the Netgear CVG834G

 arch/mips/Kconfig                                  |  16 ++-
 arch/mips/bcm63xx/Kconfig                          |   9 +-
 arch/mips/bcm63xx/boards/board_bcm963xx.c          |  52 +++++++++-
 arch/mips/bcm63xx/clk.c                            |  18 ++--
 arch/mips/bcm63xx/cpu.c                            |  28 +++++-
 arch/mips/bcm63xx/dev-flash.c                      |   1 +
 arch/mips/bcm63xx/dev-spi.c                        |   6 +-
 arch/mips/bcm63xx/dev-uart.c                       |   3 +-
 arch/mips/bcm63xx/irq.c                            |  19 ++++
 arch/mips/bcm63xx/nvram.c                          |  10 ++
 arch/mips/bcm63xx/prom.c                           |   4 +-
 arch/mips/bcm63xx/reset.c                          |  29 +++++-
 arch/mips/bcm63xx/setup.c                          |   3 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h   | 110 +++++++++++++++++++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h  |   1 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h  |  45 ++++++++-
 .../mips/include/asm/mach-bcm63xx/board_bcm963xx.h |   6 ++
 arch/mips/include/asm/mach-bcm63xx/ioremap.h       |   4 +
 arch/mips/pci/pci-bcm63xx.c                        |   3 +-
 include/uapi/linux/Kbuild                          |   1 +
 include/uapi/linux/bcm933xx_hcs.h                  |  24 +++++
 21 files changed, 363 insertions(+), 29 deletions(-)
 create mode 100644 include/uapi/linux/bcm933xx_hcs.h

-- 
1.8.1.2
