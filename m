Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2018 01:10:25 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:38563 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994674AbeE3XKRipnHQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 May 2018 01:10:17 +0200
Received: from mipsdag03.mipstec.com (mail3.mips.com [12.201.5.33]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Wed, 30 May 2018 23:09:55 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag03.mipstec.com
 (10.20.40.48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Wed, 30
 May 2018 16:10:01 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Wed, 30 May
 2018 16:10:01 -0700
Date:   Wed, 30 May 2018 16:09:55 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Tokunori Ikegami <ikegami@allied-telesis.co.jp>
CC:     James Hogan <jhogan@kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Rafa~B Mi~Becki <zajec5@gmail.com>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2 1/1] MIPS: BCM47XX: Enable MIPS32 74K Core
 ExternalSync for BCM47XX PCIe erratum
Message-ID: <20180530230955.ggmiv2r5b2gkfczm@pburton-laptop>
References: <20180528002451.2622-1-ikegami@allied-telesis.co.jp>
 <20180528002451.2622-2-ikegami@allied-telesis.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180528002451.2622-2-ikegami@allied-telesis.co.jp>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1527721795-321459-5645-18570-1
X-BESS-VER: 2018.6-r1805181819
X-BESS-Apparent-Source-IP: 12.201.5.33
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193551
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Hi Tokunori,

On Mon, May 28, 2018 at 09:24:51AM +0900, Tokunori Ikegami wrote:
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index cf3fd549e16d..75039e89694f 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -427,8 +427,18 @@ static inline void check_errata(void)
>  		 * making use of VPE1 will be responsable for that VPE.
>  		 */
>  		if ((c->processor_id & PRID_REV_MASK) <= PRID_REV_34K_V1_0_2)
> -			write_c0_config7(read_c0_config7() | MIPS_CONF7_RPS);
> +			set_c0_config7(MIPS_CONF7_RPS);
>  		break;
> +#ifdef CONFIG_BCMA_DRIVER_PCI_HOSTMODE
> +	case CPU_74K:
> +		/*
> +		 * BCM47XX Erratum "R10: PCIe Transactions Periodically Fail"
> +		 * Enable ExternalSync for sync instruction to take effect
> +		 */
> +		pr_info("ExternalSync has been enabled\n");
> +		set_c0_config7(MIPS_CONF7_ES);
> +		break;
> +#endif

Could this be moved to platform-specific code, in order to avoid the
platform-specific #ifdef in generic code?

For example, this would seem like a good fit for the existing
bcm47xx_cpu_fixes() function.

Thanks,
    Paul
