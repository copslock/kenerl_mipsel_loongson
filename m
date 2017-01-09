Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2017 21:53:34 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6378 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993179AbdAIUx1ifRlP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jan 2017 21:53:27 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 3F8627C4A5E2D;
        Mon,  9 Jan 2017 20:53:17 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 9 Jan 2017 20:53:21 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 0/10] KVM: MIPS: Implement GPA page tables and shadow flushing
Date:   Mon, 9 Jan 2017 20:51:52 +0000
Message-ID: <cover.4133d2f24fd73c1889a46ea05bb8924867b33747.1483993967.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56235
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

Note: My intention is to take this series via the MIPS KVM tree along
with the others for v4.11, with a topic branch containing the MIPS
architecture change, so an ack is welcome for patch 1 in particular.

This series first converts MIPS KVM to use page tables for its GPA ->
HPA mappings instead of a linear array. The linear array was only really
meant to be temporary, and isn't sparse so its wasteful of memory. It
also never handled resizing of the array for multiple or changed memory
regions, which a sparse page table pretty much handles automatically.

We then go on to implement the shadow flushing architecture callbacks to
allow the mappings (page tables and TLB entries) to be flushed in
response to memory region changes. This is fairly straightforward for
GPA which is shared between VCPUs as the kvm->mmu_lock can protect it,
but GVA page tables are specific to a VCPU so are accessed locklessly.
This would make it unsafe to directly modify any GVA page tables, so we
wire up the TLB flush VCPU request so that we can tell a possibly
running VCPU to flush its own GVA mappings.

Since MIPS KVM emulation code can also access GVA mappings directly, we
use the READING_SHADOW_PAGE_TABLES VCPU mode similar to how x86 does to
locklessly protect these accesses. This ensures that either the flush
will take place before the GVA access, or an IPI will be sent to confirm
receipt of the request which will be delayed until after the GVA access
is complete.

The patches are roughly grouped as follows:

Patch 1:
  This is a MIPS architecture change needed for patch 9. As I mentioned
  above I intend to combine this into a topic branch which can be merged
  into both the MIPS architecture tree and the MIPS KVM tree.

Patch 2:
  This singularly converts GPA to use page tables.

Patches 3-10:
  These implement shadow flushing, first laying the ground work to allow
  TLB flush requests to work and to protect direct GVA access from
  asynchronous flush requests.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org

James Hogan (10):
  MIPS: Add return errors to protected cache ops
  KVM: MIPS/MMU: Convert guest physical map to page table
  KVM: MIPS: Update vcpu->mode and vcpu->cpu
  KVM: MIPS/T&E: Handle TLB invalidation requests
  KVM: MIPS/T&E: Reduce stale ASID checks
  KVM: MIPS/T&E: Add lockless GVA access helpers
  KVM: MIPS/T&E: Use lockless GVA helpers for dyntrans
  KVM: MIPS/MMU: Use lockless GVA helpers for get_inst()
  KVM: MIPS/Emulate: Use lockless GVA helpers for cache emulation
  KVM: MIPS: Implement kvm_arch_flush_shadow_all/memslot

 arch/mips/include/asm/kvm_host.h |  35 ++-
 arch/mips/include/asm/r4kcache.h |  55 +++--
 arch/mips/kvm/dyntrans.c         |  26 +-
 arch/mips/kvm/emulate.c          | 149 +++++--------
 arch/mips/kvm/mips.c             |  92 +++++---
 arch/mips/kvm/mmu.c              | 367 ++++++++++++++++++++++++++++----
 arch/mips/kvm/tlb.c              |  35 +---
 arch/mips/kvm/trap_emul.c        | 185 ++++++++++++----
 8 files changed, 690 insertions(+), 254 deletions(-)

-- 
git-series 0.8.10
