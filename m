Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Feb 2013 15:38:32 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:58566 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823126Ab3BOOibFFl8N (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Feb 2013 15:38:31 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 07Ar_s5T08rv; Fri, 15 Feb 2013 15:38:19 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id E9E4A2801AE;
        Fri, 15 Feb 2013 15:38:18 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 00/11] MIPS: ath79: add support for the QCA955X SoCs
Date:   Fri, 15 Feb 2013 15:38:14 +0100
Message-Id: <1360939105-23591-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
X-archive-position: 35753
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

This series adds support for the Qualcomm Atheros QCA955[68] SoCs
and for the AP136-010 reference board

The series depends on the following patch:
  MIPS: ath79: use dynamically allocated USB platform devices
  https://patchwork.linux-mips.org/patch/4933/

Gabor Juhos (11):
  MIPS: ath79: add early printk support for the QCA955X SoCs
  MIPS: ath79: add SoC detection code for the QCA955X SoCs
  MIPS: ath79: add clock setup code for the QCA955X SoCs
  MIPS: ath79: add IRQ handling code for the QCA955X SoCs
  MIPS: ath79: add GPIO setup code for the QCA955X SoCs
  MIPS: ath79: add QCA955X specific glue to ath79_device_reset_{set,clear}
  MIPS: ath79: register UART for the QCA955X SoCs
  MIPS: ath79: add WMAC registration code for the QCA955X SoCs
  MIPS: ath79: add PCI controller registration code for the QCA9558 SoC
  MIPS: ath79: add USB controller registration code for the QCA955X SoCs
  MIPS: ath79: add support for the Qualcomm Atheros AP136-010 board

 arch/mips/ath79/Kconfig                        |   20 ++-
 arch/mips/ath79/Makefile                       |    1 +
 arch/mips/ath79/clock.c                        |   78 ++++++++++++
 arch/mips/ath79/common.c                       |    4 +
 arch/mips/ath79/dev-common.c                   |    3 +-
 arch/mips/ath79/dev-usb.c                      |   15 +++
 arch/mips/ath79/dev-wmac.c                     |   20 +++
 arch/mips/ath79/early_printk.c                 |    2 +
 arch/mips/ath79/gpio.c                         |    4 +-
 arch/mips/ath79/irq.c                          |  110 +++++++++++++++--
 arch/mips/ath79/mach-ap136.c                   |  156 ++++++++++++++++++++++++
 arch/mips/ath79/machtypes.h                    |    1 +
 arch/mips/ath79/pci.c                          |   36 ++++++
 arch/mips/ath79/setup.c                        |   18 ++-
 arch/mips/configs/ath79_defconfig              |    1 +
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |   96 +++++++++++++++
 arch/mips/include/asm/mach-ath79/ath79.h       |   17 +++
 arch/mips/include/asm/mach-ath79/irq.h         |    6 +-
 18 files changed, 576 insertions(+), 12 deletions(-)
 create mode 100644 arch/mips/ath79/mach-ap136.c

--
1.7.10
