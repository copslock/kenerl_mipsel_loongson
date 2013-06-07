Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:15:47 +0200 (CEST)
Received: from co1ehsobe002.messaging.microsoft.com ([216.32.180.185]:42422
        "EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835254Ab3FGXPKyxrnc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:15:10 +0200
Received: from mail8-co1-R.bigfish.com (10.243.78.234) by
 CO1EHSOBE039.bigfish.com (10.243.66.104) with Microsoft SMTP Server id
 14.1.225.23; Fri, 7 Jun 2013 23:15:04 +0000
Received: from mail8-co1 (localhost [127.0.0.1])        by mail8-co1-R.bigfish.com
 (Postfix) with ESMTP id 10C70540284;   Fri,  7 Jun 2013 23:15:04 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:157.56.238.53;KIP:(null);UIP:(null);IPV:NLI;H:BY2PRD0712HT002.namprd07.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: -4
X-BigFish: PS-4(zzbb2dI98dI9371I1432Izz1f42h1ee6h1de0h1fdah1202h1e76h1d1ah1d2ah1fc6hzz8275bhz2dh2a8h668h839h947hd25he5bhf0ah1288h12a5h12a9h12bdh137ah13b6h1441h14ddh1504h1537h153bh162dh1631h1758h1765h18e1h190ch1946h19b4h19c3h19ceh1ad9h1b0ah1d0ch1d2eh1d3fh1dfeh1dffh1e1dh1155h)
Received: from mail8-co1 (localhost.localdomain [127.0.0.1]) by mail8-co1
 (MessageSwitch) id 1370646902375035_9370; Fri,  7 Jun 2013 23:15:02 +0000
 (UTC)
Received: from CO1EHSMHS013.bigfish.com (unknown [10.243.78.226])       by
 mail8-co1.bigfish.com (Postfix) with ESMTP id 4E706AA0069;     Fri,  7 Jun 2013
 23:15:02 +0000 (UTC)
Received: from BY2PRD0712HT002.namprd07.prod.outlook.com (157.56.238.53) by
 CO1EHSMHS013.bigfish.com (10.243.66.23) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Fri, 7 Jun 2013 23:15:02 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.246.35) with Microsoft SMTP Server (TLS) id 14.16.293.5; Fri, 7 Jun
 2013 23:15:01 +0000
Message-ID: <51B26974.5000306@caviumnetworks.com>
Date:   Fri, 7 Jun 2013 16:15:00 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>, <kvm@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        Sanjay Lal <sanjayl@kymasys.com>,
        <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 00/31] KVM/MIPS: Implement hardware virtualization via
 the MIPS-VZ extensions.
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

I should also add that I will shortly send patches for the kvm tool 
required to drive this VM as well as a small set of patches that create 
a para-virtualized MIPS/Linux guest kernel.

The idea is that because there is no standard SMP linux system, we 
create a standard para-virtualized system that uses a handful of 
hypercalls, but mostly just uses virtio devices.  It has no emulated 
real hardware (no 8250 UART, no emulated legacy anything...)

David Daney


On 06/07/2013 04:03 PM, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
>
> These patches take a somewhat different approach to MIPS
> virtualization via the MIPS-VZ extensions than the patches previously
> sent by Sanjay Lal.
>
> Several facts about the code:
>
> o Existing exception handlers are modified to hook in to KVM instead
>    of intercepting all exceptions via the EBase register, and then
>    chaining to real exception handlers.
>
> o Able to boot 64-bit SMP guests that use the FPU (I have booted 4-way
>    SMP 64-bit MIPS/Linux).
>
> o Additional overhead on every exception even when *no* vCPU is running.
>
> o Lower interrupt overhead, than the EBase interception method, when
>    vCPU *is* running.
>
> o This code is somewhat smaller than the existing trap/emulate
>    implementation (about 2100 lines vs. about 5300 lines)
>
> o Currently probably only usable on the OCTEON III CPU model, as some
>    MIPS-VZ implementation-defined behaviors were assumed to have the
>    OCTEON III behavior.
>
> Note: I think Ralf already has the 17/31 (MIPS: Quit exposing Kconfig
> symbols in uapi headers.) queued, but I also include it here.
>
> David Daney (31):
>    MIPS: Move allocate_kscratch to cpu-probe.c and make it public.
>    MIPS: Save and restore K0/K1 when CONFIG_KVM_MIPSVZ
>    mips/kvm: Fix 32-bitisms in kvm_locore.S
>    mips/kvm: Add casts to avoid pointer width mismatch build failures.
>    mips/kvm: Use generic cache flushing functions.
>    mips/kvm: Rename kvm_vcpu_arch.pc to  kvm_vcpu_arch.epc
>    mips/kvm: Rename VCPU_registername to KVM_VCPU_ARCH_registername
>    mips/kvm: Fix code formatting in arch/mips/kvm/kvm_locore.S
>    mips/kvm: Factor trap-and-emulate support into a pluggable
>      implementation.
>    mips/kvm: Implement ioctls to get and set FPU registers.
>    MIPS: Rearrange branch.c so it can be used by kvm code.
>    MIPS: Add instruction format information for WAIT, MTC0, MFC0, et al.
>    mips/kvm: Add accessors for MIPS VZ registers.
>    mips/kvm: Add thread_info flag to indicate operation in MIPS VZ Guest
>      Mode.
>    mips/kvm: Exception handling to leave and reenter guest mode.
>    mips/kvm: Add exception handler for MIPSVZ Guest exceptions.
>    MIPS: Quit exposing Kconfig symbols in uapi headers.
>    mips/kvm: Add pt_regs slots for BadInstr and BadInstrP
>    mips/kvm: Add host definitions for MIPS VZ based host.
>    mips/kvm: Hook into TLB fault handlers.
>    mips/kvm: Allow set_except_vector() to be used from MIPSVZ code.
>    mips/kvm: Split get_new_mmu_context into two parts.
>    mips/kvm: Hook into CP unusable exception handler.
>    mips/kvm: Add thread_struct fields used by MIPSVZ hosts.
>    mips/kvm: Add some asm-offsets constants used by MIPSVZ.
>    mips/kvm: Split up Kconfig and Makefile definitions in preperation
>      for MIPSVZ.
>    mips/kvm: Gate the use of kvm_local_flush_tlb_all() by KVM_MIPSTE
>    mips/kvm: Only use KVM_COALESCED_MMIO_PAGE_OFFSET with KVM_MIPSTE
>    mips/kvm: Add MIPSVZ support.
>    mips/kvm: Enable MIPSVZ in Kconfig/Makefile
>    mips/kvm: Allow for upto 8 KVM vcpus per vm.
>
>   arch/mips/Kconfig                   |    1 +
>   arch/mips/include/asm/branch.h      |    7 +
>   arch/mips/include/asm/kvm_host.h    |  622 +-----------
>   arch/mips/include/asm/kvm_mips_te.h |  589 +++++++++++
>   arch/mips/include/asm/kvm_mips_vz.h |   29 +
>   arch/mips/include/asm/mipsregs.h    |  264 +++++
>   arch/mips/include/asm/mmu_context.h |   12 +-
>   arch/mips/include/asm/processor.h   |    6 +
>   arch/mips/include/asm/ptrace.h      |   36 +
>   arch/mips/include/asm/stackframe.h  |  150 ++-
>   arch/mips/include/asm/thread_info.h |    2 +
>   arch/mips/include/asm/uasm.h        |    2 +-
>   arch/mips/include/uapi/asm/inst.h   |   23 +-
>   arch/mips/include/uapi/asm/ptrace.h |   17 +-
>   arch/mips/kernel/asm-offsets.c      |  124 ++-
>   arch/mips/kernel/branch.c           |   63 +-
>   arch/mips/kernel/cpu-probe.c        |   34 +
>   arch/mips/kernel/genex.S            |    8 +
>   arch/mips/kernel/scall64-64.S       |   12 +
>   arch/mips/kernel/scall64-n32.S      |   12 +
>   arch/mips/kernel/traps.c            |   15 +-
>   arch/mips/kvm/Kconfig               |   23 +-
>   arch/mips/kvm/Makefile              |   15 +-
>   arch/mips/kvm/kvm_locore.S          |  980 +++++++++---------
>   arch/mips/kvm/kvm_mips.c            |  768 ++------------
>   arch/mips/kvm/kvm_mips_comm.h       |    1 +
>   arch/mips/kvm/kvm_mips_commpage.c   |    9 +-
>   arch/mips/kvm/kvm_mips_dyntrans.c   |    4 +-
>   arch/mips/kvm/kvm_mips_emul.c       |  312 +++---
>   arch/mips/kvm/kvm_mips_int.c        |   53 +-
>   arch/mips/kvm/kvm_mips_int.h        |    2 -
>   arch/mips/kvm/kvm_mips_stats.c      |    6 +-
>   arch/mips/kvm/kvm_mipsvz.c          | 1894 +++++++++++++++++++++++++++++++++++
>   arch/mips/kvm/kvm_mipsvz_guest.S    |  234 +++++
>   arch/mips/kvm/kvm_tlb.c             |  140 +--
>   arch/mips/kvm/kvm_trap_emul.c       |  932 +++++++++++++++--
>   arch/mips/mm/fault.c                |    8 +
>   arch/mips/mm/tlbex-fault.S          |    6 +
>   arch/mips/mm/tlbex.c                |   45 +-
>   39 files changed, 5299 insertions(+), 2161 deletions(-)
>   create mode 100644 arch/mips/include/asm/kvm_mips_te.h
>   create mode 100644 arch/mips/include/asm/kvm_mips_vz.h
>   create mode 100644 arch/mips/kvm/kvm_mipsvz.c
>   create mode 100644 arch/mips/kvm/kvm_mipsvz_guest.S
>
