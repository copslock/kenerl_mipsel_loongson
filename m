Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 May 2013 10:40:11 +0200 (CEST)
Received: from smtp-out-103.synserver.de ([212.40.185.103]:1079 "EHLO
        smtp-out-103.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816642Ab3EXIkDdaR1v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 May 2013 10:40:03 +0200
Received: (qmail 24661 invoked by uid 0); 24 May 2013 08:40:01 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 24596
Received: from p4fe62b20.dip0.t-ipconnect.de (HELO ?192.168.0.176?) [79.230.43.32]
  by 217.119.54.81 with AES256-SHA encrypted SMTP; 24 May 2013 08:40:01 -0000
Message-ID: <519F2756.10809@metafoo.de>
Date:   Fri, 24 May 2013 10:39:50 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Vinod Koul <vinod.koul@intel.com>
CC:     linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: Re: [alsa-devel] [PATCH 3/6] dma: Add a jz4740 dmaengine driver
References: <1369341387-19147-1-git-send-email-lars@metafoo.de> <1369341387-19147-4-git-send-email-lars@metafoo.de> <20130524045935.GM30200@intel.com> <519F016C.4040901@metafoo.de> <20130524055453.GR30200@intel.com> <519F0B81.1090009@metafoo.de> <20130524075403.GS30200@intel.com>
In-Reply-To: <20130524075403.GS30200@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36585
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

>>>>>> +static int jz4740_dma_alloc_chan_resources(struct dma_chan *c)
>>>>>> +{
>>>>>> +	struct jz4740_dmaengine_chan *chan = to_jz4740_dma_chan(c);
>>>>>> +
>>>>>> +	chan->jz_chan = jz4740_dma_request(chan, NULL);
>>>>>> +	if (!chan->jz_chan)
>>>>>> +		return -EBUSY;
>>>>>> +
>>>>>> +	jz4740_dma_set_complete_cb(chan->jz_chan, jz4740_dma_complete_cb);
>>>>>> +
>>>>>> +	return 0;
>>>>> Zero is not expected value, you need to return the descriptors allocated
>>>>> sucessfully.
>>>>
>>>> Well, zero descriptors have been allocated. As far as I can see only a negative
>>>> return value is treated as an error. Also the core doesn't seem to use the
>>>> return value for anything else but checking if it is an error.
>>> This is the API defination
>>> * @device_alloc_chan_resources: allocate resources and return the
>>> *      number of allocated descriptors
>>>
>>
>> But 0 is still the number of descriptors that have been pre-allocated.
> and that should change, typically the driver will preallocate a pool of
> descriptors. These are to be used later for .device_prep_xxx calls.
> 

Since the size of the descriptor is not know in advance this is not possible.

- Lars
