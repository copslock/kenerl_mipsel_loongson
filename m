Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Oct 2017 15:31:23 +0200 (CEST)
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55505 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990511AbdJXNbJQMyol (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Oct 2017 15:31:09 +0200
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20171024133059euoutp0181182429b8f24daa7c69d14f2e05ea1a~whMWSZyxM0150401504euoutp01j;
        Tue, 24 Oct 2017 13:30:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20171024133059euoutp0181182429b8f24daa7c69d14f2e05ea1a~whMWSZyxM0150401504euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1508851859;
        bh=jEV9GAEzwv2MPKc7N8I89gcB929JydQz9he+D1/r8F0=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=pwxNITTDUXljAhSAOju+Bj67siUccQwAnbdMLPPJ3L92ow9Ymmj8LlirtIYi2C+M+
         MFfUGDbhUZb3CPeIPcE2uhMXgRGJj+iS1VygCCEWOYFdjM+TqdDW8qmzb69KQeg+is
         6delsrYdgM/qA9UNYCT5G6YRHcGmQzh6z1f4ucZ0=
Received: from eusmges1.samsung.com (unknown [203.254.199.239]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20171024133058eucas1p21876e507802223b7d038e79445bf0b0f~whMVnXy8X0095100951eucas1p2G;
        Tue, 24 Oct 2017 13:30:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1.samsung.com  (EUCPMTA) with SMTP id E9.0A.12576.2904FE95; Tue, 24
        Oct 2017 14:30:58 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20171024133057eucas1p2673b9f6ca38e227f1708f47d353c5b51~whMU5md-l3143531435eucas1p2n;
        Tue, 24 Oct 2017 13:30:57 +0000 (GMT)
X-AuditID: cbfec7ef-f79ee6d000003120-f1-59ef40929001
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4E.4D.20118.1904FE95; Tue, 24
        Oct 2017 14:30:57 +0100 (BST)
Received: from [106.116.147.30] by eusync1.samsung.com (Oracle
        Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with
        ESMTPA id <0OYB00HXBXJKPJ10@eusync1.samsung.com>; Tue, 24 Oct 2017 14:30:57
        +0100 (BST)
Subject: Re: [PATCH V9 1/4] dma-mapping: Rework dma_get_cache_alignment()
To:     Huacai Chen <chenhc@lemote.com>, Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fuxin Zhang <zhangfx@lemote.com>, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, stable@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Pawel Osciak <pawel@osciak.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ivan Mikhaylov <ivan@ru.ibm.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Andy Gross <agross@codeaurora.org>,
        "Mark A . Greer" <mgreer@animalcreek.com>,
        Robert Baldyga <r.baldyga@hackerion.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-id: <0f34e021-a559-3e3c-4586-48450e87d5c8@samsung.com>
Date:   Tue, 24 Oct 2017 15:30:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.4.0
MIME-version: 1.0
In-reply-to: <1508742767-28366-1-git-send-email-chenhc@lemote.com>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-transfer-encoding: 7bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0zMYRzHPd/v9577dnN8XdFnyWw3zM9oazxEfm+PzcbMHw4bN76rpg53
        avKPEyVXri4sriQuP/o1cuGiNZ10iPyIKSRUh+a6U1sjHF3fbP33+jyf9/O8P+/PHp5VFeMw
        Pl63T9TrtAlqrOBuNvxsmpO7zKuZdzdPINW+TIYUXC3HxJeaxpJzqdcwKSm7z5D6Q35Megq/
        sKTUoiNPUr/JSfPtAkxyTuXKSeZrByaXXX6GfLAzxFJagcnfgW4ZOen5KSdt/l5EXtRMIXW+
        ThkpqvyEyIDZyZD+dy1oWSg1d3xmaXlhOaLW9ieYNpuPM7S+ugHTrOrHiGZ9OyKj+U1NmD44
        /Yuj90sqGPrBaefonVYjpu68ewz93vWGox0DXzH11r7C64M3KxbvFBPik0X93Jjtirg/5gxm
        z5VKZv/vuk+cEWX1IRMK4kGIgqoWB5Z4Ajx7f3WIVcIlBPY/ehNSDHIfgmx3Nvv/wrP8bEZq
        DIpy7BeQVHxG0HroPRdQBQtroLOsYcgiRFgJPW9+sAERK9zG4P5qGnoKC5Fg8piG/JRCDBRe
        fCkPMCdMBXeWmQnweGErlNkcnKQZBz9OBAx4PkhYAQ6PPnDMCovA7U+TSTwZ7OUeVuJQOJzW
        ygV8QTjDg+XW3+HMq+DtI49M4mDodlXJJQ6H5hOZnMTZCFLTZkl8GkGTRylxNNxzPR82GwO5
        N/PYwDwgKCEjXSVJKJwsbh9e6XL4aK8dXtApBHeNvbIcNNk6Io51RAbriAzWERmKEFeKQsQk
        Q2KsaIiMMGgTDUm62IgduxOvo8G/2+h3eR2o6/BGJxJ4pB6tbFnYo1HJtMmGlEQnAp5Vhyiv
        RHk1KuVObcoBUb97mz4pQTQ40USeU4cql2xO16iEWO0+cZco7hH1/7sMHxRmROsvr10aN2X0
        g4EV0xpz9tqKN4R1zebR1Lb4MQvSj6a0u2bUJxvPrIu5YdOMCl58sM/3u2ZLbNi7vOPnbTcm
        tck7db3hr9VW9zFTXV9Jc4TNEV01w5dRkX92NV0SU9lxxLPpy1NveHfBAjLdpbMoLBs80Xi+
        /eHGNRNG9Y+tL7zQiNScIU4bOZPVG7T/AA1Mise3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRiA+845+zxeVse58ssIYaiVmKVYfYaI6J8jEQX+CC2okQe1nMqO
        SiaUlySZOrUlxhT1h5HXzJTYSiXnLTPF1PKC2vKa5eYlC2+tnCPw3/N+7/O8vz6aFG1RTnRU
        TDwnj5FGS6AN1WPqGjyZH7AUerpn1gNrl7MIXFxXA/FyWgaJS9NeQFxZ3UHg9lQTxMaSbySu
        yo/BvWmLVnjwdTHEeQWPrHDWsAbiZ10mAusbCJxfVQvx383vAvzYsGGFJ0yrAA80ueDW5RkB
        LqufAnhTqSPw7/EREODIKqfnSbampAaw6i+9kB1U5hBsu7YTstnaD4DNXnwgYIv6+iD77skW
        xXZU1hKsXtdAsW9GUyA7V9hGsCuzYxQ7vbkA2aWWT/CyQ5iNXzgXHZXIyU/537CJ/KPMJOIq
        6ok7261TVArI/gkUwJpGjA/qL8olLHwI9U/WQQWwoUVMOUBDmysCyzAP0Li+eddyYILRTHXn
        bi1mgpBxbJ00SyTTAtGGQk9ZikKADDnllNmCjBdSGBTQzELGH5U8HbIyM8W4orls5e7Vg8w1
        lK//CCyOPVpXTe60NG3NBCKNQW5+JpmzaG2hTWBhZ9RQYyAt7IjSM0apPGCv3lOr9yTqPYl6
        T1IGqCog5hJ4WYSM9/bkpTI+ISbC82as7CXY+RKvOjcaNUBhDNEBhgYSO+GIrzFUJJAm8kky
        HUA0KRELK3yWQkXCcGnSXU4ee12eEM3xOnCEpiSOwpym6lAREyGN525zXBwn/78laGunFNDd
        3b90ws2d0h4+738m6Fhd4MDcAd0aMeF+7tKVwrfJBeGqh5RuSs6lhhSZVn+U2+4LU5d657r8
        KvP8+vT+atfRHOuU/cNBaL7H56rtqqpFrFa5NTcmp01njfgWHl+/JfS+8Hzb2S1TokldvHeR
        F7sGu8+T7+30ptLPHn4qrTRdQvGRUi93Us5L/wESbkD0DgMAAA==
X-CMS-MailID: 20171024133057eucas1p2673b9f6ca38e227f1708f47d353c5b51
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20171023071025epcas4p3e9b9c0af7c0a34561f0d57a20a4f9946
X-RootMTR: 20171023071025epcas4p3e9b9c0af7c0a34561f0d57a20a4f9946
References: <CGME20171023071025epcas4p3e9b9c0af7c0a34561f0d57a20a4f9946@epcas4p3.samsung.com>
        <1508742767-28366-1-git-send-email-chenhc@lemote.com>
Return-Path: <m.szyprowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.szyprowski@samsung.com
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

Hi Huacai,

On 2017-10-23 09:12, Huacai Chen wrote:
> Make dma_get_cache_alignment() to accept a 'dev' argument. As a result,
> it can return different alignments due to different devices' I/O cache
> coherency.
>
> Currently, ARM/ARM64 and MIPS support coherent & noncoherent devices
> co-exist. This may be extended in the future, so add a new function
> pointer (i.e, get_cache_alignment) in 'struct dma_map_ops' as a generic
> solution.
>
> Cc: stable@vger.kernel.org

I don't think this change should go to stable.

> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Pawel Osciak <pawel@osciak.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Michael Chan <michael.chan@broadcom.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Ivan Mikhaylov <ivan@ru.ibm.com>
> Cc: Tariq Toukan <tariqt@mellanox.com>
> Cc: Andy Gross <agross@codeaurora.org>
> Cc: Mark A. Greer <mgreer@animalcreek.com>
> Cc: Robert Baldyga <r.baldyga@hackerion.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>   drivers/infiniband/hw/mthca/mthca_main.c       |   2 +-
>   drivers/media/v4l2-core/videobuf2-dma-contig.c |   2 +-
>   drivers/net/ethernet/broadcom/b44.c            |   8 +-
>   drivers/net/ethernet/ibm/emac/core.c           |  32 +++--
>   drivers/net/ethernet/ibm/emac/core.h           |  14 +-
>   drivers/net/ethernet/mellanox/mlx4/main.c      |   2 +-
>   drivers/spi/spi-qup.c                          |   4 +-
>   drivers/tty/serial/mpsc.c                      | 179 +++++++++++++------------
>   drivers/tty/serial/samsung.c                   |  14 +-
>   include/linux/dma-mapping.h                    |  17 ++-

For videobuf2-dma-contig, serial/samsung and dma-mapping.h:

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>


>   10 files changed, 150 insertions(+), 124 deletions(-)
>
> diff --git a/drivers/infiniband/hw/mthca/mthca_main.c b/drivers/infiniband/hw/mthca/mthca_main.c
> index e36a9bc..078fe8d 100644
> --- a/drivers/infiniband/hw/mthca/mthca_main.c
> +++ b/drivers/infiniband/hw/mthca/mthca_main.c
> @@ -416,7 +416,7 @@ static int mthca_init_icm(struct mthca_dev *mdev,
>   
>   	/* CPU writes to non-reserved MTTs, while HCA might DMA to reserved mtts */
>   	mdev->limits.reserved_mtts = ALIGN(mdev->limits.reserved_mtts * mdev->limits.mtt_seg_size,
> -					   dma_get_cache_alignment()) / mdev->limits.mtt_seg_size;
> +					   dma_get_cache_alignment(&mdev->pdev->dev)) / mdev->limits.mtt_seg_size;
>   
>   	mdev->mr_table.mtt_table = mthca_alloc_icm_table(mdev, init_hca->mtt_base,
>   							 mdev->limits.mtt_seg_size,
> diff --git a/drivers/media/v4l2-core/videobuf2-dma-contig.c b/drivers/media/v4l2-core/videobuf2-dma-contig.c
> index 9f389f3..1f6a9b7 100644
> --- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
> +++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
> @@ -484,7 +484,7 @@ static void *vb2_dc_get_userptr(struct device *dev, unsigned long vaddr,
>   	int ret = 0;
>   	struct sg_table *sgt;
>   	unsigned long contig_size;
> -	unsigned long dma_align = dma_get_cache_alignment();
> +	unsigned long dma_align = dma_get_cache_alignment(dev);
>   
>   	/* Only cache aligned DMA transfers are reliable */
>   	if (!IS_ALIGNED(vaddr | size, dma_align)) {
> diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
> index a1125d1..2f6ffe5 100644
> --- a/drivers/net/ethernet/broadcom/b44.c
> +++ b/drivers/net/ethernet/broadcom/b44.c
> @@ -2344,6 +2344,10 @@ static int b44_init_one(struct ssb_device *sdev,
>   	struct net_device *dev;
>   	struct b44 *bp;
>   	int err;
> +	unsigned int dma_desc_align_size = dma_get_cache_alignment(sdev->dma_dev);
> +
> +	/* Setup paramaters for syncing RX/TX DMA descriptors */
> +	dma_desc_sync_size = max_t(unsigned int, dma_desc_align_size, sizeof(struct dma_desc));
>   
>   	instance++;
>   
> @@ -2587,12 +2591,8 @@ static inline void b44_pci_exit(void)
>   
>   static int __init b44_init(void)
>   {
> -	unsigned int dma_desc_align_size = dma_get_cache_alignment();
>   	int err;
>   
> -	/* Setup paramaters for syncing RX/TX DMA descriptors */
> -	dma_desc_sync_size = max_t(unsigned int, dma_desc_align_size, sizeof(struct dma_desc));
> -
>   	err = b44_pci_init();
>   	if (err)
>   		return err;
> diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
> index 7feff24..8dcebb2 100644
> --- a/drivers/net/ethernet/ibm/emac/core.c
> +++ b/drivers/net/ethernet/ibm/emac/core.c
> @@ -1030,8 +1030,9 @@ static int emac_set_mac_address(struct net_device *ndev, void *sa)
>   
>   static int emac_resize_rx_ring(struct emac_instance *dev, int new_mtu)
>   {
> -	int rx_sync_size = emac_rx_sync_size(new_mtu);
> -	int rx_skb_size = emac_rx_skb_size(new_mtu);
> +	struct device *dma_dev = &dev->ofdev->dev;
> +	int rx_skb_size = emac_rx_skb_size(dma_dev, new_mtu);
> +	int rx_sync_size = emac_rx_sync_size(dma_dev, new_mtu);
>   	int i, ret = 0;
>   	int mr1_jumbo_bit_change = 0;
>   
> @@ -1074,7 +1075,7 @@ static int emac_resize_rx_ring(struct emac_instance *dev, int new_mtu)
>   		BUG_ON(!dev->rx_skb[i]);
>   		dev_kfree_skb(dev->rx_skb[i]);
>   
> -		skb_reserve(skb, EMAC_RX_SKB_HEADROOM + 2);
> +		skb_reserve(skb, EMAC_RX_SKB_HEADROOM(dma_dev) + 2);
>   		dev->rx_desc[i].data_ptr =
>   		    dma_map_single(&dev->ofdev->dev, skb->data - 2, rx_sync_size,
>   				   DMA_FROM_DEVICE) + 2;
> @@ -1115,20 +1116,21 @@ static int emac_resize_rx_ring(struct emac_instance *dev, int new_mtu)
>   static int emac_change_mtu(struct net_device *ndev, int new_mtu)
>   {
>   	struct emac_instance *dev = netdev_priv(ndev);
> +	struct device *dma_dev = &dev->ofdev->dev;
>   	int ret = 0;
>   
>   	DBG(dev, "change_mtu(%d)" NL, new_mtu);
>   
>   	if (netif_running(ndev)) {
>   		/* Check if we really need to reinitialize RX ring */
> -		if (emac_rx_skb_size(ndev->mtu) != emac_rx_skb_size(new_mtu))
> +		if (emac_rx_skb_size(dma_dev, ndev->mtu) != emac_rx_skb_size(dma_dev, new_mtu))
>   			ret = emac_resize_rx_ring(dev, new_mtu);
>   	}
>   
>   	if (!ret) {
>   		ndev->mtu = new_mtu;
> -		dev->rx_skb_size = emac_rx_skb_size(new_mtu);
> -		dev->rx_sync_size = emac_rx_sync_size(new_mtu);
> +		dev->rx_skb_size = emac_rx_skb_size(dma_dev, new_mtu);
> +		dev->rx_sync_size = emac_rx_sync_size(dma_dev, new_mtu);
>   	}
>   
>   	return ret;
> @@ -1171,6 +1173,7 @@ static void emac_clean_rx_ring(struct emac_instance *dev)
>   static inline int emac_alloc_rx_skb(struct emac_instance *dev, int slot,
>   				    gfp_t flags)
>   {
> +	struct device *dma_dev = &dev->ofdev->dev;
>   	struct sk_buff *skb = alloc_skb(dev->rx_skb_size, flags);
>   	if (unlikely(!skb))
>   		return -ENOMEM;
> @@ -1178,7 +1181,7 @@ static inline int emac_alloc_rx_skb(struct emac_instance *dev, int slot,
>   	dev->rx_skb[slot] = skb;
>   	dev->rx_desc[slot].data_len = 0;
>   
> -	skb_reserve(skb, EMAC_RX_SKB_HEADROOM + 2);
> +	skb_reserve(skb, EMAC_RX_SKB_HEADROOM(dma_dev) + 2);
>   	dev->rx_desc[slot].data_ptr =
>   	    dma_map_single(&dev->ofdev->dev, skb->data - 2, dev->rx_sync_size,
>   			   DMA_FROM_DEVICE) + 2;
> @@ -1649,12 +1652,13 @@ static inline void emac_recycle_rx_skb(struct emac_instance *dev, int slot,
>   				       int len)
>   {
>   	struct sk_buff *skb = dev->rx_skb[slot];
> +	struct device *dma_dev = &dev->ofdev->dev;
>   
>   	DBG2(dev, "recycle %d %d" NL, slot, len);
>   
>   	if (len)
> -		dma_map_single(&dev->ofdev->dev, skb->data - 2,
> -			       EMAC_DMA_ALIGN(len + 2), DMA_FROM_DEVICE);
> +		dma_map_single(dma_dev, skb->data - 2,
> +			       EMAC_DMA_ALIGN(dma_dev, len + 2), DMA_FROM_DEVICE);
>   
>   	dev->rx_desc[slot].data_len = 0;
>   	wmb();
> @@ -1727,6 +1731,7 @@ static int emac_poll_rx(void *param, int budget)
>   {
>   	struct emac_instance *dev = param;
>   	int slot = dev->rx_slot, received = 0;
> +	struct device *dma_dev = &dev->ofdev->dev;
>   
>   	DBG2(dev, "poll_rx(%d)" NL, budget);
>   
> @@ -1763,11 +1768,11 @@ static int emac_poll_rx(void *param, int budget)
>   
>   		if (len && len < EMAC_RX_COPY_THRESH) {
>   			struct sk_buff *copy_skb =
> -			    alloc_skb(len + EMAC_RX_SKB_HEADROOM + 2, GFP_ATOMIC);
> +			    alloc_skb(len + EMAC_RX_SKB_HEADROOM(dma_dev) + 2, GFP_ATOMIC);
>   			if (unlikely(!copy_skb))
>   				goto oom;
>   
> -			skb_reserve(copy_skb, EMAC_RX_SKB_HEADROOM + 2);
> +			skb_reserve(copy_skb, EMAC_RX_SKB_HEADROOM(dma_dev) + 2);
>   			memcpy(copy_skb->data - 2, skb->data - 2, len + 2);
>   			emac_recycle_rx_skb(dev, slot, len);
>   			skb = copy_skb;
> @@ -2998,6 +3003,7 @@ static int emac_probe(struct platform_device *ofdev)
>   	struct emac_instance *dev;
>   	struct device_node *np = ofdev->dev.of_node;
>   	struct device_node **blist = NULL;
> +	struct device *dma_dev = &ofdev->dev;
>   	int err, i;
>   
>   	/* Skip unused/unwired EMACS.  We leave the check for an unused
> @@ -3077,8 +3083,8 @@ static int emac_probe(struct platform_device *ofdev)
>   		       np, dev->mal_dev->dev.of_node);
>   		goto err_rel_deps;
>   	}
> -	dev->rx_skb_size = emac_rx_skb_size(ndev->mtu);
> -	dev->rx_sync_size = emac_rx_sync_size(ndev->mtu);
> +	dev->rx_skb_size = emac_rx_skb_size(dma_dev, ndev->mtu);
> +	dev->rx_sync_size = emac_rx_sync_size(dma_dev, ndev->mtu);
>   
>   	/* Get pointers to BD rings */
>   	dev->tx_desc =
> diff --git a/drivers/net/ethernet/ibm/emac/core.h b/drivers/net/ethernet/ibm/emac/core.h
> index 369de2c..8107c32 100644
> --- a/drivers/net/ethernet/ibm/emac/core.h
> +++ b/drivers/net/ethernet/ibm/emac/core.h
> @@ -68,22 +68,22 @@ static inline int emac_rx_size(int mtu)
>   		return mal_rx_size(ETH_DATA_LEN + EMAC_MTU_OVERHEAD);
>   }
>   
> -#define EMAC_DMA_ALIGN(x)		ALIGN((x), dma_get_cache_alignment())
> +#define EMAC_DMA_ALIGN(d, x)		ALIGN((x), dma_get_cache_alignment(d))
>   
> -#define EMAC_RX_SKB_HEADROOM		\
> -	EMAC_DMA_ALIGN(CONFIG_IBM_EMAC_RX_SKB_HEADROOM)
> +#define EMAC_RX_SKB_HEADROOM(d)		\
> +	EMAC_DMA_ALIGN(d, CONFIG_IBM_EMAC_RX_SKB_HEADROOM)
>   
>   /* Size of RX skb for the given MTU */
> -static inline int emac_rx_skb_size(int mtu)
> +static inline int emac_rx_skb_size(struct device *dev, int mtu)
>   {
>   	int size = max(mtu + EMAC_MTU_OVERHEAD, emac_rx_size(mtu));
> -	return EMAC_DMA_ALIGN(size + 2) + EMAC_RX_SKB_HEADROOM;
> +	return EMAC_DMA_ALIGN(dev, size + 2) + EMAC_RX_SKB_HEADROOM;
>   }
>   
>   /* RX DMA sync size */
> -static inline int emac_rx_sync_size(int mtu)
> +static inline int emac_rx_sync_size(struct device *dev, int mtu)
>   {
> -	return EMAC_DMA_ALIGN(emac_rx_size(mtu) + 2);
> +	return EMAC_DMA_ALIGN(dev, emac_rx_size(mtu) + 2);
>   }
>   
>   /* Driver statistcs is split into two parts to make it more cache friendly:
> diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
> index e61c99e..bc146dd 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/main.c
> @@ -1660,7 +1660,7 @@ static int mlx4_init_icm(struct mlx4_dev *dev, struct mlx4_dev_cap *dev_cap,
>   	 */
>   	dev->caps.reserved_mtts =
>   		ALIGN(dev->caps.reserved_mtts * dev->caps.mtt_entry_sz,
> -		      dma_get_cache_alignment()) / dev->caps.mtt_entry_sz;
> +		      dma_get_cache_alignment(&dev->persist->pdev->dev)) / dev->caps.mtt_entry_sz;
>   
>   	err = mlx4_init_icm_table(dev, &priv->mr_table.mtt_table,
>   				  init_hca->mtt_base,
> diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
> index 974a8ce..e6da66e 100644
> --- a/drivers/spi/spi-qup.c
> +++ b/drivers/spi/spi-qup.c
> @@ -862,7 +862,7 @@ static bool spi_qup_can_dma(struct spi_master *master, struct spi_device *spi,
>   			    struct spi_transfer *xfer)
>   {
>   	struct spi_qup *qup = spi_master_get_devdata(master);
> -	size_t dma_align = dma_get_cache_alignment();
> +	size_t dma_align = dma_get_cache_alignment(qup->dev);
>   	int n_words;
>   
>   	if (xfer->rx_buf) {
> @@ -1038,7 +1038,7 @@ static int spi_qup_probe(struct platform_device *pdev)
>   	master->transfer_one = spi_qup_transfer_one;
>   	master->dev.of_node = pdev->dev.of_node;
>   	master->auto_runtime_pm = true;
> -	master->dma_alignment = dma_get_cache_alignment();
> +	master->dma_alignment = dma_get_cache_alignment(dev);
>   	master->max_dma_len = SPI_MAX_XFER;
>   
>   	platform_set_drvdata(pdev, master);
> diff --git a/drivers/tty/serial/mpsc.c b/drivers/tty/serial/mpsc.c
> index 67ffecc..8b5d0de 100644
> --- a/drivers/tty/serial/mpsc.c
> +++ b/drivers/tty/serial/mpsc.c
> @@ -81,19 +81,19 @@
>    * Number of Tx & Rx descriptors must be powers of 2.
>    */
>   #define	MPSC_RXR_ENTRIES	32
> -#define	MPSC_RXRE_SIZE		dma_get_cache_alignment()
> -#define	MPSC_RXR_SIZE		(MPSC_RXR_ENTRIES * MPSC_RXRE_SIZE)
> -#define	MPSC_RXBE_SIZE		dma_get_cache_alignment()
> -#define	MPSC_RXB_SIZE		(MPSC_RXR_ENTRIES * MPSC_RXBE_SIZE)
> +#define	MPSC_RXRE_SIZE(d)	dma_get_cache_alignment(d)
> +#define	MPSC_RXR_SIZE(d)	(MPSC_RXR_ENTRIES * MPSC_RXRE_SIZE(d))
> +#define	MPSC_RXBE_SIZE(d)	dma_get_cache_alignment(d)
> +#define	MPSC_RXB_SIZE(d)	(MPSC_RXR_ENTRIES * MPSC_RXBE_SIZE(d))
>   
>   #define	MPSC_TXR_ENTRIES	32
> -#define	MPSC_TXRE_SIZE		dma_get_cache_alignment()
> -#define	MPSC_TXR_SIZE		(MPSC_TXR_ENTRIES * MPSC_TXRE_SIZE)
> -#define	MPSC_TXBE_SIZE		dma_get_cache_alignment()
> -#define	MPSC_TXB_SIZE		(MPSC_TXR_ENTRIES * MPSC_TXBE_SIZE)
> +#define	MPSC_TXRE_SIZE(d)	dma_get_cache_alignment(d)
> +#define	MPSC_TXR_SIZE(d)	(MPSC_TXR_ENTRIES * MPSC_TXRE_SIZE(d))
> +#define	MPSC_TXBE_SIZE(d)	dma_get_cache_alignment(d)
> +#define	MPSC_TXB_SIZE(d)	(MPSC_TXR_ENTRIES * MPSC_TXBE_SIZE(d))
>   
> -#define	MPSC_DMA_ALLOC_SIZE	(MPSC_RXR_SIZE + MPSC_RXB_SIZE + MPSC_TXR_SIZE \
> -		+ MPSC_TXB_SIZE + dma_get_cache_alignment() /* for alignment */)
> +#define	MPSC_DMA_ALLOC_SIZE(d)	(MPSC_RXR_SIZE(d) + MPSC_RXB_SIZE(d) + MPSC_TXR_SIZE(d) \
> +		+ MPSC_TXB_SIZE(d) + dma_get_cache_alignment(d) /* for alignment */)
>   
>   /* Rx and Tx Ring entry descriptors -- assume entry size is <= cacheline size */
>   struct mpsc_rx_desc {
> @@ -520,22 +520,23 @@ static uint mpsc_sdma_tx_active(struct mpsc_port_info *pi)
>   static void mpsc_sdma_start_tx(struct mpsc_port_info *pi)
>   {
>   	struct mpsc_tx_desc *txre, *txre_p;
> +	struct device *dma_dev = pi->port.dev;
>   
>   	/* If tx isn't running & there's a desc ready to go, start it */
>   	if (!mpsc_sdma_tx_active(pi)) {
>   		txre = (struct mpsc_tx_desc *)(pi->txr
> -				+ (pi->txr_tail * MPSC_TXRE_SIZE));
> -		dma_cache_sync(pi->port.dev, (void *)txre, MPSC_TXRE_SIZE,
> +				+ (pi->txr_tail * MPSC_TXRE_SIZE(dma_dev)));
> +		dma_cache_sync(pi->port.dev, (void *)txre, MPSC_TXRE_SIZE(dma_dev),
>   				DMA_FROM_DEVICE);
>   #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
>   		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
>   			invalidate_dcache_range((ulong)txre,
> -					(ulong)txre + MPSC_TXRE_SIZE);
> +					(ulong)txre + MPSC_TXRE_SIZE(dma_dev));
>   #endif
>   
>   		if (be32_to_cpu(txre->cmdstat) & SDMA_DESC_CMDSTAT_O) {
>   			txre_p = (struct mpsc_tx_desc *)
> -				(pi->txr_p + (pi->txr_tail * MPSC_TXRE_SIZE));
> +				(pi->txr_p + (pi->txr_tail * MPSC_TXRE_SIZE(dma_dev)));
>   
>   			mpsc_sdma_set_tx_ring(pi, txre_p);
>   			mpsc_sdma_cmd(pi, SDMA_SDCM_STD | SDMA_SDCM_TXD);
> @@ -738,7 +739,7 @@ static void mpsc_init_hw(struct mpsc_port_info *pi)
>   
>   	mpsc_brg_init(pi, pi->brg_clk_src);
>   	mpsc_brg_enable(pi);
> -	mpsc_sdma_init(pi, dma_get_cache_alignment());	/* burst a cacheline */
> +	mpsc_sdma_init(pi, dma_get_cache_alignment(pi->port.dev));	/* burst a cacheline */
>   	mpsc_sdma_stop(pi);
>   	mpsc_hw_init(pi);
>   }
> @@ -746,6 +747,7 @@ static void mpsc_init_hw(struct mpsc_port_info *pi)
>   static int mpsc_alloc_ring_mem(struct mpsc_port_info *pi)
>   {
>   	int rc = 0;
> +	struct device *dma_dev = pi->port.dev;
>   
>   	pr_debug("mpsc_alloc_ring_mem[%d]: Allocating ring mem\n",
>   		pi->port.line);
> @@ -755,7 +757,7 @@ static int mpsc_alloc_ring_mem(struct mpsc_port_info *pi)
>   			printk(KERN_ERR "MPSC: Inadequate DMA support\n");
>   			rc = -ENXIO;
>   		} else if ((pi->dma_region = dma_alloc_attrs(pi->port.dev,
> -						MPSC_DMA_ALLOC_SIZE,
> +						MPSC_DMA_ALLOC_SIZE(dma_dev),
>   						&pi->dma_region_p, GFP_KERNEL,
>   						DMA_ATTR_NON_CONSISTENT))
>   				== NULL) {
> @@ -769,10 +771,12 @@ static int mpsc_alloc_ring_mem(struct mpsc_port_info *pi)
>   
>   static void mpsc_free_ring_mem(struct mpsc_port_info *pi)
>   {
> +	struct device *dma_dev = pi->port.dev;
> +
>   	pr_debug("mpsc_free_ring_mem[%d]: Freeing ring mem\n", pi->port.line);
>   
>   	if (pi->dma_region) {
> -		dma_free_attrs(pi->port.dev, MPSC_DMA_ALLOC_SIZE,
> +		dma_free_attrs(pi->port.dev, MPSC_DMA_ALLOC_SIZE(dma_dev),
>   				pi->dma_region, pi->dma_region_p,
>   				DMA_ATTR_NON_CONSISTENT);
>   		pi->dma_region = NULL;
> @@ -784,6 +788,7 @@ static void mpsc_init_rings(struct mpsc_port_info *pi)
>   {
>   	struct mpsc_rx_desc *rxre;
>   	struct mpsc_tx_desc *txre;
> +	struct device *dma_dev = pi->port.dev;
>   	dma_addr_t dp, dp_p;
>   	u8 *bp, *bp_p;
>   	int i;
> @@ -792,14 +797,14 @@ static void mpsc_init_rings(struct mpsc_port_info *pi)
>   
>   	BUG_ON(pi->dma_region == NULL);
>   
> -	memset(pi->dma_region, 0, MPSC_DMA_ALLOC_SIZE);
> +	memset(pi->dma_region, 0, MPSC_DMA_ALLOC_SIZE(dma_dev));
>   
>   	/*
>   	 * Descriptors & buffers are multiples of cacheline size and must be
>   	 * cacheline aligned.
>   	 */
> -	dp = ALIGN((u32)pi->dma_region, dma_get_cache_alignment());
> -	dp_p = ALIGN((u32)pi->dma_region_p, dma_get_cache_alignment());
> +	dp = ALIGN((u32)pi->dma_region, dma_get_cache_alignment(dma_dev));
> +	dp_p = ALIGN((u32)pi->dma_region_p, dma_get_cache_alignment(dma_dev));
>   
>   	/*
>   	 * Partition dma region into rx ring descriptor, rx buffers,
> @@ -807,20 +812,20 @@ static void mpsc_init_rings(struct mpsc_port_info *pi)
>   	 */
>   	pi->rxr = dp;
>   	pi->rxr_p = dp_p;
> -	dp += MPSC_RXR_SIZE;
> -	dp_p += MPSC_RXR_SIZE;
> +	dp += MPSC_RXR_SIZE(dma_dev);
> +	dp_p += MPSC_RXR_SIZE(dma_dev);
>   
>   	pi->rxb = (u8 *)dp;
>   	pi->rxb_p = (u8 *)dp_p;
> -	dp += MPSC_RXB_SIZE;
> -	dp_p += MPSC_RXB_SIZE;
> +	dp += MPSC_RXB_SIZE(dma_dev);
> +	dp_p += MPSC_RXB_SIZE(dma_dev);
>   
>   	pi->rxr_posn = 0;
>   
>   	pi->txr = dp;
>   	pi->txr_p = dp_p;
> -	dp += MPSC_TXR_SIZE;
> -	dp_p += MPSC_TXR_SIZE;
> +	dp += MPSC_TXR_SIZE(dma_dev);
> +	dp_p += MPSC_TXR_SIZE(dma_dev);
>   
>   	pi->txb = (u8 *)dp;
>   	pi->txb_p = (u8 *)dp_p;
> @@ -837,18 +842,18 @@ static void mpsc_init_rings(struct mpsc_port_info *pi)
>   	for (i = 0; i < MPSC_RXR_ENTRIES; i++) {
>   		rxre = (struct mpsc_rx_desc *)dp;
>   
> -		rxre->bufsize = cpu_to_be16(MPSC_RXBE_SIZE);
> +		rxre->bufsize = cpu_to_be16(MPSC_RXBE_SIZE(dma_dev));
>   		rxre->bytecnt = cpu_to_be16(0);
>   		rxre->cmdstat = cpu_to_be32(SDMA_DESC_CMDSTAT_O
>   				| SDMA_DESC_CMDSTAT_EI | SDMA_DESC_CMDSTAT_F
>   				| SDMA_DESC_CMDSTAT_L);
> -		rxre->link = cpu_to_be32(dp_p + MPSC_RXRE_SIZE);
> +		rxre->link = cpu_to_be32(dp_p + MPSC_RXRE_SIZE(dma_dev));
>   		rxre->buf_ptr = cpu_to_be32(bp_p);
>   
> -		dp += MPSC_RXRE_SIZE;
> -		dp_p += MPSC_RXRE_SIZE;
> -		bp += MPSC_RXBE_SIZE;
> -		bp_p += MPSC_RXBE_SIZE;
> +		dp += MPSC_RXRE_SIZE(dma_dev);
> +		dp_p += MPSC_RXRE_SIZE(dma_dev);
> +		bp += MPSC_RXBE_SIZE(dma_dev);
> +		bp_p += MPSC_RXBE_SIZE(dma_dev);
>   	}
>   	rxre->link = cpu_to_be32(pi->rxr_p);	/* Wrap last back to first */
>   
> @@ -861,23 +866,23 @@ static void mpsc_init_rings(struct mpsc_port_info *pi)
>   	for (i = 0; i < MPSC_TXR_ENTRIES; i++) {
>   		txre = (struct mpsc_tx_desc *)dp;
>   
> -		txre->link = cpu_to_be32(dp_p + MPSC_TXRE_SIZE);
> +		txre->link = cpu_to_be32(dp_p + MPSC_TXRE_SIZE(dma_dev));
>   		txre->buf_ptr = cpu_to_be32(bp_p);
>   
> -		dp += MPSC_TXRE_SIZE;
> -		dp_p += MPSC_TXRE_SIZE;
> -		bp += MPSC_TXBE_SIZE;
> -		bp_p += MPSC_TXBE_SIZE;
> +		dp += MPSC_TXRE_SIZE(dma_dev);
> +		dp_p += MPSC_TXRE_SIZE(dma_dev);
> +		bp += MPSC_TXBE_SIZE(dma_dev);
> +		bp_p += MPSC_TXBE_SIZE(dma_dev);
>   	}
>   	txre->link = cpu_to_be32(pi->txr_p);	/* Wrap last back to first */
>   
>   	dma_cache_sync(pi->port.dev, (void *)pi->dma_region,
> -			MPSC_DMA_ALLOC_SIZE, DMA_BIDIRECTIONAL);
> +			MPSC_DMA_ALLOC_SIZE(dma_dev), DMA_BIDIRECTIONAL);
>   #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
>   		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
>   			flush_dcache_range((ulong)pi->dma_region,
>   					(ulong)pi->dma_region
> -					+ MPSC_DMA_ALLOC_SIZE);
> +					+ MPSC_DMA_ALLOC_SIZE(dma_dev));
>   #endif
>   
>   	return;
> @@ -936,6 +941,7 @@ static int serial_polled;
>   static int mpsc_rx_intr(struct mpsc_port_info *pi, unsigned long *flags)
>   {
>   	struct mpsc_rx_desc *rxre;
> +	struct device *dma_dev = pi->port.dev;
>   	struct tty_port *port = &pi->port.state->port;
>   	u32	cmdstat, bytes_in, i;
>   	int	rc = 0;
> @@ -944,14 +950,14 @@ static int mpsc_rx_intr(struct mpsc_port_info *pi, unsigned long *flags)
>   
>   	pr_debug("mpsc_rx_intr[%d]: Handling Rx intr\n", pi->port.line);
>   
> -	rxre = (struct mpsc_rx_desc *)(pi->rxr + (pi->rxr_posn*MPSC_RXRE_SIZE));
> +	rxre = (struct mpsc_rx_desc *)(pi->rxr + (pi->rxr_posn*MPSC_RXRE_SIZE(dma_dev)));
>   
> -	dma_cache_sync(pi->port.dev, (void *)rxre, MPSC_RXRE_SIZE,
> +	dma_cache_sync(pi->port.dev, (void *)rxre, MPSC_RXRE_SIZE(dma_dev),
>   			DMA_FROM_DEVICE);
>   #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
>   	if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
>   		invalidate_dcache_range((ulong)rxre,
> -				(ulong)rxre + MPSC_RXRE_SIZE);
> +				(ulong)rxre + MPSC_RXRE_SIZE(dma_dev));
>   #endif
>   
>   	/*
> @@ -979,13 +985,13 @@ static int mpsc_rx_intr(struct mpsc_port_info *pi, unsigned long *flags)
>   			 */
>   		}
>   
> -		bp = pi->rxb + (pi->rxr_posn * MPSC_RXBE_SIZE);
> -		dma_cache_sync(pi->port.dev, (void *)bp, MPSC_RXBE_SIZE,
> +		bp = pi->rxb + (pi->rxr_posn * MPSC_RXBE_SIZE(dma_dev));
> +		dma_cache_sync(pi->port.dev, (void *)bp, MPSC_RXBE_SIZE(dma_dev),
>   				DMA_FROM_DEVICE);
>   #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
>   		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
>   			invalidate_dcache_range((ulong)bp,
> -					(ulong)bp + MPSC_RXBE_SIZE);
> +					(ulong)bp + MPSC_RXBE_SIZE(dma_dev));
>   #endif
>   
>   		/*
> @@ -1056,24 +1062,24 @@ static int mpsc_rx_intr(struct mpsc_port_info *pi, unsigned long *flags)
>   				| SDMA_DESC_CMDSTAT_EI | SDMA_DESC_CMDSTAT_F
>   				| SDMA_DESC_CMDSTAT_L);
>   		wmb();
> -		dma_cache_sync(pi->port.dev, (void *)rxre, MPSC_RXRE_SIZE,
> +		dma_cache_sync(pi->port.dev, (void *)rxre, MPSC_RXRE_SIZE(dma_dev),
>   				DMA_BIDIRECTIONAL);
>   #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
>   		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
>   			flush_dcache_range((ulong)rxre,
> -					(ulong)rxre + MPSC_RXRE_SIZE);
> +					(ulong)rxre + MPSC_RXRE_SIZE(dma_dev));
>   #endif
>   
>   		/* Advance to next descriptor */
>   		pi->rxr_posn = (pi->rxr_posn + 1) & (MPSC_RXR_ENTRIES - 1);
>   		rxre = (struct mpsc_rx_desc *)
> -			(pi->rxr + (pi->rxr_posn * MPSC_RXRE_SIZE));
> -		dma_cache_sync(pi->port.dev, (void *)rxre, MPSC_RXRE_SIZE,
> +			(pi->rxr + (pi->rxr_posn * MPSC_RXRE_SIZE(dma_dev)));
> +		dma_cache_sync(pi->port.dev, (void *)rxre, MPSC_RXRE_SIZE(dma_dev),
>   				DMA_FROM_DEVICE);
>   #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
>   		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
>   			invalidate_dcache_range((ulong)rxre,
> -					(ulong)rxre + MPSC_RXRE_SIZE);
> +					(ulong)rxre + MPSC_RXRE_SIZE(dma_dev));
>   #endif
>   		rc = 1;
>   	}
> @@ -1091,9 +1097,10 @@ static int mpsc_rx_intr(struct mpsc_port_info *pi, unsigned long *flags)
>   static void mpsc_setup_tx_desc(struct mpsc_port_info *pi, u32 count, u32 intr)
>   {
>   	struct mpsc_tx_desc *txre;
> +	struct device *dma_dev = pi->port.dev;
>   
>   	txre = (struct mpsc_tx_desc *)(pi->txr
> -			+ (pi->txr_head * MPSC_TXRE_SIZE));
> +			+ (pi->txr_head * MPSC_TXRE_SIZE(dma_dev)));
>   
>   	txre->bytecnt = cpu_to_be16(count);
>   	txre->shadow = txre->bytecnt;
> @@ -1102,17 +1109,18 @@ static void mpsc_setup_tx_desc(struct mpsc_port_info *pi, u32 count, u32 intr)
>   			| SDMA_DESC_CMDSTAT_L
>   			| ((intr) ? SDMA_DESC_CMDSTAT_EI : 0));
>   	wmb();
> -	dma_cache_sync(pi->port.dev, (void *)txre, MPSC_TXRE_SIZE,
> +	dma_cache_sync(pi->port.dev, (void *)txre, MPSC_TXRE_SIZE(dma_dev),
>   			DMA_BIDIRECTIONAL);
>   #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
>   	if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
>   		flush_dcache_range((ulong)txre,
> -				(ulong)txre + MPSC_TXRE_SIZE);
> +				(ulong)txre + MPSC_TXRE_SIZE(dma_dev));
>   #endif
>   }
>   
>   static void mpsc_copy_tx_data(struct mpsc_port_info *pi)
>   {
> +	struct device *dma_dev = pi->port.dev;
>   	struct circ_buf *xmit = &pi->port.state->xmit;
>   	u8 *bp;
>   	u32 i;
> @@ -1129,17 +1137,17 @@ static void mpsc_copy_tx_data(struct mpsc_port_info *pi)
>   			 * CHR_1.  Instead, just put it in-band with
>   			 * all the other Tx data.
>   			 */
> -			bp = pi->txb + (pi->txr_head * MPSC_TXBE_SIZE);
> +			bp = pi->txb + (pi->txr_head * MPSC_TXBE_SIZE(dma_dev));
>   			*bp = pi->port.x_char;
>   			pi->port.x_char = 0;
>   			i = 1;
>   		} else if (!uart_circ_empty(xmit)
>   				&& !uart_tx_stopped(&pi->port)) {
> -			i = min((u32)MPSC_TXBE_SIZE,
> +			i = min((u32)MPSC_TXBE_SIZE(dma_dev),
>   				(u32)uart_circ_chars_pending(xmit));
>   			i = min(i, (u32)CIRC_CNT_TO_END(xmit->head, xmit->tail,
>   				UART_XMIT_SIZE));
> -			bp = pi->txb + (pi->txr_head * MPSC_TXBE_SIZE);
> +			bp = pi->txb + (pi->txr_head * MPSC_TXBE_SIZE(dma_dev));
>   			memcpy(bp, &xmit->buf[xmit->tail], i);
>   			xmit->tail = (xmit->tail + i) & (UART_XMIT_SIZE - 1);
>   
> @@ -1149,12 +1157,12 @@ static void mpsc_copy_tx_data(struct mpsc_port_info *pi)
>   			return;
>   		}
>   
> -		dma_cache_sync(pi->port.dev, (void *)bp, MPSC_TXBE_SIZE,
> +		dma_cache_sync(pi->port.dev, (void *)bp, MPSC_TXBE_SIZE(dma_dev),
>   				DMA_BIDIRECTIONAL);
>   #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
>   		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
>   			flush_dcache_range((ulong)bp,
> -					(ulong)bp + MPSC_TXBE_SIZE);
> +					(ulong)bp + MPSC_TXBE_SIZE(dma_dev));
>   #endif
>   		mpsc_setup_tx_desc(pi, i, 1);
>   
> @@ -1166,6 +1174,7 @@ static void mpsc_copy_tx_data(struct mpsc_port_info *pi)
>   static int mpsc_tx_intr(struct mpsc_port_info *pi)
>   {
>   	struct mpsc_tx_desc *txre;
> +	struct device *dma_dev = pi->port.dev;
>   	int rc = 0;
>   	unsigned long iflags;
>   
> @@ -1173,14 +1182,14 @@ static int mpsc_tx_intr(struct mpsc_port_info *pi)
>   
>   	if (!mpsc_sdma_tx_active(pi)) {
>   		txre = (struct mpsc_tx_desc *)(pi->txr
> -				+ (pi->txr_tail * MPSC_TXRE_SIZE));
> +				+ (pi->txr_tail * MPSC_TXRE_SIZE(dma_dev)));
>   
> -		dma_cache_sync(pi->port.dev, (void *)txre, MPSC_TXRE_SIZE,
> +		dma_cache_sync(pi->port.dev, (void *)txre, MPSC_TXRE_SIZE(dma_dev),
>   				DMA_FROM_DEVICE);
>   #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
>   		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
>   			invalidate_dcache_range((ulong)txre,
> -					(ulong)txre + MPSC_TXRE_SIZE);
> +					(ulong)txre + MPSC_TXRE_SIZE(dma_dev));
>   #endif
>   
>   		while (!(be32_to_cpu(txre->cmdstat) & SDMA_DESC_CMDSTAT_O)) {
> @@ -1193,13 +1202,13 @@ static int mpsc_tx_intr(struct mpsc_port_info *pi)
>   				break;
>   
>   			txre = (struct mpsc_tx_desc *)(pi->txr
> -					+ (pi->txr_tail * MPSC_TXRE_SIZE));
> +					+ (pi->txr_tail * MPSC_TXRE_SIZE(dma_dev)));
>   			dma_cache_sync(pi->port.dev, (void *)txre,
> -					MPSC_TXRE_SIZE, DMA_FROM_DEVICE);
> +					MPSC_TXRE_SIZE(dma_dev), DMA_FROM_DEVICE);
>   #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
>   			if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
>   				invalidate_dcache_range((ulong)txre,
> -						(ulong)txre + MPSC_TXRE_SIZE);
> +						(ulong)txre + MPSC_TXRE_SIZE(dma_dev));
>   #endif
>   		}
>   
> @@ -1360,6 +1369,7 @@ static int mpsc_startup(struct uart_port *port)
>   {
>   	struct mpsc_port_info *pi =
>   		container_of(port, struct mpsc_port_info, port);
> +	struct device *dma_dev = pi->port.dev;
>   	u32 flag = 0;
>   	int rc;
>   
> @@ -1381,7 +1391,7 @@ static int mpsc_startup(struct uart_port *port)
>   
>   		mpsc_sdma_intr_unmask(pi, 0xf);
>   		mpsc_sdma_set_rx_ring(pi, (struct mpsc_rx_desc *)(pi->rxr_p
> -					+ (pi->rxr_posn * MPSC_RXRE_SIZE)));
> +					+ (pi->rxr_posn * MPSC_RXRE_SIZE(dma_dev))));
>   	}
>   
>   	return rc;
> @@ -1555,9 +1565,10 @@ static void mpsc_put_poll_char(struct uart_port *port,
>   
>   static int mpsc_get_poll_char(struct uart_port *port)
>   {
> +	struct mpsc_rx_desc *rxre;
>   	struct mpsc_port_info *pi =
>   		container_of(port, struct mpsc_port_info, port);
> -	struct mpsc_rx_desc *rxre;
> +	struct device *dma_dev = pi->port.dev;
>   	u32	cmdstat, bytes_in, i;
>   	u8	*bp;
>   
> @@ -1575,13 +1586,13 @@ static int mpsc_get_poll_char(struct uart_port *port)
>   
>   	while (poll_cnt == 0) {
>   		rxre = (struct mpsc_rx_desc *)(pi->rxr +
> -		       (pi->rxr_posn*MPSC_RXRE_SIZE));
> +		       (pi->rxr_posn*MPSC_RXRE_SIZE(dma_dev)));
>   		dma_cache_sync(pi->port.dev, (void *)rxre,
> -			       MPSC_RXRE_SIZE, DMA_FROM_DEVICE);
> +			       MPSC_RXRE_SIZE(dma_dev), DMA_FROM_DEVICE);
>   #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
>   		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
>   			invalidate_dcache_range((ulong)rxre,
> -			(ulong)rxre + MPSC_RXRE_SIZE);
> +			(ulong)rxre + MPSC_RXRE_SIZE(dma_dev));
>   #endif
>   		/*
>   		 * Loop through Rx descriptors handling ones that have
> @@ -1591,13 +1602,13 @@ static int mpsc_get_poll_char(struct uart_port *port)
>   		       !((cmdstat = be32_to_cpu(rxre->cmdstat)) &
>   			 SDMA_DESC_CMDSTAT_O)){
>   			bytes_in = be16_to_cpu(rxre->bytecnt);
> -			bp = pi->rxb + (pi->rxr_posn * MPSC_RXBE_SIZE);
> +			bp = pi->rxb + (pi->rxr_posn * MPSC_RXBE_SIZE(dma_dev));
>   			dma_cache_sync(pi->port.dev, (void *) bp,
> -				       MPSC_RXBE_SIZE, DMA_FROM_DEVICE);
> +				       MPSC_RXBE_SIZE(dma_dev), DMA_FROM_DEVICE);
>   #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
>   			if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
>   				invalidate_dcache_range((ulong)bp,
> -					(ulong)bp + MPSC_RXBE_SIZE);
> +					(ulong)bp + MPSC_RXBE_SIZE(dma_dev));
>   #endif
>   			if ((unlikely(cmdstat & (SDMA_DESC_CMDSTAT_BR |
>   			 SDMA_DESC_CMDSTAT_FR | SDMA_DESC_CMDSTAT_OR))) &&
> @@ -1619,24 +1630,24 @@ static int mpsc_get_poll_char(struct uart_port *port)
>   						    SDMA_DESC_CMDSTAT_L);
>   			wmb();
>   			dma_cache_sync(pi->port.dev, (void *)rxre,
> -				       MPSC_RXRE_SIZE, DMA_BIDIRECTIONAL);
> +				       MPSC_RXRE_SIZE(dma_dev), DMA_BIDIRECTIONAL);
>   #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
>   			if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
>   				flush_dcache_range((ulong)rxre,
> -					   (ulong)rxre + MPSC_RXRE_SIZE);
> +					   (ulong)rxre + MPSC_RXRE_SIZE(dma_dev));
>   #endif
>   
>   			/* Advance to next descriptor */
>   			pi->rxr_posn = (pi->rxr_posn + 1) &
>   				(MPSC_RXR_ENTRIES - 1);
>   			rxre = (struct mpsc_rx_desc *)(pi->rxr +
> -				       (pi->rxr_posn * MPSC_RXRE_SIZE));
> +				       (pi->rxr_posn * MPSC_RXRE_SIZE(dma_dev)));
>   			dma_cache_sync(pi->port.dev, (void *)rxre,
> -				       MPSC_RXRE_SIZE, DMA_FROM_DEVICE);
> +				       MPSC_RXRE_SIZE(dma_dev), DMA_FROM_DEVICE);
>   #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
>   			if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
>   				invalidate_dcache_range((ulong)rxre,
> -						(ulong)rxre + MPSC_RXRE_SIZE);
> +						(ulong)rxre + MPSC_RXRE_SIZE(dma_dev));
>   #endif
>   		}
>   
> @@ -1706,6 +1717,7 @@ static const struct uart_ops mpsc_pops = {
>   static void mpsc_console_write(struct console *co, const char *s, uint count)
>   {
>   	struct mpsc_port_info *pi = &mpsc_ports[co->index];
> +	struct device *dma_dev = pi->port.dev;
>   	u8 *bp, *dp, add_cr = 0;
>   	int i;
>   	unsigned long iflags;
> @@ -1723,9 +1735,9 @@ static void mpsc_console_write(struct console *co, const char *s, uint count)
>   		udelay(100);
>   
>   	while (count > 0) {
> -		bp = dp = pi->txb + (pi->txr_head * MPSC_TXBE_SIZE);
> +		bp = dp = pi->txb + (pi->txr_head * MPSC_TXBE_SIZE(dma_dev));
>   
> -		for (i = 0; i < MPSC_TXBE_SIZE; i++) {
> +		for (i = 0; i < MPSC_TXBE_SIZE(dma_dev); i++) {
>   			if (count == 0)
>   				break;
>   
> @@ -1744,12 +1756,12 @@ static void mpsc_console_write(struct console *co, const char *s, uint count)
>   			count--;
>   		}
>   
> -		dma_cache_sync(pi->port.dev, (void *)bp, MPSC_TXBE_SIZE,
> +		dma_cache_sync(pi->port.dev, (void *)bp, MPSC_TXBE_SIZE(dma_dev),
>   				DMA_BIDIRECTIONAL);
>   #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
>   		if (pi->cache_mgmt) /* GT642[46]0 Res #COMM-2 */
>   			flush_dcache_range((ulong)bp,
> -					(ulong)bp + MPSC_TXBE_SIZE);
> +					(ulong)bp + MPSC_TXBE_SIZE(dma_dev));
>   #endif
>   		mpsc_setup_tx_desc(pi, i, 0);
>   		pi->txr_head = (pi->txr_head + 1) & (MPSC_TXR_ENTRIES - 1);
> @@ -2024,7 +2036,8 @@ static void mpsc_drv_unmap_regs(struct mpsc_port_info *pi)
>   static void mpsc_drv_get_platform_data(struct mpsc_port_info *pi,
>   		struct platform_device *pd, int num)
>   {
> -	struct mpsc_pdata	*pdata;
> +	struct mpsc_pdata *pdata;
> +	struct device *dma_dev = pi->port.dev;
>   
>   	pdata = dev_get_platdata(&pd->dev);
>   
> @@ -2032,7 +2045,7 @@ static void mpsc_drv_get_platform_data(struct mpsc_port_info *pi,
>   	pi->port.iotype = UPIO_MEM;
>   	pi->port.line = num;
>   	pi->port.type = PORT_MPSC;
> -	pi->port.fifosize = MPSC_TXBE_SIZE;
> +	pi->port.fifosize = MPSC_TXBE_SIZE(dma_dev);
>   	pi->port.membase = pi->mpsc_base;
>   	pi->port.mapbase = (ulong)pi->mpsc_base;
>   	pi->port.ops = &mpsc_pops;
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index 8aca18c..9df918e5 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -241,7 +241,7 @@ static void enable_tx_dma(struct s3c24xx_uart_port *ourport)
>   	/* Enable tx dma mode */
>   	ucon = rd_regl(port, S3C2410_UCON);
>   	ucon &= ~(S3C64XX_UCON_TXBURST_MASK | S3C64XX_UCON_TXMODE_MASK);
> -	ucon |= (dma_get_cache_alignment() >= 16) ?
> +	ucon |= (dma_get_cache_alignment(port->dev) >= 16) ?
>   		S3C64XX_UCON_TXBURST_16 : S3C64XX_UCON_TXBURST_1;
>   	ucon |= S3C64XX_UCON_TXMODE_DMA;
>   	wr_regl(port,  S3C2410_UCON, ucon);
> @@ -292,7 +292,7 @@ static int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
>   	if (ourport->tx_mode != S3C24XX_TX_DMA)
>   		enable_tx_dma(ourport);
>   
> -	dma->tx_size = count & ~(dma_get_cache_alignment() - 1);
> +	dma->tx_size = count & ~(dma_get_cache_alignment(port->dev) - 1);
>   	dma->tx_transfer_addr = dma->tx_addr + xmit->tail;
>   
>   	dma_sync_single_for_device(ourport->port.dev, dma->tx_transfer_addr,
> @@ -332,7 +332,7 @@ static void s3c24xx_serial_start_next_tx(struct s3c24xx_uart_port *ourport)
>   
>   	if (!ourport->dma || !ourport->dma->tx_chan ||
>   	    count < ourport->min_dma_size ||
> -	    xmit->tail & (dma_get_cache_alignment() - 1))
> +	    xmit->tail & (dma_get_cache_alignment(port->dev) - 1))
>   		s3c24xx_serial_start_tx_pio(ourport);
>   	else
>   		s3c24xx_serial_start_tx_dma(ourport, count);
> @@ -718,8 +718,8 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
>   
>   	if (ourport->dma && ourport->dma->tx_chan &&
>   	    count >= ourport->min_dma_size) {
> -		int align = dma_get_cache_alignment() -
> -			(xmit->tail & (dma_get_cache_alignment() - 1));
> +		int align = dma_get_cache_alignment(port->dev) -
> +			(xmit->tail & (dma_get_cache_alignment(port->dev) - 1));
>   		if (count-align >= ourport->min_dma_size) {
>   			dma_count = count-align;
>   			count = align;
> @@ -870,7 +870,7 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
>   	dma->tx_conf.direction		= DMA_MEM_TO_DEV;
>   	dma->tx_conf.dst_addr_width	= DMA_SLAVE_BUSWIDTH_1_BYTE;
>   	dma->tx_conf.dst_addr		= p->port.mapbase + S3C2410_UTXH;
> -	if (dma_get_cache_alignment() >= 16)
> +	if (dma_get_cache_alignment(p->port.dev) >= 16)
>   		dma->tx_conf.dst_maxburst = 16;
>   	else
>   		dma->tx_conf.dst_maxburst = 1;
> @@ -1849,7 +1849,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>   	 * so find minimal transfer size suitable for DMA mode
>   	 */
>   	ourport->min_dma_size = max_t(int, ourport->port.fifosize,
> -				    dma_get_cache_alignment());
> +				    dma_get_cache_alignment(ourport->port.dev));
>   
>   	dbg("%s: initialising port %p...\n", __func__, ourport);
>   
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 29ce981..1326023 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -131,6 +131,7 @@ struct dma_map_ops {
>   #ifdef ARCH_HAS_DMA_GET_REQUIRED_MASK
>   	u64 (*get_required_mask)(struct device *dev);
>   #endif
> +	int (*get_cache_alignment)(struct device *dev);
>   	int is_phys;
>   };
>   
> @@ -697,12 +698,18 @@ static inline void *dma_zalloc_coherent(struct device *dev, size_t size,
>   }
>   
>   #ifdef CONFIG_HAS_DMA
> -static inline int dma_get_cache_alignment(void)
> -{
> -#ifdef ARCH_DMA_MINALIGN
> -	return ARCH_DMA_MINALIGN;
> +
> +#ifndef ARCH_DMA_MINALIGN
> +#define ARCH_DMA_MINALIGN 1
>   #endif
> -	return 1;
> +
> +static inline int dma_get_cache_alignment(struct device *dev)
> +{
> +	const struct dma_map_ops *ops = get_dma_ops(dev);
> +	if (dev && ops && ops->get_cache_alignment)
> +		return ops->get_cache_alignment(dev);
> +
> +	return ARCH_DMA_MINALIGN; /* compatible behavior */
>   }
>   #endif
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
