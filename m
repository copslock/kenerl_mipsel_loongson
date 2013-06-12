Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Jun 2013 08:18:20 +0200 (CEST)
Received: from mga03.intel.com ([143.182.124.21]:11244 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6815753Ab3FLGSR6iBeu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 Jun 2013 08:18:17 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
  by azsmga101.ch.intel.com with ESMTP; 11 Jun 2013 23:18:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,848,1363158000"; 
   d="scan'208";a="253827868"
Received: from vkoul-udesk3.iind.intel.com ([10.223.84.41])
  by AZSMGA002.ch.intel.com with ESMTP; 11 Jun 2013 23:18:04 -0700
Received: from vkoul-udesk3.iind.intel.com (localhost [127.0.0.1])
        by vkoul-udesk3.iind.intel.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id r5C5cG0b013629;
        Wed, 12 Jun 2013 11:08:16 +0530
Received: (from vkoul@localhost)
        by vkoul-udesk3.iind.intel.com (8.14.3/8.14.3/Submit) id r5C5cAmp013627;
        Wed, 12 Jun 2013 11:08:10 +0530
X-Authentication-Warning: vkoul-udesk3.iind.intel.com: vkoul set sender to vinod.koul@intel.com using -f
Date:   Wed, 12 Jun 2013 11:08:10 +0530
From:   Vinod Koul <vinod.koul@intel.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 3/6] dma: Add a jz4740 dmaengine driver
Message-ID: <20130612053810.GF4107@intel.com>
References: <1369931105-28065-1-git-send-email-lars@metafoo.de>
 <1369931105-28065-4-git-send-email-lars@metafoo.de>
 <20130530171225.GA3767@intel.com>
 <51A79E8F.4070209@metafoo.de>
 <51B60D0A.7040307@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51B60D0A.7040307@metafoo.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <vinod.koul@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36837
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

On Mon, Jun 10, 2013 at 07:29:46PM +0200, Lars-Peter Clausen wrote:
> On 05/30/2013 08:46 PM, Lars-Peter Clausen wrote:
> >>> +static int jz4740_dma_alloc_chan_resources(struct dma_chan *c)
> >>> +{
> >>> +	struct jz4740_dmaengine_chan *chan = to_jz4740_dma_chan(c);
> >>> +
> >>> +	chan->jz_chan = jz4740_dma_request(chan, NULL);
> >>> +	if (!chan->jz_chan)
> >>> +		return -EBUSY;
> >>> +
> >>> +	jz4740_dma_set_complete_cb(chan->jz_chan, jz4740_dma_complete_cb);
> >>> +
> >>> +	return 0;
> >> Sorry, I didnt reply on this one. The API expects you to allocate a pool of
> >> descriptors. These descriptors are to be used in .device_prep_xxx calls later.
> > 
> > The size of the descriptor is not fixed, so they can not be pre-allocated. And
> > this is nothing new either, most of the more recently added dmaengine drivers
> > allocate their descriptors on demand.
> 
> Vinod, are you ok with this explanation?
Sorry, I was travelling...

Can you explain more of a bit when you say size is not fixed. Why would it be
issue if we allocate descriptors at the alloc_chan. The idea is that you 
preallocated pool at alloc_chan and since the .device_prep_xxx calls can be
called from atomic context as well, you dont need to do this later. You can use use
these descriptors at that time. The idea is keep rotating the descriptors from
free poll to used one

--
~Vinod
