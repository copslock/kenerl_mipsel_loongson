Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2017 18:18:58 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:54420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992160AbdBGRSvWojUX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Feb 2017 18:18:51 +0100
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E5EAC05AA42;
        Tue,  7 Feb 2017 17:18:43 +0000 (UTC)
Received: from [10.36.116.62] (ovpn-116-62.ams2.redhat.com [10.36.116.62])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v17HIdKE024143
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 7 Feb 2017 12:18:41 -0500
Subject: Re: [GIT PULL] KVM: MIPS: GVA/GPA page tables, dirty logging,
 SYNC_MMU etc
To:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20170203160643.GS13049@jhogan-linux.le.imgtec.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c2ce5eb4-f4f6-cdb9-76c7-a4217df1a98c@redhat.com>
Date:   Tue, 7 Feb 2017 18:18:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170203160643.GS13049@jhogan-linux.le.imgtec.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="D9gctFWg6vPqf7ltSgsvsBD31pMPFUFpK"
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 07 Feb 2017 17:18:43 +0000 (UTC)
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D9gctFWg6vPqf7ltSgsvsBD31pMPFUFpK
Content-Type: multipart/mixed; boundary="0eI5H6R2KQftTjRhfiG3f04wuSbdaLPgU";
 protected-headers="v1"
From: Paolo Bonzini <pbonzini@redhat.com>
To: James Hogan <james.hogan@imgtec.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
 kvm@vger.kernel.org
Message-ID: <c2ce5eb4-f4f6-cdb9-76c7-a4217df1a98c@redhat.com>
Subject: Re: [GIT PULL] KVM: MIPS: GVA/GPA page tables, dirty logging,
 SYNC_MMU etc
References: <20170203160643.GS13049@jhogan-linux.le.imgtec.org>
In-Reply-To: <20170203160643.GS13049@jhogan-linux.le.imgtec.org>

--0eI5H6R2KQftTjRhfiG3f04wuSbdaLPgU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 03/02/2017 17:06, James Hogan wrote:
> Hi Paolo, Radim,
>=20
> The following changes since commit 0b4c208d443ba2af82b4c70f99ca8df31e9a=
0020:
>=20
>   Revert "KVM: nested VMX: disable perf cpuid reporting" (2017-01-20 22=
:18:55 +0100)
>=20
> are available in the git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/kvm-mips.git tag=
s/kvm_mips_4.11_1
>=20
> for you to fetch changes up to 12ed1faece3f141c2604b5b3a8377ba71d23ec9d=
:
>=20
>   KVM: MIPS: Allow multiple VCPUs to be created (2017-02-03 15:21:34 +0=
000)
>=20
> It is already included in linux-next (though I did tweak one of the
> commit messages just now to remove a patch changelog I had accidentally=

> left in, with no changes to the code).
>=20
> It includes a merge of my mips branch in the same repo, which is based
> on v4.10-rc2 and contains the general MIPS changes in the GVA/GPA page
> tables series, for Ralf to also merge if he likes.
>=20
> Cheers
> James
>=20
> ----------------------------------------------------------------
> KVM: MIPS: GVA/GPA page tables, dirty logging, SYNC_MMU etc
>=20
> Numerous MIPS KVM fixes, improvements, and features for 4.11, many of
> which continue to pave the way for VZ support, the most interesting of
> which are:
>=20
>  - Add GVA->HPA page tables for T&E, to cache GVA mappings.
>  - Generate fast-path TLB refill exception handler which loads host TLB=

>    entries from GVA page table, avoiding repeated guest memory
>    translation and guest TLB lookups.
>  - Use uaccess macros when T&E needs to access guest memory, which with=

>    GVA page tables and the Linux TLB refill handler improves robustness=

>    against TLB faults and fixes EVA hosts.
>  - Use BadInstr/BadInstrP registers when available to obtain instructio=
n
>    encodings after a synchronous trap.
>  - Add GPA->HPA page tables to replace the inflexible linear array,
>    allowing for multiple sparsely arranged memory regions.
>  - Properly implement dirty page logging.
>  - Add KVM_CAP_SYNC_MMU support so that changes in GPA mappings become
>    effective in guests even if they are already running, allowing for
>    copy-on-write, KSM, idle page tracking, swapping, and guest memory
>    ballooning.
>  - Add KVM_CAP_READONLY_MEM support, so writes to specified memory
>    regions are treated as MMIO.
>  - Implement proper CP0_EBase support in T&E.
>  - Expose a few more missing CP0 registers to userland.
>  - Add KVM_CAP_NR_VCPUS and KVM_CAP_MAX_VCPUS support, and allow up to =
8
>    VCPUs to be created in a VM.
>  - Various cleanups and dropping of dead and duplicated code.
>=20
> ----------------------------------------------------------------
> James Hogan (63):
>       MIPS: Move pgd_alloc() out of header
>       MIPS: Export pgd/pmd symbols for KVM
>       MIPS: uasm: Add include guards in asm/uasm.h
>       MIPS: Export some tlbex internals for KVM to use
>       MIPS: Add return errors to protected cache ops
>       Merge MIPS prerequisites
>       KVM: MIPS: Drop partial KVM_NMI implementation
>       KVM: MIPS/MMU: Simplify ASID restoration
>       KVM: MIPS: Convert get/set_regs -> vcpu_load/put
>       KVM: MIPS/MMU: Move preempt/ASID handling to implementation
>       KVM: MIPS: Remove duplicated ASIDs from vcpu
>       KVM: MIPS: Add vcpu_run() & vcpu_reenter() callbacks
>       KVM: MIPS/T&E: Restore host asid on return to host
>       KVM: MIPS/T&E: active_mm =3D init_mm in guest context
>       KVM: MIPS: Wire up vcpu uninit
>       KVM: MIPS/T&E: Allocate GVA -> HPA page tables
>       KVM: MIPS/T&E: Activate GVA page tables in guest context
>       KVM: MIPS: Support NetLogic KScratch registers
>       KVM: MIPS: Add fast path TLB refill handler
>       KVM: MIPS/TLB: Fix off-by-one in TLB invalidate
>       KVM: MIPS/TLB: Generalise host TLB invalidate to kernel ASID
>       KVM: MIPS/MMU: Invalidate GVA PTs on ASID changes
>       KVM: MIPS/MMU: Invalidate stale GVA PTEs on TLBW
>       KVM: MIPS/MMU: Convert KSeg0 faults to page tables
>       KVM: MIPS/MMU: Convert TLB mapped faults to page tables
>       KVM: MIPS/MMU: Convert commpage fault handling to page tables
>       KVM: MIPS: Drop vm_init() callback
>       KVM: MIPS: Use uaccess to read/modify guest instructions
>       KVM: MIPS/Emulate: Fix CACHE emulation for EVA hosts
>       KVM: MIPS/TLB: Drop kvm_local_flush_tlb_all()
>       KVM: MIPS/Emulate: Drop redundant TLB flushes on exceptions
>       KVM: MIPS/MMU: Drop kvm_get_new_mmu_context()
>       KVM: MIPS/T&E: Don't treat code fetch faults as MMIO
>       KVM: MIPS: Improve kvm_get_inst() error return
>       KVM: MIPS: Use CP0_BadInstr[P] for emulation
>       KVM: MIPS/MMU: Convert guest physical map to page table
>       KVM: MIPS: Update vcpu->mode and vcpu->cpu
>       KVM: MIPS/T&E: Handle TLB invalidation requests
>       KVM: MIPS/T&E: Reduce stale ASID checks
>       KVM: MIPS/T&E: Add lockless GVA access helpers
>       KVM: MIPS/T&E: Use lockless GVA helpers for dyntrans
>       KVM: MIPS/MMU: Use lockless GVA helpers for get_inst()
>       KVM: MIPS/Emulate: Use lockless GVA helpers for cache emulation
>       KVM: MIPS: Implement kvm_arch_flush_shadow_all/memslot
>       KVM: MIPS/T&E: Ignore user writes to CP0_Config7
>       KVM: MIPS: Pass type of fault down to kvm_mips_map_page()
>       KVM: MIPS/T&E: Abstract bad access handling
>       KVM: MIPS/T&E: Treat unhandled guest KSeg0 as MMIO
>       KVM: MIPS/T&E: Handle read only GPA in TLB mod
>       KVM: MIPS/MMU: Add GPA PT mkclean helper
>       KVM: MIPS/MMU: Use generic dirty log & protect helper
>       KVM: MIPS: Clean & flush on dirty page logging enable
>       KVM: MIPS/MMU: Handle dirty logging on GPA faults
>       KVM: MIPS/MMU: Pass GPA PTE bits to KSeg0 GVA PTEs
>       KVM: MIPS/MMU: Pass GPA PTE bits to mapped GVA PTEs
>       KVM: MIPS/MMU: Implement KVM_CAP_SYNC_MMU
>       KVM: MIPS: Claim KVM_CAP_READONLY_MEM support
>       KVM: MIPS/T&E: Move CP0 register access into T&E
>       KVM: MIPS/T&E: Implement CP0_EBase register
>       KVM: MIPS/T&E: Default to reset vector
>       KVM: MIPS/T&E: Expose CP0_EntryLo0/1 registers
>       KVM: MIPS/T&E: Expose read-only CP0_IntCtl register
>       KVM: MIPS: Allow multiple VCPUs to be created
>=20
> Markus Elfring (1):
>       MIPS: KVM: Return directly after a failed copy_from_user() in kvm=
_arch_vcpu_ioctl()
>=20
>  Documentation/virtual/kvm/api.txt   |   10 +
>  arch/mips/include/asm/kvm_host.h    |  183 +++--
>  arch/mips/include/asm/mmu_context.h |    9 +-
>  arch/mips/include/asm/pgalloc.h     |   16 +-
>  arch/mips/include/asm/r4kcache.h    |   55 +-
>  arch/mips/include/asm/tlbex.h       |   26 +
>  arch/mips/include/asm/uasm.h        |    5 +
>  arch/mips/include/uapi/asm/kvm.h    |    2 +
>  arch/mips/kvm/Kconfig               |    2 +
>  arch/mips/kvm/dyntrans.c            |   50 +-
>  arch/mips/kvm/emulate.c             |  432 ++++++------
>  arch/mips/kvm/entry.c               |  155 +++-
>  arch/mips/kvm/interrupt.c           |    5 +-
>  arch/mips/kvm/mips.c                |  496 ++++---------
>  arch/mips/kvm/mmu.c                 | 1335 +++++++++++++++++++++++++++=
+-------
>  arch/mips/kvm/tlb.c                 |  299 ++------
>  arch/mips/kvm/trap_emul.c           |  740 ++++++++++++++++---
>  arch/mips/mm/Makefile               |    2 +-
>  arch/mips/mm/init.c                 |    1 +
>  arch/mips/mm/pgtable-64.c           |    2 +
>  arch/mips/mm/pgtable.c              |   25 +
>  arch/mips/mm/tlbex.c                |   38 +-
>  22 files changed, 2611 insertions(+), 1277 deletions(-)
>  create mode 100644 arch/mips/include/asm/tlbex.h
>  create mode 100644 arch/mips/mm/pgtable.c
>=20

Pulled, thanks.

Paolo


--0eI5H6R2KQftTjRhfiG3f04wuSbdaLPgU--

--D9gctFWg6vPqf7ltSgsvsBD31pMPFUFpK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYmgFrAAoJEL/70l94x66DU6YIAJSZ55tczmwz/54u4N1ajmq+
ypF5xtss4fhWyYXSahRdH+qKL0STIVJ7QNfhIRsRT8d3nvz5nFKWlxJ5PoT68JMi
dAWOGnUVmhcUwZGwUvVcIzY4iuOvEjJqsNSs5sQxLgvtoe7YkXPAflzAf3WmgeH+
eUoO7nfL5RRC6cgwEjgK9/N3ja2X/q91F7px1L6PPkQ2A/+82BwODBT9sB0urB8d
P+Egvd0OE+Ga07P6+e0YeDCnq5XBH/+Ys4fecLCbS+I06ze6BDTyvGCYgnx8M970
pTxf3ZJwTNrwTn0aWeUrfAKr7cpUslRor5LSExnz4KXAUxr39qfF53Xuz2MZi4I=
=vfG7
-----END PGP SIGNATURE-----

--D9gctFWg6vPqf7ltSgsvsBD31pMPFUFpK--
