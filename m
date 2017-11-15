Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Nov 2017 15:16:16 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.230]:49200 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992127AbdKOOQH6K0p0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Nov 2017 15:16:07 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 15 Nov 2017 14:15:46 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 15 Nov
 2017 06:15:42 -0800
Date:   Wed, 15 Nov 2017 14:15:40 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [GIT PULL] MIPS changes for 4.15
Message-ID: <20171115141540.GA27409@jhogan-linux.mipstec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510755346-452060-12342-612552-2
X-BESS-VER: 2017.14.1-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186955
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Here are the main MIPS changes for 4.15. Half of the patches are from
Ralf's original linux-next branch (suitably fixed), and the rest are a
misc selection of simpler outstanding patches gathered over the last
couple of weeks or so. As such there's not a whole lot of new stuff this
cycle.

Two minor conflicts are expected, both due to SPDX headers:

 - arch/mips/boot/dts/xilfpga/Makefile
   b35565bb16a5 ("MIPS: generic: Add support for MIPSfpga")

 - arch/mips/xilfpga/Kconfig - needs removing
   0861aa1251c7 ("MIPS: Xilfpga: Switch to using generic defconfigs")

Please pull.

Thanks
James

The following changes since commit 8a5776a5f49812d29fe4b2d0a2d71675c3facf3f:

  Linux 4.14-rc4 (2017-10-08 20:53:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git tags/mips_4.15

for you to fetch changes up to e0c5f36b2a638fc3298200c385af7f196d3b5cd4:

  MIPS: Add iomem resource for kernel bss section. (2017-11-13 17:40:49 +0000)

----------------------------------------------------------------
MIPS changes for 4.15

These are the main MIPS changes for 4.15.

Fixes:
- ralink: Fix MT7620 PCI build issues (4.5)
- Disable cmpxchg64() and HAVE_VIRT_CPU_ACCOUNTING_GEN for 32-bit SMP
  (4.1)
- Fix MIPS64 FP save/restore on 32-bit kernels (4.0)
- ptrace: Pick up ptrace/seccomp changed syscall numbers (3.19)
- ralink: Fix MT7628 pinmux (3.19)
- BCM47XX: Fix LED inversion on WRT54GSv1 (3.17)
- Fix n32 core dumping as o32 since regset support (3.13)
- ralink: Drop obsolete USB_ARCH_HAS_HCD select

Build system:
- Default to "generic" (multiplatform) system type instead of IP22
- Use generic little endian MIPS32 r2 configuration as default defconfig
  instead of ip22_defconfig

FPU emulation:
- Fix exception generation for certain R6 FPU instructions

SMP:
- Allow __cpu_number_map to be larger than NR_CPUS for sparse CPU id
  spaces

Miscellaneous:
- Add iomem resource for kernel bss section for kexec/kdump
- Atomics: Nudge writes on bit unlock
- DT files: Standardise "ok" -> "okay"

Platform support:

 BMIPS:
 - Enable HARDIRQS_SW_RESEND

 Broadcom BCM63XX:
 - Add clkdev lookup support
 - Update clk driver, UART driver, DTs to handle named refclk from DTs
 - Split apart various clocks to more closely match hardware
 - Add ethernet clocks

 Cavium Octeon:
 - Remove usage of cvmx_wait() in favour of __delay()

 ImgTec Pistachio:
 - DT: Drop deprecated dwmmc num-slots property

 Ingenic JZ4780:
 - Add NFS root to Ci20 defconfig
 - Add watchdog to Ci20 DT & defconfig, and allow building of watchdog
   driver with this SoC

 Generic (multiplatform):
 - Migrate xilfpga (MIPSfpga) platform to the generic platform

 Lantiq xway:
 - Fix ASC0/ASC1 clocks

Minor cleanups:
- Define virt_to_pfn()
- Make thread_saved_pc static
- Simplify 32-bit sign extension in __read_64bit_c0_split()
- DMA: Use vma_pages() helper
- FPU emulation: Replace unsigned with unsigned int
- MM: Removed unused lastpfn
- Alchemy: Make clk_ops const
- Lasat: Use setup_timer() helper
- ralink: Use BIT() in MT7620 PCI driver

----------------------------------------------------------------
Aleksandar Markovic (2):
      MIPS: math-emu: Fix final emulation phase for certain instructions
      MIPS: math-emu: Use preferred flavor of unsigned integer declarations

Allen Pais (1):
      MIPS: Lasat: Use setup_timer() helper

Ben Hutchings (1):
      MIPS: cmpxchg64() and HAVE_VIRT_CPU_ACCOUNTING_GEN don't work for 32-bit SMP

Bhumika Goyal (1):
      MIPS: Alchemy: make clk_ops const

Chad Reese (1):
      MIPS: Add nudges to writes for bit unlocks.

David Daney (2):
      MIPS: Allow __cpu_number_map to be larger than NR_CPUS
      MIPS: Add iomem resource for kernel bss section.

Florian Fainelli (1):
      MIPS: page.h: Define virt_to_pfn()

Harvey Hunt (1):
      MIPS: Ci20: Add support for rootfs on NFS to defconfig

James Hogan (5):
      MIPS: ralink: Drop obsolete USB_ARCH_HAS_HCD select
      MIPS: Fix MIPS64 FP save/restore on 32-bit kernels
      MIPS/ptrace: Pick up ptrace/seccomp changed syscalls
      MIPS/ptrace: Update syscall nr on register changes
      MIPS: Fix odd fp register warnings with MIPS64r2

John Crispin (3):
      MIPS: pci: Remove duplicate define in mt7620 driver
      MIPS: pci: Remove KERN_WARN instance inside the mt7620 driver
      MIPS: pci: Make use of the BIT() macro inside the mt7620 driver

Jonas Gorski (8):
      MIPS: BCM63XX: add clkdev lookup support
      MIPS: BCM63XX: provide periph clock as refclk for uart
      tty/bcm63xx_uart: use refclk for the expected clock name
      tty/bcm63xx_uart: allow naming clock in device tree
      MIPS: BMIPS: name the refclk clock for uart
      MIPS: BCM63XX: move the HSSPI PLL HZ into its own clock
      MIPS: BCM63XX: provide enet clocks as "enet" to the ethernet devices
      MIPS: BCM63XX: split out swpkt_sar/usb clocks

Justin Chen (1):
      MIPS: BMIPS: Enable HARDIRQS_SW_RESEND

Maciej W. Rozycki (2):
      MIPS: Use SLL by 0 for 32-bit truncation in `__read_64bit_c0_split'
      MIPS: Fix an n32 core file generation regset support regression

Martin Schiller (1):
      MIPS: Lantiq: Fix ASC0/ASC1 clocks

Mathias Kresin (2):
      MIPS: ralink: Fix MT7628 pinmux
      MIPS: ralink: Fix typo in mt7628 pinmux function

Mathieu Malaterre (3):
      MIPS: Ci20: Enable watchdog driver
      MIPS: jz4780: DTS: Probe the jz4740-watchdog driver from devicetree
      watchdog: jz4780: Allow selection of jz4740-wdt driver

Matt Redfearn (2):
      MIPS: Kconfig: Set default MIPS system type as generic
      MIPS: Set defconfig target to a generic system for 32r2el

Mirko Parthey (1):
      MIPS: BCM47XX: Fix LED inversion for WRT54GSv1

Robert P. J. Day (1):
      MIPS: Standardize DTS files, status "ok" -> "okay"

Shawn Lin (1):
      MIPS: DTS: Remove num-slots from Pistachio SoC

Steven J. Hill (2):
      MIPS: Remove unused variable 'lastpfn'
      MIPS: Octeon: Remove usage of cvmx_wait() everywhere.

Thomas Meyer (1):
      MIPS: Cocci spatch "vma_pages"

Tobias Klauser (1):
      MIPS: make thread_saved_pc static

Zubair Lutfullah Kakakhel (2):
      MIPS: generic: Add support for MIPSfpga
      MIPS: Xilfpga: Switch to using generic defconfigs

 .../bindings/serial/brcm,bcm6345-uart.txt          |   6 +
 arch/mips/Kbuild.platforms                         |   1 -
 arch/mips/Kconfig                                  |  42 ++--
 arch/mips/Makefile                                 |   6 +-
 arch/mips/alchemy/common/clock.c                   |  10 +-
 arch/mips/bcm47xx/leds.c                           |   2 +-
 arch/mips/bcm63xx/clk.c                            | 242 +++++++++++++++++----
 arch/mips/boot/dts/brcm/bcm3368.dtsi               |   2 +
 .../boot/dts/brcm/bcm63268-comtrend-vr-3032u.dts   |   2 +-
 arch/mips/boot/dts/brcm/bcm63268.dtsi              |   2 +
 arch/mips/boot/dts/brcm/bcm6328.dtsi               |   2 +
 .../boot/dts/brcm/bcm6358-neufbox4-sercomm.dts     |   2 +-
 arch/mips/boot/dts/brcm/bcm6358.dtsi               |   2 +
 arch/mips/boot/dts/brcm/bcm6362.dtsi               |   2 +
 arch/mips/boot/dts/brcm/bcm6368.dtsi               |   2 +
 arch/mips/boot/dts/img/pistachio.dtsi              |   1 -
 arch/mips/boot/dts/ingenic/jz4780.dtsi             |   5 +
 arch/mips/boot/dts/ralink/rt3052_eval.dts          |   2 +-
 arch/mips/boot/dts/xilfpga/Makefile                |   2 +-
 arch/mips/boot/dts/xilfpga/nexys4ddr.dts           |   8 +
 arch/mips/cavium-octeon/executive/cvmx-helper.c    |   2 +-
 arch/mips/cavium-octeon/executive/cvmx-spi.c       |  10 +-
 arch/mips/configs/ci20_defconfig                   |   7 +-
 arch/mips/configs/generic/board-xilfpga.config     |  22 ++
 arch/mips/configs/ip22_defconfig                   |   1 +
 arch/mips/configs/xilfpga_defconfig                |  75 -------
 arch/mips/generic/Kconfig                          |   6 +
 arch/mips/generic/board-xilfpga.its.S              |  22 ++
 arch/mips/include/asm/asmmacro.h                   |  16 +-
 arch/mips/include/asm/bitops.h                     |   1 +
 arch/mips/include/asm/cmpxchg.h                    |   2 +
 arch/mips/include/asm/mipsregs.h                   |  14 +-
 arch/mips/include/asm/octeon/cvmx-fpa.h            |   4 +-
 arch/mips/include/asm/octeon/cvmx.h                |  15 +-
 arch/mips/include/asm/page.h                       |   4 +-
 arch/mips/include/asm/processor.h                  |   2 -
 arch/mips/include/asm/smp.h                        |   2 +-
 arch/mips/include/asm/syscall.h                    |  29 ++-
 arch/mips/kernel/process.c                         |   2 +-
 arch/mips/kernel/ptrace.c                          |  41 +++-
 arch/mips/kernel/ptrace32.c                        |   7 +
 arch/mips/kernel/r4k_fpu.S                         |  20 +-
 arch/mips/kernel/setup.c                           |   4 +
 arch/mips/kernel/smp.c                             |   2 +-
 arch/mips/lantiq/xway/sysctrl.c                    |   6 +-
 arch/mips/lasat/picvue_proc.c                      |   3 +-
 arch/mips/math-emu/cp1emu.c                        |  46 ++--
 arch/mips/math-emu/dp_maddf.c                      |   8 +-
 arch/mips/math-emu/dp_mul.c                        |   8 +-
 arch/mips/math-emu/dp_sqrt.c                       |   4 +-
 arch/mips/math-emu/ieee754.h                       |  15 +-
 arch/mips/math-emu/ieee754int.h                    |   6 +-
 arch/mips/math-emu/ieee754sp.c                     |   4 +-
 arch/mips/math-emu/ieee754sp.h                     |   2 +-
 arch/mips/math-emu/sp_div.c                        |   4 +-
 arch/mips/math-emu/sp_fint.c                       |   2 +-
 arch/mips/math-emu/sp_maddf.c                      |   6 +-
 arch/mips/math-emu/sp_mul.c                        |  10 +-
 arch/mips/mm/dma-default.c                         |   2 +-
 arch/mips/mm/init.c                                |   4 -
 arch/mips/pci/pci-mt7620.c                         |  15 +-
 arch/mips/pci/pcie-octeon.c                        |  12 +-
 arch/mips/ralink/Kconfig                           |   1 -
 arch/mips/ralink/mt7620.c                          |   4 +-
 arch/mips/xilfpga/Kconfig                          |   9 -
 arch/mips/xilfpga/Makefile                         |   7 -
 arch/mips/xilfpga/Platform                         |   3 -
 arch/mips/xilfpga/init.c                           |  44 ----
 arch/mips/xilfpga/intc.c                           |  22 --
 arch/mips/xilfpga/time.c                           |  41 ----
 drivers/tty/serial/bcm63xx_uart.c                  |   6 +-
 drivers/watchdog/Kconfig                           |   2 +-
 72 files changed, 514 insertions(+), 435 deletions(-)
 create mode 100644 arch/mips/configs/generic/board-xilfpga.config
 delete mode 100644 arch/mips/configs/xilfpga_defconfig
 create mode 100644 arch/mips/generic/board-xilfpga.its.S
 delete mode 100644 arch/mips/xilfpga/Kconfig
 delete mode 100644 arch/mips/xilfpga/Makefile
 delete mode 100644 arch/mips/xilfpga/Platform
 delete mode 100644 arch/mips/xilfpga/init.c
 delete mode 100644 arch/mips/xilfpga/intc.c
 delete mode 100644 arch/mips/xilfpga/time.c

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloMTAQACgkQbAtpk944
dnoRDQ/9GuRTBZaaSeffnHj15msGhIxe6kZz0pcC5gWc2YdLyD1mBOT6tDLlbXpd
ddvB0hggcB+K52102F+dZA03LLlHdx6sfGY7hSnvhrtUbSxSwBeK9pDfnKT3sNLy
OFWZSzqli0kQGrTCDl9zlFjgM7QUfIH4l13CUacTq9S/++SBduefB9Ha3vSmmlFf
WaowCbTZ+EVNdt73W5NzyBumDM7vSYlJe9wPQJZPCZdo/YE4kTDWKM3jBbrP6xj/
nxVkf1DhGp+3lZcgA/bWXFEFCLtLHasxoBTmsfXxLHFuhxZgeCVzECnuNHLxnf/n
2d03GNHws14t/3ARzxZ8RrFzr+zpTcQCtDpMIRdI78A9Fgi/xSVeLuJkc5MsqBhD
U7Md6Uc2LT6phWNYrbaCdfCVwNONanI1tbdy8KOCj3aaJgXJhIPYEhdos+6atCLC
UZ8ATaO2DKN01frGQmJw/R7qGoEkuweD/F4cKBLQgKCZW93L+CIbFmY20Hi6dV5Q
LlgmlDRmqulw/Jy6sIJY+xGCsmQtAlEY5zER2S/N52W4YykYCZemf6h1QzPXOw0o
cM06Ri2BuecnJz7AulF2WiJ16lEguiMuxQmiSkd3DitjhaoQirGWtNY7SjpiZZa9
iRGMcAZtv8WlurVYkpsuGKVmjHfL2R744auSr04FnMs2xMMmZTw=
=G0zR
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
