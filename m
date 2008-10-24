Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 16:12:59 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:44712 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S22301458AbYJXPMp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2008 16:12:45 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 2593D3ECC; Fri, 24 Oct 2008 08:12:38 -0700 (PDT)
Message-ID: <4901E5D3.4030000@ru.mvista.com>
Date:	Fri, 24 Oct 2008 19:12:19 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	ddaney@caviumnetworks.com
Cc:	linux-mips@linux-mips.org,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 36/37] Cavium OCTEON: pmd_none - use pmd_val() in pmd_val().
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com> <1224809821-5532-37-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1224809821-5532-37-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

ddaney@caviumnetworks.com wrote:

> Before marking pmd_val as invalid_pte_table, factor in existing value
> for pmd_val.

    I didn't get it -- this function doesn't mark anything.

> Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

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

    Unneeded parens around !pmd_val(pmd) -- ! operator is higher priority than 
any of && and ||.

WBR, Sergei
