Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2018 11:32:28 +0100 (CET)
Received: from mail-bl2nam02on0057.outbound.protection.outlook.com ([104.47.38.57]:22016
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990397AbeKGKcYVHIcE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Nov 2018 11:32:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38N9hgsxkSgh9Xh9/kyarqqo66b1vrg1Afl6/55RjJA=;
 b=Q0ivYBl8M287zJy7azSbVFq8osh6/1mlPflbEJyy6crQRLQOwXTFk0szhF/qpNvF+aCAk/wKhObW4l50GuX+8gSaoKinrrzDo8scWRLZIxbRAPVvSqRxRqpH1XL/iahKCsZXSX9pZC6FI19Us25CqI3dmkecQVJsGKbRzqdnMBg=
Received: from SN6PR07MB5326.namprd07.prod.outlook.com (52.135.105.33) by
 SN6PR07MB5358.namprd07.prod.outlook.com (52.135.105.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 7 Nov 2018 10:32:21 +0000
Received: from SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149]) by SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149%5]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 10:32:21 +0000
From:   "Richter, Robert" <Robert.Richter@cavium.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     "hch@lst.de" <hch@lst.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>,
        "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Subject: Re: [PATCH] of/device: Really only set bus DMA mask when appropriate
Thread-Topic: [PATCH] of/device: Really only set bus DMA mask when appropriate
Thread-Index: AQHUdoUq2AwKuoql6EeF9Wp0ltPKwA==
Date:   Wed, 7 Nov 2018 10:32:21 +0000
Message-ID: <20181107103150.GA14853@rric.localdomain>
References: <b06321ac25a1211e572e650a630e5e1aa9f8173f.1541504601.git.robin.murphy@arm.com>
In-Reply-To: <b06321ac25a1211e572e650a630e5e1aa9f8173f.1541504601.git.robin.murphy@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR04CA0034.eurprd04.prod.outlook.com
 (2603:10a6:206:1::47) To SN6PR07MB5326.namprd07.prod.outlook.com
 (2603:10b6:805:73::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.180.181.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB5358;6:LhJZm7jhhiS0fWs1+D25Z57BIIVnuSFf7OYllaiSzM8MUlY1/RLfv9AlKL7UPxmh/iaDyz160V+/WOY3jWy1ksSOskYVCX98aOWTSS7RqGGU0Zi4j8NG0n6582AJ6oOQSrdeXqazgrLJL/9I+CnhbKdDHyT/wcPjvnnimJ4rjJAPpm5Zfn0Qxq3mbzGzS+H+llLNfDTd3s0LvAuHWdaZ8Yqq1GqiA05THxoHORfy+lNB/jLRh2AVBayi+1vX3tnKwjBzxUQXkpFxisbrYmNDRwULRHz+gtJ3pm9nN2XtrpDQTST12bb4S9p/BVOEQ2spMUIvdfa9cYw1Zu8fhBH3BYT3olW1dD4imcDLr6R3HfpdnVA+FFV0f3nXyKNicRo7/ntxF/UAdyKaXfX2V8OsF2Z+6V/bRt+Ulzx8hGSsVbP6T63jOYUsAggSfM7wyYl2XPTfGR7hsVYeTxmPd+I9Dg==;5:JQbiuWXrYlnPqH0mcyo86+uIH+wx3lHhxp7AyKKz16fwiC8IQXlj8aOMoTtkwO4v1a+6he/nHdh70X/AlUjpQa+RKMTYRUyNAafCk3pfCnMz5HgNteLhwL/kbTsPa8DZ0njSb59HsNz7ypH4UTykVMXynxjBr6CMouQZ9ZpMBbY=;7:hRtPCn5vlYydBkcFxaIgPsm9tjgFGqfCMQN99M+LJJZYAwei7lv3UCD99FuQi+rqkymbVluiAixMoDswMg3E51pKoIDg5EQ/L0VXNa/83PAFdKfX8HjYszZZNs/WzAJrqVqTmg7hHL/PRFfuORqjEw==
x-ms-office365-filtering-correlation-id: 2f98f051-cf5e-4729-1f11-08d6449c4c22
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB5358;
x-ms-traffictypediagnostic: SN6PR07MB5358:
x-microsoft-antispam-prvs: <SN6PR07MB5358645D682005326BC0CF34F1C40@SN6PR07MB5358.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(180628864354917);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(4982022)(52105095)(93006095)(93001095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB5358;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB5358;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(136003)(376002)(189003)(199004)(25786009)(7416002)(5660300001)(99286004)(52116002)(186003)(102836004)(53546011)(386003)(478600001)(81166006)(14454004)(81156014)(8936002)(45080400002)(72206003)(68736007)(26005)(76176011)(8676002)(14444005)(6506007)(33896004)(256004)(966005)(4326008)(7736002)(305945005)(33656002)(71190400001)(71200400001)(1076002)(97736004)(229853002)(9686003)(6512007)(6116002)(3846002)(105586002)(6916009)(2906002)(1720100001)(2900100001)(66066001)(6306002)(106356001)(54906003)(86362001)(11346002)(446003)(486006)(476003)(6436002)(316002)(53936002)(6486002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB5358;H:SN6PR07MB5326.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: O4gSkdI9lDA1IIh4kQM9/1Leq16wH7U3uOdCajcEpE3xziRoQucyCJI8SzgNRVdzHh8sDYhUPXgoIlsajCVph3ynso4Y3NCeZipDw9Vp31nGKJuQchTwJ9RhBc8M0WwlO31vYD6x/4FVcl+/Y/0cY9PG9mIz6K2GIBEBMKfhBpiTBoPZuvP2wR5nWLrOXeJgeNAme4AuUgLc5ofMo44HyCnVVHSkHoG9mORIElYo9E1d2RzN5WqJYKcrNwGyvJln3qc3WZZfdI2QsSzht4KfHT45o5FPjF70JugDRpQu7r0eAgfATCMf16AveDkxEyq9mzeXxFftWgndJsfrxSuc2YK9kuNZp0UG/oJNYEIA1Tg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B18B35C78C8B9C4A8FE386F5B35FCB13@namprd07.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f98f051-cf5e-4729-1f11-08d6449c4c22
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 10:32:21.1551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5358
Return-Path: <Robert.Richter@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Robert.Richter@cavium.com
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

On 06.11.18 11:54:15, Robin Murphy wrote:
> of_dma_configure() was *supposed* to be following the same logic as
> acpi_dma_configure() and only setting bus_dma_mask if some range was
> specified by the firmware. However, it seems that subtlety got lost in
> the process of fitting it into the differently-shaped control flow, and
> as a result the force_dma==true case ends up always setting the bus mask
> to the 32-bit default, which is not what anyone wants.
> 
> Make sure we only touch it if the DT actually said so.
> 
> Fixes: 6c2fb2ea7636 ("of/device: Set bus DMA mask as appropriate")
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Reported-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Tested-by: Robert Richter <robert.richter@cavium.com>

This patch makes the bad page state message on Cavium ThunderX below
disappear.

Note: The Fixes: tag suggests the issue was already in 4.19, but I
have seen it in 4.20-rc1 first and it was pulled into mainline with:

 cff229491af5 Merge tag 'dma-mapping-4.20' of git://git.infradead.org/users/hch/dma-mapping

-Robert


[   37.634555] BUG: Bad page state in process swapper/5  pfn:f3ebb
[   37.640483] page:ffff7e0003cfaec0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
[   37.648493] flags: 0xffff00000001000(reserved)
[   37.652942] raw: 0ffff00000001000 ffff7e0003cfaec8 ffff7e0003cfaec8 0000000000000000
[   37.660691] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[   37.668438] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
[   37.674880] bad because of flags: 0x1000(reserved)
[   37.679672] Modules linked in: ip6t_REJECT nf_reject_ipv6 xt_tcpudp ipt_REJECT nf_reject_ipv4 xt_conntrack ip6table_nat nf_nat_ipv6 ip6table_mangle iptable_nat nf_nat_ipv4 nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle ip6table_filter ip6_tables iptable_filter crct10dif_ce cavium_rng_vf rng_core ipmi_ssif thunderx_zip thunderx_edac ipmi_devintf cavium_rng ipmi_msghandler ip_tables x_tables xfs libcrc32c nicvf nicpf thunder_bgx thunder_xcv i2c_thunderx mdio_thunder mdio_cavium ipv6
[   37.723866] CPU: 5 PID: 0 Comm: swapper/5 Not tainted 4.20.0-rc1-00012-gc106b1cbe843 #1
[   37.731874] Hardware name: Cavium ThunderX CRB/To be filled by O.E.M., BIOS 5.11 12/12/2012
[   37.740228] Call trace:
[   37.742677]  dump_backtrace+0x0/0x148
[   37.746334]  show_stack+0x14/0x1c
[   37.749643]  dump_stack+0x84/0xa8
[   37.752954]  bad_page+0xe4/0x144
[   37.756178]  free_pages_check_bad+0x7c/0x84
[   37.760355]  __free_pages_ok+0x22c/0x284
[   37.764272]  page_frag_free+0x64/0x68
[   37.767930]  skb_free_head+0x24/0x2c
[   37.771500]  skb_release_data+0x130/0x148
[   37.775504]  skb_release_all+0x24/0x30
[   37.779246]  kfree_skb+0x2c/0x54
[   37.782471]  ip_error+0x70/0x1d4
[   37.785693]  ip_rcv_finish+0x3c/0x50
[   37.789262]  ip_rcv+0xc0/0xd0
[   37.792225]  __netif_receive_skb_one_core+0x4c/0x70
[   37.797099]  __netif_receive_skb+0x2c/0x70
[   37.801190]  netif_receive_skb_internal+0x64/0x160
[   37.805976]  napi_gro_receive+0xa0/0xc4
[   37.809815]  nicvf_cq_intr_handler+0x930/0xc1c [nicvf]
[   37.814950]  nicvf_poll+0x30/0xb0 [nicvf]
[   37.818954]  net_rx_action+0x140/0x2f8
[   37.822697]  __do_softirq+0x11c/0x228
[   37.826354]  irq_exit+0xbc/0xd0
[   37.829491]  __handle_domain_irq+0x6c/0xb4
[   37.833581]  gic_handle_irq+0x8c/0x1a0
[   37.837324]  el1_irq+0xb0/0x128
[   37.840459]  arch_cpu_idle+0x10/0x18
[   37.844031]  default_idle_call+0x18/0x28
[   37.847948]  do_idle+0x194/0x258
[   37.851169]  cpu_startup_entry+0x20/0x24
[   37.855089]  secondary_start_kernel+0x144/0x168


> ---
> 
> Sorry about that... I guess I only have test setups that either have
> dma-ranges or where a 32-bit bus mask goes unnoticed :(
> 
> The Octeon and SMMU issues sound like they're purely down to this, and
> it's probably related to at least one of John's Hikey woes.
> 
> Robin.
> 
>  drivers/of/device.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 0f27fad9fe94..757ae867674f 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -149,7 +149,8 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
>  	 * set by the driver.
>  	 */
>  	mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1);
> -	dev->bus_dma_mask = mask;
> +	if (!ret)
> +		dev->bus_dma_mask = mask;
>  	dev->coherent_dma_mask &= mask;
>  	*dev->dma_mask &= mask;
>  
> -- 
> 2.19.1.dirty
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
