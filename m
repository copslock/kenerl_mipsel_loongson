Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 May 2016 06:43:51 +0200 (CEST)
Received: from mga02.intel.com ([134.134.136.20]:6821 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27039613AbcE3Ens6-ulh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 May 2016 06:43:48 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP; 29 May 2016 21:43:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,387,1459839600"; 
   d="scan'208";a="964887803"
Received: from vkoul-udesk7.iind.intel.com (HELO localhost) ([10.223.84.143])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2016 21:43:44 -0700
Date:   Mon, 30 May 2016 10:20:14 +0530
From:   Vinod Koul <vinod.koul@intel.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH V3] dmaengine: Loongson1: add Loongson1 dmaengine driver
Message-ID: <20160530045014.GG16910@localhost>
References: <1464428833-27517-1-git-send-email-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1464428833-27517-1-git-send-email-keguang.zhang@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <vinod.koul@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53701
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

On Sat, May 28, 2016 at 05:47:13PM +0800, Keguang Zhang wrote:
> +/* Loongson 1 DMA Register Definitions */
> +#define DMA_CTRL		0x0
> +
> +/* DMA Control Register Bits */
> +#define DMA_STOP		BIT(4)
> +#define DMA_START		BIT(3)
> +#define ASK_VALID		BIT(2)
> +
> +#define DMA_ADDR_MASK		(0xffffffc0)

These should be namespaced properly. Having generic one like DMA_STOP
DMA_ADDR_MASK makes it prone to conflicts with common symbols!

> +bool ls1x_dma_filter(struct dma_chan *chan, void *param)
> +{
> +	struct ls1x_dma_chan *dma_chan = to_ls1x_dma_chan(chan);
> +	unsigned int chan_id = *(unsigned int *)param;
> +
> +	if (chan_id == dma_chan->id)
> +		return true;
> +	else
> +		return false;
> +}

considering this is a new driver do you need a filter? Also where are the
bindings for this driver?

> +static struct ls1x_dma_desc *ls1x_dma_alloc_desc(struct ls1x_dma_chan *dma_chan,
> +						 int sg_len)

if you splitting up please ensure preceding line is < 80 char, this looks
quite bad

> +
> +	switch (direction) {
> +	case DMA_MEM_TO_DEV:
> +		dev_addr = config->dst_addr;
> +		bus_width = config->dst_addr_width;
> +		cmd = DMA_RAM2DEV | DMA_INT;
> +		break;

empty line here

> +	case DMA_DEV_TO_MEM:
> +		dev_addr = config->src_addr;
> +		bus_width = config->src_addr_width;
> +		cmd = DMA_INT;
> +		break;

here too

> +static size_t ls1x_dma_desc_residue(struct ls1x_dma_desc *dma_desc,
> +				    unsigned int next_sg)
> +{
> +	struct ls1x_dma_chan *dma_chan = dma_desc->chan;
> +	struct dma_slave_config *config = &dma_chan->config;
> +	unsigned int i, bus_width, bytes = 0;
> +
> +	if (dma_desc->dir == DMA_MEM_TO_DEV)
> +		bus_width = config->dst_addr_width;
> +	else
> +		bus_width = config->src_addr_width;

dma slave config can be reprogrammed for subsequent transaction, you should
read this from descriptor and not channel

> +
> +	for (i = next_sg; i < dma_desc->nr_descs; i++)
> +		bytes += dma_desc->desc[i]->length * bus_width;
> +
> +	return bytes;

Okay how does this tell me "residue"

For not yet processed this tells me all descriptor size, why would I want
that?

> +}
> +
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
> +	else if (cookie == dma_chan->dma_desc->vdesc.tx.cookie)
> +		/* in progress */
> +		residue = ls1x_dma_desc_residue(dma_desc, dma_desc->nr_done);
> +	else
> +		residue = 0;
> +
> +	spin_unlock_irqrestore(&dma_chan->vchan.lock, flags);
> +
> +	dma_set_residue(txstate, residue);
> +
> +	return status;
> +}

> +static int ls1x_dma_remove(struct platform_device *pdev)
> +{
> +	struct ls1x_dma *dma = platform_get_drvdata(pdev);
> +
> +	dma_async_device_unregister(&dma->dma_dev);
> +	clk_disable_unprepare(dma->clk);

You are using devm_request_irq(), now how is the irq quisced at this point
and how do you ensure all your tasklets have finished processing!

> +MODULE_AUTHOR("Kelvin Cheung <keguang.zhang@gmail.com>");
> +MODULE_DESCRIPTION("Loongson1 DMA driver");
> +MODULE_LICENSE("GPL");

No ALIAS?

-- 
~Vinod
