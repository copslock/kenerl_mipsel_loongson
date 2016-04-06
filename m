Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2016 16:27:33 +0200 (CEST)
Received: from mga01.intel.com ([192.55.52.88]:8144 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27025433AbcDFO1a5vgmf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Apr 2016 16:27:30 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP; 06 Apr 2016 07:26:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,447,1455004800"; 
   d="scan'208";a="949313108"
Received: from vkoul-mobl.iind.intel.com ([10.254.183.202])
  by orsmga002.jf.intel.com with ESMTP; 06 Apr 2016 07:26:53 -0700
Date:   Wed, 6 Apr 2016 07:26:53 -0700
From:   Vinod Koul <vinod.koul@intel.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-mtd@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH V1 3/7] dmaengine: Loongson1: add Loongson1 dmaengine
 driver
Message-ID: <20160406142652.GC27292@vkoul-mobl.iind.intel.com>
References: <1459946095-7637-1-git-send-email-keguang.zhang@gmail.com>
 <1459946095-7637-4-git-send-email-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1459946095-7637-4-git-send-email-keguang.zhang@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <vinod.koul@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vinod.koul@intel.com
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

On Wed, Apr 06, 2016 at 08:34:51PM +0800, Keguang Zhang wrote:
> @@ -527,6 +527,15 @@ config ZX_DMA
>  	help
>  	  Support the DMA engine for ZTE ZX296702 platform devices.
>  
> +config DMA_LOONGSON1

The kconfig and makefile is sorted alphabetically, pls arrage these entries
accordingly

> +
> +		/*memorize the physical address of descriptor */

bad comment style


> +	/*allocate DMA descriptors */

here and other places too :(

> +static enum dma_status ls1x_dma_tx_status(struct dma_chan *chan,
> +					  dma_cookie_t cookie,
> +					  struct dma_tx_state *txstate)
> +{
> +	struct ls1x_dma_chan *dma_chan = to_ls1x_dma_chan(chan);
> +	struct ls1x_dma_desc *dma_desc = dma_chan->dma_desc;
> +	struct virt_dma_desc *vdesc;
> +	enum dma_status status;
> +	unsigned int residue = 0;
> +	unsigned long flags;
> +
> +	status = dma_cookie_status(chan, cookie, txstate);
> +	if ((status == DMA_COMPLETE) || !txstate)
> +		return status;
> +
> +	spin_lock_irqsave(&dma_chan->vchan.lock, flags);
> +
> +	vdesc = vchan_find_desc(&dma_chan->vchan, cookie);
> +	if (vdesc)
> +		/* not yet processed */
> +		residue = ls1x_dma_desc_residue(to_ls1x_dma_desc(vdesc), 0);

If your usage queries reside repeatedly, then it might make sense to store
the size which is residue here

-- 
~Vinod
