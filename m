Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2018 23:06:54 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:40083 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994688AbeEaVGrO0uAO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 May 2018 23:06:47 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx30.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Thu, 31 May 2018 21:06:23 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Thu, 31
 May 2018 14:06:28 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Thu, 31 May
 2018 14:06:28 -0700
Date:   Thu, 31 May 2018 14:06:22 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Tokunori Ikegami <ikegami@allied-telesis.co.jp>
CC:     James Hogan <jhogan@kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH v3 1/1] MIPS: BCM47XX: Enable MIPS32 74K Core
 ExternalSync for BCM47XX PCIe erratum
Message-ID: <20180531210622.btphkhpujfxnybq4@pburton-laptop>
References: <20180531010240.16991-1-ikegami@allied-telesis.co.jp>
 <20180531010240.16991-2-ikegami@allied-telesis.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180531010240.16991-2-ikegami@allied-telesis.co.jp>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1527800782-637140-22267-511385-1
X-BESS-VER: 2018.6-r1805181819
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193585
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
X-archive-position: 64136
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

On Thu, May 31, 2018 at 10:02:40AM +0900, Tokunori Ikegami wrote:
> diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
> index 6054d49e608e..8fec219e1160 100644
> --- a/arch/mips/bcm47xx/setup.c
> +++ b/arch/mips/bcm47xx/setup.c
> @@ -212,6 +212,13 @@ static int __init bcm47xx_cpu_fixes(void)
>  		 */
>  		if (bcm47xx_bus.bcma.bus.chipinfo.id == BCMA_CHIP_ID_BCM4706)
>  			cpu_wait = NULL;
> +
> +		/*
> +		 * BCM47XX Erratum "R10: PCIe Transactions Periodically Fail"
> +		 * Enable ExternalSync for sync instruction to take effect
> +		 */
> +		pr_info("ExternalSync has been enabled\n");
> +		set_c0_config7(MIPS_CONF7_ES);

Great - this looks better placed than v2, and so long as this erratum
only applies to systems using BCMA this looks good to me.

My only other niggle would be questioning whether we really need the
pr_info() - I'd probably go without it, but it's not a strong opinion so
either way:

    Reviewed-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul
