Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 19:29:50 +0200 (CEST)
Received: from smtp-out-079.synserver.de ([212.40.185.79]:1064 "EHLO
        smtp-out-079.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835108Ab3FJR3jdPvCw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Jun 2013 19:29:39 +0200
Received: (qmail 22769 invoked by uid 0); 10 Jun 2013 17:29:38 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 22742
Received: from ppp-93-104-174-180.dynamic.mnet-online.de (HELO ?192.168.178.26?) [93.104.174.180]
  by 217.119.54.87 with AES256-SHA encrypted SMTP; 10 Jun 2013 17:29:38 -0000
Message-ID: <51B60D0A.7040307@metafoo.de>
Date:   Mon, 10 Jun 2013 19:29:46 +0200
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
References: <1369931105-28065-1-git-send-email-lars@metafoo.de> <1369931105-28065-4-git-send-email-lars@metafoo.de> <20130530171225.GA3767@intel.com> <51A79E8F.4070209@metafoo.de>
In-Reply-To: <51A79E8F.4070209@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36813
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

On 05/30/2013 08:46 PM, Lars-Peter Clausen wrote:
>>> +static int jz4740_dma_alloc_chan_resources(struct dma_chan *c)
>>> +{
>>> +	struct jz4740_dmaengine_chan *chan = to_jz4740_dma_chan(c);
>>> +
>>> +	chan->jz_chan = jz4740_dma_request(chan, NULL);
>>> +	if (!chan->jz_chan)
>>> +		return -EBUSY;
>>> +
>>> +	jz4740_dma_set_complete_cb(chan->jz_chan, jz4740_dma_complete_cb);
>>> +
>>> +	return 0;
>> Sorry, I didnt reply on this one. The API expects you to allocate a pool of
>> descriptors. These descriptors are to be used in .device_prep_xxx calls later.
> 
> The size of the descriptor is not fixed, so they can not be pre-allocated. And
> this is nothing new either, most of the more recently added dmaengine drivers
> allocate their descriptors on demand.

Vinod, are you ok with this explanation?

- Lars
