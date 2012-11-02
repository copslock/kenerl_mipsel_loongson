Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Nov 2012 18:11:16 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:50534 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6823043Ab2KBRLPSFTdF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Nov 2012 18:11:15 +0100
Received: from ::ffff:173.33.185.184 ([173.33.185.184]) by kymasys.com for <linux-mips@linux-mips.org>; Fri, 2 Nov 2012 10:11:04 -0700
Subject: Re: [PATCH 02/20] KVM/MIPS32: Arch specific KVM data structures.
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type:   text/plain; charset=US-ASCII
From:   Sanjay Lal <sanjayl@kymasys.com>
In-Reply-To: <50928F87.4060309@redhat.com>
Date:   Fri, 2 Nov 2012 13:11:03 -0400
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Content-Transfer-Encoding: 7BIT
Message-Id: <1F345D52-BEA7-4930-8C24-7DBE1EA56986@kymasys.com>
References: <54507365-0EF7-480A-8A54-75E12B3677D9@kymasys.com> <50928F87.4060309@redhat.com>
To:     Avi Kivity <avi@redhat.com>
X-Mailer: Apple Mail (2.1283)
X-archive-position: 34859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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


On Nov 1, 2012, at 11:04 AM, Avi Kivity wrote:

> On 10/31/2012 05:18 PM, Sanjay Lal wrote:
> 
>> +
>> +/* Special address that contains the comm page, used for reducing # of traps */
>> +#define KVM_GUEST_COMMPAGE_ADDR     0x0
>> +
>> +struct kvm_arch
>> +{
>> +    /* Guest GVA->HPA page table */
>> +    ulong *guest_pmap;
>> +    ulong guest_pmap_npages;
>> +
>> +    /* Wired host TLB used for the commpage */
>> +    int commpage_tlb;
>> +
>> +    pfn_t (*gfn_to_pfn) (struct kvm *kvm, gfn_t gfn);
>> +    void (*release_pfn_clean) (pfn_t pfn);
>> +    bool (*is_error_pfn) (pfn_t pfn);
> 
> Why this indirection?  Do those functions change at runtime?

On MIPS, kernel modules are executed from "mapped space", which requires TLBs.  The TLB handling code is statically linked with the rest of the kernel (kvm_tlb.c) to avoid the possibility of double faulting. The problem is that the code references routines that are part of the the KVM module, which are only available once the module is loaded, hence the indirection.

> 
>> +
>> +struct kvm_mips_callbacks {
>> +    int (*handle_cop_unusable)(struct kvm_vcpu *vcpu);
>> +    int (*handle_tlb_mod)(struct kvm_vcpu *vcpu);
>> +    int (*handle_tlb_ld_miss)(struct kvm_vcpu *vcpu);
>> +    int (*handle_tlb_st_miss)(struct kvm_vcpu *vcpu);
>> +    int (*handle_addr_err_st)(struct kvm_vcpu *vcpu);
>> +    int (*handle_addr_err_ld)(struct kvm_vcpu *vcpu);
>> +    int (*handle_syscall)(struct kvm_vcpu *vcpu);
>> +    int (*handle_res_inst)(struct kvm_vcpu *vcpu);
>> +    int (*handle_break)(struct kvm_vcpu *vcpu);
>> +    gpa_t (*gva_to_gpa)(gva_t gva);
>> +    void (*queue_timer_int)(struct kvm_vcpu *vcpu);
>> +    void (*dequeue_timer_int)(struct kvm_vcpu *vcpu);
>> +    void (*queue_io_int)(struct kvm_vcpu *vcpu, struct kvm_mips_interrupt *irq);
>> +    void (*dequeue_io_int)(struct kvm_vcpu *vcpu, struct kvm_mips_interrupt *irq);
>> +    int (*irq_deliver)(struct kvm_vcpu *vcpu, unsigned int priority, uint32_t cause);
>> +    int (*irq_clear)(struct kvm_vcpu *vcpu, unsigned int priority, uint32_t cause);
>> +    int (*vcpu_ioctl_get_regs)(struct kvm_vcpu *vcpu, struct kvm_regs *regs);
>> +    int (*vcpu_ioctl_set_regs)(struct kvm_vcpu *vcpu, struct kvm_regs *regs);
>> +    int (*vcpu_init)(struct kvm_vcpu *vcpu);
>> +};
> 
> We use callbacks on x86 because we have two separate implementations
> (svm and vmx).  Will that be the case on MIPS? If not, use direct calls.

We will eventually have separate implementations based on the features supported by H/W.
