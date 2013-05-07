Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 May 2013 19:58:34 +0200 (CEST)
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]:6461
        "EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825888Ab3EGR6dABhPL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 May 2013 19:58:33 +0200
Received: from mail97-co1-R.bigfish.com (10.243.78.229) by
 CO1EHSOBE022.bigfish.com (10.243.66.85) with Microsoft SMTP Server id
 14.1.225.23; Tue, 7 May 2013 17:58:25 +0000
Received: from mail97-co1 (localhost [127.0.0.1])       by mail97-co1-R.bigfish.com
 (Postfix) with ESMTP id A4634480BB3;   Tue,  7 May 2013 17:58:25 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:157.56.238.53;KIP:(null);UIP:(null);IPV:NLI;H:BY2PRD0712HT004.namprd07.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: -4
X-BigFish: PS-4(zzbb2dI98dI9371I1432Izz1f42h1fc6h1ee6h1de0h1fdah1202h1e76h1d1ah1d2ahzz8275bh8275dhz2dh2a8h668h839h947hd25he5bhf0ah1288h12a5h12a9h12bdh137ah13b6h1441h14ddh1504h1537h153bh162dh1631h1758h1765h18e1h190ch1946h19b4h19c3h19ceh1ad9h1b0ah1d0ch1d2eh1d3fh1155h)
Received: from mail97-co1 (localhost.localdomain [127.0.0.1]) by mail97-co1
 (MessageSwitch) id 1367949503544432_30864; Tue,  7 May 2013 17:58:23 +0000
 (UTC)
Received: from CO1EHSMHS002.bigfish.com (unknown [10.243.78.243])       by
 mail97-co1.bigfish.com (Postfix) with ESMTP id 777BA58004B;    Tue,  7 May 2013
 17:58:23 +0000 (UTC)
Received: from BY2PRD0712HT004.namprd07.prod.outlook.com (157.56.238.53) by
 CO1EHSMHS002.bigfish.com (10.243.66.12) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Tue, 7 May 2013 17:58:22 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.246.37) with Microsoft SMTP Server (TLS) id 14.16.293.5; Tue, 7 May
 2013 17:58:20 +0000
Message-ID: <518940BB.3080307@caviumnetworks.com>
Date:   Tue, 7 May 2013 10:58:19 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        Jiang Liu <liuj97@gmail.com>, <eunb.song@samsung.com>,
        <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: Make virt_to_phys() work for all unmapped addresses.
References: <1367947427-21649-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1367947427-21649-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

It doesn't apply anymore.  It was against v3.4.

I will send one against Linus' tree soon.

David Daney


On 05/07/2013 10:23 AM, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
>
> As reported:
>    This problem was discovered when doing BGP traffic with the TCP MD5 option
>    activated, where the following call chain caused a crash:
>
>     * tcp_v4_rcv
>     *  tcp_v4_timewait_ack
>     *   tcp_v4_send_ack -> follow stack variable rep.th
>     *    tcp_v4_md5_hash_hdr
>     *     tcp_md5_hash_header
>     *      sg_init_one
>     *       sg_set_buf
>     *        virt_to_page
>
>    I noticed that tcp_v4_send_reset uses a similar stack variable and
>    also calls tcp_v4_md5_hash_hdr, so it has the same problem.
>
> The networking core can indirectly call virt_to_phys() on stack
> addresses, if this is done from PID 0, the stack will usually be in
> CKSEG0, so virt_to_phys() needs to work there as well
>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>
> Not tested against kernel.org kernel, but it may still apply
>
> This could also fix problems noted by Eunbong Song with the
> free_initmem_default() call.
>
>   arch/mips/include/asm/io.h   | 2 +-
>   arch/mips/include/asm/page.h | 5 +++--
>   2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index a58f229..37fa957 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -116,7 +116,7 @@ static inline void set_io_port_base(unsigned long base)
>    */
>   static inline unsigned long virt_to_phys(volatile const void *address)
>   {
> -	return (unsigned long)address - PAGE_OFFSET + PHYS_OFFSET;
> +	return __pa(address);
>   }
>
>   /*
> diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
> index cee3893..e09bff9 100644
> --- a/arch/mips/include/asm/page.h
> +++ b/arch/mips/include/asm/page.h
> @@ -48,7 +48,6 @@
>   #ifndef __ASSEMBLY__
>
>   #include <linux/pfn.h>
> -#include <asm/io.h>
>
>   extern void build_clear_page(void);
>   extern void build_copy_page(void);
> @@ -139,7 +138,6 @@ typedef struct { unsigned long pgprot; } pgprot_t;
>    */
>   #define ptep_buddy(x)	((pte_t *)((unsigned long)(x) ^ sizeof(pte_t)))
>
> -#endif /* !__ASSEMBLY__ */
>
>   /*
>    * __pa()/__va() should be used only during mem init.
> @@ -156,6 +154,9 @@ typedef struct { unsigned long pgprot; } pgprot_t;
>   #endif
>   #define __va(x)		((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
>
> +#include <asm/io.h>
> +#endif /* !__ASSEMBLY__ */
> +
>   /*
>    * RELOC_HIDE was originally added by 6007b903dfe5f1d13e0c711ac2894bdd4a61b1ad
>    * (lmo) rsp. 8431fd094d625b94d364fe393076ccef88e6ce18 (kernel.org).  The
>
