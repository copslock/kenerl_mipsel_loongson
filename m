Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 23:11:00 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46508 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012302AbcBJWK6UNxHu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 23:10:58 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 45EB07028F2CA;
        Wed, 10 Feb 2016 22:10:48 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 10 Feb 2016 22:10:51 +0000
Received: from localhost (10.100.200.47) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 10 Feb
 2016 22:10:51 +0000
Date:   Wed, 10 Feb 2016 14:10:49 -0800
From:   Paul Burton <paul.burton@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>,
        <linux-kernel@vger.kernel.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: [PATCH] MIPS: tlb-r4k: panic if the MMU doesn't support PAGE_SIZE
Message-ID: <20160210221049.GA26712@NP-P-BURTON>
References: <1436803964-29820-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1436803964-29820-1-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.47]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Mon, Jul 13, 2015 at 05:12:44PM +0100, Paul Burton wrote:
> After writing the appropriate mask to the cop0 PageMask register, read
> the register back & check it matches what we want. If it doesn't then
> the MMU does not support the page size the kernel is configured for and
> we're better off bailing than continuing to do odd things with TLB
> exceptions.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---

Hi Ralf,

This patch is marked as accepted in patchwork[1] but is not present in
upstream. Did you lose it somehow? Could you please merge it?

Thanks,
    Paul

[1] http://patchwork.linux-mips.org/patch/10691/

>  arch/mips/mm/tlb-r4k.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
> index 08318ec..4330315 100644
> --- a/arch/mips/mm/tlb-r4k.c
> +++ b/arch/mips/mm/tlb-r4k.c
> @@ -19,6 +19,7 @@
>  #include <asm/cpu.h>
>  #include <asm/cpu-type.h>
>  #include <asm/bootinfo.h>
> +#include <asm/hazards.h>
>  #include <asm/mmu_context.h>
>  #include <asm/pgtable.h>
>  #include <asm/tlb.h>
> @@ -486,6 +487,10 @@ static void r4k_tlb_configure(void)
>  	 *     be set to fixed-size pages.
>  	 */
>  	write_c0_pagemask(PM_DEFAULT_MASK);
> +	back_to_back_c0_hazard();
> +	if (read_c0_pagemask() != PM_DEFAULT_MASK)
> +		panic("MMU doesn't support PAGE_SIZE=0x%lx", PAGE_SIZE);
> +
>  	write_c0_wired(0);
>  	if (current_cpu_type() == CPU_R10000 ||
>  	    current_cpu_type() == CPU_R12000 ||
> -- 
> 2.4.5
> 
