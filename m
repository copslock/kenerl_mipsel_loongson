Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2012 16:18:44 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:38145 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819780Ab2KAPSnOCgye (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Nov 2012 16:18:43 +0100
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qA1FIee5019877
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 1 Nov 2012 11:18:40 -0400
Received: from balrog.usersys.tlv.redhat.com (dhcp-4-121.tlv.redhat.com [10.35.4.121])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id qA1FIcNs018027;
        Thu, 1 Nov 2012 11:18:38 -0400
Message-ID: <509292CD.5030700@redhat.com>
Date:   Thu, 01 Nov 2012 17:18:37 +0200
From:   Avi Kivity <avi@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 04/20] KVM/MIPS32: MIPS arch specific APIs for KVM
References: <74E3548E-9F3A-4849-BD5A-D1AAE19A0982@kymasys.com>
In-Reply-To: <74E3548E-9F3A-4849-BD5A-D1AAE19A0982@kymasys.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
X-archive-position: 34845
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
> - Implements the arch specific APIs for KVM, some are stubs for MIPS
> - kvm_mips_handle_exit(): Main 'C' distpatch routine for handling exceptions while in "Guest" mode.
> - Also implements in-kernel timer interrupt support for the guest.
> 
> +
> +static void
> +kvm_mips_init_tlbs (void *arg)
> +{
> +    ulong flags, wired;
> +    struct kvm *kvm = (struct kvm *) arg;
> +    
> +    ENTER_CRITICAL(flags);
> +    /* Add a wired entry to the TLB, it is used to map the commpage to the Guest kernel */
> +    wired = read_c0_wired();
> +    write_c0_wired(wired + 1);
> +    mtc0_tlbw_hazard();
> +    kvm->arch.commpage_tlb = wired;
> +    EXIT_CRITICAL(flags);
> +

Since this is called from smp_call_function(), it is called with
interrupts disabled.

> +    kvm_debug("[%d] commpage TLB: %d\n", smp_processor_id(), kvm->arch.commpage_tlb);
> +}
> +
> +int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
> +{
> +	int cpu;
> +
> +    if (atomic_inc_return(&kvm_mips_instance) == 1) {
> +        kvm_info("%s: 1st KVM instance, setup host TLB parameters\n", __func__);
> +	    for_each_online_cpu(cpu) {
> +		    smp_call_function_single(cpu, kvm_mips_init_tlbs, kvm, 1);
> +        }

Use on_each_cpu() instead.

> +    }
> +
> +    kvm->arch.gfn_to_pfn = gfn_to_pfn;
> +    kvm->arch.release_pfn_clean = kvm_release_pfn_clean;
> +    kvm->arch.is_error_pfn = is_error_pfn;
> +
> +	return 0;
> +}
> +
> +
> +
> +void kvm_arch_flush_shadow_all(struct kvm *kvm)
> +{
> +}
> +
> +void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
> +				   struct kvm_memory_slot *slot)
> +{
> +}
> +
> +

Don't you need to flush the shadow tlbs here?

> +
> +ulong kvm_mips_get_ramsize (struct kvm *kvm)
> +{
> +    return (kvm->memslots->memslots[0].npages << PAGE_SHIFT);
> +}

What is this?

Slot 0 is not special on other archs.

> +
> +void
> +kvm_arch_flush_shadow(struct kvm *kvm)
> +{
> +}

Flush here too?
> +
> +int
> +kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
> +{
> +    int r = 0;
> +    sigset_t sigsaved;
> +
> +    if (vcpu->sigset_active)
> +        sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
> +
> +    if (vcpu->mmio_needed) {
> +        if (!vcpu->mmio_is_write)
> +            kvm_mips_complete_mmio_load(vcpu, run);
> +        vcpu->mmio_needed = 0;
> +    }
> +
> +    /* Check if we have any exceptions/interrupts pending */
> +    kvm_mips_deliver_interrupts(vcpu, kvm_read_c0_guest_cause(vcpu->arch.cop0));
> +
> +    local_irq_disable();
> +    kvm_guest_enter();
> +
> +    r = __kvm_mips_vcpu_run(run, vcpu);

So you handle all exits with interrupts disabled?  What about TLB misses
that need to swap in a page?  What about host interrupts?

> +
> +    kvm_guest_exit();
> +    local_irq_enable();
> +
> +    if (vcpu->sigset_active)
> +        sigprocmask(SIG_SETMASK, &sigsaved, NULL);
> +
> +    return r;
> +}
> +
> +int
> +
> +/*  
> + * Return value is in the form (errcode<<2 | RESUME_FLAG_HOST | RESUME_FLAG_NV)
> + */
> +int
> +kvm_mips_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
> +{
> +    uint32_t cause = vcpu->arch.host_cp0_cause;
> +    uint32_t exccode = (cause >> CAUSEB_EXCCODE) & 0x1f;
> +    uint32_t __user *opc = (uint32_t __user *) vcpu->arch.pc;
> +    ulong badvaddr = vcpu->arch.host_cp0_badvaddr;
> +    enum emulation_result er = EMULATE_DONE;
> +    int ret = RESUME_GUEST;
> +
> +    /* Set a default exit reason */
> +    run->exit_reason = KVM_EXIT_UNKNOWN;
> +    run->ready_for_interrupt_injection = 1;

ready_for_interrupt_injection is an x86ism, you probably don't need it.

> +
> +    /* Set the appropriate status bits based on host CPU features, before we hit the scheduler */
> +    kvm_mips_set_c0_status();
> +
> +    local_irq_enable();

Ah, so you handle exits with interrupts enabled.  But that's not how we
usually do it; the standard pattern is


 while (can continue)
     disable interrupts
     enter guest
     enable interrupts
     process exit


> +
> +    kvm_debug("kvm_mips_handle_exit: cause: %#x, PC: %p, kvm_run: %p, kvm_vcpu: %p\n", 
> +        cause, opc, run, vcpu);
> +
> +    /* Do a privilege check, if in UM most of these exit conditions end up
> +     * causing an exception to be delivered to the Guest Kernel
> +     */
> +    er = kvm_mips_check_privilege (cause, opc, run, vcpu);
> +    if (er == EMULATE_PRIV_FAIL) {
> +        goto skip_emul;
> +    }
> +    else if (er == EMULATE_FAIL) {
> +        run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
> +        ret = RESUME_HOST;
> +        goto skip_emul;
> +    }
> +
> +    switch (exccode) {
> +    case T_INT:
> +        kvm_debug("[%d]T_INT @ %p\n", vcpu->vcpu_id, opc);
> +
> +        kvm_mips_account_exit(vcpu, INT_EXITS);
> +
> +        if (need_resched()) {
> +            cond_resched();
> +        }
> +
> +        ret = RESUME_GUEST;
> +        break;
> +
> +    case T_COP_UNUSABLE:
> +        kvm_debug("T_COP_UNUSABLE: @ PC: %p\n", opc);
> +
> +        kvm_mips_account_exit(vcpu, COP_UNUSABLE_EXITS);
> +        ret = kvm_mips_callbacks->handle_cop_unusable(vcpu);
> +        /* XXXKYMA: Might need to return to user space */
> +        if (run->exit_reason == KVM_EXIT_IRQ_WINDOW_OPEN) {
> +            ret = RESUME_HOST;
> +        }
> +        break;
> +
> +    case T_TLB_MOD:
> +        kvm_mips_account_exit(vcpu, TLBMOD_EXITS);
> +        ret = kvm_mips_callbacks->handle_tlb_mod(vcpu);
> +        break;
> +
> +    case T_TLB_ST_MISS:
> +        kvm_debug("TLB ST fault:  cause %#x, status %#lx, PC: %p, BadVaddr: %#lx\n",
> +                   cause, kvm_read_c0_guest_status(vcpu->arch.cop0), opc, badvaddr);
> +
> +        kvm_mips_account_exit(vcpu, TLBMISS_ST_EXITS);
> +        ret = kvm_mips_callbacks->handle_tlb_st_miss(vcpu);
> +        break;
> +
> +    case T_TLB_LD_MISS:
> +        kvm_debug("TLB LD fault: cause %#x, PC: %p, BadVaddr: %#lx\n", cause, opc, badvaddr);
> +
> +        kvm_mips_account_exit(vcpu, TLBMISS_LD_EXITS);
> +        ret = kvm_mips_callbacks->handle_tlb_ld_miss(vcpu);
> +        break;
> +
> +    case T_ADDR_ERR_ST:
> +        kvm_mips_account_exit(vcpu, ADDRERR_ST_EXITS);
> +        ret = kvm_mips_callbacks->handle_addr_err_st(vcpu);
> +        break;
> +
> +    case T_ADDR_ERR_LD:
> +        kvm_mips_account_exit(vcpu, ADDRERR_LD_EXITS);
> +        ret = kvm_mips_callbacks->handle_addr_err_ld(vcpu);
> +        break;
> +
> +    case T_SYSCALL:
> +        kvm_mips_account_exit(vcpu, SYSCALL_EXITS);
> +        ret = kvm_mips_callbacks->handle_syscall(vcpu);
> +        break;
> +
> +    case T_RES_INST:
> +        kvm_mips_account_exit(vcpu, RESVD_INST_EXITS);
> +        ret = kvm_mips_callbacks->handle_res_inst(vcpu);
> +        break;
> +
> +    case T_BREAK:
> +        kvm_mips_account_exit(vcpu, BREAK_INST_EXITS);
> +        ret = kvm_mips_callbacks->handle_break(vcpu);
> +        break;
> +
> +    default:
> +        kvm_err("Exception Code: %d, not yet handled, @ PC: %p, inst: 0x%08x  BadVaddr: %#lx Status: %#lx\n",
> +             exccode, opc, kvm_get_inst(opc, vcpu), badvaddr, kvm_read_c0_guest_status(vcpu->arch.cop0));
> +        kvm_arch_vcpu_dump_regs(vcpu);
> +        run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
> +        ret = RESUME_HOST;
> +        break;
> +
> +    }
> +
> +skip_emul:
> +    local_irq_disable();
> +
> +    if (er == EMULATE_DONE && !(ret & RESUME_HOST))
> +        kvm_mips_deliver_interrupts(vcpu, cause);
> +
> +    if (!(ret & RESUME_HOST)) {
> +        /* Only check for signals if not already exiting to userspace  */
> +        if (signal_pending(current)) {
> +            run->exit_reason = KVM_EXIT_INTR;
> +            ret = (-EINTR << 2) | RESUME_HOST;
> +            kvm_mips_account_exit(vcpu, SIGNAL_EXITS);
> +        }
> +    }
> +
> +    return (ret);
> +}
> +void
> +kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
> +{
> +    kvm_mips_vcpu_load(vcpu, cpu);

No need for indirection, just fold these two functions.

> +    return;
> +}
> +
> +void
> +kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
> +{
> +    /* During VM shutdown */
> +    if (!vcpu)
> +        return;

Hmm, shouldn't happen.

> +
> +    kvm_mips_vcpu_put(vcpu);
> +    return;
> +}
> +
> +
> +
> +int __init
> +kvm_mips_init(void)
> +{
> +    int ret;
> +
> +    ret = kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
> +
> +    if (ret)
> +        return (ret);
> +
> +    printk("KVM/MIPS Initialized\n");
> +    return (0);
> +}
> +
> +void __exit
> +kvm_mips_exit(void)
> +{
> +    kvm_exit();
> +    printk("KVM/MIPS unloaded\n");
> +}
> +
> +module_init(kvm_mips_init);
> +module_exit(kvm_mips_exit);
> 


-- 
error compiling committee.c: too many arguments to function
