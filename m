Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2017 19:22:26 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:33573 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990427AbdKMSWRKxXXR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Nov 2017 19:22:17 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 13 Nov 2017 18:22:09 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 13 Nov
 2017 10:21:36 -0800
Date:   Mon, 13 Nov 2017 18:21:34 +0000
From:   James Hogan <james.hogan@mips.com>
To:     David Daney <david.daney@cavium.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        "Steven J. Hill" <steven.hill@cavium.com>
Subject: Re: [PATCH] MIPS: Add iomem resource for kernel bss section.
Message-ID: <20171113182134.GD31917@jhogan-linux.mipstec.com>
References: <20171012195034.5758-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20171012195034.5758-1-david.daney@cavium.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510597329-637138-17934-214624-3
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186883
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

On Thu, Oct 12, 2017 at 12:50:34PM -0700, David Daney wrote:
> The kexec/kdump tools need to know where the .bss is so it can be
> included in the core dump.  This allows vmcore-dmesg to have access to
> the dmesg buffers of the crashed kernel as well as allowing the
> debugger to examine variables in the bss section.
> 
> Add a request for the bss resource in addition to the already
> requested code and data sections.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Thanks, applied.

Cheers
James

> ---
>  arch/mips/kernel/setup.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index fe39397..702c678 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -80,6 +80,7 @@ EXPORT_SYMBOL(mips_io_port_base);
>  
>  static struct resource code_resource = { .name = "Kernel code", };
>  static struct resource data_resource = { .name = "Kernel data", };
> +static struct resource bss_resource = { .name = "Kernel bss", };
>  
>  static void *detect_magic __initdata = detect_memory_region;
>  
> @@ -927,6 +928,8 @@ static void __init resource_init(void)
>  	code_resource.end = __pa_symbol(&_etext) - 1;
>  	data_resource.start = __pa_symbol(&_etext);
>  	data_resource.end = __pa_symbol(&_edata) - 1;
> +	bss_resource.start = __pa_symbol(&__bss_start);
> +	bss_resource.end = __pa_symbol(&__bss_stop) - 1;
>  
>  	for (i = 0; i < boot_mem_map.nr_map; i++) {
>  		struct resource *res;
> @@ -966,6 +969,7 @@ static void __init resource_init(void)
>  		 */
>  		request_resource(res, &code_resource);
>  		request_resource(res, &data_resource);
> +		request_resource(res, &bss_resource);
>  		request_crashkernel(res);
>  	}
>  }
> -- 
> 2.9.5
> 
