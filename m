Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2017 17:06:56 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38816 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993874AbdBCQGtf1GCO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Feb 2017 17:06:49 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 99BF841F8E85;
        Fri,  3 Feb 2017 17:10:11 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 03 Feb 2017 17:10:11 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 03 Feb 2017 17:10:11 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 9DAD1720C110C;
        Fri,  3 Feb 2017 16:06:40 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 3 Feb
 2017 16:06:43 +0000
Date:   Fri, 3 Feb 2017 16:06:43 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>
Subject: [GIT PULL] KVM: MIPS: GVA/GPA page tables, dirty logging, SYNC_MMU
 etc
Message-ID: <20170203160643.GS13049@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eBTWNsZZiigckDWV"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56626
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

--eBTWNsZZiigckDWV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Paolo, Radim,

The following changes since commit 0b4c208d443ba2af82b4c70f99ca8df31e9a0020:

  Revert "KVM: nested VMX: disable perf cpuid reporting" (2017-01-20 22:18:55 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/kvm-mips.git tags/kvm_mips_4.11_1

for you to fetch changes up to 12ed1faece3f141c2604b5b3a8377ba71d23ec9d:

  KVM: MIPS: Allow multiple VCPUs to be created (2017-02-03 15:21:34 +0000)

It is already included in linux-next (though I did tweak one of the
commit messages just now to remove a patch changelog I had accidentally
left in, with no changes to the code).

It includes a merge of my mips branch in the same repo, which is based
on v4.10-rc2 and contains the general MIPS changes in the GVA/GPA page
tables series, for Ralf to also merge if he likes.

Cheers
James

----------------------------------------------------------------
KVM: MIPS: GVA/GPA page tables, dirty logging, SYNC_MMU etc

Numerous MIPS KVM fixes, improvements, and features for 4.11, many of
which continue to pave the way for VZ support, the most interesting of
which are:

 - Add GVA->HPA page tables for T&E, to cache GVA mappings.
 - Generate fast-path TLB refill exception handler which loads host TLB
   entries from GVA page table, avoiding repeated guest memory
   translation and guest TLB lookups.
 - Use uaccess macros when T&E needs to access guest memory, which with
   GVA page tables and the Linux TLB refill handler improves robustness
   against TLB faults and fixes EVA hosts.
 - Use BadInstr/BadInstrP registers when available to obtain instruction
   encodings after a synchronous trap.
 - Add GPA->HPA page tables to replace the inflexible linear array,
   allowing for multiple sparsely arranged memory regions.
 - Properly implement dirty page logging.
 - Add KVM_CAP_SYNC_MMU support so that changes in GPA mappings become
   effective in guests even if they are already running, allowing for
   copy-on-write, KSM, idle page tracking, swapping, and guest memory
   ballooning.
 - Add KVM_CAP_READONLY_MEM support, so writes to specified memory
   regions are treated as MMIO.
 - Implement proper CP0_EBase support in T&E.
 - Expose a few more missing CP0 registers to userland.
 - Add KVM_CAP_NR_VCPUS and KVM_CAP_MAX_VCPUS support, and allow up to 8
   VCPUs to be created in a VM.
 - Various cleanups and dropping of dead and duplicated code.

----------------------------------------------------------------
James Hogan (63):
      MIPS: Move pgd_alloc() out of header
      MIPS: Export pgd/pmd symbols for KVM
      MIPS: uasm: Add include guards in asm/uasm.h
      MIPS: Export some tlbex internals for KVM to use
      MIPS: Add return errors to protected cache ops
      Merge MIPS prerequisites
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
      KVM: MIPS/T&E: Don't treat code fetch faults as MMIO
      KVM: MIPS: Improve kvm_get_inst() error return
      KVM: MIPS: Use CP0_BadInstr[P] for emulation
      KVM: MIPS/MMU: Convert guest physical map to page table
      KVM: MIPS: Update vcpu->mode and vcpu->cpu
      KVM: MIPS/T&E: Handle TLB invalidation requests
      KVM: MIPS/T&E: Reduce stale ASID checks
      KVM: MIPS/T&E: Add lockless GVA access helpers
      KVM: MIPS/T&E: Use lockless GVA helpers for dyntrans
      KVM: MIPS/MMU: Use lockless GVA helpers for get_inst()
      KVM: MIPS/Emulate: Use lockless GVA helpers for cache emulation
      KVM: MIPS: Implement kvm_arch_flush_shadow_all/memslot
      KVM: MIPS/T&E: Ignore user writes to CP0_Config7
      KVM: MIPS: Pass type of fault down to kvm_mips_map_page()
      KVM: MIPS/T&E: Abstract bad access handling
      KVM: MIPS/T&E: Treat unhandled guest KSeg0 as MMIO
      KVM: MIPS/T&E: Handle read only GPA in TLB mod
      KVM: MIPS/MMU: Add GPA PT mkclean helper
      KVM: MIPS/MMU: Use generic dirty log & protect helper
      KVM: MIPS: Clean & flush on dirty page logging enable
      KVM: MIPS/MMU: Handle dirty logging on GPA faults
      KVM: MIPS/MMU: Pass GPA PTE bits to KSeg0 GVA PTEs
      KVM: MIPS/MMU: Pass GPA PTE bits to mapped GVA PTEs
      KVM: MIPS/MMU: Implement KVM_CAP_SYNC_MMU
      KVM: MIPS: Claim KVM_CAP_READONLY_MEM support
      KVM: MIPS/T&E: Move CP0 register access into T&E
      KVM: MIPS/T&E: Implement CP0_EBase register
      KVM: MIPS/T&E: Default to reset vector
      KVM: MIPS/T&E: Expose CP0_EntryLo0/1 registers
      KVM: MIPS/T&E: Expose read-only CP0_IntCtl register
      KVM: MIPS: Allow multiple VCPUs to be created

Markus Elfring (1):
      MIPS: KVM: Return directly after a failed copy_from_user() in kvm_arch_vcpu_ioctl()

 Documentation/virtual/kvm/api.txt   |   10 +
 arch/mips/include/asm/kvm_host.h    |  183 +++--
 arch/mips/include/asm/mmu_context.h |    9 +-
 arch/mips/include/asm/pgalloc.h     |   16 +-
 arch/mips/include/asm/r4kcache.h    |   55 +-
 arch/mips/include/asm/tlbex.h       |   26 +
 arch/mips/include/asm/uasm.h        |    5 +
 arch/mips/include/uapi/asm/kvm.h    |    2 +
 arch/mips/kvm/Kconfig               |    2 +
 arch/mips/kvm/dyntrans.c            |   50 +-
 arch/mips/kvm/emulate.c             |  432 ++++++------
 arch/mips/kvm/entry.c               |  155 +++-
 arch/mips/kvm/interrupt.c           |    5 +-
 arch/mips/kvm/mips.c                |  496 ++++---------
 arch/mips/kvm/mmu.c                 | 1335 ++++++++++++++++++++++++++++-------
 arch/mips/kvm/tlb.c                 |  299 ++------
 arch/mips/kvm/trap_emul.c           |  740 ++++++++++++++++---
 arch/mips/mm/Makefile               |    2 +-
 arch/mips/mm/init.c                 |    1 +
 arch/mips/mm/pgtable-64.c           |    2 +
 arch/mips/mm/pgtable.c              |   25 +
 arch/mips/mm/tlbex.c                |   38 +-
 22 files changed, 2611 insertions(+), 1277 deletions(-)
 create mode 100644 arch/mips/include/asm/tlbex.h
 create mode 100644 arch/mips/mm/pgtable.c

--eBTWNsZZiigckDWV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYlKqTAAoJEGwLaZPeOHZ6kC4P/124CAb84uGwZ6Pky0f8/Zqi
+n4LlMvIycwMML6zhT3o2jX7ZrpmzNx4+BkeTYXaRjPZhkHqnfxLhrmIcAUcEjMX
f7Kat4ps9ihLWFbzXqR/XlO1Va2Y0eD9+WmLS2b2op1xjwcaj9HveU52/U552Vc+
fVxJpvooO6YnlLI3nBnsPjccR4egGf+DNKHkXm6Ut5Tpl9B/gvvYbfrYPeWmU4cY
1YXR2FABjD5d8gObT72gfBFEy7vbpWiun4WRjSjX5t64cEzQGPMGpFF2PszwWxGn
kNo293rhqGJgyE8fBEWwkqjp/GI/a1tC1MJCU2mGSnyG9Nk56qlHPITaUlD0QOsV
3Qoh+BsfhR9JBAHLAya6RPdq1WK7UTCRXHjnE3NH9XrCfyEi/kBXvdGypSFpT0mg
QOC+lOC9//5XNdH2qWKXa7AjU3CC2/trxoVO1zwlLXA27TObARJOCzYEMcEbdDfP
g8XSpLmbeD32lVZuSYyc6dhjY0TP5Y7ZcnrFexoANr7rH5WVhKaak9N92vEo2kO4
J1/idziLqXoGLcAS/0P2EVJQzDtbb82puz6wujIII/2sUyX2Cncm0V1TdTG+khLG
iDj8P60dwkl2dO0RbKktez0qanIzsWhSh0PPB9Pk3iNPo3jwR6JffJJOMcdn15uo
CqAN82+UWnZFCmHqURsE
=Fv9D
-----END PGP SIGNATURE-----

--eBTWNsZZiigckDWV--
