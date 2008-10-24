Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 14:01:21 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:21122 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S22292831AbYJXNBK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2008 14:01:10 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m9OD0sn4011559;
	Fri, 24 Oct 2008 06:00:54 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 24 Oct 2008 06:00:53 -0700
Received: from [128.224.146.65] ([128.224.146.65]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 24 Oct 2008 06:00:53 -0700
Message-ID: <4901C704.1090501@windriver.com>
Date:	Fri, 24 Oct 2008 09:00:52 -0400
From:	Paul Gortmaker <paul.gortmaker@windriver.com>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
MIME-Version: 1.0
To:	ddaney@caviumnetworks.com
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH 36/37] Cavium OCTEON: pmd_none - use pmd_val() in pmd_val().
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com> <1224809821-5532-37-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1224809821-5532-37-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2008 13:00:53.0895 (UTC) FILETIME=[8C3F8170:01C935D8]
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
Precedence: bulk
X-list: linux-mips

ddaney@caviumnetworks.com wrote:
> From: David Daney <ddaney@caviumnetworks.com>
>
> Before marking pmd_val as invalid_pte_table, factor in existing value
> for pmd_val.
>
> Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  arch/mips/include/asm/pgtable-64.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>   

Hi David,

I think you missed my feedback on this patch -- you should be the primary
S.O.B.  on this, and at a minimum, it needs a better description of just why
this is required (if it actually is) on Cavium CPUs, but not on other 
boards.

Thanks,
Paul.

> diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
> index 943515f..bb93bd5 100644
> --- a/arch/mips/include/asm/pgtable-64.h
> +++ b/arch/mips/include/asm/pgtable-64.h
> @@ -129,7 +129,12 @@ extern pmd_t empty_bad_pmd_table[PTRS_PER_PMD];
>   */
>  static inline int pmd_none(pmd_t pmd)
>  {
> +#ifdef CONFIG_CPU_CAVIUM_OCTEON
> +	return (pmd_val(pmd) == (unsigned long) invalid_pte_table) ||
> +				(!pmd_val(pmd));
> +#else
>  	return pmd_val(pmd) == (unsigned long) invalid_pte_table;
> +#endif
>  }
>  
>  #define pmd_bad(pmd)		(pmd_val(pmd) & ~PAGE_MASK)
>   
