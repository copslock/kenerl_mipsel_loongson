Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2013 06:32:59 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:46048 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816841Ab3IQEcxKsUme (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Sep 2013 06:32:53 +0200
Message-ID: <5237DB62.2060303@phrozen.org>
Date:   Tue, 17 Sep 2013 06:32:34 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Rob Herring <robherring2@gmail.com>
CC:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Grant Likely <grant.likely@linaro.org>,
        Rob Herring <rob.herring@calxeda.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 28/28] mips: use common of_flat_dt_get_machine_name
References: <1379372965-22359-1-git-send-email-robherring2@gmail.com> <1379372965-22359-29-git-send-email-robherring2@gmail.com>
In-Reply-To: <1379372965-22359-29-git-send-email-robherring2@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

On 17/09/13 01:09, Rob Herring wrote:
> From: Rob Herring<rob.herring@calxeda.com>
>
> Convert mips to use the common of_flat_dt_get_machine_name function.
>
> Signed-off-by: Rob Herring<rob.herring@calxeda.com>
> Cc: Ralf Baechle<ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> ---


Acked-by: John Crispin <blogic@openwrt.org>


Thanks for this series ...



>   arch/mips/kernel/prom.c | 15 +--------------
>   1 file changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
> index 0b2485f..3c3b0df 100644
> --- a/arch/mips/kernel/prom.c
> +++ b/arch/mips/kernel/prom.c
> @@ -47,24 +47,11 @@ void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
>   	return __alloc_bootmem(size, align, __pa(MAX_DMA_ADDRESS));
>   }
>
> -int __init early_init_dt_scan_model(unsigned long node,	const char *uname,
> -				    int depth, void *data)
> -{
> -	if (!depth) {
> -		char *model = of_get_flat_dt_prop(node, "model", NULL);
> -
> -		if (model)
> -			mips_set_machine_name(model);
> -	}
> -	return 0;
> -}
> -
>   void __init __dt_setup_arch(struct boot_param_header *bph)
>   {
>   	if (!early_init_dt_scan(bph))
>   		return;
>
> -	/* try to load the mips machine name */
> -	of_scan_flat_dt(early_init_dt_scan_model, NULL);
> +	mips_set_machine_name(of_flat_dt_get_machine_name());
>   }
>   #endif
