Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2018 13:08:38 +0100 (CET)
Received: from mail-sn1nam04on060e.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe4c::60e]:60928
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992824AbeKGMIc3ivkO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Nov 2018 13:08:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKSPgUfffvwR/hLOebWllcT8SKNpl65OHhhGFLfhZfs=;
 b=Jjo3F7XFbtR1bHOcdecXIyEHG9hjOwIs9+ZIaEOFFoawZetJQIi5mTYVdfGCKs6Zflv3O9u/M2qDTLo8YmuqMWgLBTjOcKmHmLc6nyIsI7tyxR/V8Q6+bNtgYrfKuwv4n1XmuApRVFnStNhBkCtno/pthC60V5APxYLtWkkOwN0=
Received: from SN6PR07MB5326.namprd07.prod.outlook.com (52.135.105.33) by
 SN6PR07MB4989.namprd07.prod.outlook.com (52.135.121.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 7 Nov 2018 12:08:29 +0000
Received: from SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149]) by SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149%5]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 12:08:29 +0000
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
Thread-Index: AQHUdoUq2AwKuoql6EeF9Wp0ltPKwKVEOByA
Date:   Wed, 7 Nov 2018 12:08:29 +0000
Message-ID: <20181107120821.GK3795@rric.localdomain>
References: <b06321ac25a1211e572e650a630e5e1aa9f8173f.1541504601.git.robin.murphy@arm.com>
 <20181107103150.GA14853@rric.localdomain>
In-Reply-To: <20181107103150.GA14853@rric.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0042.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::19) To SN6PR07MB5326.namprd07.prod.outlook.com
 (2603:10b6:805:73::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.180.181.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB4989;6:jz9yKQKuePnutkRS8t6TT6xK4rqyqi4y/NixT/VrfqgquweWEKNkt+RTHY2W3KChfJDEhBfCkXYU3VrlkOkog+xXRODdspr/Xz6j65XNt/yJfSoX29Ad3xVTW8QHPFqQMl4W9lfoTJg+W+pHQIfcWVPrbLrZAdQLp8pBj5xD9zY8487ou0QKk2jiLKR386Od1uzXm4TmZzLohgc4woh4Rm1i51YPPLITimOScbAhi2Pok3JSZ4dkV5X97quqPBSilqrI3gre81+TNdso42nhFoXEh8UIxpxIOlijyCxld+K63/fBtgSlDZju56zTJplrDWHJM4zCShN3lTc5cYMqBlY2rYKOG/aw5wKum8vE+5IboOLW8sUTPVoZiSIQ8x1DZEriB0crktTFCRPw90qXC0S5iKylfEG1TASQ7ftienZjS5Tk5c7PwXj9Z0MHhdxFsjBhVZ+Ryvr22kJkHbPCHQ==;5:UizAXfZ+U2jjKZDQ64Zn71Qe+02dBN6lqBc9P2abWeEP7q85SttYcgaSG1pOh+tV2AmbVKsEOT5ThliyQLhzET1iXuO8kBwi07e5eYcR0HN0e4V7j/e7vRo5zYBU0DgsHjhGYrLWIOKN0c76+U1E0YDpUxbqe/8gzXMP7sySmKY=;7:8JSmlybUpuI9r0LmltNqfoo55r1xttnWIr1iHruSJRyQtmxE19ptgx7KfjTbF3aGO8VX4W1bPUqtKcYj+/29ng6yxcdFqmV1qRPbjqr8Fyu4y9WQ8NBgYSU8aWp2vwgsvfGv7R9PP3o55ZC+QLf1DA==
x-ms-office365-filtering-correlation-id: f8c6613f-cccb-4dc3-48ea-08d644a9ba65
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4989;
x-ms-traffictypediagnostic: SN6PR07MB4989:
x-microsoft-antispam-prvs: <SN6PR07MB498975D5BA2212D605C4FBCBF1C40@SN6PR07MB4989.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(180628864354917);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(4982022)(52105095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB4989;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4989;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(39860400002)(346002)(189003)(199004)(229853002)(97736004)(966005)(14454004)(25786009)(72206003)(6116002)(3846002)(6486002)(45080400002)(1076002)(478600001)(256004)(66066001)(186003)(8676002)(14444005)(316002)(8936002)(6436002)(53546011)(105586002)(6506007)(54906003)(53936002)(386003)(106356001)(6512007)(6306002)(9686003)(81166006)(71200400001)(71190400001)(26005)(81156014)(446003)(5660300001)(11346002)(102836004)(305945005)(7736002)(486006)(68736007)(4326008)(476003)(52116002)(86362001)(6916009)(6246003)(99286004)(7416002)(33896004)(1720100001)(2906002)(33656002)(2900100001)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4989;H:SN6PR07MB5326.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4Gl3DBmyie4M7PXNzcWaS0tF29XiFaaLJ4ZLq7eqxZMXvbnU/CnsxcxPL6UjdO1kD2EAXV1WVqX4h28FYAoP1+Vu0e0Xup2POLwSt2cu/IIUbwfaJewzFGjT8w9nnVYvJUCP/CKawKqH4PSn26ZaSfL+hN5KTKdISXcWkA7kd1RT+dBj/HHEqMSRvzO+FMztTuUpnwv3DV5qV9xi38FwYJB5Y9O9HFJ5S6h3qCPaf+WFjaVg3Lf7qNl2tOmA+qkpPDzGwV9Fnwxx/vFXykPhAHBC0eMaBBUzywTbhv/1qIM0vSL6bOVaJ+H4/E5nv10hLoxR9tJVyv/YiRcGuu0maAzfcMRE6K8oSz2gnp92PFQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0730569CA55EB141BCFD291FF9B75216@namprd07.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c6613f-cccb-4dc3-48ea-08d644a9ba65
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 12:08:29.2299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4989
Return-Path: <Robert.Richter@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67129
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

On 07.11.18 11:31:50, Robert Richter wrote:
> On 06.11.18 11:54:15, Robin Murphy wrote:
> > of_dma_configure() was *supposed* to be following the same logic as
> > acpi_dma_configure() and only setting bus_dma_mask if some range was
> > specified by the firmware. However, it seems that subtlety got lost in
> > the process of fitting it into the differently-shaped control flow, and
> > as a result the force_dma==true case ends up always setting the bus mask
> > to the 32-bit default, which is not what anyone wants.
> > 
> > Make sure we only touch it if the DT actually said so.
> > 
> > Fixes: 6c2fb2ea7636 ("of/device: Set bus DMA mask as appropriate")
> > Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Reported-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> Tested-by: Robert Richter <robert.richter@cavium.com>
> 
> This patch makes the bad page state message on Cavium ThunderX below
> disappear.
> 
> Note: The Fixes: tag suggests the issue was already in 4.19, but I
> have seen it in 4.20-rc1 first and it was pulled into mainline with:
> 
>  cff229491af5 Merge tag 'dma-mapping-4.20' of git://git.infradead.org/users/hch/dma-mapping

I have bisected it and the issue was seen first with:

 b4ebe6063204 dma-direct: implement complete bus_dma_mask handling

> 
> -Robert
> 
> 
> [   37.634555] BUG: Bad page state in process swapper/5  pfn:f3ebb
> [   37.640483] page:ffff7e0003cfaec0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
> [   37.648493] flags: 0xffff00000001000(reserved)
> [   37.652942] raw: 0ffff00000001000 ffff7e0003cfaec8 ffff7e0003cfaec8 0000000000000000
> [   37.660691] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> [   37.668438] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
> [   37.674880] bad because of flags: 0x1000(reserved)
> [   37.679672] Modules linked in: ip6t_REJECT nf_reject_ipv6 xt_tcpudp ipt_REJECT nf_reject_ipv4 xt_conntrack ip6table_nat nf_nat_ipv6 ip6table_mangle iptable_nat nf_nat_ipv4 nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle ip6table_filter ip6_tables iptable_filter crct10dif_ce cavium_rng_vf rng_core ipmi_ssif thunderx_zip thunderx_edac ipmi_devintf cavium_rng ipmi_msghandler ip_tables x_tables xfs libcrc32c nicvf nicpf thunder_bgx thunder_xcv i2c_thunderx mdio_thunder mdio_cavium ipv6
> [   37.723866] CPU: 5 PID: 0 Comm: swapper/5 Not tainted 4.20.0-rc1-00012-gc106b1cbe843 #1
> [   37.731874] Hardware name: Cavium ThunderX CRB/To be filled by O.E.M., BIOS 5.11 12/12/2012
> [   37.740228] Call trace:
> [   37.742677]  dump_backtrace+0x0/0x148
> [   37.746334]  show_stack+0x14/0x1c
> [   37.749643]  dump_stack+0x84/0xa8
> [   37.752954]  bad_page+0xe4/0x144
> [   37.756178]  free_pages_check_bad+0x7c/0x84
> [   37.760355]  __free_pages_ok+0x22c/0x284
> [   37.764272]  page_frag_free+0x64/0x68
> [   37.767930]  skb_free_head+0x24/0x2c
> [   37.771500]  skb_release_data+0x130/0x148
> [   37.775504]  skb_release_all+0x24/0x30
> [   37.779246]  kfree_skb+0x2c/0x54
> [   37.782471]  ip_error+0x70/0x1d4
> [   37.785693]  ip_rcv_finish+0x3c/0x50
> [   37.789262]  ip_rcv+0xc0/0xd0
> [   37.792225]  __netif_receive_skb_one_core+0x4c/0x70
> [   37.797099]  __netif_receive_skb+0x2c/0x70
> [   37.801190]  netif_receive_skb_internal+0x64/0x160
> [   37.805976]  napi_gro_receive+0xa0/0xc4
> [   37.809815]  nicvf_cq_intr_handler+0x930/0xc1c [nicvf]
> [   37.814950]  nicvf_poll+0x30/0xb0 [nicvf]
> [   37.818954]  net_rx_action+0x140/0x2f8
> [   37.822697]  __do_softirq+0x11c/0x228
> [   37.826354]  irq_exit+0xbc/0xd0
> [   37.829491]  __handle_domain_irq+0x6c/0xb4
> [   37.833581]  gic_handle_irq+0x8c/0x1a0
> [   37.837324]  el1_irq+0xb0/0x128
> [   37.840459]  arch_cpu_idle+0x10/0x18
> [   37.844031]  default_idle_call+0x18/0x28
> [   37.847948]  do_idle+0x194/0x258
> [   37.851169]  cpu_startup_entry+0x20/0x24
> [   37.855089]  secondary_start_kernel+0x144/0x168
> 
> 
> > ---
> > 
> > Sorry about that... I guess I only have test setups that either have
> > dma-ranges or where a 32-bit bus mask goes unnoticed :(
> > 
> > The Octeon and SMMU issues sound like they're purely down to this, and
> > it's probably related to at least one of John's Hikey woes.
> > 
> > Robin.
> > 
> >  drivers/of/device.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/of/device.c b/drivers/of/device.c
> > index 0f27fad9fe94..757ae867674f 100644
> > --- a/drivers/of/device.c
> > +++ b/drivers/of/device.c
> > @@ -149,7 +149,8 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
> >  	 * set by the driver.
> >  	 */
> >  	mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1);
> > -	dev->bus_dma_mask = mask;
> > +	if (!ret)
> > +		dev->bus_dma_mask = mask;
> >  	dev->coherent_dma_mask &= mask;
> >  	*dev->dma_mask &= mask;
> >  
> > -- 
> > 2.19.1.dirty
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
