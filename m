Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 01:24:03 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:61367 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835007Ab3FIXYBe7VDt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Jun 2013 01:24:01 +0200
Received: by mail-pa0-f49.google.com with SMTP id ld11so1065746pab.22
        for <multiple recipients>; Sun, 09 Jun 2013 16:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=FM6QOSZVgSz6cT97NzRm09+ziEx+CohZ3Ei5kvqSs4w=;
        b=HXI94Sbj9ss8o6Bbu4B4Sw/m0EsDaoXGpy770U7ldwBXqH3cG83BU/hSfvpiin1F0X
         Q6SqmCmcarrWyUjk7q5B4kHJHcRbr3my/t8IH/CurUh7CaCX9GIkHb52aviO4UKV45LI
         vS7eUnT2K7pCU4oJobpwclJk1rzcnMRcQL8xYzSHj8d3bEaCkmGyjAr8M0TvRq3rkBwO
         XaE/AGs0jOTQuetUqTQTIIqZCehRyQWpB3QWaNmAipqlnALvMC4M/ShMwLZo/2tf7MiM
         1mVtNtdgt8+hB+Hxo0po5SAD5EBaE8d9ggfVaO/sBq2MG+6YZ0YIRberSXCN57xAJjZ+
         Loeg==
X-Received: by 10.68.131.195 with SMTP id oo3mr7472184pbb.143.1370820234894;
        Sun, 09 Jun 2013 16:23:54 -0700 (PDT)
Received: from dd_xps.caveonetworks.com (adsl-67-124-149-174.dsl.pltn13.pacbell.net. [67.124.149.174])
        by mx.google.com with ESMTPSA id l4sm8033484pbo.6.2013.06.09.16.23.52
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 16:23:54 -0700 (PDT)
Message-ID: <51B50E87.2060501@gmail.com>
Date:   Sun, 09 Jun 2013 16:23:51 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Gleb Natapov <gleb@redhat.com>
CC:     David Daney <ddaney@caviumnetworks.com>,
        David Daney <ddaney.cavm@gmail.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        Sanjay Lal <sanjayl@kymasys.com>, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 00/31] KVM/MIPS: Implement hardware virtualization via
 the MIPS-VZ extensions.
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com> <51B26974.5000306@caviumnetworks.com> <20130609073115.GE4725@redhat.com>
In-Reply-To: <20130609073115.GE4725@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
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

On 06/09/2013 12:31 AM, Gleb Natapov wrote:
> On Fri, Jun 07, 2013 at 04:15:00PM -0700, David Daney wrote:
>> I should also add that I will shortly send patches for the kvm tool
>> required to drive this VM as well as a small set of patches that
>> create a para-virtualized MIPS/Linux guest kernel.
>>
>> The idea is that because there is no standard SMP linux system, we
>> create a standard para-virtualized system that uses a handful of
>> hypercalls, but mostly just uses virtio devices.  It has no emulated
>> real hardware (no 8250 UART, no emulated legacy anything...)
>>
> Virtualization is useful for running legacy code. Why dismiss support
> for non pv guests so easily?

Just because we create standard PV system devices, doesn't preclude 
emulating real hardware.  In fact Sanjay Lal's work includes QEMU 
support for doing just this for a MIPS malta board.  I just wanted a 
very simple system I could implement with the kvm tool in a couple of 
days, so that is what I initially did.

The problem is that almost nobody has real malta boards, they are really 
only of interest because QEMU implements a virtual malta board.

Personally, I see the most interesting us cases of MIPS KVM being a 
deployment platform for new services, so legacy support is not so 
important to me.  That doesn't mean that other people wouldn't want some 
sort of legacy support.  The problem with 'legacy' on MIPS is that there 
are hundreds of legacies to choose from (Old SGI and DEC hardware, 
various network hardware from many different vendors, etc.).  Which 
would you choose?

>   How different MIPS SMP systems are?

o Old SGI heavy metal (several different system architectures).

o Cavium OCTEON SMP SoCs.

o Broadcom (several flavors) SoCs

o Loongson


Come to think of it, Emulating SGI hardware might be an interesting 
case.  There may be old IRIX systems and applications that could be 
running low on real hardware.  Some of those systems take up a whole 
room and draw a lot of power.  They might run faster and at much lower 
power consumption on a modern 48-Way SMP SoC based system.

>   What
> about running non pv UP systems?

See above.  I think this is what Sanjay Lal is doing.

>
>> David Daney
>>
>>
>> On 06/07/2013 04:03 PM, David Daney wrote:
>>> From: David Daney <david.daney@cavium.com>
>>>
>>> These patches take a somewhat different approach to MIPS
>>> virtualization via the MIPS-VZ extensions than the patches previously
>>> sent by Sanjay Lal.
>>>
>>> Several facts about the code:
>>>
>>> o Existing exception handlers are modified to hook in to KVM instead
>>>    of intercepting all exceptions via the EBase register, and then
>>>    chaining to real exception handlers.
>>>
>>> o Able to boot 64-bit SMP guests that use the FPU (I have booted 4-way
>>>    SMP 64-bit MIPS/Linux).
>>>
>>> o Additional overhead on every exception even when *no* vCPU is running.
>>>
>>> o Lower interrupt overhead, than the EBase interception method, when
>>>    vCPU *is* running.
>>>
>>> o This code is somewhat smaller than the existing trap/emulate
>>>    implementation (about 2100 lines vs. about 5300 lines)
>>>
>>> o Currently probably only usable on the OCTEON III CPU model, as some
>>>    MIPS-VZ implementation-defined behaviors were assumed to have the
>>>    OCTEON III behavior.
>>>
>>> Note: I think Ralf already has the 17/31 (MIPS: Quit exposing Kconfig
>>> symbols in uapi headers.) queued, but I also include it here.
>>>
>>> David Daney (31):
>>>    MIPS: Move allocate_kscratch to cpu-probe.c and make it public.
>>>    MIPS: Save and restore K0/K1 when CONFIG_KVM_MIPSVZ
>>>    mips/kvm: Fix 32-bitisms in kvm_locore.S
>>>    mips/kvm: Add casts to avoid pointer width mismatch build failures.
>>>    mips/kvm: Use generic cache flushing functions.
>>>    mips/kvm: Rename kvm_vcpu_arch.pc to  kvm_vcpu_arch.epc
>>>    mips/kvm: Rename VCPU_registername to KVM_VCPU_ARCH_registername
>>>    mips/kvm: Fix code formatting in arch/mips/kvm/kvm_locore.S
>>>    mips/kvm: Factor trap-and-emulate support into a pluggable
>>>      implementation.
>>>    mips/kvm: Implement ioctls to get and set FPU registers.
>>>    MIPS: Rearrange branch.c so it can be used by kvm code.
>>>    MIPS: Add instruction format information for WAIT, MTC0, MFC0, et al.
>>>    mips/kvm: Add accessors for MIPS VZ registers.
>>>    mips/kvm: Add thread_info flag to indicate operation in MIPS VZ Guest
>>>      Mode.
>>>    mips/kvm: Exception handling to leave and reenter guest mode.
>>>    mips/kvm: Add exception handler for MIPSVZ Guest exceptions.
>>>    MIPS: Quit exposing Kconfig symbols in uapi headers.
>>>    mips/kvm: Add pt_regs slots for BadInstr and BadInstrP
>>>    mips/kvm: Add host definitions for MIPS VZ based host.
>>>    mips/kvm: Hook into TLB fault handlers.
>>>    mips/kvm: Allow set_except_vector() to be used from MIPSVZ code.
>>>    mips/kvm: Split get_new_mmu_context into two parts.
>>>    mips/kvm: Hook into CP unusable exception handler.
>>>    mips/kvm: Add thread_struct fields used by MIPSVZ hosts.
>>>    mips/kvm: Add some asm-offsets constants used by MIPSVZ.
>>>    mips/kvm: Split up Kconfig and Makefile definitions in preperation
>>>      for MIPSVZ.
>>>    mips/kvm: Gate the use of kvm_local_flush_tlb_all() by KVM_MIPSTE
>>>    mips/kvm: Only use KVM_COALESCED_MMIO_PAGE_OFFSET with KVM_MIPSTE
>>>    mips/kvm: Add MIPSVZ support.
>>>    mips/kvm: Enable MIPSVZ in Kconfig/Makefile
>>>    mips/kvm: Allow for upto 8 KVM vcpus per vm.
>>>
>>>   arch/mips/Kconfig                   |    1 +
>>>   arch/mips/include/asm/branch.h      |    7 +
>>>   arch/mips/include/asm/kvm_host.h    |  622 +-----------
>>>   arch/mips/include/asm/kvm_mips_te.h |  589 +++++++++++
>>>   arch/mips/include/asm/kvm_mips_vz.h |   29 +
>>>   arch/mips/include/asm/mipsregs.h    |  264 +++++
>>>   arch/mips/include/asm/mmu_context.h |   12 +-
>>>   arch/mips/include/asm/processor.h   |    6 +
>>>   arch/mips/include/asm/ptrace.h      |   36 +
>>>   arch/mips/include/asm/stackframe.h  |  150 ++-
>>>   arch/mips/include/asm/thread_info.h |    2 +
>>>   arch/mips/include/asm/uasm.h        |    2 +-
>>>   arch/mips/include/uapi/asm/inst.h   |   23 +-
>>>   arch/mips/include/uapi/asm/ptrace.h |   17 +-
>>>   arch/mips/kernel/asm-offsets.c      |  124 ++-
>>>   arch/mips/kernel/branch.c           |   63 +-
>>>   arch/mips/kernel/cpu-probe.c        |   34 +
>>>   arch/mips/kernel/genex.S            |    8 +
>>>   arch/mips/kernel/scall64-64.S       |   12 +
>>>   arch/mips/kernel/scall64-n32.S      |   12 +
>>>   arch/mips/kernel/traps.c            |   15 +-
>>>   arch/mips/kvm/Kconfig               |   23 +-
>>>   arch/mips/kvm/Makefile              |   15 +-
>>>   arch/mips/kvm/kvm_locore.S          |  980 +++++++++---------
>>>   arch/mips/kvm/kvm_mips.c            |  768 ++------------
>>>   arch/mips/kvm/kvm_mips_comm.h       |    1 +
>>>   arch/mips/kvm/kvm_mips_commpage.c   |    9 +-
>>>   arch/mips/kvm/kvm_mips_dyntrans.c   |    4 +-
>>>   arch/mips/kvm/kvm_mips_emul.c       |  312 +++---
>>>   arch/mips/kvm/kvm_mips_int.c        |   53 +-
>>>   arch/mips/kvm/kvm_mips_int.h        |    2 -
>>>   arch/mips/kvm/kvm_mips_stats.c      |    6 +-
>>>   arch/mips/kvm/kvm_mipsvz.c          | 1894 +++++++++++++++++++++++++++++++++++
>>>   arch/mips/kvm/kvm_mipsvz_guest.S    |  234 +++++
>>>   arch/mips/kvm/kvm_tlb.c             |  140 +--
>>>   arch/mips/kvm/kvm_trap_emul.c       |  932 +++++++++++++++--
>>>   arch/mips/mm/fault.c                |    8 +
>>>   arch/mips/mm/tlbex-fault.S          |    6 +
>>>   arch/mips/mm/tlbex.c                |   45 +-
>>>   39 files changed, 5299 insertions(+), 2161 deletions(-)
>>>   create mode 100644 arch/mips/include/asm/kvm_mips_te.h
>>>   create mode 100644 arch/mips/include/asm/kvm_mips_vz.h
>>>   create mode 100644 arch/mips/kvm/kvm_mipsvz.c
>>>   create mode 100644 arch/mips/kvm/kvm_mipsvz_guest.S
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
> --
> 			Gleb.
>
