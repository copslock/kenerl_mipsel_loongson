Return-Path: <SRS0=eOpe=YY=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C94CA9ECB
	for <linux-mips@archiver.kernel.org>; Thu, 31 Oct 2019 10:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BDA20873
	for <linux-mips@archiver.kernel.org>; Thu, 31 Oct 2019 10:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfJaKjF (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 31 Oct 2019 06:39:05 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2064 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726867AbfJaKjF (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 31 Oct 2019 06:39:05 -0400
Received: from lhreml706-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id CC4AE98301AF2BA9018F;
        Thu, 31 Oct 2019 10:39:02 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml706-cah.china.huawei.com (10.201.108.47) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 31 Oct 2019 10:39:02 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 10:39:01 +0000
Subject: Re: [PATCH 5/5] libata/ahci: Apply non-standard BAR fix for Loongson
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, <linux-mips@vger.kernel.org>
CC:     <davem@davemloft.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <axboe@kernel.dk>,
        <peppe.cavallaro@st.com>, <alexandre.torgue@st.com>,
        <joabreu@synopsys.com>, <bhelgaas@google.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20191030135347.3636-1-jiaxun.yang@flygoat.com>
 <20191030135347.3636-6-jiaxun.yang@flygoat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4411becf-9321-cda4-872a-64fd22bbbc7f@huawei.com>
Date:   Thu, 31 Oct 2019 10:39:01 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191030135347.3636-6-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On 30/10/2019 13:53, Jiaxun Yang wrote:
> Loongson is using BAR0 as AHCI registers BAR.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   drivers/ata/ahci.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index dd92faf197d5..db3d7b94ad53 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -42,6 +42,7 @@ enum {
>   	AHCI_PCI_BAR_CAVIUM	= 0,
>   	AHCI_PCI_BAR_ENMOTUS	= 2,
>   	AHCI_PCI_BAR_CAVIUM_GEN5	= 4,
> +	AHCI_PCI_BAR_LOONGSON	= 0,

nit: these seem to be ordered by ascending BAR index

>   	AHCI_PCI_BAR_STANDARD	= 5,
>   };
>   
> @@ -575,6 +576,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>   	/* Enmotus */
>   	{ PCI_DEVICE(0x1c44, 0x8000), board_ahci },
>   
> +	/* Loongson */
> +	{ PCI_VDEVICE(LOONGSON, 0x7a08), board_ahci },
> +
>   	/* Generic, PCI class code for AHCI */
>   	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>   	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci },
> @@ -1663,6 +1667,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>   			ahci_pci_bar = AHCI_PCI_BAR_CAVIUM;
>   		if (pdev->device == 0xa084)
>   			ahci_pci_bar = AHCI_PCI_BAR_CAVIUM_GEN5;
> +	} else if (pdev->vendor == PCI_VENDOR_ID_LOONGSON) {
> +		if (pdev->device == PCI_DEVICE_ID_LOONGSON_AHCI)
> +			ahci_pci_bar = AHCI_PCI_BAR_LOONGSON;
>   	}
>   
>   	/* acquire resources */
> 

