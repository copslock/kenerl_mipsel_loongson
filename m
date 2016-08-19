Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 17:38:30 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:46044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992325AbcHSPiWVllK9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Aug 2016 17:38:22 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F82381250;
        Fri, 19 Aug 2016 15:38:14 +0000 (UTC)
Received: from [10.36.112.23] (ovpn-112-23.ams2.redhat.com [10.36.112.23])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u7JFc9Dg012365
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 19 Aug 2016 11:38:11 -0400
Subject: Re: [PATCH] MIPS: KVM: Check for pfn noslot case
To:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <30bb792dbba5a6fa2a274c11740bbc7005a3ca31.1471611726.git-series.james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, stable@vger.kernel.org
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <89e6286c-3103-7397-2fdf-288348f8066f@redhat.com>
Date:   Fri, 19 Aug 2016 17:38:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <30bb792dbba5a6fa2a274c11740bbc7005a3ca31.1471611726.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 19 Aug 2016 15:38:14 +0000 (UTC)
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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



On 19/08/2016 15:30, James Hogan wrote:
> When mapping a page into the guest we error check using is_error_pfn(),
> however this doesn't detect a value of KVM_PFN_NOSLOT, indicating an
> error HVA for the page. This can only happen on MIPS right now due to
> unusual memslot management (e.g. being moved / removed / resized), or
> with an Enhanced Virtual Memory (EVA) configuration where the default
> KVM_HVA_ERR_* and kvm_is_error_hva() definitions are unsuitable (fixed
> in a later patch). This case will be treated as a pfn of zero, mapping
> the first page of physical memory into the guest.
> 
> It would appear the MIPS KVM port wasn't updated prior to being merged
> (in v3.10) to take commit 81c52c56e2b4 ("KVM: do not treat noslot pfn as
> a error pfn") into account (merged v3.8), which converted a bunch of
> is_error_pfn() calls to is_error_noslot_pfn(). Switch to using
> is_error_noslot_pfn() instead to catch this case properly.
> 
> Fixes: 858dd5d45733 ("KVM/MIPS32: MMU/TLB operations for the Guest.")
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: kvm@vger.kernel.org
> Cc: <stable@vger.kernel.org> # 3.10.y-
> ---
>  arch/mips/kvm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
> index 6cfdcf55572d..121008c0fcc9 100644
> --- a/arch/mips/kvm/mmu.c
> +++ b/arch/mips/kvm/mmu.c
> @@ -40,7 +40,7 @@ static int kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
>  	srcu_idx = srcu_read_lock(&kvm->srcu);
>  	pfn = gfn_to_pfn(kvm, gfn);
>  
> -	if (is_error_pfn(pfn)) {
> +	if (is_error_noslot_pfn(pfn)) {
>  		kvm_err("Couldn't get pfn for gfn %#llx!\n", gfn);
>  		err = -EFAULT;
>  		goto out;
> 

Queued for 4.8-rc3, thanks.
