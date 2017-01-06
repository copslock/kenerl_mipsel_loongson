Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 02:33:43 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44144 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992437AbdAFBdfhZClu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 02:33:35 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 06F159120B9F5;
        Fri,  6 Jan 2017 01:33:28 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 6 Jan 2017 01:33:28 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [PATCH 0/30] KVM: MIPS: Implement GVA page tables
Date:   Fri, 6 Jan 2017 01:32:32 +0000
Message-ID: <cover.d6d201de414322ed2c1372e164254e6055ef7db9.1483665879.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56174
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

Note: My intention is to take this series via the MIPS KVM tree, with a
topic branch for the MIPS architecture changes, so acks welcome for the
relevant parts (mainly patches 1-4, 15, 28), and please don't apply yet.

This series primarily implements GVA->HPA page tables for MIPS T&E KVM
implementation, and a fast TLB refill handler generated at runtime using
uasm (sharing MIPS arch code to do this), accompanied by a bunch of
related cleanups. There are several solid advantages of this:

- An optimised TLB refill handler will be much faster than using the
  slow exit path through C code. It also avoids repeated guest TLB
  lookups for guest mapped addresses that are evicted from the host TLB
  (which are currently implemented as a linear walk through the guest
  TLB array).

- The TLB refill handler can be pretty much reused in future for VZ, to
  fill the root TLB with GPA->HPA mappings from a soon to be implemented
  GPA page table.

- Although not enabled yet, it potentially allows page table walker
  hardware (HTW) to be used during guest execution (both for VZ GPA
  mappings, and potentially T&E GVA mappings) further reducing TLB
  refill overhead.

- It improves the robustness of direct access to guest memory by KVM,
  i.e. reading guest instructions for emulation, writing guest
  instructions for dynamic translation, and emulating CACHE
  instructions. This is because the standard userland memory accessors
  can be used, allowing the host kernel TLB refill handler to safely
  fill from the GVA page table, allowing faults to be sanely detected,
  and allowing it to work when EVA is enabled (which requires different
  instructions to be used when accessing the user address space).

The main disadvantage is a higher flushing overhead when the guest ASID
is changed, due to the need to walk and invalidate GVA page tables
(since we only manage a single GVA page table for each guest privilege
mode, across all guest ASIDs).

The patches are roughly grouped as follows:

Patches 1-4:
  These are generic or MIPS architecture changes needed by the later
  patches, mainly to expose the existing MIPS TLB exception generation
  cade to KVM. As I mentioned above I intend to combine the MIPS ones
  into a topic branch which can be merged into both the MIPS
  architecture tree and the MIPS KVM tree.

Patches 5-13:
  These are preliminary MIPS KVM changes and cleanups.

Patches 14-25:
  These incrementally add GVA page table support, allocating the GVA
  page tables, adding the fast TLB refill handler, addng page table
  invalidation, and finally converting guest fault handling (KSeg0, TLB
  mapped, and commpage) to use the GVA page table rather than injecting
  entries directly into the host TLB.

Patches 26-27:
  These switch to using uaccess and protected cache ops, which fixes KVM
  on EVA enabled host kernels.

Patches 28-30:
  These make some final cleanups.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: linux-mm@kvack.org

James Hogan (30):
  mm: Export init_mm for MIPS KVM use of pgd_alloc()
  MIPS: Export pgd/pmd symbols for KVM
  MIPS: uasm: Add include guards in asm/uasm.h
  MIPS: Export some tlbex internals for KVM to use
  KVM: MIPS: Drop partial KVM_NMI implementation
  KVM: MIPS/MMU: Simplify ASID restoration
  KVM: MIPS: Convert get/set_regs -> vcpu_load/put
  KVM: MIPS/MMU: Move preempt/ASID handling to implementation
  KVM: MIPS: Remove duplicated ASIDs from vcpu
  KVM: MIPS: Add vcpu_run() & vcpu_reenter() callbacks
  KVM: MIPS/T&E: Restore host asid on return to host
  KVM: MIPS/T&E: active_mm = init_mm in guest context
  KVM: MIPS: Wire up vcpu uninit
  KVM: MIPS/T&E: Allocate GVA -> HPA page tables
  KVM: MIPS/T&E: Activate GVA page tables in guest context
  KVM: MIPS: Support NetLogic KScratch registers
  KVM: MIPS: Add fast path TLB refill handler
  KVM: MIPS/TLB: Fix off-by-one in TLB invalidate
  KVM: MIPS/TLB: Generalise host TLB invalidate to kernel ASID
  KVM: MIPS/MMU: Invalidate GVA PTs on ASID changes
  KVM: MIPS/MMU: Invalidate stale GVA PTEs on TLBW
  KVM: MIPS/MMU: Convert KSeg0 faults to page tables
  KVM: MIPS/MMU: Convert TLB mapped faults to page tables
  KVM: MIPS/MMU: Convert commpage fault handling to page tables
  KVM: MIPS: Drop vm_init() callback
  KVM: MIPS: Use uaccess to read/modify guest instructions
  KVM: MIPS/Emulate: Fix CACHE emulation for EVA hosts
  KVM: MIPS/TLB: Drop kvm_local_flush_tlb_all()
  KVM: MIPS/Emulate: Drop redundant TLB flushes on exceptions
  KVM: MIPS/MMU: Drop kvm_get_new_mmu_context()

 arch/mips/include/asm/kvm_host.h    |  76 ++--
 arch/mips/include/asm/mmu_context.h |   9 +-
 arch/mips/include/asm/tlbex.h       |  26 +-
 arch/mips/include/asm/uasm.h        |   5 +-
 arch/mips/kvm/dyntrans.c            |  28 +-
 arch/mips/kvm/emulate.c             |  59 +--
 arch/mips/kvm/entry.c               | 141 +++++++-
 arch/mips/kvm/mips.c                | 130 +------
 arch/mips/kvm/mmu.c                 | 545 +++++++++++++++++------------
 arch/mips/kvm/tlb.c                 | 225 +-----------
 arch/mips/kvm/trap_emul.c           | 220 +++++++++++-
 arch/mips/mm/init.c                 |   1 +-
 arch/mips/mm/pgtable-32.c           |   1 +-
 arch/mips/mm/pgtable-64.c           |   3 +-
 arch/mips/mm/tlbex.c                |  38 +-
 mm/init-mm.c                        |   2 +-
 16 files changed, 861 insertions(+), 648 deletions(-)
 create mode 100644 arch/mips/include/asm/tlbex.h

-- 
git-series 0.8.10
