Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jul 2013 17:01:25 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:1534 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6837315Ab3GRGjHQ0wc5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Jul 2013 08:39:07 +0200
Received: from [10.9.208.53] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 17 Jul 2013 23:32:50 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Wed, 17 Jul 2013 23:38:48 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Wed, 17 Jul 2013 23:38:48 -0700
Received: from jayachandranc.netlogicmicro.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id ADFACF2D73; Wed, 17
 Jul 2013 23:38:47 -0700 (PDT)
Date:   Thu, 18 Jul 2013 12:11:07 +0530
From:   "Jayachandran C." <jchandra@broadcom.com>
To:     "Tony Wu" <tung7970@gmail.com>
cc:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: tlbex: Fix typo in r3000 tlb store
 handler
Message-ID: <20130718064106.GA24373@jayachandranc.netlogicmicro.com>
References: <20130717175840-tung7970@googlemail.com>
MIME-Version: 1.0
In-Reply-To: <20130717175840-tung7970@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-WSS-ID: 7DF953981R045497355-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

On Wed, Jul 17, 2013 at 05:59:47PM +0800, Tony Wu wrote:
> Should test against handle_tlbs_end, not handle_tlbs.
> 
> Signed-off-by: Tony Wu <tung7970@gmail.com>
> Cc: Jayachandran C <jchandra@broadcom.com>
> ---
>  arch/mips/mm/tlbex.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index 9ab0f90..605b6fc 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -1803,7 +1803,7 @@ static void __cpuinit build_r3000_tlb_store_handler(void)
>  	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);
>  	uasm_i_nop(&p);
>  
> -	if (p >= handle_tlbs)
> +	if (p >= handle_tlbs_end)
>  		panic("TLB store handler fastpath space exceeded");
>  
>  	uasm_resolve_relocs(relocs, labels);

Thanks for fixing this.

Acked-by: Jayachandran C. <jchandra@broadcom.com>

You should add the commit which caused the trouble to the commit message,
like:

commit 6ba045f (MIPS: Move generated code to .text for microMIPS) causes
a panic at boot.

JC.
