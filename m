Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2014 14:56:18 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32307 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008720AbaIKM4PlYcUS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Sep 2014 14:56:15 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D0CCF7F53CABF;
        Thu, 11 Sep 2014 13:56:06 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 11 Sep 2014 13:56:08 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 11 Sep
 2014 13:56:07 +0100
Message-ID: <54119BE8.5020605@imgtec.com>
Date:   Thu, 11 Sep 2014 13:56:08 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>, <nbd@openwrt.org>,
        <jchandra@broadcom.com>, <paul.burton@imgtec.com>,
        <david.daney@cavium.com>, <linux-kernel@vger.kernel.org>,
        <ralf@linux-mips.org>, <markos.chandras@imgtec.com>,
        <macro@linux-mips.org>, <manuel.lauss@gmail.com>,
        <jerinjacobk@gmail.com>, <chenhc@lemote.com>, <blogic@openwrt.org>
Subject: Re: [PATCH V2] MIPS: bugfix of coherentio variable default setup
References: <20140908191002.13852.47842.stgit@linux-yegoshin>
In-Reply-To: <20140908191002.13852.47842.stgit@linux-yegoshin>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 08/09/14 20:10, Leonid Yegoshin wrote:
> diff --git a/arch/mips/include/asm/mach-generic/dma-coherence.h b/arch/mips/include/asm/mach-generic/dma-coherence.h
> index 7629c35..b4563df 100644
> --- a/arch/mips/include/asm/mach-generic/dma-coherence.h
> +++ b/arch/mips/include/asm/mach-generic/dma-coherence.h
> @@ -49,7 +49,12 @@ static inline int plat_dma_supported(struct device *dev, u64 mask)
>  
>  static inline int plat_device_is_coherent(struct device *dev)
>  {
> -	return coherentio;
> +#ifdef CONFIG_DMA_COHERENT
> +	return 1;

if DMA_COHERENT=y (which seems to imply DMA_MAYBE_COHERENT=n),
coherentio is already defined as 1 in
arch/mips/include/asm/dma-coherent.h, so I don't think you need this case.

> +#else
> +	return (coherentio > 0);
> +#endif
> +

No need for a new blank line here

>  }

...

> diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
> index 44b6dff..42c819a 100644
> --- a/arch/mips/mm/dma-default.c
> +++ b/arch/mips/mm/dma-default.c
> @@ -24,7 +24,7 @@
>  #include <dma-coherence.h>
>  
>  #ifdef CONFIG_DMA_MAYBE_COHERENT
> -int coherentio = 0;	/* User defined DMA coherency from command line. */
> +int coherentio = -1;    /* User defined DMA coherency is not defined yet. */

Please avoid unnecessarily turned tabs into spaces. It makes files
inconsistent.

Other than that and Markos' style comment it looks reasonable to me.

Cheers
James
