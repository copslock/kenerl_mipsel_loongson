Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 23:26:12 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:56000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992096AbeDIV0EEnCvC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Apr 2018 23:26:04 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FB2421771;
        Mon,  9 Apr 2018 21:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB2421771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Mon, 9 Apr 2018 22:25:52 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [GIT PULL] MIPS changes for 4.17
Message-ID: <20180409212552.GF17347@saruman>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3oCie2+XPXTnK5a5"
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--3oCie2+XPXTnK5a5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

I didn't get as many MIPS changes applied as I'd have liked this cycle
for various reasons, but here's what I do have queued. Please pull.

Thanks
James
---
The following changes since commit 91ab883eb21325ad80f3473633f794c78ac87f51:

  Linux 4.16-rc2 (2018-02-18 17:29:42 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git tags/mips_4.17

for you to fetch changes up to a5075e6226c42a8e64ea1b862eec7747dc46cb32:

  MIPS: BCM47XX: Use standard reset button for Luxul XWR-1750 (2018-04-07 00:10:48 +0100)

----------------------------------------------------------------
MIPS changes for 4.17

These are the main MIPS changes for 4.17. Rough overview:

 (1) generic platform: Add support for Microsemi Ocelot SoCs

 (2) crypto: Add CRC32 and CRC32C HW acceleration module

 (3) Various cleanups and misc improvements

Miscellaneous:

 - Hang more efficiently on halt/powerdown/restart

 - pm-cps: Block system suspend when a JTAG probe is present

 - Expand make help text for generic defconfigs
   - Refactor handling of legacy defconfigs

 - Determine the entry point from the ELF file header to fix microMIPS
   for certain toolchains

 - Introduce isa-rev.h for MIPS_ISA_REV and use to simplify other code

Minor cleanups:

 - DTS: boston/ci20: Unit name cleanups and correction

 - kdump: Make the default for PHYSICAL_START always 64-bit

 - Constify gpio_led in Alchemy, AR7, and TXX9

 - Silence a couple of W=1 warnings

 - Remove duplicate includes

Platform support:

ath79:

 - Fix AR724X_PLL_REG_PCIE_CONFIG offset

BCM47xx:

 - FIRMWARE: Use mac_pton() for MAC address parsing

 - Add Luxul XAP1500/XWR1750 WiFi LEDs

 - Use standard reset button for Luxul XWR-1750

BMIPS:

 - Enable CONFIG_BRCMSTB_PM in bmips_stb_defconfig for build coverage

 - Add STB PM, wake-up timer, watchdog DT nodes

Generic platform:

 - Add support for Microsemi Ocelot
   - dt-bindings: Add vendor prefix for Microsemi Corporation
   - dt-bindings: Add bindings for Microsemi SoCs
   - Add ocelot SoC & PCB123 board DTS files
   - MAINTAINERS: Add entry for Microsemi MIPS SoCs

 - Enable crc32-mips on r6 configs

Octeon:

 - Drop '.' after newlines in printk calls

ralink:

 - pci-mt7621: Enable PCIe on MT7688

----------------------------------------------------------------
Alexandre Belloni (6):
      dt-bindings: Add vendor prefix for Microsemi Corporation
      dt-bindings: mips: Add bindings for Microsemi SoCs
      MIPS: mscc: Add ocelot dtsi
      MIPS: mscc: Add ocelot PCB123 device tree
      MIPS: generic: Add support for Microsemi Ocelot
      MAINTAINERS: Add entry for Microsemi MIPS SoCs

Andy Shevchenko (1):
      FIRMWARE: bcm47xx_nvram: Replace mac address parsing

Arvind Yadav (3):
      MIPS: Alchemy: Constify gpio_led
      MIPS: AR7: Constify gpio_led
      MIPS: TXX9: Constify gpio_led

Dan Haab (2):
      MIPS: BCM47XX: Add Luxul XAP1500/XWR1750 WiFi LEDs
      MIPS: BCM47XX: Use standard reset button for Luxul XWR-1750

Daniel Golle (1):
      MIPS: pci-mt7620: Enable PCIe on MT7688

Jaedon Shin (4):
      MIPS: BMIPS: Enable CONFIG_SOC_BRCMSTB
      MIPS: BMIPS: Add Broadcom STB power management nodes
      MIPS: BMIPS: Add Broadcom STB wake-up timer nodes
      MIPS: BMIPS: Add Broadcom STB watchdog nodes

James Hogan (3):
      MIPS: generic: Enable crc32-mips on r6 configs
      MIPS: Refactor legacy defconfigs
      MIPS: Expand help text to list generic defconfigs

Joe Perches (1):
      MIPS: Octeon: Fix logging messages with spurious periods after newlines

Maciej W. Rozycki (2):
      MIPS: Use the entry point from the ELF file header
      MIPS: Make the default for PHYSICAL_START always 64-bit

Marcin Nowakowski (2):
      MIPS: Add crc instruction support flag to elf_hwcap
      MIPS: crypto: Add crc32 and crc32c hw accelerated module

Mathias Kresin (1):
      MIPS: ath79: Fix AR724X_PLL_REG_PCIE_CONFIG offset

Mathieu Malaterre (4):
      MIPS: dts: Remove leading 0x and 0s from bindings notation
      MIPS: dts: Fix a typo in the node unit name
      MIPS: Make declaration for function `memory_region_available` static
      MIPS: Remove a warning when PHYS_OFFSET is 0x0

Matt Redfearn (5):
      MIPS: Introduce isa-rev.h to define MIPS_ISA_REV
      MIPS: cpu-features.h: Replace __mips_isa_rev with MIPS_ISA_REV
      MIPS: BPF: Replace __mips_isa_rev with MIPS_ISA_REV
      MIPS: VDSO: Replace __mips_isa_rev with MIPS_ISA_REV
      MIPS: pm-cps: Block system suspend when a JTAG probe is present

Paul Burton (1):
      MIPS: Hang more efficiently on halt/powerdown/restart

Pravin Shedge (1):
      MIPS: Remove duplicate includes

 Documentation/devicetree/bindings/mips/mscc.txt    |  43 +++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   9 +
 arch/mips/Kconfig                                  |   7 +-
 arch/mips/Makefile                                 |  64 ++--
 arch/mips/alchemy/board-gpr.c                      |   2 +-
 arch/mips/alchemy/board-mtx1.c                     |   2 +-
 arch/mips/ar7/platform.c                           |  14 +-
 arch/mips/bcm47xx/buttons.c                        |   2 +-
 arch/mips/bcm47xx/leds.c                           |  21 ++
 arch/mips/boot/dts/Makefile                        |   1 +
 arch/mips/boot/dts/brcm/bcm7125.dtsi               |   7 +
 arch/mips/boot/dts/brcm/bcm7346.dtsi               |  62 ++++
 arch/mips/boot/dts/brcm/bcm7358.dtsi               |  17 +
 arch/mips/boot/dts/brcm/bcm7360.dtsi               |  62 ++++
 arch/mips/boot/dts/brcm/bcm7362.dtsi               |  62 ++++
 arch/mips/boot/dts/brcm/bcm7420.dtsi               |   7 +
 arch/mips/boot/dts/brcm/bcm7425.dtsi               |  89 ++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi               |  89 ++++++
 arch/mips/boot/dts/brcm/bcm97125cbmb.dts           |   4 +
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts          |   8 +
 arch/mips/boot/dts/brcm/bcm97358svmb.dts           |   8 +
 arch/mips/boot/dts/brcm/bcm97360svmb.dts           |   8 +
 arch/mips/boot/dts/brcm/bcm97362svmb.dts           |   8 +
 arch/mips/boot/dts/brcm/bcm97420c.dts              |   4 +
 arch/mips/boot/dts/brcm/bcm97425svmb.dts           |   8 +
 arch/mips/boot/dts/brcm/bcm97435svmb.dts           |   8 +
 arch/mips/boot/dts/img/boston.dts                  |   2 +-
 arch/mips/boot/dts/ingenic/ci20.dts                |   8 +-
 arch/mips/boot/dts/mscc/Makefile                   |   3 +
 arch/mips/boot/dts/mscc/ocelot.dtsi                | 117 +++++++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts          |  27 ++
 arch/mips/cavium-octeon/octeon-irq.c               |  10 +-
 arch/mips/configs/bmips_stb_defconfig              |   1 +
 arch/mips/configs/generic/32r6.config              |   2 +
 arch/mips/configs/generic/64r6.config              |   2 +
 arch/mips/configs/generic/board-ocelot.config      |  35 +++
 arch/mips/crypto/Makefile                          |   6 +
 arch/mips/crypto/crc32-mips.c                      | 348 +++++++++++++++++++++
 arch/mips/generic/Kconfig                          |  16 +
 arch/mips/generic/Makefile                         |   1 +
 arch/mips/generic/board-ocelot.c                   |  78 +++++
 arch/mips/include/asm/cpu-features.h               |   5 +-
 arch/mips/include/asm/isa-rev.h                    |  24 ++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h     |   2 +-
 arch/mips/include/asm/mipsregs.h                   |   1 +
 arch/mips/include/uapi/asm/hwcap.h                 |   1 +
 arch/mips/kernel/cpu-probe.c                       |   3 +
 arch/mips/kernel/pm-cps.c                          |  31 ++
 arch/mips/kernel/reset.c                           |  68 +++-
 arch/mips/kernel/setup.c                           |   5 +-
 arch/mips/mm/init.c                                |   2 -
 arch/mips/net/bpf_jit_asm.S                        |   9 +-
 arch/mips/pci/pci-mt7620.c                         |   1 +
 arch/mips/txx9/rbtx4927/setup.c                    |   2 +-
 arch/mips/vdso/elf.S                               |  10 +-
 crypto/Kconfig                                     |   9 +
 drivers/firmware/broadcom/Kconfig                  |   1 +
 drivers/firmware/broadcom/bcm47xx_sprom.c          |  18 +-
 59 files changed, 1381 insertions(+), 84 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mips/mscc.txt
 create mode 100644 arch/mips/boot/dts/mscc/Makefile
 create mode 100644 arch/mips/boot/dts/mscc/ocelot.dtsi
 create mode 100644 arch/mips/boot/dts/mscc/ocelot_pcb123.dts
 create mode 100644 arch/mips/configs/generic/board-ocelot.config
 create mode 100644 arch/mips/crypto/Makefile
 create mode 100644 arch/mips/crypto/crc32-mips.c
 create mode 100644 arch/mips/generic/board-ocelot.c
 create mode 100644 arch/mips/include/asm/isa-rev.h

--3oCie2+XPXTnK5a5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrL2l8ACgkQbAtpk944
dnqlcQ//coaa2gFYU/vOQdB4gdEabOK2kllM3wxeJljVRH9yr9LuVMJtGs8PAI/2
3EQCwv5RCBAO7V7vckVdKw8Aa3SCG66h9fcEXUmmTDfR7KAAz9lxFn9HDCu/583r
0ZnOHcIMecqufAno0c+WamGqWjZLwMRLSCBAZz+S8qDQogGK+mOGT3g+xbS0eEKX
WDL7KC101hACCWVLKQlHEI0AviBtmvruY+cRRKexioRZohe9hwDCeREVUI7SHFoW
sOEwccLHXv9qiEdRuGE+rmK3AK7Fi7b8WxC+g0CZATlazgDAOEH/5jQ5bj1fu2Aq
NmJTJiyOyEA32WufDjM9wKmWm5O/4505VPXuwilmPTNoXY1Z8J6Y2HFhrpCHMoCP
1oQs9JVNkly5Fbn1Nx06mF+xkWZYf/fun2DqEoFiiUPAt/ZSIem/erg7qWNxzQua
CiiJDj1MvZfOvwQk0nYpWFXosV+avAJuy+YylQk3PeEqgark6JJd1EvFqJU6JELk
vf1L3DP3wSNEUeJpO+qSCrh6lQ5onq3GxQxY9/Rm8fAslIdb6LJ3/xca2Syr12hi
xtM95h1vnixMvK049irKpAMLAgu6aahs9xc6hnEPSx5SJDUdFqrlW1c6c2qDjZb/
XTJkI3R+6d4wwOYD34+plFUK8HR9AXvPwBPHaWpO8/PgAX3Mgro=
=5N02
-----END PGP SIGNATURE-----

--3oCie2+XPXTnK5a5--
