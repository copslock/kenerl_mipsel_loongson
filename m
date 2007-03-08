Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Mar 2007 09:02:36 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.232]:60570 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021516AbXCHJCc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Mar 2007 09:02:32 +0000
Received: by qb-out-0506.google.com with SMTP id a33so2119394qbd
        for <linux-mips@linux-mips.org>; Thu, 08 Mar 2007 01:01:22 -0800 (PST)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uRX5mmpbwY5tnDEmiPF7WbWDefexyu3Y1qFURrX24Xu0Dvy3ag7Do5/S2awjYPjKUQVqrTt66qt7QQxbvjfY8Tb+Mkl7G3Y61ZXiLRTQHdTmQTa1vPjCKar8vdjSr1KZ/fZ+ifUg0aH5nurxYetC5eE2dcC8SwIqyMw8sqbzaOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DFHPH18E2ivqTnIck4+EaeZRqZCUuJGh02FqnKl/tptrfTbk90mx3iBFDy3mRRH6tpQmkQt4ImHs7P6zt8nIUZbXTg+PpwXT2kl6+hybgehQEsyx72F6p6kQwj6fWXw/fZmIOTYmvANaNpy8WaLfs+W16sPr6kHjG7pedPZpA3w=
Received: by 10.115.111.1 with SMTP id o1mr62957wam.1173344481815;
        Thu, 08 Mar 2007 01:01:21 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Thu, 8 Mar 2007 01:01:21 -0800 (PST)
Message-ID: <cda58cb80703080101g41b4242cu76692d604e83d7ab@mail.gmail.com>
Date:	Thu, 8 Mar 2007 10:01:21 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	mbizon@freebox.fr
Subject: Re: [PATCH 0/2] FLATMEM: allow memory to start at pfn != 0 [take #2]
Cc:	linux-mips <linux-mips@linux-mips.org>, ralf <ralf@linux-mips.org>
In-Reply-To: <1173286700.6970.24.camel@sakura.staff.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <116841864595-git-send-email-fbuihuu@gmail.com>
	 <1172879147.964.65.camel@sakura.staff.proxad.net>
	 <cda58cb80703050615r4e559ca1u78517634ac23a27@mail.gmail.com>
	 <1173112433.7093.36.camel@sakura.staff.proxad.net>
	 <cda58cb80703061339l2f8cfc09m5823b090b69a7aa7@mail.gmail.com>
	 <1173286700.6970.24.camel@sakura.staff.proxad.net>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi

On 3/7/07, Maxime Bizon <mbizon@freebox.fr> wrote:
> I found the problem, I think these two liners are missing from your

good catch ! I dunno why this is missing from the original patch since
I have this in my own tree.

> patch. My board now works correctly, with 2MB more free memory, thanks
> for this ! (and for the free tour in mm/ ;)
>

yeah 2MB is quite a lot for embedded system.

>
>
>
> Commit 6f284a2ce7b8bc49cb8455b1763357897a899abb introduced PHYS_OFFSET,
> but missed some virtual to physical address conversion. The following
> patch fixes it.
>
>
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
>
> --- linux-2.6.20/include/asm-mips/pgtable.h     2007-02-04 21:22:45.000000000 +0100
> +++ linux/include/asm-mips/pgtable.h    2007-03-07 17:28:20.000000000 +0100
> @@ -75,7 +75,7 @@
>   * Conversion functions: convert a page and protection to a page entry,
>   * and a page entry and page directory to the page they refer to.
>   */
> -#define pmd_phys(pmd)          (pmd_val(pmd) - PAGE_OFFSET)
> +#define pmd_phys(pmd)          (pmd_val(pmd) - PAGE_OFFSET + PHYS_OFFSET)

please use virt_to_phys() instead plain translation...

>  #define pmd_page(pmd)          (pfn_to_page(pmd_phys(pmd) >> PAGE_SHIFT))
>  #define pmd_page_vaddr(pmd)    pmd_val(pmd)
>
> --- linux-2.6.20/include/asm-mips/pgtable-64.h  2007-02-04 21:22:45.000000000 +0100
> +++ linux/include/asm-mips/pgtable-64.h 2007-03-07 17:28:47.000000000 +0100
> @@ -199,7 +199,7 @@
>  {
>         return pud_val(pud);
>  }
> -#define pud_phys(pud)          (pud_val(pud) - PAGE_OFFSET)
> +#define pud_phys(pud)          (pud_val(pud) - PAGE_OFFSET + PHYS_OFFSET)

ditto

Ralf, could this patch reach ASAP your main tree ?

thanks
-- 
               Franck
