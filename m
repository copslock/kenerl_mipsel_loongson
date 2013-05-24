Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 May 2013 08:38:36 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:59753 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817179Ab3EXGifIWmP3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 May 2013 08:38:35 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 0A919976;
        Fri, 24 May 2013 08:38:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id M44-5SiwSAgo; Fri, 24 May 2013 08:38:28 +0200 (CEST)
Received: from [192.168.178.21] (host-188-174-213-35.customer.m-online.net [188.174.213.35])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 3D3D2975;
        Fri, 24 May 2013 08:38:26 +0200 (CEST)
Message-ID: <519F0B81.1090009@metafoo.de>
Date:   Fri, 24 May 2013 08:41:05 +0200
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
References: <1369341387-19147-1-git-send-email-lars@metafoo.de> <1369341387-19147-4-git-send-email-lars@metafoo.de> <20130524045935.GM30200@intel.com> <519F016C.4040901@metafoo.de> <20130524055453.GR30200@intel.com>
In-Reply-To: <20130524055453.GR30200@intel.com>
X-Enigmail-Version: 1.4.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36582
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

On 05/24/2013 07:54 AM, Vinod Koul wrote:
> On Fri, May 24, 2013 at 07:58:04AM +0200, Lars-Peter Clausen wrote:
>> This one needs both.
>>
>>>> +	jzcfg.mode = JZ4740_DMA_MODE_SINGLE;
>>>> +	jzcfg.request_type = config->slave_id;
>>>> +
>>>> +	chan->config = *config;
>>>> +
>>>> +	jz4740_dma_configure(chan->jz_chan, &jzcfg);
>>>> +
>>>> +	return 0;
>>> You are NOT use src_addr/dstn_addr? How else are you passing the periphral
>>> address?
>> I'm saving the whole config, which will later be used to retrieve the source or
>> dest address.
> well I missed that and it is a bad idea. You dont know when client has
> freed/thrown the pointer so copy this instead..

I do copy the full config, not just the pointer to the config. Although
src_addr and dest_addr are the only two fields which are used later on at this
point. So I could change it to just copy src_addr and dest_addr, or well just
one of them depending on the direction.

> 
>>
>>>> +}
>> [...]
>>>> +static int jz4740_dma_alloc_chan_resources(struct dma_chan *c)
>>>> +{
>>>> +	struct jz4740_dmaengine_chan *chan = to_jz4740_dma_chan(c);
>>>> +
>>>> +	chan->jz_chan = jz4740_dma_request(chan, NULL);
>>>> +	if (!chan->jz_chan)
>>>> +		return -EBUSY;
>>>> +
>>>> +	jz4740_dma_set_complete_cb(chan->jz_chan, jz4740_dma_complete_cb);
>>>> +
>>>> +	return 0;
>>> Zero is not expected value, you need to return the descriptors allocated
>>> sucessfully.
>>
>> Well, zero descriptors have been allocated. As far as I can see only a negative
>> return value is treated as an error. Also the core doesn't seem to use the
>> return value for anything else but checking if it is an error.
> This is the API defination
> * @device_alloc_chan_resources: allocate resources and return the
> *      number of allocated descriptors
> 

But 0 is still the number of descriptors that have been pre-allocated.

- Lars
