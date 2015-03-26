Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Mar 2015 17:08:54 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16140 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014619AbbCZQIwqMXAE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Mar 2015 17:08:52 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id EFC1A6A4E1E1C;
        Thu, 26 Mar 2015 16:08:43 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 26 Mar 2015 16:08:46 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 26 Mar 2015 16:08:46 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-api@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v2 00/20] MIPS: KVM: Guest FPU & SIMD (MSA) support
Date:   Thu, 26 Mar 2015 16:08:30 +0000
Message-ID: <1427386113-30515-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46552
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

This patchset primarily adds guest Floating Point Unit (FPU) and MIPS
SIMD Architecture (MSA) support to MIPS KVM, by enabling the host
FPU/MSA while in guest mode.

This patchset depends on Paul Burton's FP/MSA fixes patchset, which will
make it into 4.0. I've only included the 3 patches (15, 19, 20) that
have changed since v1, which can be found here:
http://thread.gmane.org/gmane.linux.kernel.api/8984

The corresponding QEMU patchset can be found here:
http://thread.gmane.org/gmane.comp.emulators.kvm.devel/134314

Assuming there are no further review comments I'll submit a pull request
once Ralf has applied the FP/MSA fixes for me to merge.

Changes in v2:
- Add missing MSA vector and control register id bit patterns to API
  documentation.
- Rebased on KVM queue (KVM_CAP_MIPS_FPU & KVM_CAP_MIPS_MSA increased to
  108 & 109 after KVM_CAP_S390_VECTOR_REGISTERS took 107).
- Just call kvm_vm_ioctl_check_extension() from
  kvm_vcpu_ioctl_enable_cap() rather than duplicating the extension
  presence conditions (Paolo).


Original description:
- Adds KVM_CAP_MIPS_FPU and KVM_CAP_MIPS_MSA capabilities which must be
  enabled to add FPU/MSA to the guest.
- Supports FR=0, FR=1, FRE=1 floating point register modes and 128-bit
  vector registers.
- Does not support UFR/UFE (guest user control of FR/FRE bits), or MSA
  vector partitioning.
- Context restore is lazy: done on first actual use.
- Context save is lazy: once restored, host FPU/MSA gets
  enabled/disabled when guest enables/disables it, with registers left
  loaded as long as possible.
- So the state that can be loaded at any one time is:
    - No FPRs/vector state
    - FR=0 FPRs (change of FR discards FP state)
    - FR=1 FPRs
    - Vector state (includes FR=1 FPRs)
    - Vector state only (when guest CU1=0, FR=0)
- FCSR/MSACSR status registers are saved/restored around guest
  execution, since care must be taken to handle FP exceptions when
  writing these registers.

The patches are arranged roughly in groups:
- Patch 1 is a related minimal stable fix which can be applied in
  advance of the others (patch 18 fills it out a bit).
- Patch 2 is a generic MIPS change required to be able to restore
  FCSR/MSACSR registers with exceptions pending.
- Patches 3..10 add various misc KVM improvements and cleanups, most of
  which the later patches depend on.
- Patches 11..15 add the main guest FPU support.
- Patches 16..20 add the main guest MSA support (structured like 11.15).

James Hogan (20):
  MIPS: KVM: Handle MSA Disabled exceptions from guest

  MIPS: Clear [MSA]FPE CSR.Cause after notify_die()

  MIPS: KVM: Handle TRAP exceptions from guest kernel
  MIPS: KVM: Implement PRid CP0 register access
  MIPS: KVM: Sort kvm_mips_get_reg() registers
  MIPS: KVM: Drop pr_info messages on init/exit
  MIPS: KVM: Clean up register definitions a little
  MIPS: KVM: Simplify default guest Config registers
  MIPS: KVM: Add Config4/5 and writing of Config registers
  MIPS: KVM: Add vcpu_get_regs/vcpu_set_regs callback

  MIPS: KVM: Add base guest FPU support
  MIPS: KVM: Emulate FPU bits in COP0 interface
  MIPS: KVM: Add FP exception handling
  MIPS: KVM: Expose FPU registers
  MIPS: KVM: Wire up FPU capability

  MIPS: KVM: Add base guest MSA support
  MIPS: KVM: Emulate MSA bits in COP0 interface
  MIPS: KVM: Add MSA exception handling
  MIPS: KVM: Expose MSA registers
  MIPS: KVM: Wire up MSA capability

 Documentation/virtual/kvm/api.txt |  54 +++++
 arch/mips/include/asm/kdebug.h    |   3 +-
 arch/mips/include/asm/kvm_host.h  | 125 +++++++---
 arch/mips/include/uapi/asm/kvm.h  | 160 ++++++++-----
 arch/mips/kernel/asm-offsets.c    |  39 ++++
 arch/mips/kernel/genex.S          |  14 +-
 arch/mips/kernel/traps.c          |  16 +-
 arch/mips/kvm/Makefile            |   8 +-
 arch/mips/kvm/emulate.c           | 332 ++++++++++++++++++++++++++-
 arch/mips/kvm/fpu.S               | 122 ++++++++++
 arch/mips/kvm/locore.S            |  38 +++
 arch/mips/kvm/mips.c              | 472 +++++++++++++++++++++++++++++++++++++-
 arch/mips/kvm/msa.S               | 161 +++++++++++++
 arch/mips/kvm/stats.c             |   4 +
 arch/mips/kvm/tlb.c               |   6 +
 arch/mips/kvm/trap_emul.c         | 199 +++++++++++++++-
 include/uapi/linux/kvm.h          |   2 +
 17 files changed, 1631 insertions(+), 124 deletions(-)
 create mode 100644 arch/mips/kvm/fpu.S
 create mode 100644 arch/mips/kvm/msa.S

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: linux-doc@vger.kernel.org
-- 
2.0.5
