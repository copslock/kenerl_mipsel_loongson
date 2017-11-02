Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 14:14:44 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:54234 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993379AbdKBNO2LwWwN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Nov 2017 14:14:28 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 02 Nov 2017 13:14:12 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 2 Nov 2017
 06:13:30 -0700
Date:   Thu, 2 Nov 2017 13:14:25 +0000
From:   James Hogan <james.hogan@mips.com>
To:     David Daney <david.daney@cavium.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        <devicetree@vger.kernel.org>, Carlos Munoz <cmunoz@cavium.com>
Subject: Re: [PATCH 4/7] MIPS: Octeon: Add Free Pointer Unit (FPA) support.
Message-ID: <20171102131425.GO15235@jhogan-linux>
References: <20171102003606.19913-1-david.daney@cavium.com>
 <20171102003606.19913-5-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20171102003606.19913-5-david.daney@cavium.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1509628451-637138-27159-481581-1
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 1.10
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186514
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.60 MARKETING_SUBJECT      HEADER: Subject contains popular marketing words 
X-BESS-Outbound-Spam-Status: SCORE=1.10 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60676
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

On Wed, Nov 01, 2017 at 05:36:03PM -0700, David Daney wrote:
> diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
> index 5c0b56203bae..211ef5b57214 100644
> --- a/arch/mips/cavium-octeon/Kconfig
> +++ b/arch/mips/cavium-octeon/Kconfig
> @@ -86,4 +86,14 @@ config OCTEON_ILM
>  	  To compile this driver as a module, choose M here.  The module
>  	  will be called octeon-ilm
>  
> +config OCTEON_FPA3
> +	tristate "Octeon III fpa driver"
> +	default "n"

n is the default default so I think this line is redundant.

> +	depends on CPU_CAVIUM_OCTEON
> +	help
> +	  This option enables a Octeon III driver for the Free Pool Unit (FPA).
> +	  The FPA is a hardware unit that manages pools of pointers to free
> +	  L2/DRAM memory. This driver provides an interface to reserve,
> +	  initialize, and fill fpa pools.
> +
>  endif # CAVIUM_OCTEON_SOC

Cheers
James
