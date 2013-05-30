Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 May 2013 19:51:00 +0200 (CEST)
Received: from mga03.intel.com ([143.182.124.21]:31766 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823098Ab3E3RuxVgVch (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 May 2013 19:50:53 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
  by azsmga101.ch.intel.com with ESMTP; 30 May 2013 10:50:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,772,1363158000"; 
   d="scan'208";a="248760869"
Received: from vkoul-udesk3.iind.intel.com ([10.223.84.41])
  by AZSMGA002.ch.intel.com with ESMTP; 30 May 2013 10:50:37 -0700
Received: from vkoul-udesk3.iind.intel.com (localhost [127.0.0.1])
        by vkoul-udesk3.iind.intel.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id r4UHCo2e012326;
        Thu, 30 May 2013 22:42:51 +0530
Received: (from vkoul@localhost)
        by vkoul-udesk3.iind.intel.com (8.14.3/8.14.3/Submit) id r4UHCQuk012310;
        Thu, 30 May 2013 22:42:26 +0530
X-Authentication-Warning: vkoul-udesk3.iind.intel.com: vkoul set sender to vinod.koul@intel.com using -f
Date:   Thu, 30 May 2013 22:42:26 +0530
From:   Vinod Koul <vinod.koul@intel.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 3/6] dma: Add a jz4740 dmaengine driver
Message-ID: <20130530171225.GA3767@intel.com>
References: <1369931105-28065-1-git-send-email-lars@metafoo.de>
 <1369931105-28065-4-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1369931105-28065-4-git-send-email-lars@metafoo.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <vinod.koul@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36647
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

On Thu, May 30, 2013 at 06:25:02PM +0200, Lars-Peter Clausen wrote:
> This patch adds dmaengine support for the JZ4740 DMA controller. For now the
> driver will be a wrapper around the custom JZ4740 DMA API. Once all users of the
> custom JZ4740 DMA API have been converted to the dmaengine API the custom API
> will be removed and direct hardware access will be added to the dmaengine
> driver.
> 
> +
> +#include <asm/mach-jz4740/dma.h>
Am bit worried about having header in arch. Why cant we have this drivers header
in linux/. That way same IP block cna be reused across archs.
I was hoping that you would have move it in 6th patch, but that isnt the case


> +static int jz4740_dma_alloc_chan_resources(struct dma_chan *c)
> +{
> +	struct jz4740_dmaengine_chan *chan = to_jz4740_dma_chan(c);
> +
> +	chan->jz_chan = jz4740_dma_request(chan, NULL);
> +	if (!chan->jz_chan)
> +		return -EBUSY;
> +
> +	jz4740_dma_set_complete_cb(chan->jz_chan, jz4740_dma_complete_cb);
> +
> +	return 0;
Sorry, I didnt reply on this one. The API expects you to allocate a pool of
descriptors. These descriptors are to be used in .device_prep_xxx calls later.

--
~Vinod
