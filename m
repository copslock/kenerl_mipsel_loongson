Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jul 2011 11:55:50 +0200 (CEST)
Received: from rere.qmqm.pl ([89.167.52.164]:36802 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491129Ab1GLJzp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Jul 2011 11:55:45 +0200
Received: by rere.qmqm.pl (Postfix, from userid 1000)
        id 59C1813A6A; Tue, 12 Jul 2011 11:55:41 +0200 (CEST)
Date:   Tue, 12 Jul 2011 11:55:41 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Felix Fietkau <nbd@openwrt.org>
Cc:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        Jouni Malinen <jmalinen@atheros.com>,
        Senthil Balasubramanian <senthilkumar@atheros.com>,
        ath9k-devel@lists.ath9k.org,
        Vasanthakumar Thiagarajan <vasanth@atheros.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [ath9k-devel] [PATCH v2 07/46] net/wireless: ath9k: fix DMA
 API usage
Message-ID: <20110712095541.GA6236@rere.qmqm.pl>
References: <cover.1310339688.git.mirq-linux@rere.qmqm.pl>
 <280ad9176e6532f231e054b38b952b20580874c5.1310339688.git.mirq-linux@rere.qmqm.pl>
 <4E1BCF36.2010506@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4E1BCF36.2010506@openwrt.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 30606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mirq-linux@rere.qmqm.pl
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8480

On Tue, Jul 12, 2011 at 12:36:06PM +0800, Felix Fietkau wrote:
> On 2011-07-11 8:52 AM, Micha³ Miros³aw wrote:
> >Also constify buf_addr for ath9k_hw_process_rxdesc_edma() to verify
> >assumptions --- dma_sync_single_for_device() call can be removed.
> >
> >Signed-off-by: Micha³ Miros³aw<mirq-linux@rere.qmqm.pl>
> >---
> >  drivers/net/wireless/ath/ath9k/ar9003_mac.c |    4 ++--
> >  drivers/net/wireless/ath/ath9k/ar9003_mac.h |    2 +-
> >  drivers/net/wireless/ath/ath9k/recv.c       |   10 +++-------
> >  3 files changed, 6 insertions(+), 10 deletions(-)
> >
> >diff --git a/drivers/net/wireless/ath/ath9k/recv.c b/drivers/net/wireless/ath/ath9k/recv.c
> >index 70dc8ec..c5f46d5 100644
> >--- a/drivers/net/wireless/ath/ath9k/recv.c
> >+++ b/drivers/net/wireless/ath/ath9k/recv.c
> >@@ -684,15 +684,11 @@ static bool ath_edma_get_buffers(struct ath_softc *sc,
> >  	BUG_ON(!bf);
> >
> >  	dma_sync_single_for_cpu(sc->dev, bf->bf_buf_addr,
> >-				common->rx_bufsize, DMA_FROM_DEVICE);
> >+				common->rx_bufsize, DMA_BIDIRECTIONAL);
> >
> >  	ret = ath9k_hw_process_rxdesc_edma(ah, NULL, skb->data);
> >-	if (ret == -EINPROGRESS) {
> >-		/*let device gain the buffer again*/
> >-		dma_sync_single_for_device(sc->dev, bf->bf_buf_addr,
> >-				common->rx_bufsize, DMA_FROM_DEVICE);
> >+	if (ret == -EINPROGRESS)
> >  		return false;
> >-	}
> >
> >  	__skb_unlink(skb,&rx_edma->rx_fifo);
> >  	if (ret == -EINVAL) {
> I have strong doubts about this change. On most MIPS devices,
> dma_sync_single_for_cpu is a no-op, whereas
> dma_sync_single_for_device flushes the cache range. With this
> change, the CPU could cache the DMA status part behind skb->data and
> that cache entry would not be flushed inbetween calls to this
> functions on the same buffer, likely leading to rx stalls.

You're suggesting a platform implementation bug then. If the platform is not
cache-coherent, it should invalidate relevant CPU cache lines for sync_to_cpu
and unmap cases. Do other devices show such symptoms on MIPS systems?

I'm not familiar with the platform internals, so we should ask MIPS people.

[added Cc: linux-mips]

Best Regards,
Micha³ Miros³aw
