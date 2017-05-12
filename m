Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 May 2017 17:17:19 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20116 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993983AbdELPRKNAMH9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 May 2017 17:17:10 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 4A61A41F8E8E;
        Fri, 12 May 2017 17:24:59 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 12 May 2017 17:24:59 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 12 May 2017 17:24:59 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 7F35EE9E6133F;
        Fri, 12 May 2017 16:17:00 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 12 May
 2017 16:17:04 +0100
Date:   Fri, 12 May 2017 16:17:04 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [GIT PULL] MIPS changes for 4.12
Message-ID: <20170512151703.GW1088@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lPJ5i9rX1WvdYcWF"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--lPJ5i9rX1WvdYcWF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

The following changes since commit 162b270c664dca2e0944308e92f9fcc887151a72:

  MIPS: KGDB: Use kernel context for sleeping threads (2017-04-12 22:29:22 +0200)

are available in the git repository at:

  git://git.linux-mips.org/pub/scm/ralf/upstream-linus.git upstream

for you to fetch changes up to 3e441845caf1c9591b5b961f34ff1a37d023c9e2:

  MIPS: Sibyte: Fix Kconfig warning. (2017-04-21 03:34:01 +0200)

This is the main pull request for MIPS for 4.12.  Here's the summary of
the non-merge commits:

 math-emu:
   - Add missing clearing of BLTZALL and BGEZALL emulation counters
   - Fix BC1EQZ and BC1NEZ condition handling
   - Fix BLEZL and BGTZL identification

 BPF:
   - Add JIT support for SKF_AD_HATYPE
   - Use unsigned access for unsigned SKB fields
   - Quit clobbering callee saved registers in JIT code
   - Fix multiple problems in JIT skb access helpers

 Loongson 3:
   - Select MIPS_L1_CACHE_SHIFT_6

 Octeon:
   - Remove vestiges of CONFIG_CAVIUM_OCTEON_2ND_KERNEL
   - Remove unused L2C types and macros.
   - Remove unused SLI types and macros.
   - Fix compile error when USB is not enabled.
   - Octeon: Remove unused PCIERCX types and macros.
   - Octeon: Clean up platform code.

 SNI:
   - Remove recursive include of cpu-feature-overrides.h

 Sibyte:
   - Export symbol periph_rev to sb1250-mac network driver.
   - Fix Kconfig warning.

 Generic platform:
   - Enable Root FS on NFS in generic_defconfig

 SMP-MT:
   - Use CPU interrupt controller IPI IRQ domain support

 UASM:
   - Add support for LHU for uasm.
   - Remove needless ISA abstraction

 mm:
   - Add 48-bit VA space and 4-level page tables for 4K pages.

 PCI:
   - Add controllers before the specified head

 irqchip driver for MIPS CPU:
   - Replace magic 0x100 with IE_SW0
   - Prepare for non-legacy IRQ domains
   - Introduce IPI IRQ domain support

 MAINTAINERS:
   - Update email-id of Rahul Bedarkar

 NET:
   - sb1250-mac: Add missing MODULE_LICENSE()

 CPUFREQ:
   - Loongson2: drop set_cpus_allowed_ptr()

 Misc:
   - Disable Werror when W= is set
   - Opt into HAVE_COPY_THREAD_TLS
   - Enable GENERIC_CPU_AUTOPROBE
   - Use common outgoing-CPU-notification code
   - Remove dead define of ST_OFF
   - Remove CONFIG_ARCH_HAS_ILOG2_U{32,64}
   - Stengthen IPI IRQ domain sanity check
   - Remove confusing else statement in __do_page_fault()
   - Don't unnecessarily include kmalloc.h into <asm/cache.h>.
   - Delete unused definition of SMP_CACHE_SHIFT.
   - Delete redundant definition of SMP_CACHE_BYTES.

Please consider pulling,

Thanks
James & Ralf

----------------------------------------------------------------

This has sat for a while in linux-next with no pending issues.  As usual
it's been tested on Imagination's automated test system.  Compiles with
both GCC 5.2 and 6.2 without warnings and works on a number of hardware
platforms.

When pulling there is one merge conflict expected in arch/mips/Kconfig.
It should be resolved as follows:

[...]
        select HANDLE_DOMAIN_IRQ
        select HAVE_EXIT_THREAD
        select HAVE_REGS_AND_STACK_ACCESS_API
        select HAVE_COPY_THREAD_TLS

menu "Machine selection"
[...]

----------------------------------------------------------------
Aleksandar Markovic (1):
      MIPS: r2-on-r6-emu: Clear BLTZALL and BGEZALL debugfs counters

Alex Belits (1):
      MIPS: Add 48-bit VA space (and 4-level page tables) for 4K pages.

David Daney (6):
      MIPS: uasm: Add support for LHU.
      MIPS: BPF: Add JIT support for SKF_AD_HATYPE.
      MIPS: BPF: Use unsigned access for unsigned SKB fields.
      MIPS: BPF: Quit clobbering callee saved registers in JIT code.
      MIPS: BPF: Fix multiple problems in JIT skb access helpers.
      MIPS: Octeon: Remove vestiges of CONFIG_CAVIUM_OCTEON_2ND_KERNEL

Douglas Leung (1):
      MIPS: math-emu: Fix BC1EQZ and BC1NEZ condition handling

Florian Fainelli (1):
      MIPS: Disable Werror when W= is set

Huacai Chen (1):
      MIPS: Loongson-3: Select MIPS_L1_CACHE_SHIFT_6

James Cowgill (1):
      MIPS: Opt into HAVE_COPY_THREAD_TLS

Leonid Yegoshin (1):
      MIPS: r2-on-r6-emu: Fix BLEZL and BGTZL identification

Marcin Nowakowski (3):
      MIPS: Enable GENERIC_CPU_AUTOPROBE
      MIPS: Use common outgoing-CPU-notification code
      MIPS: mach-rm: Remove recursive include of cpu-feature-overrides.h

Matt Redfearn (2):
      MIPS: Remove dead define of ST_OFF
      MIPS: generic: Enable Root FS on NFS in generic_defconfig

Paul Burton (8):
      MIPS: uasm: Remove needless ISA abstraction
      MIPS: Remove CONFIG_ARCH_HAS_ILOG2_U{32,64}
      irqchip: mips-cpu: Replace magic 0x100 with IE_SW0
      irqchip: mips-cpu: Prepare for non-legacy IRQ domains
      irqchip: mips-cpu: Introduce IPI IRQ domain support
      MIPS: smp-mt: Use CPU interrupt controller IPI IRQ domain support
      MIPS: Stengthen IPI IRQ domain sanity check
      MIPS: Remove confusing else statement in __do_page_fault()

Rahul Bedarkar (1):
      MAINTAINERS: Update email-id of Rahul Bedarkar

Ralf Baechle (7):
      MIPS: Don't unnecessarily include kmalloc.h into <asm/cache.h>.
      MIPS: Delete unused definition of SMP_CACHE_SHIFT.
      MIPS: Delete redundant definition of SMP_CACHE_BYTES.
      Merge branch '4.11-fixes' into mips-for-linux-next
      NET: sb1250-mac: Add missing MODULE_LICENSE()
      MIPS: Sibyte: Export symbol periph_rev to sb1250-mac network driver.
      MIPS: Sibyte: Fix Kconfig warning.

Sebastian Andrzej Siewior (1):
      CPUFREQ: Loongson2: drop set_cpus_allowed_ptr()

Steven J. Hill (5):
      MIPS: Octeon: Remove unused L2C types and macros.
      MIPS: Octeon: Remove unused SLI types and macros.
      MIPS: Octeon: Fix compile error when USB is not enabled.
      MIPS: Octeon: Remove unused PCIERCX types and macros.
      MIPS: Octeon: Clean up platform code.

 MAINTAINERS                                        |    2 +-
 arch/mips/Kbuild                                   |    2 +
 arch/mips/Kconfig                                  |   24 +-
 arch/mips/Kconfig.debug                            |    2 +-
 arch/mips/cavium-octeon/Kconfig                    |    9 -
 arch/mips/cavium-octeon/Platform                   |    4 -
 arch/mips/cavium-octeon/executive/cvmx-l2c.c       |  139 +-
 arch/mips/cavium-octeon/executive/octeon-model.c   |   21 +-
 arch/mips/cavium-octeon/octeon-platform.c          |  113 +-
 arch/mips/cavium-octeon/setup.c                    |   12 +-
 arch/mips/configs/generic_defconfig                |    3 +
 arch/mips/include/asm/cache.h                      |    5 -
 arch/mips/include/asm/cpu-info.h                   |    3 +-
 arch/mips/include/asm/cpufeature.h                 |   26 +
 .../include/asm/mach-rm/cpu-feature-overrides.h    |    2 -
 arch/mips/include/asm/octeon/cvmx-l2c-defs.h       | 3193 +-----------------
 arch/mips/include/asm/octeon/cvmx-l2c.h            |   59 +-
 arch/mips/include/asm/octeon/cvmx-l2d-defs.h       |  526 ---
 arch/mips/include/asm/octeon/cvmx-l2t-defs.h       |  286 +-
 arch/mips/include/asm/octeon/cvmx-pciercx-defs.h   | 3225 ++----------------
 arch/mips/include/asm/octeon/cvmx-sli-defs.h       | 3545 +-------------------
 arch/mips/include/asm/octeon/cvmx.h                |    3 +-
 arch/mips/include/asm/pgalloc.h                    |   26 +
 arch/mips/include/asm/pgtable-64.h                 |   88 +-
 arch/mips/include/asm/uasm.h                       |   88 +-
 arch/mips/kernel/cpu-probe.c                       |    7 +
 arch/mips/kernel/mips-r2-to-r6-emul.c              |   16 +-
 arch/mips/kernel/process.c                         |    6 +-
 arch/mips/kernel/r4k_switch.S                      |    6 -
 arch/mips/kernel/smp-cps.c                         |    7 +-
 arch/mips/kernel/smp-mt.c                          |   49 +-
 arch/mips/kernel/smp.c                             |   20 +-
 arch/mips/lantiq/irq.c                             |   52 -
 arch/mips/math-emu/cp1emu.c                        |   10 +-
 arch/mips/mm/fault.c                               |   16 +-
 arch/mips/mm/init.c                                |    3 +
 arch/mips/mm/pgtable-64.c                          |   33 +-
 arch/mips/mm/tlbex.c                               |   22 +
 arch/mips/mm/uasm-mips.c                           |    1 +
 arch/mips/mm/uasm.c                                |  159 +-
 arch/mips/mti-malta/malta-int.c                    |   83 +-
 arch/mips/net/bpf_jit.c                            |   41 +-
 arch/mips/net/bpf_jit_asm.S                        |   23 +-
 arch/mips/pci/pcie-octeon.c                        |    4 +-
 arch/mips/sibyte/bcm1480/setup.c                   |    1 +
 arch/mips/sibyte/sb1250/setup.c                    |    1 +
 drivers/cpufreq/loongson2_cpufreq.c                |    7 -
 drivers/irqchip/Kconfig                            |    2 +
 drivers/irqchip/irq-mips-cpu.c                     |  146 +-
 drivers/net/ethernet/broadcom/sb1250-mac.c         |    1 +
 50 files changed, 1211 insertions(+), 10911 deletions(-)
 create mode 100644 arch/mips/include/asm/cpufeature.h
 delete mode 100644 arch/mips/include/asm/octeon/cvmx-l2d-defs.h

--lPJ5i9rX1WvdYcWF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlkV0ecACgkQbAtpk944
dnoCJxAAnllEoIVN9w/oCIIi3xCpgLLXdcVD25DVAfOE0S5vYKORhL6D5RKIHza9
f+q/omKfIVeAvryn77IsacSRk+11vLy2zb2SWTSvanRKXpJkb1kJbJJtiuW4bJEz
xycJNBlK1u5+QUtSIwDrqb+n5MGjNotsTB8PI3XHrPfPrvQ3WDinFcbrBjYxp4Hj
vSfhdj0CC1tO1YWJEbIdTro6xKDHW+gXof9NeZuN8UZg8J78Q4KYq67NdTBYQ+e4
FzDEdyWlymMIrKZYuqkOxSlYYTihTJP05MN2IJnuaCvuoTfnbRcnXmySBVFli5OJ
GxIT1YONyQcl0xthUCgU1dDHAL+bLXICgbfV4Sg3YQQlLuvoi3/8fOJUr288npA0
nX8ioGcd/hJ0WDvorsLfdYr59ip7P9kvfg29sq2cBWfN7I/deCG0J4DdrrXfRwvm
rF0T+VtchU4oMYfAtSsGtAgTDeA9Iq6goAjDi6Uq/L+t3JOLplXRPFEr1TipbzR7
ZokeattI3Alt8pJ3XOx7WAVi6YmH/YH1PO3LHvFJF2yzTjjggI8Qwv1mCGgUByrn
IbEsuFukuDdfzsDdO8Kqc1xRNQ/ZtUqfTz6ixv1YTtyMQRp46l+9OaQUROfeibyq
qKzu6/JgCNmRpSzQanZ9+JIj/folaro6edmxipUaII2AgmSHzdY=
=HaJG
-----END PGP SIGNATURE-----

--lPJ5i9rX1WvdYcWF--
