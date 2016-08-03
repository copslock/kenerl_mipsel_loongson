Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Aug 2016 08:14:29 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:54408 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990517AbcHCGOWO74Yp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Aug 2016 08:14:22 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u736ELUC015149;
        Wed, 3 Aug 2016 08:14:21 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u736EKdM015148;
        Wed, 3 Aug 2016 08:14:20 +0200
Date:   Wed, 3 Aug 2016 08:14:20 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Loongson1B: Provide DMA filter callbacks via
 platform data
Message-ID: <20160803061419.GH15910@linux-mips.org>
References: <1464429112-27590-1-git-send-email-keguang.zhang@gmail.com>
 <1464429112-27590-2-git-send-email-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1464429112-27590-2-git-send-email-keguang.zhang@gmail.com>
User-Agent: Mutt/1.6.2 (2016-07-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Sat, May 28, 2016 at 05:51:52PM +0800, Keguang Zhang wrote:

> diff --git a/arch/mips/include/asm/mach-loongson32/nand.h b/arch/mips/include/asm/mach-loongson32/nand.h
> index e274912..a1f8704 100644
> --- a/arch/mips/include/asm/mach-loongson32/nand.h
> +++ b/arch/mips/include/asm/mach-loongson32/nand.h
> @@ -21,10 +21,9 @@ struct plat_ls1x_nand {
>  
>  	int hold_cycle;
>  	int wait_cycle;
> +	bool (*dma_filter)(struct dma_chan *chan, void *param);
>  };
>  
>  extern struct plat_ls1x_nand ls1b_nand_pdata;
>  
> -bool ls1x_dma_filter_fn(struct dma_chan *chan, void *param);
> -
>  #endif /* __ASM_MACH_LOONGSON32_NAND_H */
> diff --git a/arch/mips/loongson32/ls1b/board.c b/arch/mips/loongson32/ls1b/board.c
> index 38a1d40..0a57337 100644
> --- a/arch/mips/loongson32/ls1b/board.c
> +++ b/arch/mips/loongson32/ls1b/board.c
> @@ -38,6 +38,7 @@ struct plat_ls1x_nand ls1x_nand_pdata = {
>  	.nr_parts	= ARRAY_SIZE(ls1x_nand_parts),
>  	.hold_cycle	= 0x2,
>  	.wait_cycle	= 0xc,
> +	.dma_filter	= ls1x_dma_filter,
>  };

Without the DMA driver which Vinod has requested changes for this
patch will result in build errors.  It will also result in a build
error if CONFIG_LOONGSON1_DMA is disabled.

  Ralf
