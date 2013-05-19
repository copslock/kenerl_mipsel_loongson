Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 May 2013 07:47:58 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:53334 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6823068Ab3ESFrwv44hr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 May 2013 07:47:52 +0200
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Sat, 18 May 2013 22:47:43 -0700
Received: by agni.kymasys.com (Postfix, from userid 500)
        id 0F96E630050; Sat, 18 May 2013 22:47:43 -0700 (PDT)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH 00/18] KVM/MIPS32: Support for the new Virtualization ASE (VZ-ASE)
Date:   Sat, 18 May 2013 22:47:22 -0700
Message-Id: <1368942460-15577-1-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <n>
References: <n>
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36455
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

The following patch set adds support for the recently announced virtualization
extensions for the MIPS32 architecture and allows running unmodified kernels in
Guest Mode.

For more info please refer to :
	MIPS Document #: MD00846
	Volume IV-i: Virtualization Module of the MIPS32 Architecture

which can be accessed @: http://www.mips.com/auth/MD00846-2B-VZMIPS32-AFP-01.03.pdf

The patch is agains Linux-3.10-rc1.

KVM/MIPS now supports 2 modes of operation:

(1) VZ mode: Unmodified kernels running in Guest Mode.  The processor now provides
    an almost complete COP0 context in Guest mode. This greatly reduces VM exits.

(2) Trap and Emulate: Runs minimally modified guest kernels in UM and uses binary patching
    to minimize the number of traps and improve performance. This is used for processors
    that do not support the VZ-ASE.

--
Sanjay Lal (18):
  Revert "MIPS: microMIPS: Support dynamic ASID sizing."
  Revert "MIPS: Allow ASID size to be determined at boot time."
  KVM/MIPS32: Export min_low_pfn.
  KVM/MIPS32-VZ: MIPS VZ-ASE related register defines and helper
    macros.
  KVM/MIPS32-VZ: VZ-ASE assembler wrapper functions to set GuestIDs
  KVM/MIPS32-VZ: VZ-ASE related callbacks to handle guest exceptions
    that trap to the Root context.
  KVM/MIPS32: VZ-ASE related CPU feature flags and options.
  KVM/MIPS32-VZ: Entry point for trampolining to the guest and trap
    handlers.
  KVM/MIPS32-VZ: Add support for CONFIG_KVM_MIPS_VZ option
  KVM/MIPS32-VZ: Add API for VZ-ASE Capability
  KVM/MIPS32-VZ: VZ: Handle Guest TLB faults that are handled in Root
    context
  KVM/MIPS32-VZ: VM Exit Stats, add VZ exit reasons.
  KVM/MIPS32-VZ: Top level handler for Guest faults
  KVM/MIPS32-VZ: Guest exception batching support.
  KVM/MIPS32: Add dummy trap handler to catch unexpected exceptions and
    dump out useful info
  KVM/MIPS32-VZ: Add VZ-ASE support to KVM/MIPS data structures.
  KVM/MIPS32: Revert to older method for accessing ASID parameters
  KVM/MIPS32-VZ: Dump out additional info about VZ features as part of
    /proc/cpuinfo

 arch/mips/include/asm/cpu-features.h |   36 ++
 arch/mips/include/asm/cpu-info.h     |   21 +
 arch/mips/include/asm/cpu.h          |    5 +
 arch/mips/include/asm/kvm_host.h     |  244 ++++++--
 arch/mips/include/asm/mipsvzregs.h   |  494 +++++++++++++++
 arch/mips/include/asm/mmu_context.h  |   95 ++-
 arch/mips/kernel/genex.S             |    2 +-
 arch/mips/kernel/mips_ksyms.c        |    6 +
 arch/mips/kernel/proc.c              |   11 +
 arch/mips/kernel/smtc.c              |   10 +-
 arch/mips/kernel/traps.c             |    6 +-
 arch/mips/kvm/Kconfig                |   14 +-
 arch/mips/kvm/Makefile               |   14 +-
 arch/mips/kvm/kvm_locore.S           | 1088 ++++++++++++++++++----------------
 arch/mips/kvm/kvm_mips.c             |   73 ++-
 arch/mips/kvm/kvm_mips_dyntrans.c    |   24 +-
 arch/mips/kvm/kvm_mips_emul.c        |  236 ++++----
 arch/mips/kvm/kvm_mips_int.h         |    5 +
 arch/mips/kvm/kvm_mips_stats.c       |   17 +-
 arch/mips/kvm/kvm_tlb.c              |  444 +++++++++++---
 arch/mips/kvm/kvm_trap_emul.c        |   68 ++-
 arch/mips/kvm/kvm_vz.c               |  786 ++++++++++++++++++++++++
 arch/mips/kvm/kvm_vz_locore.S        |   74 +++
 arch/mips/lib/dump_tlb.c             |    5 +-
 arch/mips/lib/r3k_dump_tlb.c         |    7 +-
 arch/mips/mm/tlb-r3k.c               |   20 +-
 arch/mips/mm/tlb-r4k.c               |    2 +-
 arch/mips/mm/tlb-r8k.c               |    2 +-
 arch/mips/mm/tlbex.c                 |   82 +--
 include/uapi/linux/kvm.h             |    1 +
 30 files changed, 2906 insertions(+), 986 deletions(-)
 create mode 100644 arch/mips/include/asm/mipsvzregs.h
 create mode 100644 arch/mips/kvm/kvm_vz.c
 create mode 100644 arch/mips/kvm/kvm_vz_locore.S

-- 
1.7.11.3
