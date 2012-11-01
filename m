Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2012 16:29:02 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:40869 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819780Ab2KAP3Bh1wPD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Nov 2012 16:29:01 +0100
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qA1FSvtg024129
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 1 Nov 2012 11:28:58 -0400
Received: from balrog.usersys.tlv.redhat.com (dhcp-4-121.tlv.redhat.com [10.35.4.121])
        by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id qA1F4dDh009696;
        Thu, 1 Nov 2012 11:04:40 -0400
Message-ID: <50928F87.4060309@redhat.com>
Date:   Thu, 01 Nov 2012 17:04:39 +0200
From:   Avi Kivity <avi@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 02/20] KVM/MIPS32: Arch specific KVM data structures.
References: <54507365-0EF7-480A-8A54-75E12B3677D9@kymasys.com>
In-Reply-To: <54507365-0EF7-480A-8A54-75E12B3677D9@kymasys.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
X-archive-position: 34847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: avi@redhat.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 10/31/2012 05:18 PM, Sanjay Lal wrote:
> 
> Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
> ---
>  arch/mips/include/asm/kvm.h      |  58 ++++
>  arch/mips/include/asm/kvm_host.h | 672 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 730 insertions(+)
>  create mode 100644 arch/mips/include/asm/kvm.h
>  create mode 100644 arch/mips/include/asm/kvm_host.h
> 
> diff --git a/arch/mips/include/asm/kvm.h b/arch/mips/include/asm/kvm.h
> new file mode 100644
> index 0000000..39bb715
> --- /dev/null
> +++ b/arch/mips/include/asm/kvm.h
> @@ -0,0 +1,58 @@
> +/*
> +* This file is subject to the terms and conditions of the GNU General Public
> +* License.  See the file "COPYING" in the main directory of this archive
> +* for more details.
> +*
> +*
> +* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
> +* Authors: Sanjay Lal <sanjayl@kymasys.com>
> +*/
> +
> +
> +#ifndef __LINUX_KVM_MIPS_H
> +#define __LINUX_KVM_MIPS_H
> +
> +#include <linux/types.h>
> +
> +#define __KVM_MIPS
> +
> +#define N_MIPS_COPROC_REGS      32
> +#define N_MIPS_COPROC_SEL   	8
> +
> +/* for KVM_GET_REGS and KVM_SET_REGS */
> +struct kvm_regs {
> +    __u32 gprs[32];
> +    __u32 hi;
> +    __u32 lo;
> +    __u32 pc;
> +
> +    ulong cp0reg[N_MIPS_COPROC_REGS][N_MIPS_COPROC_SEL];
> +};

ulong changes size in 64-bit archs, requiring compat translations when
issuing 32-bit syscalls on a 64-bit kernel.  I don't know MIPS enough to
know whether that's a useful scenario.

> +
> +#define KVM_MAX_VCPUS 8

Set to 1 until smp is supported.

> +#define KVM_MEMORY_SLOTS 32
> +/* memory slots that does not exposed to userspace */
> +#define KVM_PRIVATE_MEM_SLOTS 4

Do you really need those?

> +
> +#define ENTER_CRITICAL(flags)   local_irq_save(flags)
> +#define EXIT_CRITICAL(flags)    local_irq_restore(flags)

Why wrap?

> +
> +
> +#define KVM_GUEST_KERNEL_ASID  ((vcpu->arch.guest_kernel_asid[smp_processor_id()]) & ASID_MASK)
> +
> +#define KVM_GUEST_USER_ASID		((vcpu->arch.guest_user_asid[smp_processor_id()]) & ASID_MASK)
> +
> +
> +#define KVM_GUEST_WIRED_TLBS    (current_cpu_data.tlbsize)
> +#define KVM_GUEST_COMMPAGE_TLB  (vcpu->kvm->arch.commpage_tlb)
> +#define KVM_GUEST_TLBS          KVM_GUEST_WIRED_TLBS

Don't use defines for variable expressions.  Use inline functions for
those, or just open-code when it's more readable.

> +
> +/* Special address that contains the comm page, used for reducing # of traps */
> +#define KVM_GUEST_COMMPAGE_ADDR     0x0
> +
> +struct kvm_arch
> +{
> +    /* Guest GVA->HPA page table */
> +    ulong *guest_pmap;
> +    ulong guest_pmap_npages;
> +
> +    /* Wired host TLB used for the commpage */
> +    int commpage_tlb;
> +
> +    pfn_t (*gfn_to_pfn) (struct kvm *kvm, gfn_t gfn);
> +    void (*release_pfn_clean) (pfn_t pfn);
> +    bool (*is_error_pfn) (pfn_t pfn);

Why this indirection?  Do those functions change at runtime?

> +
> +    /* Stats for exit reasons */
> +    ulong exit_reason_stats[MAX_KVM_MIPS_EXIT_TYPES];
> +};

Please use tracepoints for statistics instead of manual collection +
debugfs.

> +
> +struct kvm_mips_callbacks {
> +    int (*handle_cop_unusable)(struct kvm_vcpu *vcpu);
> +    int (*handle_tlb_mod)(struct kvm_vcpu *vcpu);
> +    int (*handle_tlb_ld_miss)(struct kvm_vcpu *vcpu);
> +    int (*handle_tlb_st_miss)(struct kvm_vcpu *vcpu);
> +    int (*handle_addr_err_st)(struct kvm_vcpu *vcpu);
> +    int (*handle_addr_err_ld)(struct kvm_vcpu *vcpu);
> +    int (*handle_syscall)(struct kvm_vcpu *vcpu);
> +    int (*handle_res_inst)(struct kvm_vcpu *vcpu);
> +    int (*handle_break)(struct kvm_vcpu *vcpu);
> +    gpa_t (*gva_to_gpa)(gva_t gva);
> +    void (*queue_timer_int)(struct kvm_vcpu *vcpu);
> +    void (*dequeue_timer_int)(struct kvm_vcpu *vcpu);
> +    void (*queue_io_int)(struct kvm_vcpu *vcpu, struct kvm_mips_interrupt *irq);
> +    void (*dequeue_io_int)(struct kvm_vcpu *vcpu, struct kvm_mips_interrupt *irq);
> +    int (*irq_deliver)(struct kvm_vcpu *vcpu, unsigned int priority, uint32_t cause);
> +    int (*irq_clear)(struct kvm_vcpu *vcpu, unsigned int priority, uint32_t cause);
> +    int (*vcpu_ioctl_get_regs)(struct kvm_vcpu *vcpu, struct kvm_regs *regs);
> +    int (*vcpu_ioctl_set_regs)(struct kvm_vcpu *vcpu, struct kvm_regs *regs);
> +    int (*vcpu_init)(struct kvm_vcpu *vcpu);
> +};

We use callbacks on x86 because we have two separate implementations
(svm and vmx).  Will that be the case on MIPS? If not, use direct calls.



-- 
error compiling committee.c: too many arguments to function
