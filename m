Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 06:28:43 +0200 (CEST)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:51821 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011198AbaJUE2lymPY4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 06:28:41 +0200
Received: by mail-pa0-f53.google.com with SMTP id kq14so505949pab.40
        for <multiple recipients>; Mon, 20 Oct 2014 21:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nGyw+jKLN+4lwInJ1q8hWyYuztMkfjUuZILCxd40IU8=;
        b=WdXO6lx2WfUunHPSoyYZWz++QpkazObMEAaOZbdGjyChiU4ED/tr59d0J3ogS5y+Vb
         YnyQmfuMhNnykOpXl5lWA9R3ZGUGGGZxf+46ZHpUPBFnbEDadvlhD+/5ZozoYCTi3nuk
         csMtOa4ZUZs6AluoK0FtwAe92oiUKnYspJD1iShNFusaspJ/DAEDEqy2nqK2EDyjIlyY
         y5SP1RzKyUp7YE3aRBEONTmRPql5AOLVDDbaDNxWxNaEjH2NM8GZzHSBrWYZS7bhDws4
         bMcrChstxBs4D4217G7WzmNQ2wB9582PKbdldIDGDiLAkECFd/CGpMzIff1iTAHElcQb
         eYSg==
X-Received: by 10.70.46.137 with SMTP id v9mr32599300pdm.78.1413865715404;
        Mon, 20 Oct 2014 21:28:35 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id b2sm10498181pbu.42.2014.10.20.21.28.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 21:28:34 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        jfraser@broadcom.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Subject: [PATCH/RFC 00/17] MIPS: BMIPS updates and BCM3384 platform support
Date:   Mon, 20 Oct 2014 21:27:50 -0700
Message-Id: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43398
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

This patch series adds support for the Linux BMIPS5000 application
processor on BCM3384, a cable modem chipset.  It incorporates the
latest bugfixes and workarounds available for the BMIPS SMP and cache
maintenance code.

The bootloader code[1] passes a device tree blob describing the
memory setup, bootargs, peripheral configuration, clocks, etc.  For
this reason, very little needs to be hardcoded in the kernel.

Dependencies:

 - bcm63xx_uart and of-serial changes, under review on the linux-serial
   list

 - OHCI changes, pending inclusion on usb.git -next

[1] https://github.com/broadcom/aeolus


Jon Fraser (2):
  MIPS: BMIPS: Allow BMIPS3300 to utilize SMP ebase relocation code
  MIPS: BMIPS: Mask off timer IRQs when hot-unplugging a CPU

Kevin Cernekee (15):
  MIPS: BMIPS: Fix ".previous without corresponding .section" warnings
  MIPS: BMIPS: Align secondary boot sequence with latest firmware
    releases
  MIPS: BMIPS: Introduce helper function to change the reset vector
  MIPS: BMIPS: Explicitly configure reset vectors prior to secondary
    boot
  MIPS: Allow MIPS_CPU_SCACHE to be used with different line sizes
  MIPS: BMIPS: Select the appropriate L1_CACHE_SHIFT for 438x and 5000
    CPUs
  MIPS: BMIPS: Let each platform customize the CPU1 IRQ mask
  MIPS: BMIPS: Add special cache handling in c-r4k.c
  MIPS: BMIPS: Add PRId for BMIPS5200 (Whirlwind)
  MIPS: Create a helper function for DT setup
  Documentation: DT: Add entries for BCM3384 and its peripherals
  Documentation: DT: Add "mti" vendor prefix
  MIPS: bcm3384: Initial commit of bcm3384 platform support
  MAINTAINERS: Add entry for BCM33xx cable chips
  MAINTAINERS: Add entry for bcm63xx/bcm33xx UDC gadget driver

 .../devicetree/bindings/mips/brcm/bcm3384-intc.txt |  37 ++++
 .../devicetree/bindings/mips/brcm/bmips.txt        |   8 +
 .../devicetree/bindings/mips/brcm/cm-dsl.txt       |  11 ++
 .../devicetree/bindings/mips/brcm/usb.txt          |  11 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |  14 ++
 arch/mips/Kbuild.platforms                         |   1 +
 arch/mips/Kconfig                                  |  30 +++-
 arch/mips/bcm3384/Makefile                         |   1 +
 arch/mips/bcm3384/Platform                         |   7 +
 arch/mips/bcm3384/dma.c                            |  81 +++++++++
 arch/mips/bcm3384/irq.c                            | 193 +++++++++++++++++++++
 arch/mips/bcm3384/setup.c                          |  97 +++++++++++
 arch/mips/boot/dts/Makefile                        |   1 +
 arch/mips/boot/dts/bcm3384.dtsi                    | 109 ++++++++++++
 arch/mips/boot/dts/bcm93384wvg.dts                 |  32 ++++
 arch/mips/configs/bcm3384_defconfig                |  78 +++++++++
 arch/mips/include/asm/bmips.h                      |   1 +
 arch/mips/include/asm/cpu.h                        |   1 +
 arch/mips/include/asm/mach-bcm3384/dma-coherence.h |  48 +++++
 arch/mips/include/asm/mach-bcm3384/war.h           |  24 +++
 arch/mips/include/asm/prom.h                       |   1 +
 arch/mips/kernel/bmips_vec.S                       |   3 -
 arch/mips/kernel/cpu-probe.c                       |   1 +
 arch/mips/kernel/prom.c                            |  18 ++
 arch/mips/kernel/smp-bmips.c                       | 114 +++++++-----
 arch/mips/lantiq/prom.c                            |  11 +-
 arch/mips/mm/c-r4k.c                               |  43 +++++
 arch/mips/ralink/of.c                              |  14 +-
 29 files changed, 924 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mips/brcm/bcm3384-intc.txt
 create mode 100644 Documentation/devicetree/bindings/mips/brcm/bmips.txt
 create mode 100644 Documentation/devicetree/bindings/mips/brcm/cm-dsl.txt
 create mode 100644 Documentation/devicetree/bindings/mips/brcm/usb.txt
 create mode 100644 arch/mips/bcm3384/Makefile
 create mode 100644 arch/mips/bcm3384/Platform
 create mode 100644 arch/mips/bcm3384/dma.c
 create mode 100644 arch/mips/bcm3384/irq.c
 create mode 100644 arch/mips/bcm3384/setup.c
 create mode 100644 arch/mips/boot/dts/bcm3384.dtsi
 create mode 100644 arch/mips/boot/dts/bcm93384wvg.dts
 create mode 100644 arch/mips/configs/bcm3384_defconfig
 create mode 100644 arch/mips/include/asm/mach-bcm3384/dma-coherence.h
 create mode 100644 arch/mips/include/asm/mach-bcm3384/war.h

-- 
2.1.1
