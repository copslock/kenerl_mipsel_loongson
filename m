Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 10:37:30 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22261 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992100AbdCBJhT30sPt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 10:37:19 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id AA1AE92DA3B0;
        Thu,  2 Mar 2017 09:37:10 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Mar 2017 09:37:12 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: [PATCH 0/32] KVM: MIPS: Add VZ support
Date:   Thu, 2 Mar 2017 09:36:27 +0000
Message-ID: <cover.5cfb5298ebc2f5308f4f56aaac7fa31c39a8ab58.1488447004.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56960
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

This series is based on kvm/next (Linus' 4.11 KVM merge) with my recent
hypercall series (which will likely be revised).
My hope is to take this series via the MIPS KVM tree for 4.12, with a
topic branch containing the MIPS architecture changes (patches 1-6).

This series implements basic support for the MIPS Virtualization Module
(generally known as VZ) in KVM, which adds a new "guest" processor mode
with a partial guest Cop0 state and guest TLB to complement the existing
"root" (host) modes & state, allowing for far fewer traps to the
hypervisor compared to the existing Trap & Emulate implementation of KVM
for MIPS, as well as fully virtualizing the guest virtual memory space
to run unmodified kernels.

The MIPS32 and MIPS64 VZ architecture documentation can be found here:
http://wiki.prplfoundation.org/w/images/f/fd/MD00846-2B-VZMIPS32-AFP-01.06.pdf
http://wiki.prplfoundation.org/w/images/f/fe/MD00847-2B-VZMIPS64-AFP-01.06.pdf

We primarily support the ImgTec P5600, P6600, and I6400 cores so far,
including the following VZ / guest hardware features:
- MIPS32 and MIPS64, r5 (VZ requires r5 or later) and r6
- TLBs with GuestID (IMG cores) or Root ASID Dealias (Octeon III)
- Shared physical root/guest TLB (IMG cores)
- FPU / MSA
- Cop0 timer (up to 1GHz for now due to soft timer limit)
- Segmentation control (EVA)
- Hardware page table walker (HTW) both for root and guest TLB

Limitations:
- Support for Cavium Octeon III will follow shortly in a separate series
- Perf counters and watch registers not exposed to guest in this series
  (the patches require some further cleanup)
- Guest microMIPS not supported yet (e.g. M5150)
- Guest XPA not supported yet (e.g. P5600)

We start with some preliminary MIPS changes in patches 1-6, including
some MAAR definition refactoring for XPA and some new guest capabilities
and accessors.

Patches 7-16 make preliminary VZ changes in KVM, including 64-bit MMIO
support, the VZ and 64BIT KVM capabilities, and new implementation
callbacks used by the VZ implementation.

Patches 17-22 get into some meatier KVM changes for VZ, such as
abstracting guest register access and adding VZ entry and TLB management
code.

Patches 23-24 add the bulk of the core VZ support and enable it in the
build system.

Patches 25-30 then go on to implement support for various optional
architectural features, such as segmentation control (EVA) and hardware
page table walkers (HTW). Context switching of the guest state may be
incomplete on certain cores without these patches if the features in
question can't be disabled in the guest context.

Finally patches 31-32 implement support for features that can be easily
disabled at runtime, namely the hardware guest timer (which can be
emulated in software before patch 31) and tracing of guest mode changes
using VZ's CP0_GuestCtl0.MC bit.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: linux-doc@vger.kernel.org

James Hogan (32):
  MIPS: Add defs & probing of UFR
  MIPS: Separate MAAR V bit into VL and VH for XPA
  MIPS: Probe guest CP0_UserLocal
  MIPS: Probe guest MVH
  MIPS: Add some missing guest CP0 accessors & defs
  MIPS: asm/tlb.h: Add UNIQUE_GUEST_ENTRYHI() macro
  KVM: MIPS/Emulate: De-duplicate MMIO emulation
  KVM: MIPS/Emulate: Implement 64-bit MMIO emulation
  KVM: MIPS: Update kvm_lose_fpu() for VZ
  KVM: MIPS: Extend counters & events for VZ GExcCodes
  KVM: MIPS: Add VZ capability
  KVM: MIPS: Add 64BIT capability
  KVM: MIPS: Init timer frequency from callback
  KVM: MIPS: Add callback to check extension
  KVM: MIPS: Add hardware_{enable,disable} callback
  KVM: MIPS: Add guest exit exception callback
  KVM: MIPS: Abstract guest CP0 register access for VZ
  KVM: MIPS/Entry: Update entry code to support VZ
  KVM: MIPS/TLB: Add VZ TLB management
  KVM: MIPS/Emulate: Update CP0_Compare emulation for VZ
  KVM: MIPS/Emulate: Drop CACHE emulation for VZ
  KVM: MIPS: Update exit handler for VZ
  KVM: MIPS: Implement VZ support
  KVM: MIPS: Add VZ support to build system
  KVM: MIPS/VZ: Support guest CP0_BadInstr[P]
  KVM: MIPS/VZ: Support guest CP0_[X]ContextConfig
  KVM: MIPS/VZ: Support guest segmentation control
  KVM: MIPS/VZ: Support guest hardware page table walker
  KVM: MIPS/VZ: Support guest load-linked bit
  KVM: MIPS/VZ: Emulate MAARs when necessary
  KVM: MIPS/VZ: Support hardware guest timer
  KVM: MIPS/VZ: Trace guest mode changes

 Documentation/virtual/kvm/api.txt    |   81 +-
 arch/mips/include/asm/cpu-features.h |   10 +-
 arch/mips/include/asm/cpu-info.h     |    2 +-
 arch/mips/include/asm/cpu.h          |    1 +-
 arch/mips/include/asm/kvm_host.h     |  460 +++-
 arch/mips/include/asm/maar.h         |   10 +-
 arch/mips/include/asm/mipsregs.h     |   24 +-
 arch/mips/include/asm/tlb.h          |    6 +-
 arch/mips/include/uapi/asm/kvm.h     |   20 +-
 arch/mips/kernel/cpu-probe.c         |   13 +-
 arch/mips/kernel/time.c              |    1 +-
 arch/mips/kvm/Kconfig                |   28 +-
 arch/mips/kvm/Makefile               |    8 +-
 arch/mips/kvm/emulate.c              |  370 +--
 arch/mips/kvm/entry.c                |  132 +-
 arch/mips/kvm/interrupt.h            |    5 +-
 arch/mips/kvm/mips.c                 |  122 +-
 arch/mips/kvm/mmu.c                  |   20 +-
 arch/mips/kvm/tlb.c                  |  411 ++++-
 arch/mips/kvm/trace.h                |   74 +-
 arch/mips/kvm/trap_emul.c            |   50 +-
 arch/mips/kvm/vz.c                   | 3132 +++++++++++++++++++++++++++-
 arch/mips/mm/init.c                  |    2 +-
 include/uapi/linux/kvm.h             |    7 +-
 24 files changed, 4671 insertions(+), 318 deletions(-)
 create mode 100644 arch/mips/kvm/vz.c

-- 
git-series 0.8.10
