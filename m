Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 May 2013 11:27:20 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:32654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818014Ab3ENJ1QYrRej (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 May 2013 11:27:16 +0200
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4E9R8lb008351
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 14 May 2013 05:27:08 -0400
Received: from dhcp-1-237.tlv.redhat.com (dhcp-4-26.tlv.redhat.com [10.35.4.26])
        by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r4E9R690011488;
        Tue, 14 May 2013 05:27:07 -0400
Received: by dhcp-1-237.tlv.redhat.com (Postfix, from userid 13519)
        id 620BA18D3DE; Tue, 14 May 2013 12:27:05 +0300 (IDT)
Date:   Tue, 14 May 2013 12:27:05 +0300
From:   Gleb Natapov <gleb@redhat.com>
To:     Sanjay Lal <sanjayl@kymasys.com>
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org,
        mtosatti@redhat.com, ralf@linux-mips.org
Subject: Re: [PATCH 2/2] KVM/MIPS32: Wrap calls to gfn_to_pfn() with
 srcu_read_lock/unlock()
Message-ID: <20130514092705.GD20995@redhat.com>
References: <n>
 <1368476500-20031-1-git-send-email-sanjayl@kymasys.com>
 <1368476500-20031-3-git-send-email-sanjayl@kymasys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1368476500-20031-3-git-send-email-sanjayl@kymasys.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Return-Path: <gleb@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gleb@redhat.com
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

On Mon, May 13, 2013 at 01:21:40PM -0700, Sanjay Lal wrote:
> 

Explain kvm_mips_map_page() changes here please. The text from the cover
letter does not go into git history.

> Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
> ---
>  arch/mips/kvm/kvm_tlb.c | 38 +++++++++++++++++++++++++++++---------
>  1 file changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
> index 89511a9..218075f 100644
> --- a/arch/mips/kvm/kvm_tlb.c
> +++ b/arch/mips/kvm/kvm_tlb.c
> @@ -16,7 +16,10 @@
>  #include <linux/mm.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
> +#include <linux/bootmem.h>
>  #include <linux/kvm_host.h>
> +#include <linux/srcu.h>
> +
>  
>  #include <asm/cpu.h>
>  #include <asm/bootinfo.h>
> @@ -36,6 +39,8 @@
>  /* Use VZ EntryHi.EHINV to invalidate TLB entries */
>  #define UNIQUE_ENTRYHI(idx) (CKSEG0 + ((idx) << (PAGE_SHIFT + 1)))
>  
> +EXPORT_SYMBOL(min_low_pfn);     /* defined by bootmem.c, but not exported by generic code */
> +
What you need this for? It is not used anywhere in this patch and by
mips/kvm code in general.

>  atomic_t kvm_mips_instance;
>  EXPORT_SYMBOL(kvm_mips_instance);
>  
> @@ -169,21 +174,27 @@ void kvm_mips_dump_shadow_tlbs(struct kvm_vcpu *vcpu)
>  	}
>  }
>  
> -static void kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
> +static int kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
>  {
> +	int srcu_idx, err = 0;
>  	pfn_t pfn;
>  
>  	if (kvm->arch.guest_pmap[gfn] != KVM_INVALID_PAGE)
> -		return;
> +		return 0;
>  
> +        srcu_idx = srcu_read_lock(&kvm->srcu);
Use tabs to indent.

>  	pfn = kvm_mips_gfn_to_pfn(kvm, gfn);
>  
>  	if (kvm_mips_is_error_pfn(pfn)) {
> -		panic("Couldn't get pfn for gfn %#" PRIx64 "!\n", gfn);
> +		kvm_err("Couldn't get pfn for gfn %#" PRIx64 "!\n", gfn);
> +		err = -EFAULT;
> +		goto out;
>  	}
>  
>  	kvm->arch.guest_pmap[gfn] = pfn;
> -	return;
> +out:
> +	srcu_read_unlock(&kvm->srcu, srcu_idx);
> +	return err;
>  }
>  
>  /* Translate guest KSEG0 addresses to Host PA */
> @@ -207,7 +218,10 @@ unsigned long kvm_mips_translate_guest_kseg0_to_hpa(struct kvm_vcpu *vcpu,
>  			gva);
>  		return KVM_INVALID_PAGE;
>  	}
> -	kvm_mips_map_page(vcpu->kvm, gfn);
> +
> +	if (kvm_mips_map_page(vcpu->kvm, gfn) < 0)
> +		return KVM_INVALID_ADDR;
> +
>  	return (kvm->arch.guest_pmap[gfn] << PAGE_SHIFT) + offset;
>  }
>  
> @@ -310,8 +324,11 @@ int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
>  	even = !(gfn & 0x1);
>  	vaddr = badvaddr & (PAGE_MASK << 1);
>  
> -	kvm_mips_map_page(vcpu->kvm, gfn);
> -	kvm_mips_map_page(vcpu->kvm, gfn ^ 0x1);
> +	if (kvm_mips_map_page(vcpu->kvm, gfn) < 0)
> +		return -1;
> +
> +	if (kvm_mips_map_page(vcpu->kvm, gfn ^ 0x1) < 0)
> +		return -1;
>  
>  	if (even) {
>  		pfn0 = kvm->arch.guest_pmap[gfn];
> @@ -389,8 +406,11 @@ kvm_mips_handle_mapped_seg_tlb_fault(struct kvm_vcpu *vcpu,
>  		pfn0 = 0;
>  		pfn1 = 0;
>  	} else {
> -		kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo0) >> PAGE_SHIFT);
> -		kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo1) >> PAGE_SHIFT);
> +		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo0) >> PAGE_SHIFT) < 0)
> +			return -1;
> +
> +		if (kvm_mips_map_page(kvm, mips3_tlbpfn_to_paddr(tlb->tlb_lo1) >> PAGE_SHIFT) < 0)
> +			return -1;
>  
>  		pfn0 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo0) >> PAGE_SHIFT];
>  		pfn1 = kvm->arch.guest_pmap[mips3_tlbpfn_to_paddr(tlb->tlb_lo1) >> PAGE_SHIFT];
> -- 
> 1.7.11.3

--
			Gleb.
