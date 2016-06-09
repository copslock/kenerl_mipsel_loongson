Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 15:19:40 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28172 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27033852AbcFINTiipeNi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 15:19:38 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 4352A56759397;
        Thu,  9 Jun 2016 14:19:29 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 9 Jun 2016 14:19:32 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 00/18] MIPS: KVM: Miscellaneous clean-ups
Date:   Thu, 9 Jun 2016 14:19:03 +0100
Message-ID: <1465478361-7431-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53914
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

This patchset does a whole load of miscellaneous and usually quite self
contained cleanups in the MIPS KVM code, although a few of the patches
(patches 4-7) are a bit more invasive.

It is based on my "[PATCH 0/4] MIPS: KVM: Module + non dynamic
translating fixes" patchset from earlier today.

Patches 1-3, 10   drop dead or pointless code.
Patches 4-6       make changes to types (getting rid of uint32_t style
                  types and changing Cause register to u32).
Patches 7-8       separate non TLB handling code out of tlb.c into mmu.c,
                  which is built into the KVM module.
Patches 9, 12-16  make cleanups to host and guest TLB management code.

The remaining patches (11, 17-18) make other misc cleanups.

James Hogan (18):
  MIPS: KVM: Drop unused guest_inst from kvm_vcpu_arch
  MIPS: KVM: Drop unused host_cp0_entryhi
  MIPS: KVM: Drop unused kvm_mips_sync_icache()
  MIPS: KVM: Convert headers to kernel sized types
  MIPS: KVM: Convert code to kernel sized types
  MIPS: KVM: Make various Cause variables 32-bit
  MIPS: KVM: Move non-TLB handling code out of tlb.c
  MIPS: KVM: Don't indirect KVM functions
  MIPS: KVM: Simplify even/odd TLB handling
  MIPS: KVM: Drop unused hpa0/hpa1 args from function
  MIPS: KVM: Restore host EBase from ebase variable
  MIPS: KVM: Clean up TLB management hazards
  MIPS: KVM: Use dump_tlb_all() for kvm_mips_dump_host_tlbs()
  MIPS: KVM: Arrayify struct kvm_mips_tlb::tlb_lo*
  MIPS: KVM: Simplify TLB_* macros
  MIPS: KVM: Use MIPS_ENTRYLO_* defs from mipsregs.h
  MIPS: KVM: Combine handle_tlb_ld/st_miss
  MIPS: KVM: Use va in kvm_get_inst()

 arch/mips/include/asm/kvm_host.h | 170 +++++++-------
 arch/mips/kernel/asm-offsets.c   |   4 -
 arch/mips/kernel/traps.c         |   1 +
 arch/mips/kvm/Makefile           |   1 +
 arch/mips/kvm/dyntrans.c         |  32 +--
 arch/mips/kvm/emulate.c          | 251 +++++++++-----------
 arch/mips/kvm/interrupt.c        |  12 +-
 arch/mips/kvm/interrupt.h        |  10 +-
 arch/mips/kvm/locore.S           |   7 +-
 arch/mips/kvm/mips.c             |  29 +--
 arch/mips/kvm/mmu.c              | 367 +++++++++++++++++++++++++++++
 arch/mips/kvm/tlb.c              | 481 +++------------------------------------
 arch/mips/kvm/trap_emul.c        | 133 ++++-------
 13 files changed, 675 insertions(+), 823 deletions(-)
 create mode 100644 arch/mips/kvm/mmu.c

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
-- 
2.4.10
