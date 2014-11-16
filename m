Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Nov 2014 01:19:29 +0100 (CET)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:62521 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013700AbaKPATYm1VUz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Nov 2014 01:19:24 +0100
Received: by mail-pa0-f50.google.com with SMTP id eu11so19680479pac.23
        for <multiple recipients>; Sat, 15 Nov 2014 16:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ggyDx0G0lkGvyhQYWRMhjNypCqBB2vKrwAxD9yHJuiE=;
        b=OyzYlIqj4W/JgrjEzRe7reYzTWDFI9o0UjzkzS7c3G5WHgLEGIPTWXlod94Q/bYWus
         dKyAkzN+Kod2LdWs4nJoAs2csMd6gKKesKInioD0ml0wc9J8CGDU+h2uNdUku8CyyQnR
         BCOGZ9/e+VLsB1hQW1h6oT+1k2stbMFT3T5Kj0WEqwuxLYTJD4J4KCATg5u8pW4gr5BI
         YbWCfmbtYoGGePOORZ8SPKq2e8eRvaq+UFy+oyH7iHnZeRST2hklm+8pn2pfARrg8Ycc
         Wa5Slz5j0WrEN102YcksIxYmr03VksNATP258wZViVpVaXx2nxf46mIdgSOhkgD7ue+x
         55Lg==
X-Received: by 10.68.204.8 with SMTP id ku8mr19665114pbc.103.1416097158597;
        Sat, 15 Nov 2014 16:19:18 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id xn4sm11099440pab.9.2014.11.15.16.19.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Nov 2014 16:19:17 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 00/22] Multiplatform BMIPS kernel
Date:   Sat, 15 Nov 2014 16:17:24 -0800
Message-Id: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44191
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

This patch series implements a multiplatform target that runs on a
variety of different Broadcom chipsets based on the BMIPS CPUs.  It
evolved out of the "BMIPS updates and BCM3384 platform support"
RFC posted earlier.

V1->V2:

 - Add several more DTS files so the same kernel can boot on multiple
   chips: BCM6328, BCM6368, BCM7125, BCM7346, BCM7360, BCM7420, BCM7425,
   and as a very special bonus, the BCM3384 Viper CPU.

 - Add irq-bcm7038-l1.c to support the BCM7xxx chipsets.

 - Rename target from "bcm3384" to "bmips".

 - Change L1_CACHE_SHIFT fix so it works correctly when multiple BMIPS
   CPU types are selected.

 - Drop dependency on rejected EARLYCON_FORCE changes.

 - Delete most of my new irq.c, in favor of using the refactored
   irq-bcm7120-l2.c.

 - Add flush for BMIPS3300/BMIPS43xx readahead caches, to avoid
   non-coherency after DMA_FROM_DEVICE operations.

 - Utilize the new MIPS IRQ APIs from mips-for-linux-next.

 - Tweak docs/copyrights/maintainership.


This series is based on 3.18-rc4, plus:

http://patchwork.linux-mips.org/bundle/cernekee/bmips-multi-v2-deps/?state=*
http://marc.info/?l=linux-usb&m=141305106215886&w=2 (all 3/3)

These are all queued for tty-next / irqchip-next / usb-next.  Notably,
the proposed serial/pxa/ttyBCM coexistence changes are not required at
this time.


A couple of sample boot logs are posted here:

https://gist.github.com/cernekee/e53a6ff05292c3a78a94


checkpatch status:

The checkpatch warnings fall into two categories:

 - Undocumented DT bindings.  These SoCs use mostly-standard-looking
   peripherals (OHCI/EHCI controllers, ethernet PHYs), but it may be
   necessary to add extra code in the future to compensate for
   hardware quirks.  So the compatible string in the DTS file lists
   both the generic device name (documented) and a more specific
   identifier for the hardware present on the chip (undocumented).

 - extern declarations for the __dtb_* symbols.


Known issues:

If the lockdep checks are enabled, I see a weird IRQ state mismatch
returning from e.g. sys_execve().  CP0 STATUS shows IE disabled, but
current->hardirqs_enabled == 1.  Not sure if this is a problem with
my new code or something more general.  It only shows up on
SMP && !PREEMPT builds.

Booting a HIGHMEM MIPS kernel on a system with cache aliases may fail
if the system has >256MB of memory.  AFAICT this is a general problem
with the fallback logic in arch/mips/mm/init.c.

Many of the BCM63xx bootloaders impose severe restrictions on the kernel
size.  This tends to cause a lot of trouble booting images that include
an initramfs (because we're still missing MTD support).  One workaround
is to set CONFIG_PHYSICAL_START to a higher value, like 0x8100_0000.


Future work:

Many BCM7xxx boards can be freely switched between big endian and little
endian modes, with the latter being the default.  It would be nice if we
could use identical DTS files for both configurations, since the LE/BE
setting mostly doesn't affect how the peripherals work.  But currently a
few assumptions are hardcoded in there ("big-endian" USB register
properties and a hack to get the 16550 register addresses correct).  I
submitted a patch to the DT/serial lists which adds a "native-endian"
property; if this is accepted and utilized by the drivers in question, it
will go a long way toward solving this problem.

Lots of peripherals are still missing, especially flash and bcm63xx_enet.
The lack of a reboot handler is annoying; syscon-reboot probably won't work
on STB (because it requires two writes).  Some peripherals, like USB on
certain boards, need more work (possibly PHY drivers) and were left
disabled.

There are ways to retrieve other information from the legacy non-DT
bootloaders, but they're pretty hacky.  The flash configuration is among
the worst of the bunch, because these chips can have up to 4 different
flash controllers, more than one can be active at a time, and the
bootloader just passes "hints" rather than explicit partition maps.  For
specific boards it is sometimes OK to hardcode the map into the DTS file,
although most of the supported boards are user-reconfigurable and the
flash layouts may change from one bootloader version to the next.

There is currently no way to distinguish between different bcm63xx
board types (i.e. we can only identify the SoC, not the board).  There
is a way to distinguish different bcm7xxx board types, although in
practice the data source is somewhat unreliable and doesn't always convey
all of the information needed to distinguish boards with different
capabilities.

The kernel makes a few assumptions about how the bootloader has set up
Broadcom-specific registers for e.g. USB.  If/when power management
features are added, these registers will revert to their default settings
on resume, and somehow need to be set up again by Linux.

irq-bcm7120-l2.c is getting a little bloated and I'm not entirely happy
with the latest round of changes.  In particular it would be really nice
if the probe function could use the devm_ APIs and not have to worry
about so many error paths.  And I'm not sure if the generic-chip helpers
are making the code any simpler.


Dmitry Torokhov (2):
  irqchip: brcmstb-l2: fix error handling of irq_of_parse_and_map
  irqchip: bcm7120-l2: fix error handling of irq_of_parse_and_map

Jon Fraser (2):
  MIPS: BMIPS: Allow BMIPS3300 to utilize SMP ebase relocation code
  MIPS: BMIPS: Mask off timer IRQs when hot-unplugging a CPU

Kevin Cernekee (18):
  irqchip: Update docs regarding irq_domain_add_tree()
  irqchip: bcm7120-l2: Refactor driver for arbitrary IRQEN/IRQSTAT
    offsets
  irqchip: bcm7120-l2: Change DT binding to allow non-contiguous
    IRQEN/IRQSTAT
  irqchip: Add new driver for BCM7038-style level 1 interrupt
    controllers
  MIPS: BMIPS: Fix ".previous without corresponding .section" warnings
  MIPS: BMIPS: Align secondary boot sequence with latest firmware
    releases
  MIPS: BMIPS: Introduce helper function to change the reset vector
  MIPS: BMIPS: Explicitly configure reset vectors prior to secondary
    boot
  MIPS: Allow MIPS_CPU_SCACHE to be used with different line sizes
  MIPS: BMIPS: Fix L1_CACHE_SHIFT when BMIPS5000 is selected
  MIPS: BMIPS: Let each platform customize the CPU1 IRQ mask
  MIPS: BMIPS: Add special cache handling in c-r4k.c
  MIPS: BMIPS: Add PRId for BMIPS5200 (Whirlwind)
  MIPS: Create a helper function for DT setup
  Documentation: DT: Add "mti" vendor prefix
  MAINTAINERS: Add entry for bcm63xx/bcm33xx UDC gadget driver
  MAINTAINERS: Add entry for BMIPS multiplatform kernel
  MIPS: Add multiplatform BMIPS target

 Documentation/IRQ-domain.txt                       |   3 +-
 .../interrupt-controller/brcm,bcm7038-l1-intc.txt  |  52 ++++
 .../interrupt-controller/brcm,bcm7120-l2-intc.txt  |   5 +-
 .../devicetree/bindings/mips/brcm/bmips.txt        |   8 +
 .../devicetree/bindings/mips/brcm/soc.txt          |  21 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |  18 ++
 arch/mips/Kbuild.platforms                         |   1 +
 arch/mips/Kconfig                                  |  40 ++-
 arch/mips/bmips/Makefile                           |   1 +
 arch/mips/bmips/Platform                           |   7 +
 arch/mips/bmips/dma.c                              | 109 +++++++
 arch/mips/bmips/irq.c                              |  38 +++
 arch/mips/bmips/setup.c                            | 249 +++++++++++++++
 arch/mips/boot/dts/Makefile                        |   9 +
 arch/mips/boot/dts/bcm3384_common.dtsi             |  44 +++
 arch/mips/boot/dts/bcm3384_viper.dtsi              |  63 ++++
 arch/mips/boot/dts/bcm3384_zephyr.dtsi             |  82 +++++
 arch/mips/boot/dts/bcm6328.dtsi                    |  63 ++++
 arch/mips/boot/dts/bcm6368.dtsi                    |  89 ++++++
 arch/mips/boot/dts/bcm7125.dtsi                    |  99 ++++++
 arch/mips/boot/dts/bcm7346.dtsi                    | 174 +++++++++++
 arch/mips/boot/dts/bcm7360.dtsi                    | 121 ++++++++
 arch/mips/boot/dts/bcm7420.dtsi                    | 142 +++++++++
 arch/mips/boot/dts/bcm7425.dtsi                    | 174 +++++++++++
 arch/mips/boot/dts/bcm93384wvg.dts                 |  25 ++
 arch/mips/boot/dts/bcm93384wvg_viper.dts           |  25 ++
 arch/mips/boot/dts/bcm96368mvwg.dts                |  31 ++
 arch/mips/boot/dts/bcm97125cbmb.dts                |  31 ++
 arch/mips/boot/dts/bcm97346dbsmb.dts               |  58 ++++
 arch/mips/boot/dts/bcm97360svmb.dts                |  34 +++
 arch/mips/boot/dts/bcm97420c.dts                   |  44 +++
 arch/mips/boot/dts/bcm97425svmb.dts                |  59 ++++
 arch/mips/boot/dts/bcm9ejtagprb.dts                |  22 ++
 arch/mips/configs/bmips_be_defconfig               |  83 +++++
 arch/mips/configs/bmips_stb_defconfig              |  83 +++++
 arch/mips/include/asm/bmips.h                      |   1 +
 arch/mips/include/asm/cpu.h                        |   1 +
 arch/mips/include/asm/mach-bmips/dma-coherence.h   |  45 +++
 arch/mips/include/asm/mach-bmips/spaces.h          |  17 ++
 arch/mips/include/asm/mach-bmips/war.h             |  24 ++
 arch/mips/include/asm/prom.h                       |   1 +
 arch/mips/kernel/bmips_vec.S                       |   3 -
 arch/mips/kernel/cpu-probe.c                       |   1 +
 arch/mips/kernel/prom.c                            |  18 ++
 arch/mips/kernel/smp-bmips.c                       | 114 ++++---
 arch/mips/lantiq/prom.c                            |  11 +-
 arch/mips/mm/c-r4k.c                               |  43 +++
 arch/mips/ralink/of.c                              |  14 +-
 drivers/irqchip/Kconfig                            |   5 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-bcm7038-l1.c                   | 335 +++++++++++++++++++++
 drivers/irqchip/irq-bcm7120-l2.c                   | 105 +++++--
 drivers/irqchip/irq-brcmstb-l2.c                   |   4 +-
 54 files changed, 2755 insertions(+), 96 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
 create mode 100644 Documentation/devicetree/bindings/mips/brcm/bmips.txt
 create mode 100644 Documentation/devicetree/bindings/mips/brcm/soc.txt
 create mode 100644 arch/mips/bmips/Makefile
 create mode 100644 arch/mips/bmips/Platform
 create mode 100644 arch/mips/bmips/dma.c
 create mode 100644 arch/mips/bmips/irq.c
 create mode 100644 arch/mips/bmips/setup.c
 create mode 100644 arch/mips/boot/dts/bcm3384_common.dtsi
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
 create mode 100644 arch/mips/include/asm/mach-bmips/dma-coherence.h
 create mode 100644 arch/mips/include/asm/mach-bmips/spaces.h
 create mode 100644 arch/mips/include/asm/mach-bmips/war.h
 create mode 100644 drivers/irqchip/irq-bcm7038-l1.c

-- 
2.1.1
