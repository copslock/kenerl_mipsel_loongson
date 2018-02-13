Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2018 12:30:29 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:43686 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992821AbeBMLaRkrOaI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Feb 2018 12:30:17 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 13 Feb 2018 11:28:44 +0000
Received: from [10.150.130.83] (10.150.130.83) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 13 Feb
 2018 03:22:18 -0800
Subject: Re: [PATCH v2 02/15] MIPS: memblock: Surely map BSS kernel memory
 section
To:     Serge Semin <fancer.lancer@gmail.com>, <ralf@linux-mips.org>,
        <miodrag.dinic@mips.com>, <jhogan@kernel.org>,
        <goran.ferenc@mips.com>, <david.daney@cavium.com>,
        <paul.gortmaker@windriver.com>, <paul.burton@mips.com>,
        <alex.belits@cavium.com>, <Steven.Hill@cavium.com>
CC:     <alexander.sverdlin@nokia.com>, <kumba@gentoo.org>,
        <marcin.nowakowski@mips.com>, <James.hogan@mips.com>,
        <Peter.Wotton@mips.com>, <Sergey.Semin@t-platforms.ru>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
 <20180202035458.30456-3-fancer.lancer@gmail.com>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <aa201bf9-2901-d5d9-64c7-835c444a980e@mips.com>
Date:   Tue, 13 Feb 2018 11:22:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180202035458.30456-3-fancer.lancer@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1518521323-452059-10562-45689-3
X-BESS-VER: 2018.1.1-r1801291958
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189977
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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



On 02/02/18 03:54, Serge Semin wrote:
> The current MIPS code makes sure the kernel code/data/init
> sections are in the maps, but BSS should also be there.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Looks good to me :-)

Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>

Thanks,
Matt

> ---
>   arch/mips/kernel/setup.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 1a4d64410303..f502cd702fa7 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -845,6 +845,9 @@ static void __init arch_mem_init(char **cmdline_p)
>   	arch_mem_addpart(PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT,
>   			 PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT,
>   			 BOOT_MEM_INIT_RAM);
> +	arch_mem_addpart(PFN_DOWN(__pa_symbol(&__bss_start)) << PAGE_SHIFT,
> +			 PFN_UP(__pa_symbol(&__bss_stop)) << PAGE_SHIFT,
> +			 BOOT_MEM_RAM);
>   
>   	pr_info("Determined physical RAM map:\n");
>   	print_memory_map();
> 
