Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2016 20:30:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54556 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042320AbcFOSaM7amOW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2016 20:30:12 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 57623AE79E133;
        Wed, 15 Jun 2016 19:30:01 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 15 Jun 2016 19:30:05 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        David Daney <david.daney@cavium.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 00/17] MIPS: KVM: Misc KVM T&E improvements
Date:   Wed, 15 Jun 2016 19:29:44 +0100
Message-ID: <1466015401-24433-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54053
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

This patchset gathers together some miscellaneous MIPS KVM (trap &
emulate) improvements.

Patches 8 and 15 in particular change non-KVM MIPS code, so Acks
appreciated. They are used by other patches in the series, so it makes
sense I think to keep them together.

The patchset is based on my recent MIPS KVM patchsets:

[PATCH 0/4] MIPS: KVM: Module + non dynamic translating fixes
[PATCH 00/18] MIPS: KVM: Miscellaneous clean-ups
[PATCH 0/8] MIPS: KVM: Debug & trace event improvements

Changes include:
- Patches 1-3: Dynamic translation & emulation fix/cleanups.
- Patches 4-7: Dynamic KVM_GET_REG_LIST so it can actually properly list
  all available registers, which allows for improved robustness of
  userland, especially for VZ support where the core may implement
  optional registers that KVM can't opt out of exposing.
- Patches 8-11: HWREna / RDHWR handling improvements.
- Patch 12: Add guest KScratch registers.
- Patches 13-17: Other miscellaneous improvements.

James Hogan (17):
  MIPS: KVM: Fix translation of MFC0 ErrCtl
  MIPS: KVM: Factor writing of translated guest instructions
  MIPS: KVM: Convert emulation to use asm/inst.h
  MIPS: KVM: Pass all unknown registers to callbacks
  MIPS: KVM: Make KVM_GET_REG_LIST dynamic
  MIPS: KVM: Use raw_cpu_has_fpu in kvm_mips_guest_can_have_fpu()
  MIPS: KVM: List FPU/MSA registers
  MIPS: Clean up RDHWR handling
  MIPS: KVM: Don't hardcode restored HWREna
  MIPS: KVM: Allow ULRI to restrict UserLocal register
  MIPS: KVM: Emulate RDHWR CPUNum register
  MIPS: KVM: Add KScratch registers
  MIPS: KVM: Move commpage so 0x0 is unmapped
  MIPS: KVM: Use host CCA for TLB mappings
  MIPS: Add define for Config.VI (virtual icache) bit
  MIPS: KVM: Report more accurate CP0_Config fields to guest
  MIPS: KVM: Use mipsregs.h defs for config registers

 Documentation/virtual/kvm/api.txt                  |   6 +
 arch/mips/include/asm/kvm_host.h                   | 122 +++++---------
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |   2 +-
 arch/mips/include/asm/mipsregs.h                   |  21 ++-
 arch/mips/include/asm/setup.h                      |   1 +
 arch/mips/include/uapi/asm/inst.h                  |  35 +++-
 arch/mips/kernel/traps.c                           |  22 ++-
 arch/mips/kvm/commpage.c                           |   2 +-
 arch/mips/kvm/dyntrans.c                           | 156 ++++++++----------
 arch/mips/kvm/emulate.c                            | 142 ++++++++--------
 arch/mips/kvm/locore.S                             |   4 +-
 arch/mips/kvm/mips.c                               | 180 +++++++++++++++++----
 arch/mips/kvm/mmu.c                                |  18 ++-
 arch/mips/kvm/tlb.c                                |  19 +--
 arch/mips/kvm/trace.h                              |   6 +
 arch/mips/kvm/trap_emul.c                          |  39 ++++-
 arch/mips/mm/c-r4k.c                               |   2 +-
 17 files changed, 465 insertions(+), 312 deletions(-)

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
-- 
2.4.10
