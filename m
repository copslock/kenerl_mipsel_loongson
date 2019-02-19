Return-Path: <SRS0=ba0M=Q2=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEA4C43381
	for <linux-mips@archiver.kernel.org>; Tue, 19 Feb 2019 20:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383E821479
	for <linux-mips@archiver.kernel.org>; Tue, 19 Feb 2019 20:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Om+4a6ty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfBSUsO (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:48:14 -0500
Received: from mail-eopbgr820109.outbound.protection.outlook.com ([40.107.82.109]:11440
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725963AbfBSUsO (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 19 Feb 2019 15:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xm4y0O9YLZQg2jFc+G95TWGexU9LEtsWiXQxogLaf8Q=;
 b=Om+4a6ty7Za+EgC1rLYvv0HrgbxC5C920tT83BffJexqYDG189kS2+ga7ukXdCEvgtgMgpJllGliU/tG7eqczea/BDkGv2jzn2zfYVJoU9yjT8Ihm7xiMmIXxDzMEercaYiPVDYVm45NJroGzQuxycztgXMQJ61Hr5CxlRi6onE=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1103.namprd22.prod.outlook.com (10.174.169.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Tue, 19 Feb 2019 20:48:12 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1622.018; Tue, 19 Feb 2019
 20:48:12 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: dma-noncoherent: Remove bogus condition in
  dma_sync_phys()
Thread-Topic: [PATCH] MIPS: dma-noncoherent: Remove bogus condition in
  dma_sync_phys()
Thread-Index: AQHUyJRt9T776yuMSU6Xglc0qUydbA==
Date:   Tue, 19 Feb 2019 20:48:11 +0000
Message-ID: <MWHPR2201MB127723685A579CA37395A4A2C17C0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190215220250.30883-1-paul.burton@mips.com>
In-Reply-To: <20190215220250.30883-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::43) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbd68da4-05cb-468a-ff45-08d696ab8faa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1103;
x-ms-traffictypediagnostic: MWHPR2201MB1103:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR2201MB1103;23:IRuciCnZx1QSuvHggU8O8AiSW4CCkw6/wO5Qx?=
 =?iso-8859-1?Q?Y1v/vhbVm5ZkPY6U4cBTm3tteqGFKNqxX+9r8FWZDo4wFS47+/C3EesPzm?=
 =?iso-8859-1?Q?XOvSk/cMTj71qNz8r/FXElhuHtpUlxLimaFI9znQ+WZULPninkCHQfKqJF?=
 =?iso-8859-1?Q?Q1/5p7SoewnyeGuGPAvq0+hKsi9dpCdQ5IocWoAFVO5uyeJDWmoPAY9Pas?=
 =?iso-8859-1?Q?+vxXaEuy6ksiwF1+mrJXEeoF8dAhnEKq6m3BADh1zjOnULC3Pn0BSs4ncl?=
 =?iso-8859-1?Q?cRDgI2xj3OwVIFKGWttaDT87kptH6ibj/mjvAnd63gu+U5K3Uiolf9tBNP?=
 =?iso-8859-1?Q?B5Mn2EA5lwEtMRxAOm+8NSR6Hd8wnvuI66qRNU5V+L2yUW9ZmcyJQA1c9+?=
 =?iso-8859-1?Q?LxOKjlXOP7d2S1+YiQFrI2EplWyeBCJscjTxt/7qf7FAVeCJiBLazmMp9L?=
 =?iso-8859-1?Q?jEl5gJ77KziRlIML7G+81SdsysQkKsKAUux7KR92aOQRToubdwGOrs2v7t?=
 =?iso-8859-1?Q?2LYKreL2xQi23nOn3e+fzfwT/7X0tP7foaEBUSdJ3XCAMnoZBXlOrK7eHY?=
 =?iso-8859-1?Q?T5zR24PBG06s61NvkbRSK39ZaqctjllB2BEh/zd0GLwINi7j+fhc5itnRj?=
 =?iso-8859-1?Q?eYIFEX+wdSBNBtjmHlJ5Nv5q2Lb0mfEJO8xutp1sy+bNIR/t0EiQqDoH1Q?=
 =?iso-8859-1?Q?YYAxSf6pKb2uAkM6NtP7+RfRuLuDfrzaoofXTrbiRKCTYnQ2Q0AdTS/IoO?=
 =?iso-8859-1?Q?QW5Qq3AlCxPIB+ouJrTdv3r+LztuK2x2MmBs3GMeX6cQbA96ehTgXmwJqx?=
 =?iso-8859-1?Q?BvonlmiCsysez39OH7uYcgZKj5v0WLqWcj/cVLW3iDJnrL/Xa6nS6TGwGG?=
 =?iso-8859-1?Q?L17kjChjlLOcAfDrMz628f6Dp2lZiy/UbZISWWZW3DRxLYO+cHyuNC9fSX?=
 =?iso-8859-1?Q?F02b/OG1aLJoCGeWufw0kzCYCB9rKg+3Gh59KkDk4eq5DSHgsETmydb+0s?=
 =?iso-8859-1?Q?IvdufUVMRHWSraPeywcg13YieG6NNyx0kCThMYTBuvuxIO8VDdFnqkHBmq?=
 =?iso-8859-1?Q?ZYev4xMyJ1ghEVEF5EQwIu2nkyNjokIU38V3MZmAskzVm+5c7NkPpRl2ZS?=
 =?iso-8859-1?Q?1hCT9mOlSRwa8QK0jbz37HjNZNlfPa1mbT5mpcykpku+IGkXrznnjQ2Awj?=
 =?iso-8859-1?Q?XDnK1h0Ct+Kkd2kF8wxLOkfTGrt+TjzwlH5PsG/s4izeLPuKFnlZLFTShH?=
 =?iso-8859-1?Q?KqSC0xwiF53E5ntOxluLmJixniVpk+8UrqKysomoF3xhIfs4QCmdrJvcWi?=
 =?iso-8859-1?Q?tKor9Yj+Vs5N73XKJUOZfdFyw1xWrPZ9mpMHT1LVYND/4C8P+nhke1l0FE?=
 =?iso-8859-1?Q?YEk8+6uops=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB11036715919FCD01B6C16573C17C0@MWHPR2201MB1103.namprd22.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(136003)(346002)(366004)(376002)(396003)(189003)(199004)(2906002)(44832011)(446003)(186003)(106356001)(102836004)(105586002)(71200400001)(71190400001)(54906003)(42882007)(316002)(7696005)(81156014)(486006)(81166006)(26005)(52116002)(76176011)(6346003)(8676002)(33656002)(74316002)(25786009)(386003)(11346002)(4744005)(6506007)(476003)(6436002)(256004)(14454004)(14444005)(55016002)(9686003)(6862004)(5660300002)(68736007)(6246003)(4326008)(66066001)(6116002)(8936002)(229853002)(3846002)(53936002)(305945005)(97736004)(7736002)(99286004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1103;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XSov+1wq8W8vj1i0g5ZT871Aa0gpl24DlOlhZX2JcLI0tS+Xjjnl+Sl+h6Yk9trNTcl8Gbl753OBqRUkPnVuqtSWWq3PEYz4sgkjHAlZwhMmJHfmZQ9JM7+AO+AnySOQKBcpuvkzTXR+55m5hjhk+F7/iyTZqj4LadDmzD/s9LWZi6WYEzo26vJb7/cAeKvS/Dza9q3OBb9akDsMMlrQXr0w9JV6/HZfAaiWMtlUwn2SynYwGuX23BvF3LDCsbyIJrNUqbuovsRPG6h0Rj49DGXvb1g2dLstP2q+lHrzjNMm9otWPD9BHSgn2diJ5zzFpsxjsmLRItAXd3jZc9QXbLMbhE8PfXru0mL5dSNVycqd/StuXr/mhnogUyNq0JdBFEY5KVubSUMH4tyY5k4tD9EyE6+5DHhzv0dIy3vwLVg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd68da4-05cb-468a-ff45-08d696ab8faa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 20:48:11.2865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1103
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Paul Burton wrote:
> Commit e36863a550da ("MIPS: HIGHMEM DMA on noncoherent MIPS32
> processors") introduced code which:
>=20
> 1) Calculates an offset within a page, by ANDing an address
> with ~PAGE_MASK.
>=20
> 2) Checks whether that offset is >=3D PAGE_SIZE.
>=20
> This check can never evaluate true, making the code it guards
> unreachable. smatch spots bogus arithmetic resulting from the
> impossible condition, resulting in the following warning:
>=20
> arch/mips/mm/dma-noncoherent.c:125
> dma_sync_phys() warn: mask and shift to zero
>=20
> Fix this by removing the impossible to satisfy condition & the
> unreachable code it guards.
>=20
> Signed-off-by: Paul Burton <paul.burton@mips.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
