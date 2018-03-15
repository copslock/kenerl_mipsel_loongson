Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Mar 2018 22:13:55 +0100 (CET)
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48832 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994554AbeCOVNsTITmM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Mar 2018 22:13:48 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 1F140270B70
Message-ID: <1521148366.26589.14.camel@collabora.co.uk>
Subject: Re: [PATCH v2 10/14] mmc: jz4740: Use dma_request_chan()
From:   Ezequiel Garcia <ezequiel@collabora.co.uk>
To:     Paul Cercueil <paul@crapouillou.net>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>
Date:   Thu, 15 Mar 2018 18:12:46 -0300
In-Reply-To: <1521147579.1697.0@smtp.crapouillou.net>
References: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
         <20180312215554.20770-11-ezequiel@vanguardiasur.com.ar>
         <1521147579.1697.0@smtp.crapouillou.net>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <ezequiel@collabora.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@collabora.co.uk
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

On Thu, 2018-03-15 at 17:59 -0300, Paul Cercueil wrote:
> Hi,
> 
> Le lun. 12 mars 2018 à 18:55, Ezequiel Garcia 
> <ezequiel@vanguardiasur.com.ar> a écrit :
> > From: Ezequiel Garcia <ezequiel@collabora.co.uk>
> > 
> > Replace dma_request_channel() with dma_request_chan(),
> > which also supports probing from the devicetree.
> > 
> > Tested-by: Mathieu Malaterre <malat@debian.org>
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
> > ---
> >  drivers/mmc/host/jz4740_mmc.c | 22 +++++++---------------
> >  1 file changed, 7 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/jz4740_mmc.c 
> > b/drivers/mmc/host/jz4740_mmc.c
> > index c3ec8e662706..37183fe32ef8 100644
> > --- a/drivers/mmc/host/jz4740_mmc.c
> > +++ b/drivers/mmc/host/jz4740_mmc.c
> > @@ -225,31 +225,23 @@ static void 
> > jz4740_mmc_release_dma_channels(struct jz4740_mmc_host *host)
> > 
> >  static int jz4740_mmc_acquire_dma_channels(struct jz4740_mmc_host 
> > *host)
> >  {
> > -	dma_cap_mask_t mask;
> > -
> > -	dma_cap_zero(mask);
> > -	dma_cap_set(DMA_SLAVE, mask);
> > -
> > -	host->dma_tx = dma_request_channel(mask, NULL, host);
> > -	if (!host->dma_tx) {
> > +	host->dma_tx = dma_request_chan(mmc_dev(host->mmc), "tx");
> > +	if (IS_ERR(host->dma_tx)) {
> >  		dev_err(mmc_dev(host->mmc), "Failed to get dma_tx
> > channel\n");
> > -		return -ENODEV;
> > +		return PTR_ERR(host->dma_tx);
> >  	}
> > 
> > -	host->dma_rx = dma_request_channel(mask, NULL, host);
> > -	if (!host->dma_rx) {
> > +	host->dma_rx = dma_request_chan(mmc_dev(host->mmc), "rx");
> 
> I suspect this breaks on jz4740... Did you test?
> 

No, but code inspecting I was expecting it wouldn't break anything.
dma_request_channel() searches for a slave channel, via the DMA_SLAVE
mask that the driver sets.

dma_request_chan() seems to fallback to do the same.

struct dma_chan *dma_request_chan(struct device *dev, const char *name)
{
        struct dma_device *d, *_d;
        struct dma_chan *chan = NULL;

        /* If device-tree is present get slave info from here */
        if (dev->of_node)
                chan = of_dma_request_slave_channel(dev->of_node,
name);

        /* ... */

        if (chan) {
                /* Valid channel found or requester need to be deferred
*/
                if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER)
                        return chan;
        }

        /* Try to find the channel via the DMA filter map(s) */
        mutex_lock(&dma_list_mutex);
        list_for_each_entry_safe(d, _d, &dma_device_list, global_node)
{
                dma_cap_mask_t mask;
                const struct dma_slave_map *map = dma_filter_match(d,
name, dev);

                if (!map)
                        continue;

                dma_cap_zero(mask);
                dma_cap_set(DMA_SLAVE, mask);

                chan = find_candidate(d, &mask, d->filter.fn, map-
>param);
                if (!IS_ERR(chan))
                        break;
        }
        mutex_unlock(&dma_list_mutex);

        return chan ? chan : ERR_PTR(-EPROBE_DEFER);
}

Unfortunately, I don't have anything but a jz4780 Ci20, so can't really
test this.

Thanks,
Eze
