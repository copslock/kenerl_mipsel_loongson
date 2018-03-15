Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Mar 2018 22:00:05 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:35788 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994039AbeCOU76K9oZM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Mar 2018 21:59:58 +0100
Date:   Thu, 15 Mar 2018 17:59:39 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 10/14] mmc: jz4740: Use dma_request_chan()
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Message-Id: <1521147579.1697.0@smtp.crapouillou.net>
In-Reply-To: <20180312215554.20770-11-ezequiel@vanguardiasur.com.ar>
References: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
        <20180312215554.20770-11-ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1521147596; bh=GslvfaUXGbX3g/qd77k6oDeeUfmjK3X4pD8M38lnoV8=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=TLkbaSVyW16WDfNrrZNfZPxGcPsfFCARy757gjfC+8/JXW86aK1l9u2VvXGtVhuuU+nD1SGEU1HFVW0/J186HbYxAuSmR0O2QJ1KUWqQgAO3qeDdlCGHijZ6cQx0YzjMrrS4r3IWrUqZnlUemUR/gIWb04K2ERv+BjbLnAMK8CM=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62991
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

Hi,

Le lun. 12 mars 2018 à 18:55, Ezequiel Garcia 
<ezequiel@vanguardiasur.com.ar> a écrit :
> From: Ezequiel Garcia <ezequiel@collabora.co.uk>
> 
> Replace dma_request_channel() with dma_request_chan(),
> which also supports probing from the devicetree.
> 
> Tested-by: Mathieu Malaterre <malat@debian.org>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
> ---
>  drivers/mmc/host/jz4740_mmc.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mmc/host/jz4740_mmc.c 
> b/drivers/mmc/host/jz4740_mmc.c
> index c3ec8e662706..37183fe32ef8 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -225,31 +225,23 @@ static void 
> jz4740_mmc_release_dma_channels(struct jz4740_mmc_host *host)
> 
>  static int jz4740_mmc_acquire_dma_channels(struct jz4740_mmc_host 
> *host)
>  {
> -	dma_cap_mask_t mask;
> -
> -	dma_cap_zero(mask);
> -	dma_cap_set(DMA_SLAVE, mask);
> -
> -	host->dma_tx = dma_request_channel(mask, NULL, host);
> -	if (!host->dma_tx) {
> +	host->dma_tx = dma_request_chan(mmc_dev(host->mmc), "tx");
> +	if (IS_ERR(host->dma_tx)) {
>  		dev_err(mmc_dev(host->mmc), "Failed to get dma_tx channel\n");
> -		return -ENODEV;
> +		return PTR_ERR(host->dma_tx);
>  	}
> 
> -	host->dma_rx = dma_request_channel(mask, NULL, host);
> -	if (!host->dma_rx) {
> +	host->dma_rx = dma_request_chan(mmc_dev(host->mmc), "rx");

I suspect this breaks on jz4740... Did you test?

> +	if (IS_ERR(host->dma_rx)) {
>  		dev_err(mmc_dev(host->mmc), "Failed to get dma_rx channel\n");
> -		goto free_master_write;
> +		dma_release_channel(host->dma_tx);
> +		return PTR_ERR(host->dma_rx);
>  	}
> 
>  	/* Initialize DMA pre request cookie */
>  	host->next_data.cookie = 1;
> 
>  	return 0;
> -
> -free_master_write:
> -	dma_release_channel(host->dma_tx);
> -	return -ENODEV;
>  }
> 
>  static inline struct dma_chan *jz4740_mmc_get_dma_chan(struct 
> jz4740_mmc_host *host,
> --
> 2.16.2
> 
