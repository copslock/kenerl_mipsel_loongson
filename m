Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Nov 2014 05:33:13 +0100 (CET)
Received: from mail-pd0-f181.google.com ([209.85.192.181]:40921 "EHLO
        mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007442AbaK1EdLJYJsS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Nov 2014 05:33:11 +0100
Received: by mail-pd0-f181.google.com with SMTP id v10so622646pde.26
        for <multiple recipients>; Thu, 27 Nov 2014 20:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5NwbszxJZ/RYYsG+duFAUA1rjfkFCJlXLciHmRpO5mE=;
        b=gXHvV0N/V6KrA1/rwNWTGCseTc6rnuQkXvCmoogbGuHwkkAuPBXFIfcJBun54zD+J+
         vuEAQ1zBrZc9Yzhyw8dd4zZ+77q/DrQqLNELZ7oVfvQvWwu04zsxzSeLb36hhlU+HnB+
         8YJn/VKO10aYSWRuWVpeFnFGjElL74/DR4VVBpwOapMKSSY6/oqWjJ+nfgeci5fP0+17
         aBWlHUZobTAHGR+9DJCGJ3cMQeNbydcnd3hxAD1DwJgvetiKk5pILW94HsfIag8Dxeg1
         YArq0zD0rJ/xUFgij4IeaR6ilmDUSl4O4tHNB/XjtjNF6GnS4Cdbd1r1T151q3o+2Enw
         6AAA==
X-Received: by 10.69.0.138 with SMTP id ay10mr68071159pbd.110.1417149184796;
        Thu, 27 Nov 2014 20:33:04 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id u5sm8482887pdc.79.2014.11.27.20.33.02
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 27 Nov 2014 20:33:03 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 00/16] Generic BMIPS kernel
Date:   Thu, 27 Nov 2014 20:32:06 -0800
Message-Id: <1417149142-3756-1-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

This patch series REPLACES the following commits in Ralf's
mips-for-linux-next branch:

846deacebfe1 Documentation: DT: Add entries for BCM3384 and its peripherals
d666cd0246f7 MIPS: bcm3384: Initial commit of bcm3384 platform support
a2f6734c5f68 MAINTAINERS: Add entry for BCM33xx cable chips

(if you just want to drop the above commits and target this for 3.20+,
that's fine.)


V3->V4:

 - Rename "Multiplatform BMIPS kernel" to "Generic BMIPS kernel".

 - Split the "Generic BMIPS kernel" work into two separate commits: one
   for code and one for DTS.

 - Drop set_io_port_base stuff; this can be added later when PCI(e)
   support is done.

 - Document the boot interface (entry points, register contents).

 - Document the special FIXMAP requirement.

 - Create a mach-generic/war.h to reduce copy/paste.

 - Change "compatible" strings to distinguish bcm7120-style
   "IRQEN/IRQSTAT" controllers from bcm3380-style "free form"
   controllers.

 - Add DT nodes for brcmstb-reboot.c and brcmstb_gisb.c.

 - Rebase on Ralf's latest tree.


This series is based on mips-for-linux-next, minus the three 3384 patches
listed above, plus these non-MIPS patches:

http://patchwork.linux-mips.org/bundle/cernekee/bmips-multi-v4-deps/?state=%2a
http://marc.info/?l=linux-usb&m=141305106215886&w=2 (all 3/3)
http://marc.info/?l=linux-usb&m=141696309127730&w=2 (all 9/9)

I believe the irq-b*-l2.c patches are the only compile-time dependencies;
you may want to take 01-08 through the irqchip tree since they build on
top of other pending commits there.

My branch can be viewed here:

https://github.com/Broadcom/stblinux/commits/bmips-generic-v4


Brian Norris (1):
  irqchip: brcmstb-l2: don't clear wakeable interrupts at init time

Dmitry Torokhov (2):
  irqchip: brcmstb-l2: fix error handling of irq_of_parse_and_map
  irqchip: bcm7120-l2: fix error handling of irq_of_parse_and_map

Kevin Cernekee (13):
  irqchip: Update docs regarding irq_domain_add_tree()
  irqchip: bcm7120-l2: Refactor driver for arbitrary IRQEN/IRQSTAT
    offsets
  irqchip: bcm7120-l2: Split STB-specific logic into its own function
  irqchip: bcm7120-l2: Add support for BCM3380-style controllers
  irqchip: Add new driver for BCM7038-style level 1 interrupt
    controllers
  MIPS: Let __dt_register_buses accept a single bus type
  MIPS: Fall back to the generic restart notifier
  MIPS: Reorder MIPS_L1_CACHE_SHIFT priorities
  MIPS: Create a common <asm/mach-generic/war.h>
  MIPS: BMIPS: Flush the readahead cache after DMA
  MIPS: BMIPS: Document the firmware->kernel DTB interface
  MIPS: Add Generic BMIPS target
  MIPS: BMIPS: Add DTS files for several platforms

 Documentation/IRQ-domain.txt                       |   3 +-
 .../interrupt-controller/brcm,bcm3380-l2-intc.txt  |  41 +++
 .../interrupt-controller/brcm,bcm7038-l1-intc.txt  |  52 ++++
 .../interrupt-controller/brcm,bcm7120-l2-intc.txt  |  12 +-
 .../devicetree/bindings/mips/brcm/bmips.txt        |   8 +
 .../devicetree/bindings/mips/brcm/soc.txt          |  12 +
 Documentation/devicetree/booting-without-of.txt    |  28 ++
 arch/mips/Kbuild.platforms                         |   1 +
 arch/mips/Kconfig                                  |  41 ++-
 arch/mips/bmips/Kconfig                            |  50 +++
 arch/mips/bmips/Makefile                           |   1 +
 arch/mips/bmips/Platform                           |   7 +
 arch/mips/bmips/dma.c                              | 121 ++++++++
 arch/mips/bmips/irq.c                              |  38 +++
 arch/mips/bmips/setup.c                            | 191 ++++++++++++
 arch/mips/boot/dts/Makefile                        |   9 +
 arch/mips/boot/dts/bcm3384_viper.dtsi              | 108 +++++++
 arch/mips/boot/dts/bcm3384_zephyr.dtsi             | 126 ++++++++
 arch/mips/boot/dts/bcm6328.dtsi                    |  86 ++++++
 arch/mips/boot/dts/bcm6368.dtsi                    |  93 ++++++
 arch/mips/boot/dts/bcm7125.dtsi                    | 139 +++++++++
 arch/mips/boot/dts/bcm7346.dtsi                    | 224 ++++++++++++++
 arch/mips/boot/dts/bcm7360.dtsi                    | 161 ++++++++++
 arch/mips/boot/dts/bcm7420.dtsi                    | 184 +++++++++++
 arch/mips/boot/dts/bcm7425.dtsi                    | 225 ++++++++++++++
 arch/mips/boot/dts/bcm93384wvg.dts                 |  25 ++
 arch/mips/boot/dts/bcm93384wvg_viper.dts           |  25 ++
 arch/mips/boot/dts/bcm96368mvwg.dts                |  31 ++
 arch/mips/boot/dts/bcm97125cbmb.dts                |  31 ++
 arch/mips/boot/dts/bcm97346dbsmb.dts               |  58 ++++
 arch/mips/boot/dts/bcm97360svmb.dts                |  34 +++
 arch/mips/boot/dts/bcm97420c.dts                   |  45 +++
 arch/mips/boot/dts/bcm97425svmb.dts                |  60 ++++
 arch/mips/boot/dts/bcm9ejtagprb.dts                |  22 ++
 arch/mips/configs/bmips_be_defconfig               |  88 ++++++
 arch/mips/configs/bmips_stb_defconfig              |  88 ++++++
 arch/mips/include/asm/mach-ar7/war.h               |  24 --
 arch/mips/include/asm/mach-ath25/war.h             |  25 --
 arch/mips/include/asm/mach-ath79/war.h             |  24 --
 arch/mips/include/asm/mach-au1x00/war.h            |  24 --
 arch/mips/include/asm/mach-bcm47xx/war.h           |  24 --
 arch/mips/include/asm/mach-bcm63xx/war.h           |  24 --
 arch/mips/include/asm/mach-bmips/dma-coherence.h   |  48 +++
 arch/mips/include/asm/mach-bmips/spaces.h          |  18 ++
 arch/mips/include/asm/mach-cavium-octeon/war.h     |  25 --
 arch/mips/include/asm/mach-cobalt/war.h            |  24 --
 arch/mips/include/asm/mach-dec/war.h               |  24 --
 arch/mips/include/asm/mach-emma2rh/war.h           |  24 --
 arch/mips/include/asm/mach-generic/war.h           |  24 ++
 arch/mips/include/asm/mach-jazz/war.h              |  24 --
 arch/mips/include/asm/mach-jz4740/war.h            |  24 --
 arch/mips/include/asm/mach-lantiq/war.h            |  23 --
 arch/mips/include/asm/mach-lasat/war.h             |  24 --
 arch/mips/include/asm/mach-loongson/war.h          |  24 --
 arch/mips/include/asm/mach-loongson1/war.h         |  24 --
 arch/mips/include/asm/mach-netlogic/war.h          |  25 --
 arch/mips/include/asm/mach-paravirt/war.h          |  25 --
 arch/mips/include/asm/mach-pnx833x/war.h           |  24 --
 arch/mips/include/asm/mach-ralink/war.h            |  24 --
 arch/mips/include/asm/mach-tx39xx/war.h            |  24 --
 arch/mips/include/asm/mach-vr41xx/war.h            |  24 --
 arch/mips/kernel/prom.c                            |   5 +-
 arch/mips/kernel/reset.c                           |   2 +
 arch/mips/mm/dma-default.c                         |  13 +
 drivers/irqchip/Kconfig                            |   5 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-bcm7038-l1.c                   | 335 +++++++++++++++++++++
 drivers/irqchip/irq-bcm7120-l2.c                   | 197 ++++++++----
 drivers/irqchip/irq-brcmstb-l2.c                   |  13 +-
 69 files changed, 3048 insertions(+), 612 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm3380-l2-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
 create mode 100644 Documentation/devicetree/bindings/mips/brcm/bmips.txt
 create mode 100644 Documentation/devicetree/bindings/mips/brcm/soc.txt
 create mode 100644 arch/mips/bmips/Kconfig
 create mode 100644 arch/mips/bmips/Makefile
 create mode 100644 arch/mips/bmips/Platform
 create mode 100644 arch/mips/bmips/dma.c
 create mode 100644 arch/mips/bmips/irq.c
 create mode 100644 arch/mips/bmips/setup.c
 create mode 100644 arch/mips/boot/dts/bcm3384_viper.dtsi
 create mode 100644 arch/mips/boot/dts/bcm3384_zephyr.dtsi
 create mode 100644 arch/mips/boot/dts/bcm6328.dtsi
 create mode 100644 arch/mips/boot/dts/bcm6368.dtsi
 create mode 100644 arch/mips/boot/dts/bcm7125.dtsi
 create mode 100644 arch/mips/boot/dts/bcm7346.dtsi
 create mode 100644 arch/mips/boot/dts/bcm7360.dtsi
 create mode 100644 arch/mips/boot/dts/bcm7420.dtsi
 create mode 100644 arch/mips/boot/dts/bcm7425.dtsi
 create mode 100644 arch/mips/boot/dts/bcm93384wvg.dts
 create mode 100644 arch/mips/boot/dts/bcm93384wvg_viper.dts
 create mode 100644 arch/mips/boot/dts/bcm96368mvwg.dts
 create mode 100644 arch/mips/boot/dts/bcm97125cbmb.dts
 create mode 100644 arch/mips/boot/dts/bcm97346dbsmb.dts
 create mode 100644 arch/mips/boot/dts/bcm97360svmb.dts
 create mode 100644 arch/mips/boot/dts/bcm97420c.dts
 create mode 100644 arch/mips/boot/dts/bcm97425svmb.dts
 create mode 100644 arch/mips/boot/dts/bcm9ejtagprb.dts
 create mode 100644 arch/mips/configs/bmips_be_defconfig
 create mode 100644 arch/mips/configs/bmips_stb_defconfig
 delete mode 100644 arch/mips/include/asm/mach-ar7/war.h
 delete mode 100644 arch/mips/include/asm/mach-ath25/war.h
 delete mode 100644 arch/mips/include/asm/mach-ath79/war.h
 delete mode 100644 arch/mips/include/asm/mach-au1x00/war.h
 delete mode 100644 arch/mips/include/asm/mach-bcm47xx/war.h
 delete mode 100644 arch/mips/include/asm/mach-bcm63xx/war.h
 create mode 100644 arch/mips/include/asm/mach-bmips/dma-coherence.h
 create mode 100644 arch/mips/include/asm/mach-bmips/spaces.h
 delete mode 100644 arch/mips/include/asm/mach-cavium-octeon/war.h
 delete mode 100644 arch/mips/include/asm/mach-cobalt/war.h
 delete mode 100644 arch/mips/include/asm/mach-dec/war.h
 delete mode 100644 arch/mips/include/asm/mach-emma2rh/war.h
 create mode 100644 arch/mips/include/asm/mach-generic/war.h
 delete mode 100644 arch/mips/include/asm/mach-jazz/war.h
 delete mode 100644 arch/mips/include/asm/mach-jz4740/war.h
 delete mode 100644 arch/mips/include/asm/mach-lantiq/war.h
 delete mode 100644 arch/mips/include/asm/mach-lasat/war.h
 delete mode 100644 arch/mips/include/asm/mach-loongson/war.h
 delete mode 100644 arch/mips/include/asm/mach-loongson1/war.h
 delete mode 100644 arch/mips/include/asm/mach-netlogic/war.h
 delete mode 100644 arch/mips/include/asm/mach-paravirt/war.h
 delete mode 100644 arch/mips/include/asm/mach-pnx833x/war.h
 delete mode 100644 arch/mips/include/asm/mach-ralink/war.h
 delete mode 100644 arch/mips/include/asm/mach-tx39xx/war.h
 delete mode 100644 arch/mips/include/asm/mach-vr41xx/war.h
 create mode 100644 drivers/irqchip/irq-bcm7038-l1.c

-- 
2.1.0
