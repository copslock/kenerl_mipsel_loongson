Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 May 2013 08:31:53 +0200 (CEST)
Received: from mga11.intel.com ([192.55.52.93]:48960 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823690Ab3EXGbvdgO-J (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 May 2013 08:31:51 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP; 23 May 2013 23:31:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,732,1363158000"; 
   d="scan'208";a="339309875"
Received: from vkoul-udesk3.iind.intel.com ([10.223.84.41])
  by fmsmga001.fm.intel.com with ESMTP; 23 May 2013 23:31:39 -0700
Received: from vkoul-udesk3.iind.intel.com (localhost [127.0.0.1])
        by vkoul-udesk3.iind.intel.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id r4O5sx9Z000706;
        Fri, 24 May 2013 11:25:00 +0530
Received: (from vkoul@localhost)
        by vkoul-udesk3.iind.intel.com (8.14.3/8.14.3/Submit) id r4O5srpY000704;
        Fri, 24 May 2013 11:24:53 +0530
X-Authentication-Warning: vkoul-udesk3.iind.intel.com: vkoul set sender to vinod.koul@intel.com using -f
Date:   Fri, 24 May 2013 11:24:53 +0530
From:   Vinod Koul <vinod.koul@intel.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 3/6] dma: Add a jz4740 dmaengine driver
Message-ID: <20130524055453.GR30200@intel.com>
References: <1369341387-19147-1-git-send-email-lars@metafoo.de>
 <1369341387-19147-4-git-send-email-lars@metafoo.de>
 <20130524045935.GM30200@intel.com>
 <519F016C.4040901@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <519F016C.4040901@metafoo.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <vinod.koul@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36581
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

On Fri, May 24, 2013 at 07:58:04AM +0200, Lars-Peter Clausen wrote:
> This one needs both.
> 
> >> +	jzcfg.mode = JZ4740_DMA_MODE_SINGLE;
> >> +	jzcfg.request_type = config->slave_id;
> >> +
> >> +	chan->config = *config;
> >> +
> >> +	jz4740_dma_configure(chan->jz_chan, &jzcfg);
> >> +
> >> +	return 0;
> > You are NOT use src_addr/dstn_addr? How else are you passing the periphral
> > address?
> I'm saving the whole config, which will later be used to retrieve the source or
> dest address.
well I missed that and it is a bad idea. You dont know when client has
freed/thrown the pointer so copy this instead..

> 
> >> +}
> [...]
> >> +static int jz4740_dma_alloc_chan_resources(struct dma_chan *c)
> >> +{
> >> +	struct jz4740_dmaengine_chan *chan = to_jz4740_dma_chan(c);
> >> +
> >> +	chan->jz_chan = jz4740_dma_request(chan, NULL);
> >> +	if (!chan->jz_chan)
> >> +		return -EBUSY;
> >> +
> >> +	jz4740_dma_set_complete_cb(chan->jz_chan, jz4740_dma_complete_cb);
> >> +
> >> +	return 0;
> > Zero is not expected value, you need to return the descriptors allocated
> > sucessfully.
> 
> Well, zero descriptors have been allocated. As far as I can see only a negative
> return value is treated as an error. Also the core doesn't seem to use the
> return value for anything else but checking if it is an error.
This is the API defination
* @device_alloc_chan_resources: allocate resources and return the
*      number of allocated descriptors

> >> +}
> >> +
> [...]
> >> +	dd->chancnt = 6;
> > hard coding is not advised
> 
> But there are 6 channels ;)
JZ4740_MAX_CH 6 :)

--
~Vinod
