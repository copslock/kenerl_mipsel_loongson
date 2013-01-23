Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jan 2013 13:08:44 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:52008 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831954Ab3AWMIl1Ay7c (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Jan 2013 13:08:41 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [RFC 00/11] MIPS: ralink: adds support for ralink platform
Date:   Wed, 23 Jan 2013 13:05:44 +0100
Message-Id: <1358942755-25371-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 35506
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
Return-Path: <linux-mips-bounce@linux-mips.org>

This series adds support for the ralink SoC family. Currently RT305X type
SoC is supported. RT2880/3883 are in my local queue already but require
further testing.

John Crispin (11):
  MIPS: allow platforms to override cp0_compare_irq
  MIPS: ralink: adds include files
  MIPS: ralink: adds irq code
  MIPS: ralink: adds reset code
  MIPS: ralink: adds prom and cmdline code
  MIPS: ralink: adds clkdev code
  MIPS: ralink: adds OF code
  MIPS: ralink: adds early_printk support
  MIPS: ralink: adds support for RT305x SoC family
  MIPS: ralink: adds rt305x devicetree
  MIPS: ralink: adds Kbuild files

 arch/mips/Kbuild.platforms                      |    1 +
 arch/mips/Kconfig                               |   19 +-
 arch/mips/include/asm/mach-ralink/ralink_regs.h |   39 ++++
 arch/mips/include/asm/mach-ralink/rt305x.h      |  139 ++++++++++++++
 arch/mips/include/asm/mach-ralink/war.h         |   25 +++
 arch/mips/include/asm/time.h                    |    1 +
 arch/mips/kernel/traps.c                        |    7 +-
 arch/mips/ralink/Kconfig                        |   27 +++
 arch/mips/ralink/Makefile                       |   15 ++
 arch/mips/ralink/Platform                       |   11 ++
 arch/mips/ralink/clk.c                          |   72 +++++++
 arch/mips/ralink/common.h                       |   43 +++++
 arch/mips/ralink/dts/Makefile                   |    1 +
 arch/mips/ralink/dts/rt305x.dts                 |  156 +++++++++++++++
 arch/mips/ralink/early_printk.c                 |   43 +++++
 arch/mips/ralink/irq.c                          |  182 ++++++++++++++++++
 arch/mips/ralink/of.c                           |  105 +++++++++++
 arch/mips/ralink/prom.c                         |   69 +++++++
 arch/mips/ralink/reset.c                        |   44 +++++
 arch/mips/ralink/rt305x.c                       |  231 +++++++++++++++++++++++
 20 files changed, 1228 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-ralink/ralink_regs.h
 create mode 100644 arch/mips/include/asm/mach-ralink/rt305x.h
 create mode 100644 arch/mips/include/asm/mach-ralink/war.h
 create mode 100644 arch/mips/ralink/Kconfig
 create mode 100644 arch/mips/ralink/Makefile
 create mode 100644 arch/mips/ralink/Platform
 create mode 100644 arch/mips/ralink/clk.c
 create mode 100644 arch/mips/ralink/common.h
 create mode 100644 arch/mips/ralink/dts/Makefile
 create mode 100644 arch/mips/ralink/dts/rt305x.dts
 create mode 100644 arch/mips/ralink/early_printk.c
 create mode 100644 arch/mips/ralink/irq.c
 create mode 100644 arch/mips/ralink/of.c
 create mode 100644 arch/mips/ralink/prom.c
 create mode 100644 arch/mips/ralink/reset.c
 create mode 100644 arch/mips/ralink/rt305x.c

-- 
1.7.10.4
