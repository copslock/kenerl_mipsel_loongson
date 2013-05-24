Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 May 2013 07:55:44 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:56569 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6820512Ab3EXFzfM7ok4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 May 2013 07:55:35 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 842A884E;
        Fri, 24 May 2013 07:55:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id RFb80YNbtFGn; Fri, 24 May 2013 07:55:28 +0200 (CEST)
Received: from [192.168.178.21] (host-188-174-213-35.customer.m-online.net [188.174.213.35])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 5D23084D;
        Fri, 24 May 2013 07:55:25 +0200 (CEST)
Message-ID: <519F016C.4040901@metafoo.de>
Date:   Fri, 24 May 2013 07:58:04 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Vinod Koul <vinod.koul@intel.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 3/6] dma: Add a jz4740 dmaengine driver
References: <1369341387-19147-1-git-send-email-lars@metafoo.de> <1369341387-19147-4-git-send-email-lars@metafoo.de> <20130524045935.GM30200@intel.com>
In-Reply-To: <20130524045935.GM30200@intel.com>
X-Enigmail-Version: 1.4.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 05/24/2013 06:59 AM, Vinod Koul wrote:
> On Thu, May 23, 2013 at 10:36:24PM +0200, Lars-Peter Clausen wrote:
>> This patch adds dmaengine support for the JZ4740 DMA controller. For now the
>> driver will be a wrapper around the custom JZ4740 DMA API. Once all users of the
>> custom JZ4740 DMA API have been converted to the dmaengine API the custom API
>> will be removed and direct hardware access will be added to the dmaengine
>> driver.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
> 
>> +static enum jz4740_dma_width jz4740_dma_width(enum dma_slave_buswidth width)
>> +{
>> +	switch (width) {
>> +	case DMA_SLAVE_BUSWIDTH_1_BYTE:
>> +		return JZ4740_DMA_WIDTH_8BIT;
>> +	case DMA_SLAVE_BUSWIDTH_2_BYTES:
>> +		return JZ4740_DMA_WIDTH_16BIT;
>> +	case DMA_SLAVE_BUSWIDTH_4_BYTES:
>> +		return JZ4740_DMA_WIDTH_32BIT;
>> +	default:
>> +		return JZ4740_DMA_WIDTH_32BIT;
>> +	}
> Only diff between the values here and dmaengien values is JZ4740_DMA_WIDTH_32BIT
> as 0. But the header tells me taht its default and SIZE one has values in that
> pattern too. If that is the case you maybe able to get rid on conversion and use
> dmaengine values directly.
> 

I'd prefer to keep it the way it is. The JZ4740_DMA_WIDTH constants end up
being written to the hardware, while the DMA_SLAVE_BUSWIDTH constants are Linux
internal. I prefer to not mix these two up.

>> +}
>> +
>> +static enum jz4740_dma_transfer_size jz4740_dma_maxburst(u32 maxburst)
>> +{
>> +	if (maxburst <= 1)
>> +		return JZ4740_DMA_TRANSFER_SIZE_1BYTE;
>> +	else if (maxburst <= 3)
>> +		return JZ4740_DMA_TRANSFER_SIZE_2BYTE;
>> +	else if (maxburst <= 15)
>> +		return JZ4740_DMA_TRANSFER_SIZE_4BYTE;
>> +	else if (maxburst <= 31)
>> +		return JZ4740_DMA_TRANSFER_SIZE_16BYTE;
>> +
>> +	return JZ4740_DMA_TRANSFER_SIZE_32BYTE;
>> +}
>> +
>> +static int jz4740_dma_slave_config(struct dma_chan *c,
>> +	const struct dma_slave_config *config)
>> +{
>> +	struct jz4740_dmaengine_chan *chan = to_jz4740_dma_chan(c);
>> +	struct jz4740_dma_config jzcfg;
>> +
>> +	switch (config->direction) {
>> +	case DMA_MEM_TO_DEV:
>> +		jzcfg.flags = JZ4740_DMA_SRC_AUTOINC;
>> +		jzcfg.transfer_size = jz4740_dma_maxburst(config->dst_maxburst);
>> +		break;
>> +	case DMA_DEV_TO_MEM:
>> +		jzcfg.flags = JZ4740_DMA_DST_AUTOINC;
>> +		jzcfg.transfer_size = jz4740_dma_maxburst(config->src_maxburst);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +
>> +	jzcfg.src_width = jz4740_dma_width(config->src_addr_width);
>> +	jzcfg.dst_width = jz4740_dma_width(config->dst_addr_width);
> this should be direction based, typically DMA engines have only one width to be
> programmed.

This one needs both.

>> +	jzcfg.mode = JZ4740_DMA_MODE_SINGLE;
>> +	jzcfg.request_type = config->slave_id;
>> +
>> +	chan->config = *config;
>> +
>> +	jz4740_dma_configure(chan->jz_chan, &jzcfg);
>> +
>> +	return 0;
> You are NOT use src_addr/dstn_addr? How else are you passing the periphral
> address?

I'm saving the whole config, which will later be used to retrieve the source or
dest address.

>> +}
[...]
>> +static int jz4740_dma_alloc_chan_resources(struct dma_chan *c)
>> +{
>> +	struct jz4740_dmaengine_chan *chan = to_jz4740_dma_chan(c);
>> +
>> +	chan->jz_chan = jz4740_dma_request(chan, NULL);
>> +	if (!chan->jz_chan)
>> +		return -EBUSY;
>> +
>> +	jz4740_dma_set_complete_cb(chan->jz_chan, jz4740_dma_complete_cb);
>> +
>> +	return 0;
> Zero is not expected value, you need to return the descriptors allocated
> sucessfully.

Well, zero descriptors have been allocated. As far as I can see only a negative
return value is treated as an error. Also the core doesn't seem to use the
return value for anything else but checking if it is an error.

>> +}
>> +
[...]
>> +	dd->chancnt = 6;
> hard coding is not advised

But there are 6 channels ;)

[...]
>> +
>> +static struct platform_driver jz4740_dma_driver = {
>> +	.probe = jz4740_dma_probe,
>> +	.remove = jz4740_dma_remove,
>> +	.driver = {
>> +		.name = "jz4740-dma",
>> +		.owner = THIS_MODULE,
>> +	},
>> +};
>> +module_platform_driver(jz4740_dma_driver);
> typically lot of dma driver like to be higher up in the module order. The reason
> is to have device initialized before clients, pls check if you need that

I don't need it.

Thanks for the quick review.
- Lars
