Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2012 10:24:42 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:54586 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903616Ab2FLIYe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jun 2012 10:24:34 +0200
Received: by bkwj4 with SMTP id j4so5334449bkw.36
        for <multiple recipients>; Tue, 12 Jun 2012 01:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=WyRcAx28Hn24N1KAG0Ne6zk9GJALZB3eYj8ac0bOmq8=;
        b=kwPqZEuV/JIO7QbQYqcMoCmGjqiJGEQuVnEvNHsLBfh9b/QffMgSqA49Fk+i3FxLkd
         ElTEoNdfl8UHp01dPQyCTNHf79YWiobun9h8yorMc0yw1NKuzOebSR6Qk3SF/dtSoOPS
         u9rZW0LIANeKOazGNFS8SnPxr9IXb1ehhiKIBMptcC5tMFIAj/X8VDhl+fjBUR53m9J3
         v2qbyg32noKhcO/H39eACNmWhWhpkiAfKi5zHfH0qkm3WuxSMIBJjvjIGlSxOidBiS4o
         46AwkOf21UodQy3XDptHcVZaZUt8SaFnoCW7YSfb4WcZ/a+XY3Zqtafrr8VSbAJHi9yu
         aY9Q==
Received: by 10.204.157.23 with SMTP id z23mr11608226bkw.71.1339489469446;
        Tue, 12 Jun 2012 01:24:29 -0700 (PDT)
Received: from shaker64.lan (dslb-088-073-055-195.pools.arcor-ip.net. [88.73.55.195])
        by mx.google.com with ESMTPS id h18sm19177912bkh.8.2012.06.12.01.24.27
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jun 2012 01:24:28 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 0/8] Add basic support for BCM6328
Date:   Tue, 12 Jun 2012 10:23:37 +0200
Message-Id: <1339489425-19037-1-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 33610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

This patchset adds basic support for BCM6328 and its PCIe port.

The BCM6328 is an ADSL2+ SoC with support for NAND and SPI flash,
integrated five port ethernet switch, and one PCIe port.

Patches 1 and 2 add generic flash type detection, as different chips
support different flash types, and the BCM6328 does not support
parallel CFI flashes.

Patches 3-4 add support for detecting and handling the BCM6328 itself.
This allows booting to command line.

Patches 5-7 add support for the PCIe port of the BCM6328 and expose
the PCIe port driver for MIPS (I wonder what is so special about it
that it isn't included in the standard PCI drivers).

Patch 8 then adds a 6328 reference board definition, so one can actually
boot to command line.

Jonas Gorski (8):
  MIPS: BCM63XX: move flash registration out of board_bcm963xx.c
  MIPS: BCM63XX: add flash type detection
  MIPS: BCM63XX: use the Chip ID register for identifying the SoC
  MIPS: BCM63XX: add basic BCM6328 CPU support
  MIPS: BCM63XX: Move the PCI initialization into its own function
  MIPS: BCM63XX: Add PCIe Support for BCM6328
  MIPS: expose PCIe drivers for MIPS
  MIPS: BCM63XX: add 96328avng reference board

 arch/mips/Kconfig                                  |    2 +
 arch/mips/bcm63xx/Kconfig                          |    4 +
 arch/mips/bcm63xx/Makefile                         |    4 +-
 arch/mips/bcm63xx/boards/board_bcm963xx.c          |  106 ++++++++--------
 arch/mips/bcm63xx/cpu.c                            |   63 ++++++++--
 arch/mips/bcm63xx/dev-flash.c                      |  123 ++++++++++++++++++
 arch/mips/bcm63xx/dev-spi.c                        |    2 +-
 arch/mips/bcm63xx/irq.c                            |   21 +++
 arch/mips/bcm63xx/prom.c                           |    4 +-
 arch/mips/bcm63xx/setup.c                          |   13 ++-
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h   |  120 +++++++++++++++++-
 .../include/asm/mach-bcm63xx/bcm63xx_dev_flash.h   |   12 ++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h  |    2 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h    |    8 ++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h  |  117 +++++++++++++++++
 arch/mips/include/asm/mach-bcm63xx/ioremap.h       |    1 +
 arch/mips/pci/ops-bcm63xx.c                        |   61 +++++++++
 arch/mips/pci/pci-bcm63xx.c                        |  133 +++++++++++++++++++-
 arch/mips/pci/pci-bcm63xx.h                        |    5 +
 19 files changed, 729 insertions(+), 72 deletions(-)
 create mode 100644 arch/mips/bcm63xx/dev-flash.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_flash.h

-- 
1.7.2.5
