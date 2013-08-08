Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 11:50:11 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:38421 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823002Ab3HHJuEkadQb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Aug 2013 11:50:04 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1V7Mr6-0002hz-00; Thu, 08 Aug 2013 11:50:04 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id 3F2EA1D440; Thu,  8 Aug 2013 11:49:42 +0200 (CEST)
Date:   Thu, 8 Aug 2013 11:49:42 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/4] MIPS: lantiq: adds 4dword burst length for dma
Message-ID: <20130808094942.GA21442@alpha.franken.de>
References: <1375952846-25812-1-git-send-email-blogic@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1375952846-25812-1-git-send-email-blogic@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
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

On Thu, Aug 08, 2013 at 11:07:23AM +0200, John Crispin wrote:
> Comparing the upstream code with the Lantiq UGW kernel we see that burst length
> should be set to 4 bytes.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>  arch/mips/lantiq/xway/dma.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
> index 08f7ebd..ccf1451 100644
> --- a/arch/mips/lantiq/xway/dma.c
> +++ b/arch/mips/lantiq/xway/dma.c
> @@ -48,6 +48,7 @@
>  #define DMA_IRQ_ACK		0x7e		/* IRQ status register */
>  #define DMA_POLL		BIT(31)		/* turn on channel polling */
>  #define DMA_CLK_DIV4		BIT(6)		/* polling clock divider */
> +#define DMA_4W_BURST		BIT(2)		/* 4 word burst length */
>  #define DMA_2W_BURST		BIT(1)		/* 2 word burst length */

that's wrong, it's not BIT(x), but x itself.

1 means 2 word burst
2 means 4 word burst
3 means 8 word burst

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
