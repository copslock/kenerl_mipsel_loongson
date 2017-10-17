Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Oct 2017 13:56:07 +0200 (CEST)
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44599 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990505AbdJQLz43gFey (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Oct 2017 13:55:56 +0200
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20171017115545euoutp025cbb3d5e286e7f7e4169f5534438bb1a~uWYNcMziQ2512025120euoutp02x;
        Tue, 17 Oct 2017 11:55:45 +0000 (GMT)
Received: from eusmges1.samsung.com (unknown [203.254.199.239]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20171017115545eucas1p2074d5ad670f5888d8f73e492766f6bc0~uWYMzEfYN2743627436eucas1p2b;
        Tue, 17 Oct 2017 11:55:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1.samsung.com  (EUCPMTA) with SMTP id D5.41.12576.0CFE5E95; Tue, 17
        Oct 2017 12:55:44 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20171017115544eucas1p19ea8e9ebc1232f317fc35ed37a91aa9b~uWYMEi8wz1940719407eucas1p1Y;
        Tue, 17 Oct 2017 11:55:44 +0000 (GMT)
X-AuditID: cbfec7ef-f79ee6d000003120-bf-59e5efc05806
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 50.10.20118.0CFE5E95; Tue, 17
        Oct 2017 12:55:44 +0100 (BST)
Received: from [106.116.147.30] by eusync1.samsung.com (Oracle
        Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with
        ESMTPA id <0OXY009G2UGVCBB0@eusync1.samsung.com>; Tue, 17 Oct 2017 12:55:44
        +0100 (BST)
Subject: Re: [PATCH V8 4/5] libsas: Align SMP req/resp to
 dma_get_cache_alignment()
To:     Huacai Chen <chenhc@lemote.com>, Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fuxin Zhang <zhangfx@lemote.com>, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org, stable@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-id: <286bf838-4d2f-a25f-baf9-ef3ac9b37d93@samsung.com>
Date:   Tue, 17 Oct 2017 13:55:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.4.0
MIME-version: 1.0
In-reply-to: <1508227542-13165-4-git-send-email-chenhc@lemote.com>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-transfer-encoding: 7bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfOjmfD1Wlavk1LGNWHNFPyw8HULoocCKKgC5Mgl56czE3Z
        1FJKxFum5m1dTG0JoqIuvExsmprOyzJLSykvpJi68oIzMUNdWs6zwm+/53n+z+X/8uIIf4wt
        wMPkUbRCLg4XYly0oXut71jbolHkrunwIouqNRj5PLEGIyuqulikST2DkJW5crJbN8kiB5uK
        MDLnUZ4NmTGkw8hywyaLHGg+RLb/mGaTxbWTgFwv7wLkry/D4PRuSqPWACqz8R2g6irvY1Rh
        Xx9Gvck3o1RXxQsWNaHXotSrkQSMWjKOotRy3cEL3ECudwgdHhZDK477BnElM9qbkaXUbdXY
        M3YC+EqmAw4OCU9Y0rjKYngf/DBejaUDLs4nygBs/1RrwwTLAM73mG3+dZT1z4H/qvmiVDYT
        fAcwef0326KyIy5DdUXhdoc94QdNo6uIRYQQnxH4eKUftRQwwgOmL6RjFuYRvnDqHrMCJQ7D
        IdPa9lF7iWuwqkSHMpo9cFU1vs0c4ixsyera1iCEF/y2mcJm2BlqNQsIww4wKWUEtSyGRJ0N
        LGpqtnrwh5sJ9QjDdnDOUG/NO8FBVQbKcDaAiSkuDOcD2LfAY/gk7DB8tC7bBfManmzNwbfy
        PJiWymckFCw1D1pHnoFacxbKvNB7AA3mTnYOcC7Y4adgh4eCHR4KdngoBmglsKejlbJQWunh
        phTLlNHyULfgCFkd2Pp0vZuGRR0wJl3SAwIHQlueRD8t4rPFMcpYmR5AHBHa85pGjSI+L0Qc
        G0crIq4rosNppR444qjQgecTmCriE6HiKFpK05G04l+VhXMECaBwInNMVdMZz+m5+vDUVFz8
        n5RhJGhibr+nnymoReAzuxLQJj1RHpB10dB5gJLfWJGOOF6xTVQfudVd44cHZy8G3+2VvXSp
        //kgmK6+o8eyNpYGnr52Pe+RbKhqFbZ6p/kYJKVOuVPu/lJdU+OGQCqaPlcuMca7BuhmbY0z
        +FshqpSIPY4iCqX4LxdkkSpwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xy7oH3j+NNNh+Scpizvo1bBbzmzaw
        WaxcfZTJ4t28F8wWqybmWRzb8YjJ4vKuOWwWE6ZOYrfovr6DzWL58X9MFpf2qFgc/PCE1WLB
        xkeMFr+WH2W0+HbnBqMDv8eaeWsYPXp2nmH02LSqk81j9rlzbB4nZvxm8Ti6ci2Tx4NDm1k8
        dt9sYPP4+PQWi8fnTXIBXFFcNimpOZllqUX6dglcGS82pxUs9aiYfHcuawPjQ4suRk4OCQET
        iWXnXzFC2GISF+6tZ+ti5OIQEljCKLG9aweU85xRordvEStIlbBAqMS8lbPZQWwRAWeJd7d+
        MIMUMQvcYJbouTMFquMso8SP7U1sIFVsAoYSXW+7wGxeATuJx+2/wbpZBFQlrr/7yQRiiwrE
        SEx8cJERokZQ4sfkeywgNqeAk8TevqNgNcwCZhJfXh5mhbDlJTavecsMYYtLNLfeZJnAKDgL
        SfssJC2zkLTMQtKygJFlFaNIamlxbnpusZFecWJucWleul5yfu4mRmBUbjv2c8sOxq53wYcY
        BTgYlXh4Mw49iRRiTSwrrsw9xCjBwawkwrvr1tNIId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ry9
        e1ZHCgmkJ5akZqemFqQWwWSZODilGhhXrm2cMod/t8aHDdVbOopX/q9OvfSn28hah+PGrULV
        0EsiWmV8jN53p3NUBt1ekPtxvVKDZsFNheW8txT5ruU8OFC39NfNeSqWTycvnJP47Mu6Xeed
        w1P31XW0yi165mC9qSzmW8NuG+mNB1vfV6za8ze4a+fvoxZJ2xNsHY+kui14K2Knfy5PiaU4
        I9FQi7moOBEA6RahMMYCAAA=
X-CMS-MailID: 20171017115544eucas1p19ea8e9ebc1232f317fc35ed37a91aa9b
X-Msg-Generator: CA
X-Sender-IP: 182.198.249.180
X-Local-Sender: =?UTF-8?B?TWFyZWsgU3p5cHJvd3NraRtTUlBPTC1LZXJuZWwgKFRQKRs=?=
        =?UTF-8?B?7IK87ISx7KCE7J6QG1NlbmlvciBTb2Z0d2FyZSBFbmdpbmVlcg==?=
X-Global-Sender: =?UTF-8?B?TWFyZWsgU3p5cHJvd3NraRtTUlBPTC1LZXJuZWwgKFRQKRtT?=
        =?UTF-8?B?YW1zdW5nIEVsZWN0cm9uaWNzG1NlbmlvciBTb2Z0d2FyZSBFbmdpbmVlcg==?=
X-Sender-Code: =?UTF-8?B?QzEwG0VIURtDMTBDRDAyQ0QwMjczOTI=?=
CMS-TYPE: 201P
X-CMS-RootMailID: 20171017080448epcas5p2c7c53292d84838f6d06e78abf4416729
X-RootMTR: 20171017080448epcas5p2c7c53292d84838f6d06e78abf4416729
References: <1508227542-13165-1-git-send-email-chenhc@lemote.com>
        <CGME20171017080448epcas5p2c7c53292d84838f6d06e78abf4416729@epcas5p2.samsung.com>
        <1508227542-13165-4-git-send-email-chenhc@lemote.com>
Return-Path: <m.szyprowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60424
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

On 2017-10-17 10:05, Huacai Chen wrote:
> In non-coherent DMA mode, kernel uses cache flushing operations to
> maintain I/O coherency, so libsas's SMP request/response should be
> aligned to ARCH_DMA_MINALIGN. Otherwise, If a DMA buffer and a kernel
> structure share a same cache line, and if the kernel structure has
> dirty data, cache_invalidate (no writeback) will cause data corruption.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>   drivers/scsi/libsas/sas_expander.c | 93 +++++++++++++++++++++++---------------
>   1 file changed, 57 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index 6b4fd23..124a44b 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -164,17 +164,17 @@ static int smp_execute_task(struct domain_device *dev, void *req, int req_size,
>   
>   /* ---------- Allocations ---------- */
>   
> -static inline void *alloc_smp_req(int size)
> +static inline void *alloc_smp_req(int size, int align)
>   {
> -	u8 *p = kzalloc(size, GFP_KERNEL);
> +	u8 *p = kzalloc(ALIGN(size, align), GFP_KERNEL);

If I remember correctly, kernel guarantees that each kmalloced buffer is
always at least aligned to the CPU cache line, so CPU cache can be
invalidated on the allocated buffer without corrupting anything else.
Taking this into account, I wonder if the above change make sense.

Have you experienced any problems without this change?

>   	if (p)
>   		p[0] = SMP_REQUEST;
>   	return p;
>   }
>   
> -static inline void *alloc_smp_resp(int size)
> +static inline void *alloc_smp_resp(int size, int align)
>   {
> -	return kzalloc(size, GFP_KERNEL);
> +	return kzalloc(ALIGN(size, align), GFP_KERNEL);

Save a above.

>   }
>   
>   static char sas_route_char(struct domain_device *dev, struct ex_phy *phy)
> @@ -403,15 +403,17 @@ static int sas_ex_phy_discover_helper(struct domain_device *dev, u8 *disc_req,
>   int sas_ex_phy_discover(struct domain_device *dev, int single)
>   {
>   	struct expander_device *ex = &dev->ex_dev;
> -	int  res = 0;
> +	int  res = 0, align;
>   	u8   *disc_req;
>   	u8   *disc_resp;
>   
> -	disc_req = alloc_smp_req(DISCOVER_REQ_SIZE);
> +	align = dma_get_cache_alignment(&dev->phy->dev);
> +
> +	disc_req = alloc_smp_req(DISCOVER_REQ_SIZE, align);
>   	if (!disc_req)
>   		return -ENOMEM;
>   
> -	disc_resp = alloc_smp_resp(DISCOVER_RESP_SIZE);
> +	disc_resp = alloc_smp_resp(DISCOVER_RESP_SIZE, align);
>   	if (!disc_resp) {
>   		kfree(disc_req);
>   		return -ENOMEM;
> @@ -480,14 +482,15 @@ static int sas_ex_general(struct domain_device *dev)
>   {
>   	u8 *rg_req;
>   	struct smp_resp *rg_resp;
> -	int res;
> -	int i;
> +	int i, res, align;
>   
> -	rg_req = alloc_smp_req(RG_REQ_SIZE);
> +	align = dma_get_cache_alignment(&dev->phy->dev);
> +
> +	rg_req = alloc_smp_req(RG_REQ_SIZE, align);
>   	if (!rg_req)
>   		return -ENOMEM;
>   
> -	rg_resp = alloc_smp_resp(RG_RESP_SIZE);
> +	rg_resp = alloc_smp_resp(RG_RESP_SIZE, align);
>   	if (!rg_resp) {
>   		kfree(rg_req);
>   		return -ENOMEM;
> @@ -552,13 +555,15 @@ static int sas_ex_manuf_info(struct domain_device *dev)
>   {
>   	u8 *mi_req;
>   	u8 *mi_resp;
> -	int res;
> +	int res, align;
>   
> -	mi_req = alloc_smp_req(MI_REQ_SIZE);
> +	align = dma_get_cache_alignment(&dev->phy->dev);
> +
> +	mi_req = alloc_smp_req(MI_REQ_SIZE, align);
>   	if (!mi_req)
>   		return -ENOMEM;
>   
> -	mi_resp = alloc_smp_resp(MI_RESP_SIZE);
> +	mi_resp = alloc_smp_resp(MI_RESP_SIZE, align);
>   	if (!mi_resp) {
>   		kfree(mi_req);
>   		return -ENOMEM;
> @@ -593,13 +598,15 @@ int sas_smp_phy_control(struct domain_device *dev, int phy_id,
>   {
>   	u8 *pc_req;
>   	u8 *pc_resp;
> -	int res;
> +	int res, align;
> +
> +	align = dma_get_cache_alignment(&dev->phy->dev);
>   
> -	pc_req = alloc_smp_req(PC_REQ_SIZE);
> +	pc_req = alloc_smp_req(PC_REQ_SIZE, align);
>   	if (!pc_req)
>   		return -ENOMEM;
>   
> -	pc_resp = alloc_smp_resp(PC_RESP_SIZE);
> +	pc_resp = alloc_smp_resp(PC_RESP_SIZE, align);
>   	if (!pc_resp) {
>   		kfree(pc_req);
>   		return -ENOMEM;
> @@ -664,17 +671,19 @@ static int sas_dev_present_in_domain(struct asd_sas_port *port,
>   #define RPEL_RESP_SIZE	32
>   int sas_smp_get_phy_events(struct sas_phy *phy)
>   {
> -	int res;
> +	int res, align;
>   	u8 *req;
>   	u8 *resp;
>   	struct sas_rphy *rphy = dev_to_rphy(phy->dev.parent);
>   	struct domain_device *dev = sas_find_dev_by_rphy(rphy);
>   
> -	req = alloc_smp_req(RPEL_REQ_SIZE);
> +	align = dma_get_cache_alignment(&phy->dev);
> +
> +	req = alloc_smp_req(RPEL_REQ_SIZE, align);
>   	if (!req)
>   		return -ENOMEM;
>   
> -	resp = alloc_smp_resp(RPEL_RESP_SIZE);
> +	resp = alloc_smp_resp(RPEL_RESP_SIZE, align);
>   	if (!resp) {
>   		kfree(req);
>   		return -ENOMEM;
> @@ -709,7 +718,8 @@ int sas_get_report_phy_sata(struct domain_device *dev, int phy_id,
>   			    struct smp_resp *rps_resp)
>   {
>   	int res;
> -	u8 *rps_req = alloc_smp_req(RPS_REQ_SIZE);
> +	int align = dma_get_cache_alignment(&dev->phy->dev);
> +	u8 *rps_req = alloc_smp_req(RPS_REQ_SIZE, align);
>   	u8 *resp = (u8 *)rps_resp;
>   
>   	if (!rps_req)
> @@ -1398,7 +1408,7 @@ static int sas_check_parent_topology(struct domain_device *child)
>   static int sas_configure_present(struct domain_device *dev, int phy_id,
>   				 u8 *sas_addr, int *index, int *present)
>   {
> -	int i, res = 0;
> +	int i, res = 0, align;
>   	struct expander_device *ex = &dev->ex_dev;
>   	struct ex_phy *phy = &ex->ex_phy[phy_id];
>   	u8 *rri_req;
> @@ -1406,12 +1416,13 @@ static int sas_configure_present(struct domain_device *dev, int phy_id,
>   
>   	*present = 0;
>   	*index = 0;
> +	align = dma_get_cache_alignment(&dev->phy->dev);
>   
> -	rri_req = alloc_smp_req(RRI_REQ_SIZE);
> +	rri_req = alloc_smp_req(RRI_REQ_SIZE, align);
>   	if (!rri_req)
>   		return -ENOMEM;
>   
> -	rri_resp = alloc_smp_resp(RRI_RESP_SIZE);
> +	rri_resp = alloc_smp_resp(RRI_RESP_SIZE, align);
>   	if (!rri_resp) {
>   		kfree(rri_req);
>   		return -ENOMEM;
> @@ -1472,15 +1483,17 @@ static int sas_configure_present(struct domain_device *dev, int phy_id,
>   static int sas_configure_set(struct domain_device *dev, int phy_id,
>   			     u8 *sas_addr, int index, int include)
>   {
> -	int res;
> +	int res, align;
>   	u8 *cri_req;
>   	u8 *cri_resp;
>   
> -	cri_req = alloc_smp_req(CRI_REQ_SIZE);
> +	align = dma_get_cache_alignment(&dev->phy->dev);
> +
> +	cri_req = alloc_smp_req(CRI_REQ_SIZE, align);
>   	if (!cri_req)
>   		return -ENOMEM;
>   
> -	cri_resp = alloc_smp_resp(CRI_RESP_SIZE);
> +	cri_resp = alloc_smp_resp(CRI_RESP_SIZE, align);
>   	if (!cri_resp) {
>   		kfree(cri_req);
>   		return -ENOMEM;
> @@ -1689,10 +1702,12 @@ int sas_discover_root_expander(struct domain_device *dev)
>   static int sas_get_phy_discover(struct domain_device *dev,
>   				int phy_id, struct smp_resp *disc_resp)
>   {
> -	int res;
> +	int res, align;
>   	u8 *disc_req;
>   
> -	disc_req = alloc_smp_req(DISCOVER_REQ_SIZE);
> +	align = dma_get_cache_alignment(&dev->phy->dev);
> +
> +	disc_req = alloc_smp_req(DISCOVER_REQ_SIZE, align);
>   	if (!disc_req)
>   		return -ENOMEM;
>   
> @@ -1715,10 +1730,12 @@ static int sas_get_phy_discover(struct domain_device *dev,
>   static int sas_get_phy_change_count(struct domain_device *dev,
>   				    int phy_id, int *pcc)
>   {
> -	int res;
> +	int res, align;
>   	struct smp_resp *disc_resp;
>   
> -	disc_resp = alloc_smp_resp(DISCOVER_RESP_SIZE);
> +	align = dma_get_cache_alignment(&dev->phy->dev);
> +
> +	disc_resp = alloc_smp_resp(DISCOVER_RESP_SIZE, align);
>   	if (!disc_resp)
>   		return -ENOMEM;
>   
> @@ -1733,11 +1750,13 @@ static int sas_get_phy_change_count(struct domain_device *dev,
>   static int sas_get_phy_attached_dev(struct domain_device *dev, int phy_id,
>   				    u8 *sas_addr, enum sas_device_type *type)
>   {
> -	int res;
> +	int res, align;
>   	struct smp_resp *disc_resp;
>   	struct discover_resp *dr;
>   
> -	disc_resp = alloc_smp_resp(DISCOVER_RESP_SIZE);
> +	align = dma_get_cache_alignment(&dev->phy->dev);
> +
> +	disc_resp = alloc_smp_resp(DISCOVER_RESP_SIZE, align);
>   	if (!disc_resp)
>   		return -ENOMEM;
>   	dr = &disc_resp->disc;
> @@ -1787,15 +1806,17 @@ static int sas_find_bcast_phy(struct domain_device *dev, int *phy_id,
>   
>   static int sas_get_ex_change_count(struct domain_device *dev, int *ecc)
>   {
> -	int res;
> +	int res, align;
>   	u8  *rg_req;
>   	struct smp_resp  *rg_resp;
>   
> -	rg_req = alloc_smp_req(RG_REQ_SIZE);
> +	align = dma_get_cache_alignment(&dev->phy->dev);
> +
> +	rg_req = alloc_smp_req(RG_REQ_SIZE, align);
>   	if (!rg_req)
>   		return -ENOMEM;
>   
> -	rg_resp = alloc_smp_resp(RG_RESP_SIZE);
> +	rg_resp = alloc_smp_resp(RG_RESP_SIZE, align);
>   	if (!rg_resp) {
>   		kfree(rg_req);
>   		return -ENOMEM;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
