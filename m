Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jul 2013 17:00:23 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:4529 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6837379Ab3GRGv0JdgTv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Jul 2013 08:51:26 +0200
Received: from [10.9.208.57] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 17 Jul 2013 23:47:25 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Wed, 17 Jul 2013 23:51:12 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Wed, 17 Jul 2013 23:51:12 -0700
Received: from jayachandranc.netlogicmicro.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 2FD69F2D74; Wed, 17
 Jul 2013 23:51:10 -0700 (PDT)
Date:   Thu, 18 Jul 2013 12:23:30 +0530
From:   "Jayachandran C." <jchandra@broadcom.com>
To:     "Tony Wu" <tung7970@gmail.com>
cc:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: tlbex: Guard tlbmiss_handler_setup_pgd
Message-ID: <20130718065329.GB24373@jayachandranc.netlogicmicro.com>
References: <20130717175840-tung7970@googlemail.com>
 <20130717180052-tung7970@googlemail.com>
MIME-Version: 1.0
In-Reply-To: <20130717180052-tung7970@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-WSS-ID: 7DF950F731W53208328-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37314
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

On Wed, Jul 17, 2013 at 06:01:29PM +0800, Tony Wu wrote:
> tlbmiss_handler_setup_pgd* are only referenced when
> CONFIG_MIPS_PGD_C0_CONTEXT is defined.
> 
> Signed-off-by: Tony Wu <tung7970@gmail.com>
> Cc: Jayachandran C <jchandra@broadcom.com>
> ---
>  arch/mips/mm/tlb-funcs.S |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/mm/tlb-funcs.S b/arch/mips/mm/tlb-funcs.S
> index 30a494d..79bca31 100644
> --- a/arch/mips/mm/tlb-funcs.S
> +++ b/arch/mips/mm/tlb-funcs.S
> @@ -16,10 +16,12 @@
>  
>  #define FASTPATH_SIZE	128
>  
> +#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
>  LEAF(tlbmiss_handler_setup_pgd)
>  	.space		16 * 4
>  END(tlbmiss_handler_setup_pgd)
>  EXPORT(tlbmiss_handler_setup_pgd_end)
> +#endif
>  
>  LEAF(handle_tlbm)
>  	.space		FASTPATH_SIZE * 4

There is a patchset planned which uses tlbmiss_handler_setup_pgd when
CONFIG_MIPS_PGD_C0_CONTEXT is not defined, but it did not make it into 3.11.

This change can be applied - but if it goes in, I will need to undo this
as part of the scratch patchset.

JC.
