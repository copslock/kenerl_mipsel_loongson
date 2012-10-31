Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 16:27:01 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:54088 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6822164Ab2JaPR2G8Tze convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Oct 2012 16:17:28 +0100
Received: from ::ffff:173.33.185.184 ([173.33.185.184]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 31 Oct 2012 08:17:17 -0700
From:   Sanjay Lal <sanjayl@kymasys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 00/20] KVM for MIPS32 Processors
Date:   Wed, 31 Oct 2012 11:17:13 -0400
Message-Id: <C5B4CB07-2946-4536-9854-9F66893D2C2B@kymasys.com>
To:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Mime-Version: 1.0 (Apple Message framework v1283)
X-Mailer: Apple Mail (2.1283)
X-archive-position: 34833
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

The following patchset implements KVM support for MIPS32R2 processors,
using Trap & Emulate, with basic runtime binary translation to improve
performance.  The goal has been to keep the Guest kernel changes to a
minimum.

The patch is against Linux 3.7-rc2.  

There is a companion patchset for QEMU that adds KVM support for the 
MIPS target.

KVM/MIPS should support MIPS32-R2 processors and beyond.
It has been tested on the following platforms:
  - Malta Board with FPGA based 34K (Little Endian).
  - Sigma Designs TangoX board with a 24K based 8654 SoC (Little Endian).
  - Malta Board with 74K @ 1GHz (Little Endian).
  - OVPSim MIPS simulator from Imperas emulating a Malta board with 
    24Kc and 1074Kc cores (Little Endian).

Both Guest kernel and Guest Userspace execute in UM. The Guest address space is
as folows:
 Guest User address space:   0x00000000 -> 0x40000000
 Guest Kernel Unmapped:      0x40000000 -> 0x60000000
 Guest Kernel Mapped:        0x60000000 -> 0x80000000

As a result, Guest Usermode virtual memory is limited to 1GB.

Relase Notes
============
(1) 16K Page Size:
    Both Host Kernel and Guest Kernel should have the same page size, 
    currently at least 16K.  Note that due to cache aliasing issues, 
    4K page sizes are NOT supported.

(2) No HugeTLB/Large Page Support:
    Both the host kernel and Guest kernel should have the page size 
    set to at least 16K.
    This will be implemented in a future release.

(3) SMP Guests to not work
    Linux-3.7-rc2 based SMP guest hangs due to the following code sequence 
    in the generated TLB handlers:
         LL/TLBP/SC
    Since the TLBP instruction causes a trap the reservation gets cleared
    when we ERET back to the guest. This causes the guest to hang in an 
    infinite loop.
    As a workaround, make sure that CONFIG_SMP is disabled for Guest kernels.
    This will be fixed in a future release.

(4) FPU support:
    Currently KVM/MIPS emulates a 24K CPU without a FPU.
    This will be fixed in a future release

--
Sanjay Lal (20):
  KVM/MIPS32: Infrastructure/build files.
  KVM/MIPS32: Arch specific KVM data structures.
  KVM/MIPS32: Entry point for trampolining to the guest and trap
    handlers.
  KVM/MIPS32: MIPS arch specific APIs for KVM
  KVM/MIPS32: KVM Guest kernel support.
  KVM/MIPS32: Privileged instruction/target branch emulation.
  KVM/MIPS32: Dynamic binary translation of select privileged
    instructions.
  KVM/MIPS32: MMU/TLB operations for the Guest.
  KVM/MIPS32: Release notes and KVM module Makefile
  KVM/MIPS32: Keep track of VM exits and a historgram of COP0 accesses.
  KVM/MIPS32: Guest interrupt delivery.
  KVM/MIPS32: Routines to handle specific traps/exceptions while
    executing the guest.
  MIPS: Export routines needed by the KVM module.
  MIPS: Use the UM bit instead of the CU0 enable bit in the status
    register to figure out the stack for saving regs.
  MIPS: If KVM is enabled then use the KVM specific routine to flush
    the TLBs on a ASID wrap
  MIPS: ASM offsets for VCPU arch specific fields.
  MIPS: Pull in MIPS fix: fix endless loop when processing signals for
    kernel tasks.
  MIPS: Export symbols used by KVM/MIPS module
  KVM/MIPS32: Do not call vcpu_load when injecting interrupts.
  KVM/MIPS32: Malta config files for KVM host and guest kernels.

 arch/mips/Kbuild                            |    4 +
 arch/mips/Kconfig                           |   20 +
 arch/mips/configs/malta_kvm_defconfig       | 2244 +++++++++++++++++++++++++++
 arch/mips/configs/malta_kvm_guest_defconfig | 2237 ++++++++++++++++++++++++++
 arch/mips/include/asm/kvm.h                 |   58 +
 arch/mips/include/asm/kvm_host.h            |  672 ++++++++
 arch/mips/include/asm/mach-generic/spaces.h |    9 +-
 arch/mips/include/asm/mmu_context.h         |    6 +
 arch/mips/include/asm/processor.h           |    5 +
 arch/mips/include/asm/stackframe.h          |    6 +-
 arch/mips/include/asm/uaccess.h             |   15 +-
 arch/mips/kernel/asm-offsets.c              |   67 +
 arch/mips/kernel/binfmt_elfo32.c            |    6 +-
 arch/mips/kernel/cevt-r4k.c                 |    4 +
 arch/mips/kernel/entry.S                    |    7 +-
 arch/mips/kernel/smp.c                      |    1 +
 arch/mips/kernel/traps.c                    |    7 +-
 arch/mips/kvm/00README.txt                  |   31 +
 arch/mips/kvm/Kconfig                       |   49 +
 arch/mips/kvm/Makefile                      |   13 +
 arch/mips/kvm/kvm_cb.c                      |   16 +
 arch/mips/kvm/kvm_locore.S                  |  646 ++++++++
 arch/mips/kvm/kvm_mips.c                    | 1016 ++++++++++++
 arch/mips/kvm/kvm_mips_comm.h               |   24 +
 arch/mips/kvm/kvm_mips_commpage.c           |   38 +
 arch/mips/kvm/kvm_mips_dyntrans.c           |  142 ++
 arch/mips/kvm/kvm_mips_emul.c               | 1786 +++++++++++++++++++++
 arch/mips/kvm/kvm_mips_int.c                |  251 +++
 arch/mips/kvm/kvm_mips_int.h                |   49 +
 arch/mips/kvm/kvm_mips_opcode.h             |   27 +
 arch/mips/kvm/kvm_mips_stats.c              |   93 ++
 arch/mips/kvm/kvm_mips_stats.h              |   47 +
 arch/mips/kvm/kvm_tlb.c                     |  889 +++++++++++
 arch/mips/kvm/kvm_trap_emul.c               |  446 ++++++
 arch/mips/mm/c-r4k.c                        |    6 +-
 arch/mips/mm/cache.c                        |    1 +
 arch/mips/mm/tlb-r4k.c                      |    2 +
 arch/mips/mti-malta/Platform                |    6 +-
 arch/mips/mti-malta/malta-time.c            |   13 +
 mm/bootmem.c                                |    1 +
 virt/kvm/kvm_main.c                         |    2 +-
 41 files changed, 10948 insertions(+), 14 deletions(-)
 create mode 100644 arch/mips/configs/malta_kvm_defconfig
 create mode 100644 arch/mips/configs/malta_kvm_guest_defconfig
 create mode 100644 arch/mips/include/asm/kvm.h
 create mode 100644 arch/mips/include/asm/kvm_host.h
 create mode 100644 arch/mips/kvm/00README.txt
 create mode 100644 arch/mips/kvm/Kconfig
 create mode 100644 arch/mips/kvm/Makefile
 create mode 100644 arch/mips/kvm/kvm_cb.c
 create mode 100644 arch/mips/kvm/kvm_locore.S
 create mode 100644 arch/mips/kvm/kvm_mips.c
 create mode 100644 arch/mips/kvm/kvm_mips_comm.h
 create mode 100644 arch/mips/kvm/kvm_mips_commpage.c
 create mode 100644 arch/mips/kvm/kvm_mips_dyntrans.c
 create mode 100644 arch/mips/kvm/kvm_mips_emul.c
 create mode 100644 arch/mips/kvm/kvm_mips_int.c
 create mode 100644 arch/mips/kvm/kvm_mips_int.h
 create mode 100644 arch/mips/kvm/kvm_mips_opcode.h
 create mode 100644 arch/mips/kvm/kvm_mips_stats.c
 create mode 100644 arch/mips/kvm/kvm_mips_stats.h
 create mode 100644 arch/mips/kvm/kvm_tlb.c
 create mode 100644 arch/mips/kvm/kvm_trap_emul.c

-- 
1.7.11.3
