Received:  by oss.sgi.com id <S553740AbQJSVo4>;
	Thu, 19 Oct 2000 14:44:56 -0700
Received: from u-176.karlsruhe.ipdial.viaginterkom.de ([62.180.19.176]:26639
        "EHLO u-176.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553736AbQJSVoq>; Thu, 19 Oct 2000 14:44:46 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870161AbQJSVoa>;
        Thu, 19 Oct 2000 23:44:30 +0200
Date:   Thu, 19 Oct 2000 23:44:30 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Cc:     Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-mips@oss.sgi.com
Subject: Re: Swap on DECStation
Message-ID: <20001019234430.C20887@bacchus.dhis.org>
References: <20001019121432.E9832@lug-owl.de> <XFMail.001019205554.Harald.Koerfgen@home.ivm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <XFMail.001019205554.Harald.Koerfgen@home.ivm.de>; from Harald.Koerfgen@home.ivm.de on Thu, Oct 19, 2000 at 08:55:54PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Oct 19, 2000 at 08:55:54PM +0200, Harald Koerfgen wrote:

> --- snip ---
> --- pgtable.h.orig      Sat Jul  1 12:27:34 2000
> +++ pgtable.h   Sat Jul  1 17:25:21 2000
> @@ -443,9 +443,9 @@
>  extern void update_mmu_cache(struct vm_area_struct *vma,
>                                 unsigned long address, pte_t pte);
>  
> -#define SWP_TYPE(x)            (((x).val >> 1) & 0x3f)
> -#define SWP_OFFSET(x)          ((x).val >> 8)
> -#define SWP_ENTRY(type,offset) ((swp_entry_t) { ((type) << 1) | ((offset) << 8) })
> +#define SWP_TYPE(x)            (((x).val >> 8) & 0x7f)
> +#define SWP_OFFSET(x)          ((x).val >> 15)
> +#define SWP_ENTRY(type,offset) ((swp_entry_t) { ((type) << 8) | ((offset) << 15) })
>  #define pte_to_swp_entry(pte)  ((swp_entry_t) { pte_val(pte) })

Reverting this breaks R4000.  At least now I know how this did end up in
CVS ...

  Ralf
