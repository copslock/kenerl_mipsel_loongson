Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 May 2013 20:43:45 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:65013 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824782Ab3E3SnkKOqsV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 May 2013 20:43:40 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 30068BD7;
        Thu, 30 May 2013 20:43:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id aKGG4yzlwnY8; Thu, 30 May 2013 20:43:33 +0200 (CEST)
Received: from [192.168.178.21] (ppp-188-174-155-156.dynamic.mnet-online.de [188.174.155.156])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id B5BFFBD6;
        Thu, 30 May 2013 20:43:31 +0200 (CEST)
Message-ID: <51A79E8F.4070209@metafoo.de>
Date:   Thu, 30 May 2013 20:46:39 +0200
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
Subject: Re: [PATCH v2 3/6] dma: Add a jz4740 dmaengine driver
References: <1369931105-28065-1-git-send-email-lars@metafoo.de> <1369931105-28065-4-git-send-email-lars@metafoo.de> <20130530171225.GA3767@intel.com>
In-Reply-To: <20130530171225.GA3767@intel.com>
X-Enigmail-Version: 1.4.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36654
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

On 05/30/2013 07:12 PM, Vinod Koul wrote:
> On Thu, May 30, 2013 at 06:25:02PM +0200, Lars-Peter Clausen wrote:
>> This patch adds dmaengine support for the JZ4740 DMA controller. For now the
>> driver will be a wrapper around the custom JZ4740 DMA API. Once all users of the
>> custom JZ4740 DMA API have been converted to the dmaengine API the custom API
>> will be removed and direct hardware access will be added to the dmaengine
>> driver.
>>
>> +
>> +#include <asm/mach-jz4740/dma.h>
> Am bit worried about having header in arch. Why cant we have this drivers header
> in linux/. That way same IP block cna be reused across archs.
> I was hoping that you would have move it in 6th patch, but that isnt the case

At the end of this series the header only contains the slave ids used by the
various cores on the JZ4740. Since these ids differ from SoC to SoC it doesn't
make much sense to move the header to a generic location.

> 
> 
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
> Sorry, I didnt reply on this one. The API expects you to allocate a pool of
> descriptors. These descriptors are to be used in .device_prep_xxx calls later.

The size of the descriptor is not fixed, so they can not be pre-allocated. And
this is nothing new either, most of the more recently added dmaengine drivers
allocate their descriptors on demand.

- Lars
