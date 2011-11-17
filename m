Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 00:57:17 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:53904 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904090Ab1KQX5K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2011 00:57:10 +0100
Received: from akpm.mtv.corp.google.com (216-239-45-4.google.com [216.239.45.4])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2D06C3C0;
        Thu, 17 Nov 2011 23:55:30 +0000 (UTC)
Date:   Thu, 17 Nov 2011 15:57:03 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     David Rientjes <rientjes@google.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Robin Holt <holt@sgi.com>
Subject: Re: [patch] hugetlb: remove dummy definitions of HPAGE_MASK and
 HPAGE_SIZE
Message-Id: <20111117155703.b8af6be5.akpm@linux-foundation.org>
In-Reply-To: <4EC59E3C.5070204@gmail.com>
References: <1321567050-13197-1-git-send-email-ddaney.cavm@gmail.com>
        <alpine.DEB.2.00.1111171520130.20133@chino.kir.corp.google.com>
        <alpine.DEB.2.00.1111171522131.20133@chino.kir.corp.google.com>
        <20111117153526.f90ee248.akpm@linux-foundation.org>
        <alpine.DEB.2.00.1111171538540.13555@chino.kir.corp.google.com>
        <4EC59E3C.5070204@gmail.com>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 31778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14987

On Thu, 17 Nov 2011 15:52:28 -0800
David Daney <ddaney.cavm@gmail.com> wrote:

> A counter argument would be:
> 
> There are hundreds of places in the kernel where dummy definitions are 
> selected by !CONFIG_* so that we can do:
> 
>     if (test_something()) {
>        do_one_thing();
>     } else {
>        do_the_other_thing();
>     }
> 
> 
> Rather than:
> 
> #ifdef CONFIG_SOMETHING
>     if (test_something()) {
>        do_one_thing();
>     } else
> #else
>     {
>        do_the_other_thing();
>     }
> 
> 
> 
> We even do this all over the place with dummy definitions selected by 
> CONFIG_HUGETLB_PAGE, What exactly makes HPAGE_MASK special and not the 
> hundreds of other similar situations?

yup.  Look at free_pgtables():

		if (is_vm_hugetlb_page(vma)) {
			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
				floor, next? next->vm_start: ceiling);
		} else {

and

#define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) ({BUG(); 0; })

This is the same thing.
