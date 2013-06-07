Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 12:58:59 +0200 (CEST)
Received: from mail-ie0-f172.google.com ([209.85.223.172]:53198 "EHLO
        mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818472Ab3FGXDv6vFPY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:03:51 +0200
Received: by mail-ie0-f172.google.com with SMTP id 17so12309662iea.3
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=fIcb2IVrVYimL5AybFaA8s6oiaLJba0w583vtONIPHA=;
        b=Ux6ShZc2qkPpCpCfT7X/1SJpFhwLoWbC4EsMbo+KWKsswFJOtl75SLbn5xhvsLMfZl
         XulJdLuHZrp0JOn5P1cmKPZwFbsZHNAEp7DkqxwMPqi43RW3iP9AqIOhivkA1YqTbVFy
         YCVr04dpujyFLCrW2fgFcePHTaRr9ZePfW1yTx76jjNYYKthZhQNWu/NJ5l/1nH8PNI5
         wRVSzu09IKGvRi8ziOMZzlzngamgh8QYdYuyE3G8blHy/7WMueEfPOLX+eKD5F/mZi6R
         1UEGusV/s3TmhyogdRUrr++F9XNwPW4CHTGJkfNpV+fu1FT0YfbEYz9hHljtIYrLevFM
         C7Iw==
X-Received: by 10.50.30.2 with SMTP id o2mr464120igh.12.1370646225492;
        Fri, 07 Jun 2013 16:03:45 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id gz1sm182405igb.5.2013.06.07.16.03.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:44 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3gAx006610;
        Fri, 7 Jun 2013 16:03:42 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3cE6006607;
        Fri, 7 Jun 2013 16:03:38 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 00/31] KVM/MIPS: Implement hardware virtualization via the MIPS-VZ extensions.
Date:   Fri,  7 Jun 2013 16:03:04 -0700
Message-Id: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36793
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

These patches take a somewhat different approach to MIPS
virtualization via the MIPS-VZ extensions than the patches previously
sent by Sanjay Lal.

Several facts about the code:

o Existing exception handlers are modified to hook in to KVM instead
  of intercepting all exceptions via the EBase register, and then
  chaining to real exception handlers.

o Able to boot 64-bit SMP guests that use the FPU (I have booted 4-way
  SMP 64-bit MIPS/Linux).

o Additional overhead on every exception even when *no* vCPU is running.

o Lower interrupt overhead, than the EBase interception method, when
  vCPU *is* running.

o This code is somewhat smaller than the existing trap/emulate
  implementation (about 2100 lines vs. about 5300 lines)

o Currently probably only usable on the OCTEON III CPU model, as some
  MIPS-VZ implementation-defined behaviors were assumed to have the
  OCTEON III behavior.

Note: I think Ralf already has the 17/31 (MIPS: Quit exposing Kconfig
symbols in uapi headers.) queued, but I also include it here.

David Daney (31):
  MIPS: Move allocate_kscratch to cpu-probe.c and make it public.
  MIPS: Save and restore K0/K1 when CONFIG_KVM_MIPSVZ
  mips/kvm: Fix 32-bitisms in kvm_locore.S
  mips/kvm: Add casts to avoid pointer width mismatch build failures.
  mips/kvm: Use generic cache flushing functions.
  mips/kvm: Rename kvm_vcpu_arch.pc to  kvm_vcpu_arch.epc
  mips/kvm: Rename VCPU_registername to KVM_VCPU_ARCH_registername
  mips/kvm: Fix code formatting in arch/mips/kvm/kvm_locore.S
  mips/kvm: Factor trap-and-emulate support into a pluggable
    implementation.
  mips/kvm: Implement ioctls to get and set FPU registers.
  MIPS: Rearrange branch.c so it can be used by kvm code.
  MIPS: Add instruction format information for WAIT, MTC0, MFC0, et al.
  mips/kvm: Add accessors for MIPS VZ registers.
  mips/kvm: Add thread_info flag to indicate operation in MIPS VZ Guest
    Mode.
  mips/kvm: Exception handling to leave and reenter guest mode.
  mips/kvm: Add exception handler for MIPSVZ Guest exceptions.
  MIPS: Quit exposing Kconfig symbols in uapi headers.
  mips/kvm: Add pt_regs slots for BadInstr and BadInstrP
  mips/kvm: Add host definitions for MIPS VZ based host.
  mips/kvm: Hook into TLB fault handlers.
  mips/kvm: Allow set_except_vector() to be used from MIPSVZ code.
  mips/kvm: Split get_new_mmu_context into two parts.
  mips/kvm: Hook into CP unusable exception handler.
  mips/kvm: Add thread_struct fields used by MIPSVZ hosts.
  mips/kvm: Add some asm-offsets constants used by MIPSVZ.
  mips/kvm: Split up Kconfig and Makefile definitions in preperation
    for MIPSVZ.
  mips/kvm: Gate the use of kvm_local_flush_tlb_all() by KVM_MIPSTE
  mips/kvm: Only use KVM_COALESCED_MMIO_PAGE_OFFSET with KVM_MIPSTE
  mips/kvm: Add MIPSVZ support.
  mips/kvm: Enable MIPSVZ in Kconfig/Makefile
  mips/kvm: Allow for upto 8 KVM vcpus per vm.

 arch/mips/Kconfig                   |    1 +
 arch/mips/include/asm/branch.h      |    7 +
 arch/mips/include/asm/kvm_host.h    |  622 +-----------
 arch/mips/include/asm/kvm_mips_te.h |  589 +++++++++++
 arch/mips/include/asm/kvm_mips_vz.h |   29 +
 arch/mips/include/asm/mipsregs.h    |  264 +++++
 arch/mips/include/asm/mmu_context.h |   12 +-
 arch/mips/include/asm/processor.h   |    6 +
 arch/mips/include/asm/ptrace.h      |   36 +
 arch/mips/include/asm/stackframe.h  |  150 ++-
 arch/mips/include/asm/thread_info.h |    2 +
 arch/mips/include/asm/uasm.h        |    2 +-
 arch/mips/include/uapi/asm/inst.h   |   23 +-
 arch/mips/include/uapi/asm/ptrace.h |   17 +-
 arch/mips/kernel/asm-offsets.c      |  124 ++-
 arch/mips/kernel/branch.c           |   63 +-
 arch/mips/kernel/cpu-probe.c        |   34 +
 arch/mips/kernel/genex.S            |    8 +
 arch/mips/kernel/scall64-64.S       |   12 +
 arch/mips/kernel/scall64-n32.S      |   12 +
 arch/mips/kernel/traps.c            |   15 +-
 arch/mips/kvm/Kconfig               |   23 +-
 arch/mips/kvm/Makefile              |   15 +-
 arch/mips/kvm/kvm_locore.S          |  980 +++++++++---------
 arch/mips/kvm/kvm_mips.c            |  768 ++------------
 arch/mips/kvm/kvm_mips_comm.h       |    1 +
 arch/mips/kvm/kvm_mips_commpage.c   |    9 +-
 arch/mips/kvm/kvm_mips_dyntrans.c   |    4 +-
 arch/mips/kvm/kvm_mips_emul.c       |  312 +++---
 arch/mips/kvm/kvm_mips_int.c        |   53 +-
 arch/mips/kvm/kvm_mips_int.h        |    2 -
 arch/mips/kvm/kvm_mips_stats.c      |    6 +-
 arch/mips/kvm/kvm_mipsvz.c          | 1894 +++++++++++++++++++++++++++++++++++
 arch/mips/kvm/kvm_mipsvz_guest.S    |  234 +++++
 arch/mips/kvm/kvm_tlb.c             |  140 +--
 arch/mips/kvm/kvm_trap_emul.c       |  932 +++++++++++++++--
 arch/mips/mm/fault.c                |    8 +
 arch/mips/mm/tlbex-fault.S          |    6 +
 arch/mips/mm/tlbex.c                |   45 +-
 39 files changed, 5299 insertions(+), 2161 deletions(-)
 create mode 100644 arch/mips/include/asm/kvm_mips_te.h
 create mode 100644 arch/mips/include/asm/kvm_mips_vz.h
 create mode 100644 arch/mips/kvm/kvm_mipsvz.c
 create mode 100644 arch/mips/kvm/kvm_mipsvz_guest.S

-- 
1.7.11.7
