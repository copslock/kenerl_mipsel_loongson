Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Mar 2018 23:34:05 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:51450 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994554AbeCOWd6zNUY0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Mar 2018 23:33:58 +0100
Date:   Thu, 15 Mar 2018 19:33:40 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 10/14] mmc: jz4740: Use dma_request_chan()
To:     Ezequiel Garcia <ezequiel@collabora.co.uk>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Message-Id: <1521153221.9698.0@smtp.crapouillou.net>
In-Reply-To: <1521148366.26589.14.camel@collabora.co.uk>
References: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
        <20180312215554.20770-11-ezequiel@vanguardiasur.com.ar>
        <1521147579.1697.0@smtp.crapouillou.net>
        <1521148366.26589.14.camel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1521153237; bh=8B0sefcXo5yHAqgd688CZEMBhH/z9ID01UmysRY2kJg=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=UHnsGKOPPshvo7ZTX2vXOlxvuyp6t+4V7vi7tbkNayOqlpqgFAsmPLGWPZ+Q6us3r/413VGf/jXtTmG70EpujJqZVBRgq/1oqKBpEhNhlBjdwb1hc7Z3aQbloRrJ4l8ICCix/0xBF7KVFQMgiQLTnExP4Na1/V7xBBfxbJdGpQw=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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



Le jeu. 15 mars 2018 à 18:12, Ezequiel Garcia 
<ezequiel@collabora.co.uk> a écrit :
> On Thu, 2018-03-15 at 17:59 -0300, Paul Cercueil wrote:
>>  Hi,
>> 
>>  Le lun. 12 mars 2018 à 18:55, Ezequiel Garcia
>>  <ezequiel@vanguardiasur.com.ar> a écrit :
>>  > From: Ezequiel Garcia <ezequiel@collabora.co.uk>
>>  >
>>  > Replace dma_request_channel() with dma_request_chan(),
>>  > which also supports probing from the devicetree.
>>  >
>>  > Tested-by: Mathieu Malaterre <malat@debian.org>
>>  > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
>>  > ---
>>  >  drivers/mmc/host/jz4740_mmc.c | 22 +++++++---------------
>>  >  1 file changed, 7 insertions(+), 15 deletions(-)
>>  >
>>  > diff --git a/drivers/mmc/host/jz4740_mmc.c
>>  > b/drivers/mmc/host/jz4740_mmc.c
>>  > index c3ec8e662706..37183fe32ef8 100644
>>  > --- a/drivers/mmc/host/jz4740_mmc.c
>>  > +++ b/drivers/mmc/host/jz4740_mmc.c
>>  > @@ -225,31 +225,23 @@ static void
>>  > jz4740_mmc_release_dma_channels(struct jz4740_mmc_host *host)
>>  >
>>  >  static int jz4740_mmc_acquire_dma_channels(struct jz4740_mmc_host
>>  > *host)
>>  >  {
>>  > -	dma_cap_mask_t mask;
>>  > -
>>  > -	dma_cap_zero(mask);
>>  > -	dma_cap_set(DMA_SLAVE, mask);
>>  > -
>>  > -	host->dma_tx = dma_request_channel(mask, NULL, host);
>>  > -	if (!host->dma_tx) {
>>  > +	host->dma_tx = dma_request_chan(mmc_dev(host->mmc), "tx");
>>  > +	if (IS_ERR(host->dma_tx)) {
>>  >  		dev_err(mmc_dev(host->mmc), "Failed to get dma_tx
>>  > channel\n");
>>  > -		return -ENODEV;
>>  > +		return PTR_ERR(host->dma_tx);
>>  >  	}
>>  >
>>  > -	host->dma_rx = dma_request_channel(mask, NULL, host);
>>  > -	if (!host->dma_rx) {
>>  > +	host->dma_rx = dma_request_chan(mmc_dev(host->mmc), "rx");
>> 
>>  I suspect this breaks on jz4740... Did you test?
>> 
> 
> No, but code inspecting I was expecting it wouldn't break anything.
> dma_request_channel() searches for a slave channel, via the DMA_SLAVE
> mask that the driver sets.
> 
> dma_request_chan() seems to fallback to do the same.

Alright, I overlooked that. I guess it's fine then.

> struct dma_chan *dma_request_chan(struct device *dev, const char 
> *name)
> {
>         struct dma_device *d, *_d;
>         struct dma_chan *chan = NULL;
> 
>         /* If device-tree is present get slave info from here */
>         if (dev->of_node)
>                 chan = of_dma_request_slave_channel(dev->of_node,
> name);
> 
>         /* ... */
> 
>         if (chan) {
>                 /* Valid channel found or requester need to be 
> deferred
> */
>                 if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER)
>                         return chan;
>         }
> 
>         /* Try to find the channel via the DMA filter map(s) */
>         mutex_lock(&dma_list_mutex);
>         list_for_each_entry_safe(d, _d, &dma_device_list, global_node)
> {
>                 dma_cap_mask_t mask;
>                 const struct dma_slave_map *map = dma_filter_match(d,
> name, dev);
> 
>                 if (!map)
>                         continue;
> 
>                 dma_cap_zero(mask);
>                 dma_cap_set(DMA_SLAVE, mask);
> 
>                 chan = find_candidate(d, &mask, d->filter.fn, map-
>> param);
>                 if (!IS_ERR(chan))
>                         break;
>         }
>         mutex_unlock(&dma_list_mutex);
> 
>         return chan ? chan : ERR_PTR(-EPROBE_DEFER);
> }
> 
> Unfortunately, I don't have anything but a jz4780 Ci20, so can't 
> really
> test this.

Apart from this patch, your patchset looks sufficiently similar to what 
I
successfully tested on jz4740, so it's safe to assume it doesn't break 
anything.
Unfortunately I won't be able to test it on jz4740 before the end of 
this year.

> Thanks,
> Eze
