Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Oct 2011 18:46:52 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:54350 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901334Ab1J1Qqq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Oct 2011 18:46:46 +0200
Received: by ywm19 with SMTP id 19so4341027ywm.36
        for <multiple recipients>; Fri, 28 Oct 2011 09:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=pmXz9W+BXPX4LrBFEGIXriOG+tENCAK9NiFLz2x4UB8=;
        b=asmYbEii+p7cXAqTXqyjZlqyygAYyQGFYzrQCl0Fo6g90F63tdc82Up8gz4lVtFat+
         j7bXsy9DWqD7bCSCXX0I3alGspQoIoqyxdBP4/7ak+phEZUxooaK4Ch9rjn/bb+7IcH1
         B9H9xprzvLA60k7rELev8LvrJq/eY1Oh11YFo=
Received: by 10.151.3.13 with SMTP id f13mr3463708ybi.3.1319818592368;
        Fri, 28 Oct 2011 09:16:32 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id j13sm25787293ani.19.2011.10.28.09.16.30
        (version=SSLv3 cipher=OTHER);
        Fri, 28 Oct 2011 09:16:30 -0700 (PDT)
Message-ID: <4EAAD55D.4070106@gmail.com>
Date:   Fri, 28 Oct 2011 09:16:29 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Hillf Danton <dhillf@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Keep TLB cache hot while flushing
References: <CAJd=RBAQpea=wr2Nv6U1yRAH1bwaCvMxpnjfnKdhzAN3mtbK7A@mail.gmail.com>
In-Reply-To: <CAJd=RBAQpea=wr2Nv6U1yRAH1bwaCvMxpnjfnKdhzAN3mtbK7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20725

On 10/28/2011 07:15 AM, Hillf Danton wrote:
> Hi David,
>
> If we only flush the TLB of the given huge page, the TLB cache remains hot for
> the relevant mm as it is, and less will be refilled after flush, huge or not.
>
> As always all comments and ideas welcome.
>

I haven't tested it, but it looks correct.  When I wrote the original 
flush_tlb_mm(), I was in a hurry and was more concerned about 
maintaining TLB consistency, rather than performance.

> Thanks
>
> Signed-off-by: Hillf Danton<dhillf@gmail.com>

Acked-by: David Daney <david.daney@cavium.com>

> ---
>
> --- a/arch/mips/include/asm/hugetlb.h	Sat May 14 15:21:01 2011
> +++ b/arch/mips/include/asm/hugetlb.h	Fri Oct 28 22:08:05 2011
> @@ -70,7 +70,7 @@ static inline pte_t huge_ptep_get_and_cl
>   static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>   					 unsigned long addr, pte_t *ptep)
>   {
> -	flush_tlb_mm(vma->vm_mm);
> +	flush_tlb_page(vma, addr&  huge_page_mask(hstate_vma(vma)));
>   }
>
>   static inline int huge_pte_none(pte_t pte)
>
