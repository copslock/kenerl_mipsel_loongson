Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Feb 2017 15:32:07 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44557 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993899AbdBUOb7YhbZK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Feb 2017 15:31:59 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 173204DAEE7B;
        Tue, 21 Feb 2017 14:31:47 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 21 Feb
 2017 14:31:49 +0000
Date:   Tue, 21 Feb 2017 14:31:49 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: [GIT PULL] MIPS changes for 4.11
Message-ID: <20170221143149.GA1668@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56884
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

Hi Linus,

Here's the main MIPS pull request for 4.11.

It contains a few new features such as IRQ stacks, cacheinfo support,
and KASLR for Octeon CPUs, and a variety of smaller improvements and
fixes including devicetree additions, kexec cleanups, microMIPS stack
unwinding fixes, and a bunch of build fixes to clean up continuous
integration builds.

Its all been in linux-next for at least a couple of days, most of it far
longer.

A trivial conflict is expected in arch/mips/configs/lemote2f_defconfig
due to removal of CONFIG_CPU_FREQ_STAT_DETAILS in commit 801e0f378fe7
("cpufreq: Remove CONFIG_CPU_FREQ_STAT_DETAILS config option"):

- CONFIG_CPU_FREQ_STAT=m
+ CONFIG_CPU_FREQ_STAT=y
 -CONFIG_CPU_FREQ_STAT_DETAILS=y

Please consider pulling,

Thanks
James

The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git tags/mips_4.11

for you to fetch changes up to cfd75c2db17ef70590d7f04dfc254cf003b9cd77:

  MIPS: VDSO: Explicitly use -fno-asynchronous-unwind-tables (2017-02-17 11:32:12 +0000)

----------------------------------------------------------------
MIPS changes for v4.11

Miscellaneous:
 - Add IRQ stacks
 - Add cacheinfo support
 - Add "uzImage.bin" zboot target
 - Unify performance counter definitions
 - Export various (mainly assembly) symbols alongside their
   definitions
 - Audit and remove unnecessary uses of module.h

kexec & kdump:
 - Lots of improvements and fixes
 - Add correct copy_regs implementations
 - Add debug logging of new kernel information

Security:
 - Use Makefile.postlink to insert relocations into vmlinux
 - Provide plat_post_relocation hook (used for Octeon KASLR)
 - Add support for tuning mmap randomisation
 - Relocate DTB

microMIPS:
 - A load of unwind fixes
 - Add some missing .insn to fix link errors

MIPSr6:
 - Fix MULTU/MADDU/MSUBU sign extension in r2 emulation
 - Remove r2_emul_return and use ERETNC unconditionally on MIPSr6
 - Allow pre-r6 emulation on SMP MIPSr6 kernels

Cache management:
 - Treat physically indexed dcache as non-aliasing
 - Add return errors to protected cache ops for KVM
 - CM3: Ensure L1 & L2 cache ECC checking matches
 - CM3: Indicate inclusive caches
 - I6400: Treat dcache as physically indexed

Memory management:
 - Ensure bootmem doesn't corrupt reserved memory
 - Export some TLB exception generation functions for KVM

OF
 - NULL check initial_boot_params before use in of_scan_flat_dt()
 - Fix unaligned access in of_alias_scan()

SMP:
 - CPS: Don't BUG if a CPU fails to start

Other fixes
 - Fix longstanding 64-bit IP checksum carry bug
 - Fix KERN_CONT fallout in cpu-bugs64.c and sync-r4k.c
 - Update defconfigs for NF_CT_PROTO_DCCP, DPLITE,
   CPU_FREQ_STAT,SCSI_DH changes
 - Disable certain builtin compiler options, stack-check (whole
   kernel), asynchronous-unwind-tables (VDSO).
 - A bunch of build fixes from kernelci.org testing
 - Various other minor cleanups & corrections

BMIPS:
 - Migrate interrupts during bmips_cpu_disable
 - BCM47xx: Add Luxul devices
 - BCM47xx: Fix Asus WL-500W button inversion
 - BCM7xxx: Add SPI device nodes

Generic (multiplatform):
 - Add kexec DTB passing
 - Fix big endian
 - Add cpp_its_S in ksym_dep_filter to silence build warning

IP22:
 - Reformat inline assembler code to modern standards
 - Fix binutils 2.25 build error

IP27:
 - Fix duplicate CAC_BASE definition build error
 - Disable qlge driver to workaround broken compiler

Lantiq:
 - Refresh defconfig and activate more drivers
 - Lock DMA register access
 - Fix cascading IRQ setup
 - Fix build of VPE loader
 - xway: Fix ethernet packet header corruption over reboot

Loongson1
 - Add watchdog support
 - 1B: Reduce DEFAULT_MEMSIZE to 64MB
 - 1B: Change OSC clock name to match rest of kernel
 - 1C: Remove ARCH_WANT_OPTIONAL_GPIOLIB

Octeon:
 - Add KASLR support
 - Support Octeon III USB controller
 - Fix large copy_from_user corner case
 - Enable devtmpfs in defconfig

Netlogic:
 - Fix non-default XLR build error due to netlogic,xlp-pic code
 - Fix assembler warning from smpboot.S

pic32mzda:
 - Fix linker error when early printk is disabled

Pistachio:
 - Add base device tree
 - Add Ci40 "Marduk" device tree

Ralink:
 - Support raw appended DTB
 - Add missing I2C & I2S clocks
 - Add missing pinmux and fix pinmux function name typo
 - Add missing clk_round_rate()
 - Clean up prom_init()
 - MT7621: Set SoC type
 - MT7621: Support highmem

TXx9:
 - Modernize printing of kernel messages and resolve KERN_CONT fallout
 - 7segled: use permission-specific DEVICE_ATTR variants

XilFPGA:
 - Add IRQ controller and UART IRQ
 - Add AXI I2C and emaclite to DT & defconfig

----------------------------------------------------------------
Aaro Koskinen (1):
      MIPS: Octeon: Kill cvmx_helper_link_autoconf()

Arnd Bergmann (16):
      MIPS: Update defconfigs for NF_CT_PROTO_DCCP/UDPLITE change
      MIPS: Update lemote2f_defconfig for CPU_FREQ_STAT change
      MIPS: Update ip27_defconfig for SCSI_DH change
      MIPS: Fix modversions
      MIPS: VDSO: avoid duplicate CAC_BASE definition
      MIPS: 'make -s' should be silent
      MIPS: Alchemy: Remove duplicate initializer
      MIPS: Lantiq: Fix another request_mem_region() return code check
      MIPS: ralink: Remove unused timer functions
      MIPS: ralink: Fix request_mem_region error handling
      MIPS: ralink: Remove unused rt*_wdt_reset functions
      MIPS: Loongson64: Fix empty-body warning in dma_alloc
      MIPS: Octeon: Avoid empty-body warning
      MIPS: ip22: Fix ip28 build for modern gcc
      MIPS: Avoid old-style declaration
      MIPS: ip27: Disable qlge driver in defconfig

Arvind Yadav (1):
      mips: ath79: clock:- Unmap region obtained by of_iomap

Christophe JAILLET (1):
      MIPS: ath79: Fix error handling

Colin Ian King (1):
      MIPS: ralink: Fix incorrect assignment on ralink_soc

Dan Haab (1):
      MIPS: BCM47XX: Add Luxul devices to the database

Felix Fietkau (2):
      MIPS: Lantiq: Fix cascaded IRQ setup
      MIPS: Lantiq: Keep ethernet enabled during boot

Florian Fainelli (1):
      MIPS: BMIPS: Migrate interrupts during bmips_cpu_disable

Geert Uytterhoeven (1):
      MIPS: TXx9: Modernize printing of kernel messages

Hauke Mehrtens (4):
      MIPS: lantiq: Refresh default configuration
      MIPS: Lantiq: Activate more drivers in default configuration
      MIPS: Lantiq: Lock DMA register accesses for SMP
      MIPS: lantiq: Set physical_memsize

Ian Pozella (1):
      MIPS: DTS: Add img directory to Makefile

Jaedon Shin (1):
      MIPS: BMIPS: Add support SPI device nodes

James Cowgill (1):
      MIPS: OCTEON: Fix copy_from_user fault handling for large buffers

James Hogan (10):
      MIPS: Fix printk continuations in cpu-bugs64.c
      MIPS: Move pgd_alloc() out of header
      MIPS: Export pgd/pmd symbols for KVM
      MIPS: uasm: Add include guards in asm/uasm.h
      MIPS: Export some tlbex internals for KVM to use
      MIPS: Add return errors to protected cache ops
      Merge tag 'mips_kvm_4.11_1' into mips-for-linux-next
      MIPS: Fix cacheinfo overflow
      MIPS: Unify perf counter register definitions
      MIPS: OCTEON: Enable DEVTMPFS

John Crispin (7):
      MIPS: ralink: MT7621 does not set its SoC type.
      MIPS: ralink: Add missing I2C and I2S clocks.
      MIPS: ralink: Add missing pinmux.
      MIPS: ralink: Fix a typo in the pinmux setup.
      MIPS: ralink: Add missing clk_round_rate().
      MIPS: ralink: Add missing symbol for highmem support.
      MIPS: ralink: Cosmetic change to prom_init().

Joshua Kinard (1):
      MIPS: Disable stack checks on MIPS kernels

Julia Lawall (1):
      MIPS: TXx9: 7segled: use permission-specific DEVICE_ATTR variants

Justin Chen (1):
      MIPS: Add cacheinfo support

Kelvin Cheung (3):
      MIPS: Loongson1C: Remove ARCH_WANT_OPTIONAL_GPIOLIB
      MIPS: Loongson1B: Modify DEFAULT_MEMSIZE
      MIPS: Loongson1B: Change the OSC clock name

Leonid Yegoshin (1):
      MIPS: R2-on-R6 MULTU/MADDU/MSUBU emulation bugfix

Maarten ter Huurne (1):
      MIPS: zboot: Add "uzImage.bin" target

Marcin Nowakowski (16):
      MIPS: kexec: remove SMP_DUMP
      MIPS: Kconfig: Fix indentation for kexec-related entries
      MIPS: Move register dump routines out of ptrace code
      MIPS: elfcore: add correct copy_regs implementations
      MIPS: Do not request resources for crashkernel if one isn't defined
      MIPS: init: Ensure reserved memory regions are not added to bootmem
      MIPS: init: Ensure bootmem does not corrupt reserved memory
      MIPS: Use early_init_fdt_reserve_self to protect DTB location
      MIPS: platform: Allow for DTB to be moved during kernel relocation
      MIPS: relocate: Optionally relocate the DTB
      MIPS: fix mem=X@Y commandline processing
      MIPS: kexec: Do not reserve invalid crashkernel memory on boot
      MIPS: kexec: add debug info about the new kexec'ed image
      MIPS: generic/kexec: add support for a DTB passed in a separate buffer
      MIPS: uprobes: Remove __weak attribute from arch_uprobe_copy_ixol.
      Kbuild: Add cpp_its_S in ksym_dep_filter

Markus Elfring (3):
      MIPS: Return directly in 32_mmap2()
      MIPS: MT: Move an assignment for the variable "retval" in mipsmt_sys_sched_setaffinity()
      MIPS: syscall: Return directly in mips_mmap()

Matt Redfearn (14):
      MIPS: Introduce irq_stack
      MIPS: Stack unwinding while on IRQ stack
      MIPS: Only change $28 to thread_info if coming from user mode
      MIPS: Switch to the irq_stack in interrupts
      MIPS: Select HAVE_IRQ_EXIT_ON_IRQ_STACK
      MIPS: Use Makefile.postlink to insert relocations into vmlinux
      MIPS: SMP: Use a completion event to signal CPU up
      MIPS: SMP: Remove cpu_callin_map
      MIPS: SMP-CPS: Don't BUG if a CPU fails to start
      MIPS: Add support for ARCH_MMAP_RND_{COMPAT_}BITS
      MIPS: Generic: Fix big endian CPUs on generic machine
      MIPS: Fix distclean with Makefile.postlink
      MIPS: IRQ Stack: Fix erroneous jal to plat_irq_dispatch
      MIPS: sync-r4k: Fix KERN_CONT fallout

Mirko Parthey (1):
      MIPS: BCM47XX: Fix button inversion for Asus WL-500W

Paul Bolle (1):
      MIPS: Zboot: Don't use $(LINUXINCLUDE) twice

Paul Burton (31):
      MIPS: Ensure bss section ends on a long-aligned address
      MIPS: Use generic asm/unaligned.h
      MIPS: Clear ISA bit correctly in get_frame_info()
      MIPS: Prevent unaligned accesses during stack unwinding
      MIPS: Fix get_frame_info() handling of microMIPS function size
      MIPS: Fix is_jump_ins() handling of 16b microMIPS instructions
      MIPS: Calculate microMIPS ra properly when unwinding the stack
      MIPS: Handle microMIPS jumps in the same way as MIPS32/MIPS64 jumps
      MIPS: Remove unused HIGHMEM_DEBUG macro
      MIPS: Netlogic: Exclude netlogic,xlp-pic code from XLR builds
      MIPS: traps: Ensure L1 & L2 ECC checking match for CM3 systems
      MIPS: Remove r2_emul_return from struct thread_info
      MIPS: Cleanup LLBit handling in switch_to
      MIPS: Allow pre-r6 emulation on SMP MIPSr6 kernels
      MIPS: Remove RESTORE_ALL_AND_RET
      OF: Prevent unaligned access in of_alias_scan()
      MIPS: Use generic asm/export.h
      MIPS: tlbex: Clear ISA bit when writing to handle_tlb{l,m,s}
      MIPS: End asm function prologue macros with .insn
      MIPS: Export _save_fp & _save_msa alongside their definitions
      MIPS: Export _mcount alongside its definition
      MIPS: Export invalid_pte_table alongside its definition
      MIPS: Export csum functions alongside their definitions
      MIPS: Export string functions alongside their definitions
      MIPS: Export memcpy & memset functions alongside their definitions
      MIPS: Export {copy, clear}_page functions alongside their definitions
      MIPS: Netlogic: Fix assembler warning from smpboot.S
      MIPS: c-r4k: Treat I6400 dcache as though physically indexed
      MIPS: c-r4k: Treat physically indexed dcaches as not aliasing
      MIPS: sc-mips: L2 cache is inclusive of L1 dcache for CM3
      MIPS: Fix protected_cache(e)_op() for microMIPS

Paul Gortmaker (1):
      MIPS: Audit and remove any unnecessary uses of module.h

Purna Chandra Mandal (1):
      MIPS: pic32mzda: Fix linker error for pic32_get_pbclk()

Rahul Bedarkar (2):
      MIPS: DTS: Add base device tree for Pistachio SoC
      MIPS: DTS: img: add device tree for Marduk board

Ralf Baechle (5):
      MIPS: IP22: Reformat inline assembler code to modern standards.
      MIPS: IP22: Fix build error due to binutils 2.25 uselessnes.
      MIPS: IRQ: Remove useless i8259_of_init() prototype.
      MIPS: zboot: Consolidate compiler flag filtering.
      MIPS: Fix special case in 64 bit IP checksumming.

Robert Schiele (1):
      MIPS: VDSO: Explicitly use -fno-asynchronous-unwind-tables

Steven J. Hill (5):
      MIPS: Octeon: Add fw_init_cmdline() for Cavium platforms.
      MIPS: Octeon: Add plat_get_fdt() function for Cavium platforms.
      MIPS: Octeon: Enable KASLR
      MIPS: Relocatable: Provide plat_post_relocation hook
      MIPS: OCTEON: Platform support for OCTEON III USB controller

Tobias Wolf (2):
      ralink: Introduce fw_passed_dtb to arch/mips/ralink
      of: Add check to of_scan_flat_dt() before accessing initial_boot_params

Wei Yongjun (1):
      MIPS: sysmips: Remove duplicated include from syscall.c

Yang Ling (2):
      MIPS: Loongson1: Remove several redundant RTC-related macros
      MIPS: Loongson1: Add watchdog support for Loongson1 board

Zubair Lutfullah Kakakhel (6):
      MIPS: xilfpga: Use irqchip instead of the legacy way
      MIPS: xilfpga: Use Xilinx Interrupt Controller
      MIPS: xilfpga: Update DT node and specify uart irq
      MIPS: xilfpga: Add DT node for AXI I2C
      MIPS: xilfpga: Add DT node for AXI emaclite
      MIPS: xilfpga: Update defconfig

 .../bindings/mips/img/pistachio-marduk.txt         |  10 +
 MAINTAINERS                                        |   8 +-
 arch/mips/Kconfig                                  |  41 +-
 arch/mips/Makefile                                 |  35 +-
 arch/mips/Makefile.postlink                        |  35 +
 arch/mips/alchemy/board-gpr.c                      |   1 -
 arch/mips/alchemy/common/dbdma.c                   |   2 +-
 arch/mips/alchemy/common/dma.c                     |   2 +-
 arch/mips/alchemy/common/gpiolib.c                 |   1 -
 arch/mips/alchemy/common/prom.c                    |   1 -
 arch/mips/alchemy/common/usb.c                     |   2 +-
 arch/mips/alchemy/common/vss.c                     |   2 +-
 arch/mips/alchemy/devboards/bcsr.c                 |   3 +-
 arch/mips/ar7/clock.c                              |   2 +-
 arch/mips/ar7/gpio.c                               |   3 +-
 arch/mips/ar7/memory.c                             |   1 -
 arch/mips/ar7/platform.c                           |   1 -
 arch/mips/ar7/prom.c                               |   2 +-
 arch/mips/ath79/clock.c                            |  10 +-
 arch/mips/ath79/common.c                           |   2 +-
 arch/mips/bcm47xx/board.c                          |   9 +
 arch/mips/bcm47xx/buttons.c                        |  82 +-
 arch/mips/bcm47xx/leds.c                           |  81 ++
 arch/mips/bcm63xx/clk.c                            |   3 +-
 arch/mips/bcm63xx/cpu.c                            |   2 +-
 arch/mips/bcm63xx/cs.c                             |   3 +-
 arch/mips/bcm63xx/gpio.c                           |   2 +-
 arch/mips/bcm63xx/irq.c                            |   1 -
 arch/mips/bcm63xx/reset.c                          |   3 +-
 arch/mips/bcm63xx/timer.c                          |   3 +-
 arch/mips/boot/compressed/Makefile                 |  10 +-
 arch/mips/boot/dts/Makefile                        |   1 +
 arch/mips/boot/dts/brcm/bcm7125.dtsi               |  49 +-
 arch/mips/boot/dts/brcm/bcm7346.dtsi               |  43 +
 arch/mips/boot/dts/brcm/bcm7358.dtsi               |  43 +
 arch/mips/boot/dts/brcm/bcm7360.dtsi               |  43 +
 arch/mips/boot/dts/brcm/bcm7362.dtsi               |  43 +
 arch/mips/boot/dts/brcm/bcm7420.dtsi               |  49 +-
 arch/mips/boot/dts/brcm/bcm7425.dtsi               |  43 +
 arch/mips/boot/dts/brcm/bcm7435.dtsi               |  43 +
 arch/mips/boot/dts/brcm/bcm97125cbmb.dts           |   4 +
 arch/mips/boot/dts/brcm/bcm97346dbsmb.dts          |   4 +
 arch/mips/boot/dts/brcm/bcm97358svmb.dts           |  36 +
 arch/mips/boot/dts/brcm/bcm97360svmb.dts           |  36 +
 arch/mips/boot/dts/brcm/bcm97362svmb.dts           |   4 +
 arch/mips/boot/dts/brcm/bcm97420c.dts              |   4 +
 arch/mips/boot/dts/brcm/bcm97425svmb.dts           |  36 +
 arch/mips/boot/dts/brcm/bcm97435svmb.dts           |   4 +
 arch/mips/boot/dts/img/Makefile                    |   9 +
 arch/mips/boot/dts/img/pistachio.dtsi              | 924 +++++++++++++++++++++
 arch/mips/boot/dts/img/pistachio_marduk.dts        | 163 ++++
 arch/mips/boot/dts/xilfpga/nexys4ddr.dts           |  63 ++
 arch/mips/cavium-octeon/Makefile                   |   1 +
 arch/mips/cavium-octeon/crypto/octeon-crypto.c     |   2 +-
 arch/mips/cavium-octeon/dma-octeon.c               |  15 +-
 arch/mips/cavium-octeon/executive/cvmx-bootmem.c   |   2 +-
 .../cavium-octeon/executive/cvmx-helper-errata.c   |   2 +-
 .../cavium-octeon/executive/cvmx-helper-rgmii.c    |   3 +-
 .../cavium-octeon/executive/cvmx-helper-sgmii.c    |   3 +-
 .../mips/cavium-octeon/executive/cvmx-helper-spi.c |   3 +-
 .../cavium-octeon/executive/cvmx-helper-xaui.c     |   3 +-
 arch/mips/cavium-octeon/executive/cvmx-helper.c    |  47 +-
 arch/mips/cavium-octeon/executive/cvmx-sysinfo.c   |   2 +-
 arch/mips/cavium-octeon/octeon-memcpy.S            |  25 +-
 arch/mips/cavium-octeon/octeon-platform.c          |   1 +
 arch/mips/cavium-octeon/octeon-usb.c               | 552 ++++++++++++
 arch/mips/cavium-octeon/setup.c                    |  23 +
 arch/mips/cavium-octeon/smp.c                      |  24 +-
 arch/mips/configs/cavium_octeon_defconfig          |   1 +
 arch/mips/configs/ip22_defconfig                   |   4 +-
 arch/mips/configs/ip27_defconfig                   |   3 +-
 arch/mips/configs/lemote2f_defconfig               |   2 +-
 arch/mips/configs/loongson1b_defconfig             |   4 +
 arch/mips/configs/loongson1c_defconfig             |   4 +
 arch/mips/configs/malta_defconfig                  |   4 +-
 arch/mips/configs/malta_kvm_defconfig              |   4 +-
 arch/mips/configs/malta_kvm_guest_defconfig        |   4 +-
 arch/mips/configs/maltaup_xpa_defconfig            |   4 +-
 arch/mips/configs/nlm_xlp_defconfig                |   2 +-
 arch/mips/configs/nlm_xlr_defconfig                |   2 +-
 arch/mips/configs/xilfpga_defconfig                |  37 +-
 arch/mips/configs/xway_defconfig                   |  21 +-
 arch/mips/dec/prom/identify.c                      |   2 +-
 arch/mips/dec/setup.c                              |   2 +-
 arch/mips/dec/wbflush.c                            |   4 +-
 arch/mips/emma/markeins/setup.c                    |   2 +-
 arch/mips/generic/Makefile                         |   1 +
 arch/mips/generic/init.c                           |  13 +
 arch/mips/generic/kexec.c                          |  44 +
 arch/mips/include/asm/Kbuild                       |   2 +
 arch/mips/include/asm/asm-prototypes.h             |   5 +
 arch/mips/include/asm/asm.h                        |  10 +-
 arch/mips/include/asm/bootinfo.h                   |  13 +
 arch/mips/include/asm/checksum.h                   |   2 +
 arch/mips/include/asm/elf.h                        |   9 +
 arch/mips/include/asm/highmem.h                    |   3 -
 arch/mips/include/asm/i8259.h                      |   1 -
 arch/mips/include/asm/irq.h                        |  12 +
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h |   9 +
 .../asm/mach-cavium-octeon/kernel-entry-init.h     |  15 +-
 arch/mips/include/asm/mach-ip27/spaces.h           |   6 +-
 arch/mips/include/asm/mach-loongson32/loongson1.h  |   9 +-
 arch/mips/include/asm/mach-loongson32/platform.h   |   9 +-
 arch/mips/include/asm/mach-loongson32/regs-rtc.h   |  23 +
 arch/mips/include/asm/mach-ralink/mt7620.h         |   7 +-
 arch/mips/include/asm/mips-cm.h                    |   7 +
 arch/mips/include/asm/mipsregs.h                   |  33 +
 arch/mips/include/asm/octeon/cvmx-gpio-defs.h      |   8 +-
 arch/mips/include/asm/octeon/cvmx-helper-rgmii.h   |   3 +-
 arch/mips/include/asm/octeon/cvmx-helper-sgmii.h   |   3 +-
 arch/mips/include/asm/octeon/cvmx-helper-spi.h     |   3 +-
 arch/mips/include/asm/octeon/cvmx-helper-xaui.h    |   3 +-
 arch/mips/include/asm/octeon/cvmx-helper.h         |  14 +-
 arch/mips/include/asm/pgalloc.h                    |  16 +-
 arch/mips/include/asm/r4kcache.h                   |  61 +-
 arch/mips/include/asm/smp.h                        |  10 +-
 arch/mips/include/asm/stackframe.h                 |  19 +-
 arch/mips/include/asm/switch_to.h                  |  18 +-
 arch/mips/include/asm/thread_info.h                |   1 -
 arch/mips/include/asm/tlbex.h                      |  26 +
 arch/mips/include/asm/uaccess.h                    |  18 +
 arch/mips/include/asm/uasm.h                       |   5 +
 arch/mips/include/asm/unaligned.h                  |  28 -
 arch/mips/jazz/jazzdma.c                           |   2 +-
 arch/mips/jz4740/gpio.c                            |   2 +-
 arch/mips/jz4740/prom.c                            |   1 -
 arch/mips/jz4740/timer.c                           |   3 +-
 arch/mips/kernel/Makefile                          |   4 +-
 arch/mips/kernel/asm-offsets.c                     |   2 +-
 arch/mips/kernel/cacheinfo.c                       |  87 ++
 arch/mips/kernel/cpu-bugs64.c                      |  24 +-
 arch/mips/kernel/crash.c                           |   2 +-
 arch/mips/kernel/entry.S                           |  18 -
 arch/mips/kernel/genex.S                           |  81 +-
 arch/mips/kernel/irq.c                             |  11 +
 arch/mips/kernel/linux32.c                         |  11 +-
 arch/mips/kernel/machine_kexec.c                   |  22 +
 arch/mips/kernel/mcount.S                          |   3 +
 arch/mips/kernel/mips-mt-fpaff.c                   |   5 +-
 arch/mips/kernel/mips-r2-to-r6-emul.c              |  12 +-
 arch/mips/kernel/mips_ksyms.c                      |  94 ---
 arch/mips/kernel/perf_event_mipsxx.c               |  55 +-
 arch/mips/kernel/process.c                         | 214 +++--
 arch/mips/kernel/prom.c                            |   7 +
 arch/mips/kernel/ptrace.c                          |  34 +-
 arch/mips/kernel/r2300_switch.S                    |   2 +
 arch/mips/kernel/r4k_switch.S                      |   3 +
 arch/mips/kernel/relocate.c                        |  56 +-
 arch/mips/kernel/setup.c                           |  94 ++-
 arch/mips/kernel/smp-bmips.c                       |   2 +-
 arch/mips/kernel/smp-cps.c                         |   7 +-
 arch/mips/kernel/smp.c                             |  34 +-
 arch/mips/kernel/sync-r4k.c                        |   4 +-
 arch/mips/kernel/syscall.c                         |  12 +-
 arch/mips/kernel/traps.c                           |  65 +-
 arch/mips/kernel/uprobes.c                         |   2 +-
 arch/mips/kernel/vmlinux.lds.S                     |   2 +-
 arch/mips/lantiq/irq.c                             |  36 +-
 arch/mips/lantiq/prom.c                            |   6 +
 arch/mips/lantiq/xway/dma.c                        |  41 +-
 arch/mips/lantiq/xway/gptu.c                       |   3 +-
 arch/mips/lantiq/xway/sysctrl.c                    |  12 +-
 arch/mips/lasat/at93c.c                            |   1 -
 arch/mips/lasat/sysctl.c                           |   1 -
 arch/mips/lib/csum_partial.S                       |   6 +
 arch/mips/lib/memcpy.S                             |   9 +
 arch/mips/lib/memset.S                             |   5 +
 arch/mips/lib/strlen_user.S                        |   4 +
 arch/mips/lib/strncpy_user.S                       |   7 +
 arch/mips/lib/strnlen_user.S                       |   7 +
 arch/mips/loongson32/common/platform.c             |  45 +-
 arch/mips/loongson32/ls1b/board.c                  |   7 +-
 arch/mips/loongson32/ls1c/board.c                  |   7 +-
 arch/mips/loongson64/common/cs5536/cs5536_mfgpt.c  |   2 +-
 arch/mips/loongson64/common/dma-swiotlb.c          |  20 +-
 arch/mips/loongson64/common/env.c                  |   2 +-
 arch/mips/loongson64/common/setup.c                |   3 +-
 arch/mips/loongson64/common/uart_base.c            |   2 +-
 arch/mips/loongson64/lemote-2f/ec_kb3310b.c        |   3 +-
 arch/mips/loongson64/lemote-2f/irq.c               |   3 +-
 arch/mips/loongson64/lemote-2f/pm.c                |   2 +-
 arch/mips/loongson64/loongson-3/irq.c              |   2 +-
 arch/mips/loongson64/loongson-3/numa.c             |   2 +-
 arch/mips/loongson64/loongson-3/smp.c              |   1 -
 arch/mips/mm/Makefile                              |   2 +-
 arch/mips/mm/c-r4k.c                               |   6 +-
 arch/mips/mm/init.c                                |   3 +
 arch/mips/mm/mmap.c                                |  10 +-
 arch/mips/mm/page-funcs.S                          |   3 +
 arch/mips/mm/page.c                                |   2 +
 arch/mips/mm/pgtable-64.c                          |   2 +
 arch/mips/mm/pgtable.c                             |  25 +
 arch/mips/mm/sc-ip22.c                             |  54 +-
 arch/mips/mm/sc-mips.c                             |   1 +
 arch/mips/mm/tlbex.c                               |  44 +-
 arch/mips/mti-malta/malta-platform.c               |   1 -
 arch/mips/netlogic/common/irq.c                    |   4 +-
 arch/mips/netlogic/common/smpboot.S                |   4 +-
 arch/mips/netlogic/xlp/wakeup.c                    |   2 +-
 arch/mips/oprofile/op_model_mipsxx.c               |  40 +-
 arch/mips/pci/pci-tx4927.c                         |  22 +-
 arch/mips/pci/pci-tx4938.c                         |  30 +-
 arch/mips/pci/pci-tx4939.c                         |  10 +-
 arch/mips/pic32/pic32mzda/Makefile                 |   5 +-
 arch/mips/pmcs-msp71xx/msp_prom.c                  |   2 +-
 arch/mips/pmcs-msp71xx/msp_time.c                  |   1 -
 arch/mips/ralink/Kconfig                           |   1 +
 arch/mips/ralink/clk.c                             |   9 +-
 arch/mips/ralink/irq.c                             |   4 +-
 arch/mips/ralink/mt7620.c                          |  32 +-
 arch/mips/ralink/mt7621.c                          |   3 +-
 arch/mips/ralink/of.c                              |  16 +-
 arch/mips/ralink/prom.c                            |   9 +-
 arch/mips/ralink/rt288x.c                          |  12 +-
 arch/mips/ralink/rt305x.c                          |  16 +-
 arch/mips/ralink/rt3883.c                          |  15 +-
 arch/mips/ralink/timer.c                           |  14 -
 arch/mips/rb532/irq.c                              |   1 -
 arch/mips/rb532/prom.c                             |   2 +-
 arch/mips/sgi-ip22/Platform                        |   2 +-
 arch/mips/sgi-ip22/ip22-hpc.c                      |   2 +-
 arch/mips/sgi-ip22/ip22-mc.c                       |   3 +-
 arch/mips/sgi-ip22/ip22-nvram.c                    |   2 +-
 arch/mips/sgi-ip22/ip22-reset.c                    |   1 -
 arch/mips/sgi-ip22/ip22-setup.c                    |   1 -
 arch/mips/sgi-ip27/ip27-berr.c                     |   2 -
 arch/mips/sgi-ip27/ip27-init.c                     |   2 +-
 arch/mips/sgi-ip27/ip27-klnuma.c                   |   2 +-
 arch/mips/sgi-ip27/ip27-memory.c                   |   2 +-
 arch/mips/sgi-ip32/crime.c                         |   2 +-
 arch/mips/sgi-ip32/ip32-irq.c                      |   4 +-
 arch/mips/sibyte/bcm1480/setup.c                   |   2 +-
 arch/mips/sibyte/sb1250/setup.c                    |   2 +-
 arch/mips/txx9/generic/7segled.c                   |   4 +-
 arch/mips/txx9/generic/pci.c                       |  28 +-
 arch/mips/txx9/generic/setup.c                     |   2 +-
 arch/mips/txx9/generic/setup_tx3927.c              |   6 +-
 arch/mips/txx9/generic/setup_tx4927.c              |  20 +-
 arch/mips/txx9/generic/setup_tx4938.c              |  26 +-
 arch/mips/txx9/generic/setup_tx4939.c              |   8 +-
 arch/mips/txx9/generic/smsc_fdc37m81x.c            |  17 +-
 arch/mips/txx9/jmr3927/prom.c                      |   2 +-
 arch/mips/txx9/jmr3927/setup.c                     |  11 +-
 arch/mips/txx9/rbtx4938/setup.c                    |  14 +-
 arch/mips/vdso/Makefile                            |   8 +-
 arch/mips/vr41xx/common/bcu.c                      |   3 +-
 arch/mips/vr41xx/common/cmu.c                      |   2 +-
 arch/mips/vr41xx/common/icu.c                      |   2 +-
 arch/mips/vr41xx/common/irq.c                      |   2 +-
 arch/mips/xilfpga/intc.c                           |   7 +-
 drivers/of/base.c                                  |   2 +-
 drivers/of/fdt.c                                   |   9 +-
 scripts/Kbuild.include                             |   2 +-
 253 files changed, 4089 insertions(+), 1028 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mips/img/pistachio-marduk.txt
 create mode 100644 arch/mips/Makefile.postlink
 create mode 100644 arch/mips/boot/dts/img/Makefile
 create mode 100644 arch/mips/boot/dts/img/pistachio.dtsi
 create mode 100644 arch/mips/boot/dts/img/pistachio_marduk.dts
 create mode 100644 arch/mips/cavium-octeon/octeon-usb.c
 create mode 100644 arch/mips/generic/kexec.c
 create mode 100644 arch/mips/include/asm/asm-prototypes.h
 create mode 100644 arch/mips/include/asm/mach-loongson32/regs-rtc.h
 create mode 100644 arch/mips/include/asm/tlbex.h
 delete mode 100644 arch/mips/include/asm/unaligned.h
 create mode 100644 arch/mips/kernel/cacheinfo.c
 delete mode 100644 arch/mips/kernel/mips_ksyms.c
 create mode 100644 arch/mips/mm/pgtable.c
