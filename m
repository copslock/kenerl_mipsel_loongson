Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Dec 2014 14:27:50 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57041 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007950AbaLKN1ruIoTO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 11 Dec 2014 14:27:47 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sBBDRkYM000919
        for <linux-mips@linux-mips.org>; Thu, 11 Dec 2014 14:27:46 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sBBDRk34000918
        for linux-mips@linux-mips.org; Thu, 11 Dec 2014 14:27:46 +0100
Date:   Thu, 11 Dec 2014 14:27:46 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Subject: MIPS in 3.19
Message-ID: <20141211132746.GF31723@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44619
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

The pull request for 3.19 is out but it's unusually large - I think by
number of patches it may be the largest since the initial pull request
after linux-mips.org switched from CVS to git in 2005 and I send the
pending backlog, like half a year worth of patches to Linux in a single
pull request.

There are several reasons for the size of this pull request.  For one
I've finally able to concentrate on getting this out of the door.  I've
also started to enforce the -rc5 deadline for acceptance of feature
patches for the last two merge windows and again a number of people
missed that window for 3.18 causing a bit of backlog.  And finally, folks
at Broadcom, Imagination, OpenWRT and a few others have opened their
floodgates even a bit more.  Which is great not last because it means
that kernel trees that once for all practical matters were forks are
moving closer to mainline - and that is rewarded with less headache
and yes, Santa might be nice to you instead of refering you to
Knecht Ruprecht ...

But - this pull request has grown so large that it's a potencial problem.
So test, test, test this.  And then test some more!  And when you're done
with the xmas roast, have a cup of coffee and debug some more!

Below the shortlog for the pull request for 3.19.

  Ralf

----------------------------------------------------------------
Aaro Koskinen (13):
      MIPS: oprofile: Enable backtrace on timer-based profiling
      MIPS: oprofile: Backtrace: don't fail on leaf functions
      MIPS: Octeon: Move cvmx_fuse_read_byte()
      MIPS: Octeon: Delete potentially dangerous feature checks
      MIPS: Octeon: Move code to avoid forward declaration
      MIPS: Octeon: Mark octeon_model_get_string() with __init
      MIPS: Loongson: common: Fix array initializer syntax.
      MIPS: Loongson: cs5536_pci: Add a missing include
      MIPS: loongson: common: Setup: add a missing include
      MIPS: loongson: lemote-2f: irq: Make internal data static
      MIPS: loongson: lemote-2f: reset: make ml2f_reboot static
      MIPS: loongson: common: init: Add a missing include
      MIPS: loongson: common: rtc: make loongson_rtc_resources static

Alban Bedel (4):
      MIPS: FW: Fix parsing u-boot environment
      MIPS: FW: Use kstrtoul() to parse unsigned long from the fw environment
      MIPS: ath79: Use the firmware lib to parse the kernel command line
      MIPS: ath79: Read the initrd address from the firmware environment

Andrew Bresticker (46):
      MIPS: Always use IRQ domains for CPU IRQs
      MIPS: Rename mips_cpu_intc_init() -> mips_cpu_irq_of_init()
      MIPS: Provide a generic plat_irq_dispatch
      MIPS: Set vint handler when mapping CPU interrupts
      MIPS: i8259: Use IRQ domains
      MIPS: Add hook to get C0 performance counter interrupt
      MIPS: smp-cps: Enable all hardware interrupts on secondary CPUs
      MIPS: Remove gic_{enable,disable}_interrupt()
      MIPS: SEAD3: Remove sead3-serial.c
      MIPS: sead3: Do not overlap CPU/GIC IRQ ranges
      MIPS: Malta: Move MSC01 interrupt base
      MIPS: Move MIPS_GIC_IRQ_BASE into platform irq.h
      MIPS: Move GIC to drivers/irqchip/
      irqchip: mips-gic: Remove platform irq_ack/irq_eoi callbacks
      irqchip: mips-gic: Implement irq_set_type callback
      irqchip: mips-gic: Fix gic_set_affinity() return value
      irqchip: mips-gic: Use IRQ domains
      irqchip: mips-gic: Stop using per-platform mapping tables
      irqchip: mips-gic: Probe for number of external interrupts
      irqchip: mips-gic: Use separate edge/level irq_chips
      irqchip: mips-gic: Support local interrupts
      irqchip: mips-gic: Remove unnecessary globals
      MIPS: Malta: Use generic plat_irq_dispatch
      MIPS: SEAD3: Use generic plat_irq_dispatch
      MIPS: Malta: Use gic_read_count() to read GIC timer
      irqchip: mips-gic: Export function to read counter width
      MIPS: SEAD3: Stop using GIC REG macros
      MIPS: Malta: Stop using GIC REG macros
      irqchip: mips-gic: Use proper iomem accessors
      MIPS: Move gic.h to include/linux/irqchip/mips-gic.h
      irqchip: mips-gic: Clean up header file
      irqchip: mips-gic: Clean up #includes
      irqchip: mips-gic: Remove gic_{pending,itrmask}_regs
      irqchip: mips-gic: Use GIC_SH_WEDGE_{SET,CLR} macros
      MIPS: Move GIC clocksource driver to drivers/clocksource/
      clocksource: mips-gic: Combine with GIC clockevent driver
      clocksource: mips-gic: Staticize local symbols
      clocksource: mips-gic: Move gic_frequency to clocksource driver
      clocksource: mips-gic: Remove gic_event_handler
      clocksource: mips-gic: Use percpu_dev_id
      clocksource: mips-gic: Use CPU notifiers to setup the timer
      clocksource: mips-gic: Use clockevents_config_and_register
      clocksource: mips-gic: Bump up rating of GIC timer
      of: Add binding document for MIPS GIC
      irqchip: mips-gic: Add device-tree support
      clocksource: mips-gic: Add device-tree support

Eunbong Song (1):
      MIPS: Add arch_trigger_all_cpu_backtrace() function

Huacai Chen (5):
      MIPS: Loongson-3: Add PHYS48_TO_HT40 support
      MIPS: Loongson: Allow booting from any core
      MIPS: Loongson: Improve LEFI firmware interface
      MIPS: Loongson-3: Add oprofile support
      MIPS: Loongson-3: Add RS780/SBX00 HPET support

Isamu Mogi (2):
      MIPS: R3000: Replace magic numbers with macros
      MIPS: R3000: Remove redundant parentheses

Joe Perches (1):
      mips: Convert pr_warning to pr_warn

John Crispin (25):
      MIPS: lantiq: handle vmmc memory reservation
      MIPS: lantiq: add reset-controller api support
      MIPS: lantiq: reboot gphy on restart
      MIPS: lantiq: add support for xrx200 firmware depending on soc type
      MIPS: lantiq: export soc type
      MIPS: lantiq: move eiu init after irq_domain register
      MIPS: lantiq: copy the commandline from the devicetree
      MIPS: lantiq: the detection of the gpe clock is broken
      MIPS: lantiq: add missing spi clock on falcon SoC
      MIPS: ralink: add verbose pmu info
      MIPS: ralink: add a helper for reading the ECO version
      MIPS: ralink: add rt_sysc_m32 helper
      MIPS: ralink: add illegal access driver
      MIPS: ralink: allow manual memory override
      MIPS: ralink: add missing clk_set_rate() to clk.c
      MIPS: ralink: add rt2880 wmac clock
      MIPS: ralink: add rt3883 wmac clock
      MIPS: ralink: add a bootrom dumper module
      MIPS: ralink: copy the commandline from the devicetree
      MIPS: ralink: cleanup the soc specific pinmux data
      MIPS: ralink: cleanup early_printk
      MIPS: ralink: add support for MT7620n
      MIPS: ralink: add mt7628an support
      MIPS: ralink: allow loading irq registers from the devicetree
      MIPS: ralink: add rt2880 pci driver

Jon Fraser (2):
      MIPS: BMIPS: Allow BMIPS3300 to utilize SMP ebase relocation code
      MIPS: BMIPS: Mask off timer IRQs when hot-unplugging a CPU

Joshua Kinard (1):
      MIPS: IP22/IP32: Add line to arch/mips/Makefile archhelp about vmlinux.32

Kelvin Cheung (5):
      MIPS: Loongson1B: Fix reboot problem on LS1B
      MIPS: Loongson1B: Improve early printk
      MIPS: Loongson1B: Some fixes/updates for LS1B
      MIPS: Loongson1B: Add a clockevent/clocksource using PWM Timer
      clk: ls1x: Update relationship among all clocks

Kevin Cernekee (15):
      MIPS: BMIPS: Align secondary boot sequence with latest firmware releases
      MIPS: BMIPS: Introduce helper function to change the reset vector
      MIPS: BMIPS: Explicitly configure reset vectors prior to secondary boot
      MIPS: Allow MIPS_CPU_SCACHE to be used with different line sizes
      MIPS: BMIPS: Select the appropriate L1_CACHE_SHIFT for 438x and 5000 CPUs
      MIPS: BMIPS: Let each platform customize the CPU1 IRQ mask
      MIPS: BMIPS: Add special cache handling in c-r4k.c
      MIPS: BMIPS: Add PRId for BMIPS5200 (Whirlwind)
      MIPS: Create a helper function for DT setup
      Documentation: DT: Add entries for BCM3384 and its peripherals
      Documentation: DT: Add "mti" vendor prefix
      MIPS: bcm3384: Initial commit of bcm3384 platform support
      MAINTAINERS: Add entry for BCM33xx cable chips
      MAINTAINERS: Add entry for bcm63xx/bcm33xx UDC gadget driver
      MAINTAINERS: Add entry for BMIPS multiplatform kernel

Maarten ter Huurne (1):
      MIPS: Remove declaration of obsolete arch_init_clk_ops()

Maciej W. Rozycki (8):
      TC: Error handling clean-ups
      MIPS: Kconfig: Enable microMIPS support for Malta
      MIPS: mm: Only build one microassembler that is suitable
      MIPS: signal.c: Fix an invalid cast in ISA mode bit handling
      MIPS: Kconfig: Only allow 32-bit microMIPS builds
      MIPS: Fix microMIPS LL/SC immediate offsets
      MIPS: Apply `.insn' to fixup labels throughout
      MIPS: atomic.h: Reformat to fit in 79 columns

Markos Chandras (7):
      MIPS: cpu: Add 'noftlb' kernel command line option to disable the FTLB
      MIPS: traps: Replace printk with pr_err for MC exceptions
      MIPS: traps: Dump the HTW registers on a MC exception
      MIPS: traps: Dump the PageGrain and Wired registers on MC
      MIPS: lib: mips-atomic.c: Remove obsolete ifdefery
      MIPS: iomap: Use __mem_{read,write}{b,w,l} for MMIO
      MIPS: lib: memset: Clean up some MIPS{EL,EB} ifdefery

Paul Burton (10):
      binfmt_elf: Hoist ELF program header loading to a function
      binfmt_elf: load interpreter program headers earlier
      binfmt_elf: allow arch code to examine PT_LOPROC ... PT_HIPROC headers
      MIPS: define bits introduced for hybrid FPRs
      MIPS: detect presence of the FRE & UFR bits
      MIPS: Ensure Config5.UFE is clear on boot
      MIPS: Support for hybrid FPRs
      MIPS: ELF: Add definition for the .MIPS.abiflags section
      MIPS: ELF: Set FP mode according to .MIPS.abiflags
      MIPS: Kconfig option to better exercise/debug hybrid FPRs

Prem Karat (1):
      MIPS: Enable VDSO randomization

Rafał Miłecki (7):
      MIPS: BCM47XX: Get rid of calls to KSEG1ADDR
      MIPS: BCM47XX: Make ssb init NVRAM instead of bcm47xx polling it
      MIPS: BCM47XX: Make bcma init NVRAM instead of bcm47xx polling it
      MIPS: BCM47XX: Move SPROM fallback code into sprom.c
      MIPS: BCM47XX: Initialize bcma bus later (with mm available)
      MIPS: BCM47XX: Use mtd as an alternative way/API to get NVRAM content
      MIPS: BCM47XX: Clean up nvram header

Ralf Baechle (10):
      MIPS: Remove useless parentheses
      MIPS: Remove __strlen_user().
      MIPS: DMA: Explain the lack of special handling for R14000/R16000.
      MIPS: uaccess.h: Fix strnlen_user comment.
      MIPS: Remove a temporary hack for debugging cache flushes in SMTC configuration
      MIPS: <asm/types.h> fix indentation.
      PCMCIA: Alchemy Don't select 64BIT_PHYS_ADDR in Kconfig.
      MIPS: Replace MIPS-specific 64BIT_PHYS_ADDR with generic PHYS_ADDR_T_64BIT
      MIPS: Replace use of phys_t with phys_addr_t.
      MIPS: Remove now unused definition of phys_t.

Sergey Ryazanov (17):
      MIPS: NILE4: Remove odd locking in PCI config space access code
      MIPS: MSP71xx: remove odd locking in PCI config space access code
      MIPS: pci-ar7{1x, 24}x: remove odd locking in PCI config space access code
      MIPS: pci-rt3883: Remove odd locking in PCI config space access code
      MIPS: ath25: add common parts
      MIPS: ath25: add basic AR5312 SoC support
      MIPS: ath25: Add basic AR2315 SoC support
      MIPS: ath25: add interrupts handling routines
      MIPS: ath25: add early printk support
      MIPS: ath25: add UART support
      MIPS: ath25: add board configuration detection
      MIPS: ath25: add SoC type detection
      MIPS: ath25: register AR5312 flash controller
      MIPS: ath25: add AR2315 PCI host controller driver
      ath5k: revert AHB bus support removing
      ath5k: update dependencies
      MIPS: ath25: add Wireless device support

Steven J. Hill (3):
      MIPS: Add CP0 macros for extended EntryLo registers
      MIPS: Cosmetic cleanups of page table headers.
      MIPS: Add MFHC0 and MTHC0 instructions to uasm.

Tomeu Vizoso (1):
      MIPS: Alchemy: Remove direct access to prepare_count field of struct clk

 .../bindings/interrupt-controller/mips-gic.txt     |  55 ++
 .../devicetree/bindings/mips/brcm/bcm3384-intc.txt |  37 +
 .../devicetree/bindings/mips/brcm/bmips.txt        |   8 +
 .../devicetree/bindings/mips/brcm/cm-dsl.txt       |  11 +
 .../devicetree/bindings/mips/brcm/usb.txt          |  11 +
 Documentation/devicetree/bindings/mips/cpu_irq.txt |   4 +-
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |  26 +
 arch/mips/Kbuild.platforms                         |   2 +
 arch/mips/Kconfig                                  |  98 ++-
 arch/mips/Kconfig.debug                            |  13 +
 arch/mips/Makefile                                 |   1 +
 arch/mips/alchemy/common/clock.c                   |   7 +-
 arch/mips/alchemy/common/setup.c                   |   6 +-
 arch/mips/ar7/platform.c                           |  24 +-
 arch/mips/ath25/Kconfig                            |  16 +
 arch/mips/ath25/Makefile                           |  16 +
 arch/mips/ath25/Platform                           |   6 +
 arch/mips/ath25/ar2315.c                           | 364 ++++++++++
 arch/mips/ath25/ar2315.h                           |  22 +
 arch/mips/ath25/ar2315_regs.h                      | 410 +++++++++++
 arch/mips/ath25/ar5312.c                           | 393 ++++++++++
 arch/mips/ath25/ar5312.h                           |  22 +
 arch/mips/ath25/ar5312_regs.h                      | 224 ++++++
 arch/mips/ath25/board.c                            | 234 ++++++
 arch/mips/ath25/devices.c                          | 125 ++++
 arch/mips/ath25/devices.h                          |  43 ++
 arch/mips/ath25/early_printk.c                     |  44 ++
 arch/mips/ath25/prom.c                             |  26 +
 arch/mips/ath79/irq.c                              |   1 -
 arch/mips/ath79/prom.c                             |  38 +-
 arch/mips/ath79/setup.c                            |   5 +
 arch/mips/bcm3384/Makefile                         |   1 +
 arch/mips/bcm3384/Platform                         |   7 +
 arch/mips/bcm3384/dma.c                            |  81 +++
 arch/mips/bcm3384/irq.c                            | 193 +++++
 arch/mips/bcm3384/setup.c                          |  97 +++
 arch/mips/bcm47xx/bcm47xx_private.h                |   6 +
 arch/mips/bcm47xx/irq.c                            |   8 +
 arch/mips/bcm47xx/nvram.c                          | 155 ++--
 arch/mips/bcm47xx/setup.c                          |  91 +--
 arch/mips/bcm47xx/sprom.c                          |  82 +++
 arch/mips/bcm63xx/cpu.c                            |   2 +-
 arch/mips/boot/dts/Makefile                        |   1 +
 arch/mips/boot/dts/bcm3384.dtsi                    | 109 +++
 arch/mips/boot/dts/bcm93384wvg.dts                 |  32 +
 arch/mips/cavium-octeon/dma-octeon.c               |   4 +-
 arch/mips/cavium-octeon/executive/octeon-model.c   |  49 +-
 arch/mips/configs/bcm3384_defconfig                |  78 ++
 arch/mips/fw/lib/cmdline.c                         |   8 +-
 arch/mips/include/asm/atomic.h                     | 374 +++++-----
 arch/mips/include/asm/bitops.h                     |  35 +-
 arch/mips/include/asm/bmips.h                      |   1 +
 arch/mips/include/asm/bootinfo.h                   |  13 +-
 arch/mips/include/asm/clock.h                      |   3 -
 arch/mips/include/asm/cmpxchg.h                    |  27 +-
 arch/mips/include/asm/compiler.h                   |   8 +
 arch/mips/include/asm/cpu-features.h               |   4 +
 arch/mips/include/asm/cpu.h                        |   2 +
 arch/mips/include/asm/edac.h                       |   6 +-
 arch/mips/include/asm/elf.h                        |  74 +-
 arch/mips/include/asm/fpu.h                        |  49 +-
 arch/mips/include/asm/futex.h                      |  27 +-
 arch/mips/include/asm/hpet.h                       |  73 ++
 arch/mips/include/asm/io.h                         |   8 +-
 arch/mips/include/asm/irq.h                        |   3 +
 arch/mips/include/asm/irq_cpu.h                    |   4 +-
 arch/mips/include/asm/mach-ath25/ath25_platform.h  |  73 ++
 .../include/asm/mach-ath25/cpu-feature-overrides.h |  64 ++
 arch/mips/include/asm/mach-ath25/dma-coherence.h   |  82 +++
 arch/mips/include/asm/mach-ath25/gpio.h            |  16 +
 arch/mips/include/asm/mach-ath25/war.h             |  25 +
 arch/mips/include/asm/mach-au1x00/ioremap.h        |  10 +-
 arch/mips/include/asm/mach-bcm3384/dma-coherence.h |  48 ++
 arch/mips/include/asm/mach-bcm3384/war.h           |  24 +
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h |  36 +-
 arch/mips/include/asm/mach-bcm63xx/ioremap.h       |   6 +-
 arch/mips/include/asm/mach-generic/ioremap.h       |   4 +-
 arch/mips/include/asm/mach-generic/irq.h           |   6 +
 arch/mips/include/asm/mach-lantiq/lantiq.h         |   2 +
 arch/mips/include/asm/mach-loongson/boot_param.h   |  49 +-
 .../mips/include/asm/mach-loongson/dma-coherence.h |   6 +-
 arch/mips/include/asm/mach-loongson/irq.h          |   3 +-
 arch/mips/include/asm/mach-loongson/loongson.h     |   2 +-
 .../include/asm/mach-loongson/loongson_hwmon.h     |  55 ++
 arch/mips/include/asm/mach-loongson/machine.h      |   2 +-
 arch/mips/include/asm/mach-loongson/topology.h     |   2 +-
 arch/mips/include/asm/mach-loongson/workarounds.h  |   7 +
 arch/mips/include/asm/mach-loongson1/cpufreq.h     |  23 +
 arch/mips/include/asm/mach-loongson1/loongson1.h   |   8 +-
 arch/mips/include/asm/mach-loongson1/platform.h    |  10 +-
 arch/mips/include/asm/mach-loongson1/regs-clk.h    |  23 +-
 arch/mips/include/asm/mach-loongson1/regs-mux.h    |  67 ++
 arch/mips/include/asm/mach-loongson1/regs-pwm.h    |  29 +
 arch/mips/include/asm/mach-loongson1/regs-wdt.h    |  11 +-
 arch/mips/include/asm/mach-malta/irq.h             |   1 -
 .../include/asm/mach-pmcs-msp71xx/msp_regops.h     |  25 +-
 arch/mips/include/asm/mach-ralink/mt7620.h         |  64 +-
 arch/mips/include/asm/mach-ralink/pinmux.h         |  55 ++
 arch/mips/include/asm/mach-ralink/ralink_regs.h    |   7 +
 arch/mips/include/asm/mach-ralink/rt305x.h         |  35 +-
 arch/mips/include/asm/mach-ralink/rt3883.h         |  16 +-
 arch/mips/include/asm/mach-sead3/irq.h             |   1 -
 arch/mips/include/asm/mach-tx39xx/ioremap.h        |   4 +-
 arch/mips/include/asm/mach-tx49xx/ioremap.h        |   4 +-
 arch/mips/include/asm/mips-boards/maltaint.h       |  24 +-
 arch/mips/include/asm/mips-boards/sead3int.h       |  15 +-
 arch/mips/include/asm/mips-cm.h                    |   2 +-
 arch/mips/include/asm/mips-cpc.h                   |   4 +-
 arch/mips/include/asm/mipsregs.h                   |  43 ++
 arch/mips/include/asm/octeon/cvmx-cmd-queue.h      |   4 +-
 arch/mips/include/asm/octeon/cvmx-pow.h            |  69 +-
 arch/mips/include/asm/octeon/cvmx.h                |  63 --
 arch/mips/include/asm/octeon/octeon-feature.h      |  52 --
 arch/mips/include/asm/octeon/octeon-model.h        |   3 +-
 arch/mips/include/asm/paccess.h                    |   2 +
 arch/mips/include/asm/page.h                       |   2 +-
 arch/mips/include/asm/pci.h                        |   2 +-
 arch/mips/include/asm/pgtable-32.h                 | 104 +--
 arch/mips/include/asm/pgtable-bits.h               |  36 +-
 arch/mips/include/asm/pgtable.h                    |  18 +-
 arch/mips/include/asm/prom.h                       |   1 +
 arch/mips/include/asm/r4kcache.h                   |  59 --
 arch/mips/include/asm/spinlock.h                   |  50 +-
 arch/mips/include/asm/thread_info.h                |   2 +
 arch/mips/include/asm/time.h                       |   6 +-
 arch/mips/include/asm/types.h                      |  18 +-
 arch/mips/include/asm/uaccess.h                    |  33 +-
 arch/mips/include/asm/uasm.h                       |   2 +
 arch/mips/include/uapi/asm/inst.h                  |   7 +-
 arch/mips/jz4740/setup.c                           |   2 +-
 arch/mips/kernel/Makefile                          |  10 +-
 arch/mips/kernel/cevt-gic.c                        | 105 ---
 arch/mips/kernel/cevt-r4k.c                        |   6 +-
 arch/mips/kernel/cpu-probe.c                       |  71 +-
 arch/mips/kernel/crash_dump.c                      |   4 +-
 arch/mips/kernel/csrc-gic.c                        |  40 --
 arch/mips/kernel/elf.c                             | 191 +++++
 arch/mips/kernel/i8259.c                           |  24 +-
 arch/mips/kernel/irq-gic.c                         | 402 -----------
 arch/mips/kernel/irq_cpu.c                         |  48 +-
 arch/mips/kernel/mips-cm.c                         |  12 +-
 arch/mips/kernel/mips-cpc.c                        |   4 +-
 arch/mips/kernel/mips_ksyms.c                      |   4 -
 arch/mips/kernel/perf_event_mipsxx.c               |  30 +-
 arch/mips/kernel/process.c                         |  54 +-
 arch/mips/kernel/prom.c                            |  18 +
 arch/mips/kernel/setup.c                           |  12 +-
 arch/mips/kernel/signal.c                          |   2 +-
 arch/mips/kernel/smp-bmips.c                       | 114 +--
 arch/mips/kernel/smp-cmp.c                         |   2 +-
 arch/mips/kernel/smp-cps.c                         |   6 +-
 arch/mips/kernel/smp-gic.c                         |   2 +-
 arch/mips/kernel/smp-mt.c                          |   6 +-
 arch/mips/kernel/syscall.c                         |   2 +
 arch/mips/kernel/traps.c                           |  66 +-
 arch/mips/kernel/vdso.c                            |  15 +-
 arch/mips/lantiq/falcon/sysctrl.c                  |  11 +-
 arch/mips/lantiq/irq.c                             |  56 +-
 arch/mips/lantiq/prom.c                            |  18 +-
 arch/mips/lantiq/xway/Makefile                     |   2 +
 arch/mips/lantiq/xway/reset.c                      |  70 +-
 arch/mips/lantiq/xway/vmmc.c                       |  69 ++
 arch/mips/lantiq/xway/xrx200_phy_fw.c              |  23 +-
 arch/mips/lib/iomap.c                              |  18 +-
 arch/mips/lib/memset.S                             |   6 +-
 arch/mips/lib/mips-atomic.c                        |  20 -
 arch/mips/lib/r3k_dump_tlb.c                       |  11 +-
 arch/mips/lib/strlen_user.S                        |   3 -
 arch/mips/loongson/Kconfig                         |  17 +
 arch/mips/loongson/common/cs5536/cs5536_pci.c      |  25 +-
 arch/mips/loongson/common/dma-swiotlb.c            |  14 +
 arch/mips/loongson/common/early_printk.c           |   2 +-
 arch/mips/loongson/common/env.c                    |  28 +-
 arch/mips/loongson/common/gpio.c                   |   2 +-
 arch/mips/loongson/common/init.c                   |   1 +
 arch/mips/loongson/common/machtype.c               |  23 +-
 arch/mips/loongson/common/rtc.c                    |   2 +-
 arch/mips/loongson/common/serial.c                 |  66 +-
 arch/mips/loongson/common/setup.c                  |   1 +
 arch/mips/loongson/common/time.c                   |   5 +
 arch/mips/loongson/common/uart_base.c              |  30 +-
 arch/mips/loongson/lemote-2f/irq.c                 |   4 +-
 arch/mips/loongson/lemote-2f/reset.c               |   2 +-
 arch/mips/loongson/loongson-3/Makefile             |   4 +-
 arch/mips/loongson/loongson-3/hpet.c               | 257 +++++++
 arch/mips/loongson/loongson-3/irq.c                |  16 +-
 arch/mips/loongson/loongson-3/numa.c               |  12 +-
 arch/mips/loongson/loongson-3/platform.c           |  43 ++
 arch/mips/loongson/loongson-3/smp.c                |  70 +-
 arch/mips/loongson1/Kconfig                        |  42 +-
 arch/mips/loongson1/common/Makefile                |   2 +-
 arch/mips/loongson1/common/clock.c                 |  28 -
 arch/mips/loongson1/common/platform.c              | 141 +++-
 arch/mips/loongson1/common/prom.c                  |  30 +-
 arch/mips/loongson1/common/reset.c                 |  20 +-
 arch/mips/loongson1/common/time.c                  | 226 ++++++
 arch/mips/loongson1/ls1b/board.c                   |  12 +-
 arch/mips/math-emu/cp1emu.c                        |   9 +-
 arch/mips/math-emu/ieee754dp.c                     |   2 +-
 arch/mips/math-emu/ieee754sp.c                     |   2 +-
 arch/mips/mm/Makefile                              |  10 +-
 arch/mips/mm/c-r4k.c                               |  43 ++
 arch/mips/mm/dma-default.c                         |   5 +
 arch/mips/mm/gup.c                                 |   2 +-
 arch/mips/mm/init.c                                |   2 +-
 arch/mips/mm/ioremap.c                             |  18 +-
 arch/mips/mm/sc-r5k.c                              |   2 +-
 arch/mips/mm/tlb-r4k.c                             |   2 +-
 arch/mips/mm/tlbex.c                               |  18 +-
 arch/mips/mm/uasm-mips.c                           |   2 +
 arch/mips/mm/uasm.c                                |  14 +-
 arch/mips/mti-malta/malta-init.c                   |   2 +-
 arch/mips/mti-malta/malta-int.c                    | 327 ++-------
 arch/mips/mti-malta/malta-time.c                   |  51 +-
 arch/mips/mti-sead3/sead3-ehci.c                   |   8 +-
 arch/mips/mti-sead3/sead3-int.c                    | 131 +---
 arch/mips/mti-sead3/sead3-net.c                    |  14 +-
 arch/mips/mti-sead3/sead3-platform.c               |  18 +-
 arch/mips/mti-sead3/sead3-serial.c                 |  45 --
 arch/mips/mti-sead3/sead3-time.c                   |  35 +-
 arch/mips/oprofile/Makefile                        |   1 +
 arch/mips/oprofile/backtrace.c                     |   5 +-
 arch/mips/oprofile/common.c                        |  11 +-
 arch/mips/oprofile/op_model_loongson3.c            | 220 ++++++
 arch/mips/oprofile/op_model_mipsxx.c               |  18 +-
 arch/mips/pci/Makefile                             |   2 +
 arch/mips/pci/ops-bcm63xx.c                        |   2 +-
 arch/mips/pci/ops-nile4.c                          |  12 +-
 arch/mips/pci/ops-pmcmsp.c                         |  12 -
 arch/mips/pci/pci-ar2315.c                         | 511 +++++++++++++
 arch/mips/pci/pci-ar71xx.c                         |  13 -
 arch/mips/pci/pci-ar724x.c                         |  23 -
 arch/mips/pci/pci-rt2880.c                         | 285 ++++++++
 arch/mips/pci/pci-rt3883.c                         |   9 -
 arch/mips/pci/pci-tx4939.c                         |   2 +-
 arch/mips/pmcs-msp71xx/msp_prom.c                  |   2 +-
 arch/mips/ralink/Kconfig                           |   3 +-
 arch/mips/ralink/Makefile                          |   4 +
 arch/mips/ralink/bootrom.c                         |  48 ++
 arch/mips/ralink/clk.c                             |   6 +
 arch/mips/ralink/common.h                          |  19 -
 arch/mips/ralink/early_printk.c                    |  45 +-
 arch/mips/ralink/ill_acc.c                         |  87 +++
 arch/mips/ralink/irq.c                             |  45 +-
 arch/mips/ralink/mt7620.c                          | 465 ++++++++----
 arch/mips/ralink/of.c                              |  32 +-
 arch/mips/ralink/prom.c                            |   1 +
 arch/mips/ralink/rt288x.c                          |  65 +-
 arch/mips/ralink/rt305x.c                          | 153 ++--
 arch/mips/ralink/rt3883.c                          | 174 ++---
 arch/mips/rb532/gpio.c                             |   2 +-
 arch/mips/rb532/prom.c                             |   8 +-
 arch/mips/sgi-ip22/ip22-mc.c                       |   6 +-
 arch/mips/sgi-ip22/ip28-berr.c                     |   6 +-
 arch/mips/sgi-ip27/ip27-klnuma.c                   |   5 +-
 arch/mips/sgi-ip27/ip27-memory.c                   |   5 +-
 arch/mips/sibyte/common/cfe.c                      |   8 +-
 arch/mips/sibyte/swarm/platform.c                  |   2 +-
 arch/mips/sibyte/swarm/rtc_m41t81.c                |   4 +-
 arch/mips/sibyte/swarm/rtc_xicor1241.c             |   4 +-
 arch/mips/sibyte/swarm/setup.c                     |   2 +-
 arch/mips/txx9/generic/setup_tx4927.c              |   4 +-
 arch/mips/txx9/generic/setup_tx4938.c              |   4 +-
 arch/mips/txx9/generic/setup_tx4939.c              |   4 +-
 drivers/bcma/driver_mips.c                         |  13 +-
 drivers/clk/clk-ls1x.c                             | 109 ++-
 drivers/clocksource/Kconfig                        |   5 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/mips-gic-timer.c               | 166 +++++
 drivers/dma/txx9dmac.c                             |   2 +-
 drivers/dma/txx9dmac.h                             |   4 +-
 drivers/irqchip/Kconfig                            |   4 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-mips-gic.c                     | 789 +++++++++++++++++++++
 drivers/net/wireless/ath/ath5k/Kconfig             |  14 +-
 drivers/net/wireless/ath/ath5k/Makefile            |   1 +
 drivers/net/wireless/ath/ath5k/ahb.c               | 234 ++++++
 drivers/net/wireless/ath/ath5k/ath5k.h             |  28 +
 drivers/net/wireless/ath/ath5k/base.c              |  14 +
 drivers/net/wireless/ath/ath5k/led.c               |   6 +
 drivers/pcmcia/Kconfig                             |   2 -
 drivers/ssb/driver_mipscore.c                      |  14 +-
 drivers/tc/tc.c                                    |  36 +-
 fs/Kconfig.binfmt                                  |   3 +
 fs/binfmt_elf.c                                    | 238 +++++--
 .../dt-bindings/interrupt-controller/mips-gic.h    |   9 +
 include/linux/elf.h                                |   5 +
 .../asm/gic.h => include/linux/irqchip/mips-gic.h  | 267 ++-----
 289 files changed, 9837 insertions(+), 3447 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mips-gic.txt
 create mode 100644 Documentation/devicetree/bindings/mips/brcm/bcm3384-intc.txt
 create mode 100644 Documentation/devicetree/bindings/mips/brcm/bmips.txt
 create mode 100644 Documentation/devicetree/bindings/mips/brcm/cm-dsl.txt
 create mode 100644 Documentation/devicetree/bindings/mips/brcm/usb.txt
 create mode 100644 arch/mips/ath25/Kconfig
 create mode 100644 arch/mips/ath25/Makefile
 create mode 100644 arch/mips/ath25/Platform
 create mode 100644 arch/mips/ath25/ar2315.c
 create mode 100644 arch/mips/ath25/ar2315.h
 create mode 100644 arch/mips/ath25/ar2315_regs.h
 create mode 100644 arch/mips/ath25/ar5312.c
 create mode 100644 arch/mips/ath25/ar5312.h
 create mode 100644 arch/mips/ath25/ar5312_regs.h
 create mode 100644 arch/mips/ath25/board.c
 create mode 100644 arch/mips/ath25/devices.c
 create mode 100644 arch/mips/ath25/devices.h
 create mode 100644 arch/mips/ath25/early_printk.c
 create mode 100644 arch/mips/ath25/prom.c
 create mode 100644 arch/mips/bcm3384/Makefile
 create mode 100644 arch/mips/bcm3384/Platform
 create mode 100644 arch/mips/bcm3384/dma.c
 create mode 100644 arch/mips/bcm3384/irq.c
 create mode 100644 arch/mips/bcm3384/setup.c
 create mode 100644 arch/mips/boot/dts/bcm3384.dtsi
 create mode 100644 arch/mips/boot/dts/bcm93384wvg.dts
 create mode 100644 arch/mips/configs/bcm3384_defconfig
 create mode 100644 arch/mips/include/asm/hpet.h
 create mode 100644 arch/mips/include/asm/mach-ath25/ath25_platform.h
 create mode 100644 arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-ath25/dma-coherence.h
 create mode 100644 arch/mips/include/asm/mach-ath25/gpio.h
 create mode 100644 arch/mips/include/asm/mach-ath25/war.h
 create mode 100644 arch/mips/include/asm/mach-bcm3384/dma-coherence.h
 create mode 100644 arch/mips/include/asm/mach-bcm3384/war.h
 create mode 100644 arch/mips/include/asm/mach-loongson/loongson_hwmon.h
 create mode 100644 arch/mips/include/asm/mach-loongson/workarounds.h
 create mode 100644 arch/mips/include/asm/mach-loongson1/cpufreq.h
 create mode 100644 arch/mips/include/asm/mach-loongson1/regs-mux.h
 create mode 100644 arch/mips/include/asm/mach-loongson1/regs-pwm.h
 create mode 100644 arch/mips/include/asm/mach-ralink/pinmux.h
 delete mode 100644 arch/mips/kernel/cevt-gic.c
 delete mode 100644 arch/mips/kernel/csrc-gic.c
 create mode 100644 arch/mips/kernel/elf.c
 delete mode 100644 arch/mips/kernel/irq-gic.c
 create mode 100644 arch/mips/lantiq/xway/vmmc.c
 create mode 100644 arch/mips/loongson/loongson-3/hpet.c
 create mode 100644 arch/mips/loongson/loongson-3/platform.c
 delete mode 100644 arch/mips/loongson1/common/clock.c
 create mode 100644 arch/mips/loongson1/common/time.c
 delete mode 100644 arch/mips/mti-sead3/sead3-serial.c
 create mode 100644 arch/mips/oprofile/op_model_loongson3.c
 create mode 100644 arch/mips/pci/pci-ar2315.c
 create mode 100644 arch/mips/pci/pci-rt2880.c
 create mode 100644 arch/mips/ralink/bootrom.c
 create mode 100644 arch/mips/ralink/ill_acc.c
 create mode 100644 drivers/clocksource/mips-gic-timer.c
 create mode 100644 drivers/irqchip/irq-mips-gic.c
 create mode 100644 drivers/net/wireless/ath/ath5k/ahb.c
 create mode 100644 include/dt-bindings/interrupt-controller/mips-gic.h
 rename arch/mips/include/asm/gic.h => include/linux/irqchip/mips-gic.h (50%)
