Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jul 2014 16:43:19 +0200 (CEST)
Received: from casper.infradead.org ([85.118.1.10]:55257 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6859932AbaGEOnQdPXMM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Jul 2014 16:43:16 +0200
Received: from static-50-53-39-157.bvtn.or.frontiernet.net ([50.53.39.157] helo=dragon.site)
        by casper.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1X3RBH-0003Pe-AD; Sat, 05 Jul 2014 14:43:11 +0000
Message-ID: <53B80EFC.6020504@infradead.org>
Date:   Sat, 05 Jul 2014 07:43:08 -0700
From:   Randy Dunlap <rdunlap@infradead.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Nicholas Krause <xerofoify@gmail.com>, ralf@linux-mips.org
CC:     jchandra@broadcom.com, blogic@openwrt.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: Add #ifdef in file bridge.h
References: <1404528619-3715-1-git-send-email-xerofoify@gmail.com>
In-Reply-To: <1404528619-3715-1-git-send-email-xerofoify@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <rdunlap@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdunlap@infradead.org
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

On 07/04/2014 07:50 PM, Nicholas Krause wrote:
> This patch addes a #ifdef __ASSEMBLY__ in order to check if this part
> of the file is configured to fix this #ifdef block in bridge.h for mips.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  arch/mips/include/asm/netlogic/xlp-hal/bridge.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/netlogic/xlp-hal/bridge.h b/arch/mips/include/asm/netlogic/xlp-hal/bridge.h
> index 3067f98..4f315c3 100644
> --- a/arch/mips/include/asm/netlogic/xlp-hal/bridge.h
> +++ b/arch/mips/include/asm/netlogic/xlp-hal/bridge.h
> @@ -143,7 +143,7 @@
>  #define BRIDGE_GIO_WEIGHT		0x2cb
>  #define BRIDGE_FLASH_WEIGHT		0x2cc
>  
> -/* FIXME verify */
> +#ifdef __ASSEMBLY__
>  #define BRIDGE_9XX_FLASH_BAR(i)		(0x11 + (i))
>  #define BRIDGE_9XX_FLASH_BAR_LIMIT(i)	(0x15 + (i))
>  
> 

Hi,

Where is the corresponding #endif ?
The #endif at line 185 goes with the #ifndef __ASSEMBLY__ at line 176.

I think that this patch will cause a build error (or at least a warning).
Did you test it?


-- 
~Randy
