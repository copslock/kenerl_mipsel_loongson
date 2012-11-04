Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Nov 2012 20:04:58 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:11684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825923Ab2KDTE4zJPwL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 4 Nov 2012 20:04:56 +0100
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qA4J4pro022021
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sun, 4 Nov 2012 14:04:52 -0500
Received: from dragon.usersys.redhat.com (vpn-229-27.phx2.redhat.com [10.3.229.27])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id qA4J4nGe026307;
        Sun, 4 Nov 2012 14:04:49 -0500
Message-ID: <5096BC50.8070006@redhat.com>
Date:   Sun, 04 Nov 2012 21:04:48 +0200
From:   Avi Kivity <avi@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 02/20] KVM/MIPS32: Arch specific KVM data structures.
References: <54507365-0EF7-480A-8A54-75E12B3677D9@kymasys.com> <50928F87.4060309@redhat.com> <1F345D52-BEA7-4930-8C24-7DBE1EA56986@kymasys.com>
In-Reply-To: <1F345D52-BEA7-4930-8C24-7DBE1EA56986@kymasys.com>
X-Enigmail-Version: 1.4.5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
X-archive-position: 34864
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

On 11/02/2012 07:11 PM, Sanjay Lal wrote:
> On Nov 1, 2012, at 11:04 AM, Avi Kivity wrote:
>
> > On 10/31/2012 05:18 PM, Sanjay Lal wrote:
> > 
> >> +
> >> +/* Special address that contains the comm page, used for reducing # of traps */
> >> +#define KVM_GUEST_COMMPAGE_ADDR     0x0
> >> +
> >> +struct kvm_arch
> >> +{
> >> +    /* Guest GVA->HPA page table */
> >> +    ulong *guest_pmap;
> >> +    ulong guest_pmap_npages;
> >> +
> >> +    /* Wired host TLB used for the commpage */
> >> +    int commpage_tlb;
> >> +
> >> +    pfn_t (*gfn_to_pfn) (struct kvm *kvm, gfn_t gfn);
> >> +    void (*release_pfn_clean) (pfn_t pfn);
> >> +    bool (*is_error_pfn) (pfn_t pfn);
> > 
> > Why this indirection?  Do those functions change at runtime?
>
> On MIPS, kernel modules are executed from "mapped space", which requires TLBs.  The TLB handling code is statically linked with the rest of the kernel (kvm_tlb.c) to avoid the possibility of double faulting. The problem is that the code references routines that are part of the the KVM module, which are only available once the module is loaded, hence the indirection.

Ok.  These should be global function pointers then, assigned when the
module is loaded, and cleared when it is unloaded, with a comment
explaining why.

>
> > 
> >> +
> >> +struct kvm_mips_callbacks {
> >> +    int (*handle_cop_unusable)(struct kvm_vcpu *vcpu);
> >> +    int (*handle_tlb_mod)(struct kvm_vcpu *vcpu);
> >> +    int (*handle_tlb_ld_miss)(struct kvm_vcpu *vcpu);
> >> +    int (*handle_tlb_st_miss)(struct kvm_vcpu *vcpu);
> >> +    int (*handle_addr_err_st)(struct kvm_vcpu *vcpu);
> >> +    int (*handle_addr_err_ld)(struct kvm_vcpu *vcpu);
> >> +    int (*handle_syscall)(struct kvm_vcpu *vcpu);
> >> +    int (*handle_res_inst)(struct kvm_vcpu *vcpu);
> >> +    int (*handle_break)(struct kvm_vcpu *vcpu);
> >> +    gpa_t (*gva_to_gpa)(gva_t gva);
> >> +    void (*queue_timer_int)(struct kvm_vcpu *vcpu);
> >> +    void (*dequeue_timer_int)(struct kvm_vcpu *vcpu);
> >> +    void (*queue_io_int)(struct kvm_vcpu *vcpu, struct kvm_mips_interrupt *irq);
> >> +    void (*dequeue_io_int)(struct kvm_vcpu *vcpu, struct kvm_mips_interrupt *irq);
> >> +    int (*irq_deliver)(struct kvm_vcpu *vcpu, unsigned int priority, uint32_t cause);
> >> +    int (*irq_clear)(struct kvm_vcpu *vcpu, unsigned int priority, uint32_t cause);
> >> +    int (*vcpu_ioctl_get_regs)(struct kvm_vcpu *vcpu, struct kvm_regs *regs);
> >> +    int (*vcpu_ioctl_set_regs)(struct kvm_vcpu *vcpu, struct kvm_regs *regs);
> >> +    int (*vcpu_init)(struct kvm_vcpu *vcpu);
> >> +};
> > 
> > We use callbacks on x86 because we have two separate implementations
> > (svm and vmx).  Will that be the case on MIPS? If not, use direct calls.
>
> We will eventually have separate implementations based on the features supported by H/W.

It's probably better to add the indirection when the need arrives,
unless you already have hardware specs and know exactly the best points
for a split.

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.
