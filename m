Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Dec 2008 23:32:39 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:47905 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24207776AbYLKXce (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Dec 2008 23:32:34 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4941a2fe0000>; Thu, 11 Dec 2008 18:32:14 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 11 Dec 2008 15:32:06 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 11 Dec 2008 15:32:06 -0800
Message-ID: <4941A2F5.1010202@caviumnetworks.com>
Date:	Thu, 11 Dec 2008 15:32:05 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
MIME-Version: 1.0
To:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 00/20] Add Cavium OCTEON processor support (v6).
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Dec 2008 23:32:06.0239 (UTC) FILETIME=[ADC096F0:01C95BE8]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This is the sixth revision of the patch set introduces preliminary
support for Cavium Networks' OCTEON processor family.  More (but not
detailed) information about these processors may be obtained here:

http://www.caviumnetworks.com/OCTEON_MIPS64.html

These patches depend on the '[PATCH 0/4] serial: Patches for OCTEON
CPU support (version 2).' set that Alan Cox already has queued up.
They can be seen here:

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=4934774E.6080805%40caviumnetworks.com

This initial patch set adds support for booting an initramfs to a
serial console.  Follow-on patch sets will add support for the on-chip
Compact Flash, ethernet, USB, PCI, PCIe, I2c and other peripherals.

With this sixth revision of the patches I think we have address all
the issues explicitly flagged as objectionable in the preceding
revisions.  The main change from the previous set is the addition of a
clock source driver.  Previously the clock source had been broken.

20 patches to follow as replies.

David Daney (20):
  MIPS: Add Cavium OCTEON processor CSR definitions
  MIPS: Add Cavium OCTEON processor support files to
    arch/mips/cavium-octeon/executive and asm/octeon.
  MIPS: Add Cavium OCTEON processor support files to
    arch/mips/cavium-octeon.
  MIPS: For Cavium OCTEON handle hazards as per the R10000 handling.
  MIPS: For Cavium OCTEON set hwrena and lazily restore CP2 state.
  MIPS: Add Cavium OCTEON specific register definitions to mipsregs.h
  MIPS: Override assembler target architecture for octeon.
  MIPS: Add Cavium OCTEON processor constants and CPU probe.
  MIPS: Hook Cavium OCTEON cache init into cache.c
  MIPS: Hook up Cavium OCTEON in arch/mips.
  MIPS: Modify core io.h macros to account for the Octeon Errata
    Core-301.
  MIPS: Add Cavium OCTEON cop2/cvmseg state entries to processor.h.
  MIPS: Add Cavium OCTEON specific registers to ptrace.h and
    asm-offsets.c
  MIPS: Add SMP_ICACHE_FLUSH for the Cavium CPU family.
  MIPS: Cavium OCTEON multiplier state preservation.
  MIPS:  Compute branch returns for Cavium OCTEON specific branch
    instructions.
  MIPS: Add Cavium OCTEON slot into proper tlb category.
  MIPS: Adjust the dma-common.c platform hooks.
  MIPS: Add defconfig for Cavium OCTEON.
  MIPS: Add Cavium OCTEON to arch/mips/Kconfig

 arch/mips/Kconfig                                  |   63 +-
 arch/mips/Makefile                                 |   16 +
 arch/mips/cavium-octeon/Kconfig                    |   85 +
 arch/mips/cavium-octeon/Makefile                   |   16 +
 arch/mips/cavium-octeon/csrc-octeon.c              |   51 +
 arch/mips/cavium-octeon/dma-octeon.c               |   32 +
 arch/mips/cavium-octeon/executive/Makefile         |   13 +
 arch/mips/cavium-octeon/executive/cvmx-bootmem.c   |  586 ++++++
 arch/mips/cavium-octeon/executive/cvmx-l2c.c       |  734 +++++++
 arch/mips/cavium-octeon/executive/cvmx-sysinfo.c   |  116 ++
 arch/mips/cavium-octeon/executive/octeon-model.c   |  340 ++++
 arch/mips/cavium-octeon/flash_setup.c              |   84 +
 arch/mips/cavium-octeon/octeon-irq.c               |  496 +++++
 arch/mips/cavium-octeon/octeon-memcpy.S            |  521 +++++
 arch/mips/cavium-octeon/serial.c                   |  136 ++
 arch/mips/cavium-octeon/setup.c                    |  934 +++++++++
 arch/mips/cavium-octeon/smp.c                      |  211 ++
 arch/mips/configs/cavium-octeon_defconfig          |  943 +++++++++
 arch/mips/include/asm/cpu-features.h               |    3 +
 arch/mips/include/asm/cpu.h                        |   14 +
 arch/mips/include/asm/hazards.h                    |    4 +-
 arch/mips/include/asm/io.h                         |   14 +
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |   58 +
 .../include/asm/mach-cavium-octeon/dma-coherence.h |   64 +
 arch/mips/include/asm/mach-cavium-octeon/irq.h     |  244 +++
 .../asm/mach-cavium-octeon/kernel-entry-init.h     |  131 ++
 arch/mips/include/asm/mach-cavium-octeon/war.h     |   26 +
 arch/mips/include/asm/mach-generic/dma-coherence.h |   26 +-
 arch/mips/include/asm/mach-ip27/dma-coherence.h    |   26 +-
 arch/mips/include/asm/mach-ip32/dma-coherence.h    |   26 +-
 arch/mips/include/asm/mach-jazz/dma-coherence.h    |   26 +-
 arch/mips/include/asm/mach-lemote/dma-coherence.h  |   26 +-
 arch/mips/include/asm/mipsregs.h                   |   22 +
 arch/mips/include/asm/module.h                     |    2 +
 arch/mips/include/asm/octeon/cvmx-asm.h            |  128 ++
 arch/mips/include/asm/octeon/cvmx-bootinfo.h       |  262 +++
 arch/mips/include/asm/octeon/cvmx-bootmem.h        |  288 +++
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h       | 1616 ++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-gpio-defs.h      |  219 +++
 arch/mips/include/asm/octeon/cvmx-iob-defs.h       |  530 ++++++
 arch/mips/include/asm/octeon/cvmx-ipd-defs.h       |  877 +++++++++
 arch/mips/include/asm/octeon/cvmx-l2c-defs.h       |  963 ++++++++++
 arch/mips/include/asm/octeon/cvmx-l2c.h            |  325 ++++
 arch/mips/include/asm/octeon/cvmx-l2d-defs.h       |  369 ++++
 arch/mips/include/asm/octeon/cvmx-l2t-defs.h       |  141 ++
 arch/mips/include/asm/octeon/cvmx-led-defs.h       |  240 +++
 arch/mips/include/asm/octeon/cvmx-mio-defs.h       | 2004 ++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-packet.h         |   61 +
 arch/mips/include/asm/octeon/cvmx-platform.h       |   56 +
 arch/mips/include/asm/octeon/cvmx-pow-defs.h       |  698 +++++++
 arch/mips/include/asm/octeon/cvmx-spinlock.h       |  232 +++
 arch/mips/include/asm/octeon/cvmx-sysinfo.h        |  152 ++
 arch/mips/include/asm/octeon/cvmx.h                |  503 +++++
 arch/mips/include/asm/octeon/octeon-feature.h      |  119 ++
 arch/mips/include/asm/octeon/octeon-model.h        |  276 +++
 arch/mips/include/asm/octeon/octeon.h              |  248 +++
 arch/mips/include/asm/processor.h                  |   69 +
 arch/mips/include/asm/ptrace.h                     |    4 +
 arch/mips/include/asm/smp.h                        |    3 +
 arch/mips/include/asm/stackframe.h                 |   17 +
 arch/mips/kernel/Makefile                          |    1 +
 arch/mips/kernel/asm-offsets.c                     |   31 +
 arch/mips/kernel/branch.c                          |   33 +
 arch/mips/kernel/cpu-probe.c                       |   25 +
 arch/mips/kernel/genex.S                           |    4 +
 arch/mips/kernel/octeon_switch.S                   |  506 +++++
 arch/mips/kernel/traps.c                           |   21 +
 arch/mips/lib/Makefile                             |    1 +
 arch/mips/mm/Makefile                              |    1 +
 arch/mips/mm/c-octeon.c                            |  307 +++
 arch/mips/mm/cache.c                               |    6 +
 arch/mips/mm/cex-oct.S                             |   70 +
 arch/mips/mm/dma-default.c                         |   25 +-
 arch/mips/mm/tlbex.c                               |    1 +
 74 files changed, 17497 insertions(+), 24 deletions(-)
 create mode 100644 arch/mips/cavium-octeon/Kconfig
 create mode 100644 arch/mips/cavium-octeon/Makefile
 create mode 100644 arch/mips/cavium-octeon/csrc-octeon.c
 create mode 100644 arch/mips/cavium-octeon/dma-octeon.c
 create mode 100644 arch/mips/cavium-octeon/executive/Makefile
 create mode 100644 arch/mips/cavium-octeon/executive/cvmx-bootmem.c
 create mode 100644 arch/mips/cavium-octeon/executive/cvmx-l2c.c
 create mode 100644 arch/mips/cavium-octeon/executive/cvmx-sysinfo.c
 create mode 100644 arch/mips/cavium-octeon/executive/octeon-model.c
 create mode 100644 arch/mips/cavium-octeon/flash_setup.c
 create mode 100644 arch/mips/cavium-octeon/octeon-irq.c
 create mode 100644 arch/mips/cavium-octeon/octeon-memcpy.S
 create mode 100644 arch/mips/cavium-octeon/serial.c
 create mode 100644 arch/mips/cavium-octeon/setup.c
 create mode 100644 arch/mips/cavium-octeon/smp.c
 create mode 100644 arch/mips/configs/cavium-octeon_defconfig
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/irq.h
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
 create mode 100644 arch/mips/include/asm/mach-cavium-octeon/war.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-asm.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-bootinfo.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-bootmem.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-ciu-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-gpio-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-iob-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-ipd-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-l2c-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-l2c.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-l2d-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-l2t-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-led-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-mio-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-packet.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-platform.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-pow-defs.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-spinlock.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx-sysinfo.h
 create mode 100644 arch/mips/include/asm/octeon/cvmx.h
 create mode 100644 arch/mips/include/asm/octeon/octeon-feature.h
 create mode 100644 arch/mips/include/asm/octeon/octeon-model.h
 create mode 100644 arch/mips/include/asm/octeon/octeon.h
 create mode 100644 arch/mips/kernel/octeon_switch.S
 create mode 100644 arch/mips/mm/c-octeon.c
 create mode 100644 arch/mips/mm/cex-oct.S
