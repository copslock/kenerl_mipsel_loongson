Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Feb 2018 14:18:01 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:40396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990400AbeBGNRvroXf3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Feb 2018 14:17:51 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B84821789;
        Wed,  7 Feb 2018 13:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B84821789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 7 Feb 2018 13:17:20 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [GIT PULL] MIPS changes for 4.16
Message-ID: <20180207131719.GA8649@saruman>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62452
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


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Here are the main MIPS changes for 4.16. Again most of the patches have
been gathered in the last few weeks of the 4.15 cycle, with mainly fixes
since then, so there's not a whole lot of new stuff again. Hopefully
that should be different for 4.17.

Please pull.

Thanks
James

The following changes since commit 50c4c4e268a2d7a3e58ebb698ac74da0de40ae36:

  Linux 4.15-rc3 (2017-12-10 17:56:26 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git tags/mips_4.16

for you to fetch changes up to 8f2256d8eaf5acef3b49ea27edf79cc1069c4de9:

  MIPS: Malta: Sanitize mouse and keyboard configuration. (2018-02-06 15:50:15 +0000)

----------------------------------------------------------------
MIPS changes for 4.16

These are the main MIPS changes for 4.16. Rough overview:
 - Basic support for the Ingenic JZ4770 based GCW Zero open-source
   handheld video game console
 - Support for the Ranchu board (used by Android emulator)
 - Various cleanups and misc improvements

Fixes:
 - Fix generic platform's USB_*HCI_BIG_ENDIAN selects (4.9)
 - Fix vmlinuz default build when ZBOOT selected
 - Fix clean up of vmlinuz targets
 - Fix command line duplication (in preparation for Ingenic JZ4770)

Miscellaneous:
 - Allow Processor ID reads to be to be optimised away by the compiler
   (improves performance when running in guest)
 - Push ARCH_MIGHT_HAVE_PC_SERIO/PARPORT down to platform level to
   disable on generic platform with Ranchu board support
 - Add helpers for assembler macro instructions for older assemblers
 - Use assembler macro instructions to support VZ, XPA & MSA operations
   on older assemblers, removing C wrapper duplication
 - Various improvements to VZ & XPA assembly wrappers
 - Add drivers/platform/mips/ to MIPS MAINTAINERS entry

Minor cleanups:
 - Misc FPU emulation cleanups (removal of unnecessary include, moving
   macros to common header, checkpatch and sparse fixes)
 - Remove duplicate assignment of core in play_dead()
 - Remove duplication in watchpoint handling
 - Remove mips_dma_mapping_error() stub
 - Use NULL instead of 0 in prepare_ftrace_return()
 - Use proper kernel-doc Return keyword for
   __compute_return_epc_for_insn()
 - Remove duplicate semicolon in csum_fold()

Platform support:

Broadcom:
 - Enable ZBOOT on BCM47xx

Generic platform:
 - Add Ranchu board support, used by Android emulator
 - Fix machine compatible string matching for Ranchu
 - Support GIC in EIC mode

Ingenic platforms:
 - Add DT, defconfig and other support for JZ4770 SoC and GCW Zero
 - Support dynamnic machine types (i.e. JZ4740 / JZ4770 / JZ4780)
 - Add Ingenic JZ4770 CGU clocks
 - General Ingenic clk changes to prepare for JZ4770 SoC support
 - Use common command line handling code
 - Add DT vendor prefix to GCW (Game Consoles Worldwide)

Loongson:
 - Add MAINTAINERS entry for Loongson2 and Loongson3 platforms
 - Drop 32-bit support for Loongson 2E/2F devices
 - Fix build failures due to multiple use of "MEM_RESERVED"

----------------------------------------------------------------
Aaro Koskinen (1):
      MIPS: bcm47xx: enable ZBOOT support

Aleksandar Markovic (6):
      MIPS: math-emu: Remove an unnecessary header inclusion
      MIPS: math-emu: Avoid definition duplication for macro DPXMULT()
      MIPS: math-emu: Declare function srl128() as static
      MIPS: math-emu: Avoid an assignment within if statement condition
      MIPS: math-emu: Avoid multiple assignment
      MIPS: math-emu: Mark fall throughs in switch statements with a comment

Corentin Labbe (1):
      MIPS: Fix typo BIG_ENDIAN to CPU_BIG_ENDIAN

Daniel Sabogal (1):
      MIPS: Fix vmlinuz build when ZBOOT is selected

Felix Fietkau (1):
      MIPS: mm: remove mips_dma_mapping_error

Huacai Chen (2):
      MAINTAINERS: Add Loongson-2/Loongson-3 maintainers
      MIPS: Loongson fix name confict - MEM_RESERVED

James Hogan (13):
      MIPS: mipsregs.h: Add read const Cop0 macros
      MIPS: mipsregs.h: Make read_c0_prid use const accessor
      MIPS: Fix clean of vmlinuz.{32,ecoff,bin,srec}
      MIPS: Add helpers for assembler macro instructions
      MIPS: VZ: Update helpers to use new asm macros
      MIPS: VZ: Pass GC0 register names in $n format
      MIPS: XPA: Use XPA instructions in assembly
      MIPS: XPA: Allow use of $0 (zero) to MTHC0
      MIPS: XPA: Standardise readx/writex accessors
      MIPS: MSA: Update helpers to use new asm macros
      MIPS: generic: Fix machine compatible matching
      MIPS: generic: Fix ranchu_of_match[] termination
      MIPS: generic: Fix Makefile alignment

Jiaxun Yang (1):
      MIPS: Loongson64: Drop 32-bit support for Loongson 2E/2F devices

Luis de Bethencourt (1):
      MIPS: Fix trailing semicolon

Maarten ter Huurne (1):
      MIPS: JZ4770: Work around config2 misreporting associativity

Mathieu Malaterre (2):
      MIPS: ftrace: Remove pointer comparison to 0 in prepare_ftrace_return
      MIPS: Use proper kernel-doc Return keyword

Matt Redfearn (4):
      MIPS: Watch: Avoid duplication of bits in mips_install_watch_registers.
      MIPS: Watch: Avoid duplication of bits in mips_read_watch_registers
      MIPS: Generic: Support GIC in EIC mode
      MIPS: SMP-CPS: Remove duplicate assignment of core in play_dead

Miodrag Dinic (1):
      MIPS: ranchu: Add Ranchu as a new generic-based board

Paul Burton (2):
      MIPS: Setup boot_command_line before plat_mem_setup
      MIPS: ingenic: Use common cmdline handling code

Paul Cercueil (11):
      clk: ingenic: Use const pointer to clk_ops in struct
      clk: ingenic: Fix recalc_rate for clocks with fixed divider
      clk: ingenic: support PLLs with no bypass bit
      clk: ingenic: Add code to enable/disable PLLs
      dt-bindings: clock: Add jz4770-cgu.h header
      clk: Add Ingenic jz4770 CGU driver
      MIPS: platform: add machtype IDs for more Ingenic SoCs
      MIPS: ingenic: Detect machtype from SoC compatible string
      MIPS: ingenic: Initial JZ4770 support
      devicetree/bindings: Add GCW vendor prefix
      MIPS: ingenic: Initial GCW Zero support

Ralf Baechle (5):
      MAINTAINERS: Add entry for drivers/platform/mips/
      MIPS: Push ARCH_MIGHT_HAVE_PC_PARPORT down to platform level
      MIPS: Push ARCH_MIGHT_HAVE_PC_SERIO down to platform level
      MIPS: Update defconfigs after previous patch.
      MIPS: Malta: Sanitize mouse and keyboard configuration.

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |  27 +
 arch/mips/Kconfig                                  |  23 +-
 arch/mips/Makefile                                 |   8 +-
 arch/mips/bcm47xx/Platform                         |   1 +
 arch/mips/boot/compressed/Makefile                 |   6 +-
 arch/mips/boot/dts/ingenic/Makefile                |   1 +
 arch/mips/boot/dts/ingenic/gcw0.dts                |  62 ++
 arch/mips/boot/dts/ingenic/jz4770.dtsi             | 212 ++++++
 arch/mips/configs/bigsur_defconfig                 |   1 -
 arch/mips/configs/gcw0_defconfig                   |  27 +
 arch/mips/configs/generic/board-ranchu.config      |  30 +
 arch/mips/configs/ip27_defconfig                   |   1 -
 arch/mips/configs/ip32_defconfig                   |   1 -
 arch/mips/configs/malta_defconfig                  |   5 +-
 arch/mips/configs/malta_kvm_defconfig              |   4 +-
 arch/mips/configs/malta_kvm_guest_defconfig        |   4 +-
 arch/mips/configs/malta_qemu_32r6_defconfig        |   1 +
 arch/mips/configs/maltaaprp_defconfig              |   1 +
 arch/mips/configs/maltasmvp_defconfig              |   1 +
 arch/mips/configs/maltasmvp_eva_defconfig          |   1 +
 arch/mips/configs/maltaup_defconfig                |   1 +
 arch/mips/configs/maltaup_xpa_defconfig            |   5 +-
 arch/mips/configs/nlm_xlp_defconfig                |   1 -
 arch/mips/configs/nlm_xlr_defconfig                |   1 -
 arch/mips/configs/pnx8335_stb225_defconfig         |   1 -
 arch/mips/configs/sb1250_swarm_defconfig           |   1 -
 arch/mips/generic/Kconfig                          |  10 +
 arch/mips/generic/Makefile                         |   1 +
 arch/mips/generic/board-ranchu.c                   |  93 +++
 arch/mips/generic/irq.c                            |  18 +-
 arch/mips/include/asm/bootinfo.h                   |   2 +
 arch/mips/include/asm/checksum.h                   |   2 +-
 arch/mips/include/asm/mach-loongson64/boot_param.h |   2 +-
 arch/mips/include/asm/machine.h                    |   2 +-
 arch/mips/include/asm/mipsregs.h                   | 708 +++++++++++----------
 arch/mips/include/asm/msa.h                        |  63 +-
 arch/mips/jz4740/Kconfig                           |  10 +
 arch/mips/jz4740/prom.c                            |  25 +-
 arch/mips/jz4740/setup.c                           |  22 +-
 arch/mips/jz4740/time.c                            |   2 +-
 arch/mips/kernel/branch.c                          |   2 +-
 arch/mips/kernel/ftrace.c                          |   2 +-
 arch/mips/kernel/setup.c                           |  55 +-
 arch/mips/kernel/smp-cps.c                         |   2 -
 arch/mips/kernel/watch.c                           |  31 +-
 arch/mips/loongson64/Kconfig                       |   2 -
 arch/mips/loongson64/common/mem.c                  |   2 +-
 arch/mips/loongson64/loongson-3/numa.c             |   2 +-
 arch/mips/math-emu/cp1emu.c                        |  28 +-
 arch/mips/math-emu/dp_add.c                        |   3 +-
 arch/mips/math-emu/dp_div.c                        |   1 +
 arch/mips/math-emu/dp_fmax.c                       |   2 +
 arch/mips/math-emu/dp_fmin.c                       |   2 +
 arch/mips/math-emu/dp_maddf.c                      |   8 +-
 arch/mips/math-emu/dp_mul.c                        |   4 +-
 arch/mips/math-emu/dp_sqrt.c                       |   8 +-
 arch/mips/math-emu/dp_sub.c                        |   2 +-
 arch/mips/math-emu/ieee754dp.h                     |   3 +
 arch/mips/math-emu/sp_add.c                        |   3 +-
 arch/mips/math-emu/sp_div.c                        |   1 +
 arch/mips/math-emu/sp_fdp.c                        |   3 +-
 arch/mips/math-emu/sp_fmax.c                       |   2 +
 arch/mips/math-emu/sp_fmin.c                       |   2 +
 arch/mips/math-emu/sp_maddf.c                      |   3 +-
 arch/mips/math-emu/sp_mul.c                        |   1 +
 arch/mips/math-emu/sp_sqrt.c                       |   3 +-
 arch/mips/math-emu/sp_sub.c                        |   1 +
 arch/mips/math-emu/sp_tlong.c                      |   1 -
 arch/mips/mm/dma-default.c                         |   6 -
 arch/mips/mm/sc-mips.c                             |   9 +
 drivers/clk/ingenic/Makefile                       |   1 +
 drivers/clk/ingenic/cgu.c                          |  96 ++-
 drivers/clk/ingenic/cgu.h                          |   4 +-
 drivers/clk/ingenic/jz4770-cgu.c                   | 483 ++++++++++++++
 drivers/clk/ingenic/jz4780-cgu.c                   |   2 +-
 include/dt-bindings/clock/jz4770-cgu.h             |  58 ++
 77 files changed, 1661 insertions(+), 565 deletions(-)
 create mode 100644 arch/mips/boot/dts/ingenic/gcw0.dts
 create mode 100644 arch/mips/boot/dts/ingenic/jz4770.dtsi
 create mode 100644 arch/mips/configs/gcw0_defconfig
 create mode 100644 arch/mips/configs/generic/board-ranchu.config
 create mode 100644 arch/mips/generic/board-ranchu.c
 create mode 100644 drivers/clk/ingenic/jz4770-cgu.c
 create mode 100644 include/dt-bindings/clock/jz4770-cgu.h

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlp6/F8ACgkQbAtpk944
dnqMFg//bum7Rs5NvxLdjn1sCGGMGXXLSiY+wmsDJJ2s1minAk8dNjP/C2gf++sc
/kYpX8e4gtXKpRoYWLWreBCtT7CmCivAZQR66mHA1ucgzampyJWTHr09mJHAZ3fQ
Umfl474+raVDwZS1B3WsP3g3/3t/fspmmTU7Eo+dzjZaK1bt+TBNSuHKnE78WLsR
2asD7o1WZ0uW5mjruFYVfoAAOR6Titkxe7sO2Je7rDK869FKI75hZnNc5HPC0vUU
/gK4Q07QXxlZpuBN+fSa3UW3alNWjJBnfDJXqcbNT2TPo33s7sxqYKdGp4QM3uj7
acHOWdPAKrErmZvKRyAPYpvWo6ulWZWa/8yL1Q8GHxapGC0iLqQi7vTjSHEVE5fe
cfOZ9huJF5ROsuIWSSkdRfKrShwwwNXAiwoPKJKsJp7iihklp7QZUpajgGlQY6UJ
02tkcx5lXbQpwONkFWToM/uDbBgFh+wxCuzrhEY22Fuzw5ahQ4udeQh8eNPjwuZr
pUxQUK6JzghdJSWTzwyFTmYj0qNe81GrIzpBxDyJiiFMsq8GXuIPNAi9S0cHYHY0
oLtSsNvDUqth31goj06vjIlNDAlSJeiI1COfQlXqLjf3D7L7KBkv0gvOw6v8rugL
pEnqUAoetfEZI4rfRnnwvJ9Mhz6X3YusJu+RRJ31ljyKiXPGYdA=
=8JpX
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
