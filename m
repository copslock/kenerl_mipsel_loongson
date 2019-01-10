Return-Path: <SRS0=2fGM=PS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8645C43387
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 18:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721AF20675
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 18:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="gq/rgNeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbfAJSYs (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:24:48 -0500
Received: from mail-eopbgr700092.outbound.protection.outlook.com ([40.107.70.92]:43317
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729986AbfAJSYr (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 10 Jan 2019 13:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqLakPUc4cn3gnDtIMKwmZN9DKLnmygvZq3NF+UYSy0=;
 b=gq/rgNeC3Q7O1PEGng1QfYpe48H08yGfBo85/a32UOJEs/9s92J+4dpNjAW0L1S64+TxU9BPgfp8S81eiCNvjnD5DCpoOBCDmPaScp2ksCb8Yf1aHbwR5Xmdbl6UBoh/uUWLh8z5CNcKTi7ZZbsnnTZsqR1c/visnU4D8lxmeBE=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1757.namprd22.prod.outlook.com (10.164.133.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.15; Thu, 10 Jan 2019 18:24:45 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 18:24:45 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     YunQiang Su <syq@debian.org>
CC:     Paul Burton <pburton@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>,
        Yunqiang Su <ysu@wavecomp.com>
Subject: Re: [PATCH v2] Disable MSI also when pcie-octeon.pcie_disable on
Thread-Topic: [PATCH v2] Disable MSI also when pcie-octeon.pcie_disable on
Thread-Index: AQHUpxVYS+YSucY4hEqdri6AUUk7laWo1ViA
Date:   Thu, 10 Jan 2019 18:24:44 +0000
Message-ID: <20190110182443.dic3trktlnn23ynn@pburton-laptop>
References: <20190108054510.7393-1-syq@debian.org>
In-Reply-To: <20190108054510.7393-1-syq@debian.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::33) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1757;6:wYxkRQQwHKy/KvMYZqFsVwjQN0xPodNdKZJHgr1HvQRtr9StrNvLb+3XeBQsTOZtnjntuQMp6qJIl3F8k/rUVeouIK+7xgJK9yj9uxvYqXq/mV6KPE+AB6wa9Ej44BqV68clKAkztJVSF7JgEEEMbJv4122lMAgFDjorgVU7T8MeQ9fdKQvc0EH8tWXCcRRiytVQIrvGaM9Fo5Rs+xrRzDkvK4DEQdhWi9RNZLny8u00jxNMBV9435OGIDyO7rdM2WfuLTbtaSd2mW5ZHqjc0aaHA+qjs2mPvaA/6mmZffmifzyBFj+dribO5w0pEsI/QHFNq0HKpJzctJLXPoC/eyAXRzHNPAPShemt5E/VoTO1jQMLet+BF3qYQMlg5Vu16QetAJ6Jid/0lV3Rb1lEOs4LAXiSYpGsTB4ZpYDbinOhe7WCUeKB3OZ6tJrBQ8GoetVL6mXvFqUdo7/dVIAtqA==;5:BoQdIf0taRTuvj733c9UOq+Ht/PJnU77VoDKlxvB+Sh6aO80MN05qx8nie5tAC41fhflUc2d6IuDBiH3p3BkVmYqNYbO9pOTz9ozVnI5VbEjYqpkK2cUFXtJEoGqNJUqrMCRX/JgT2IcaW7LQgewlo92+xaKqGcJWX8HUe1zdrsYlPlq3FgY+8zMNdjVq98vb+j8uiCpdWeSfLi4+VpNFw==;7:xV92dnekvf3RxMqCxDpwhEomKW3Q/b6GP4lVk/WR7JyAcrc3phYx+8lPQAAyKCoxP2jJpS5KMeX7h+GnT6F/N5TRnZYDRAo8unBs2N4i8koQJ0+CJYWfX+ynP/alFQonAGb7S8t5yY4YnYOWrUjUog==
x-ms-office365-filtering-correlation-id: 8854c173-7ce1-4ed5-2202-08d67728e528
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1757;
x-ms-traffictypediagnostic: MWHPR2201MB1757:
x-microsoft-antispam-prvs: <MWHPR2201MB17570715FBC359BF8896BBE2C1840@MWHPR2201MB1757.namprd22.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(396003)(136003)(346002)(39840400004)(366004)(199004)(189003)(81156014)(8676002)(71200400001)(7736002)(8936002)(71190400001)(81166006)(14444005)(305945005)(105586002)(106356001)(256004)(68736007)(478600001)(33716001)(229853002)(6436002)(14454004)(6486002)(2906002)(97736004)(76176011)(66066001)(33896004)(6916009)(52116002)(6346003)(386003)(26005)(6506007)(102836004)(1076003)(316002)(54906003)(6116002)(58126008)(3846002)(99286004)(42882007)(5660300001)(107886003)(53936002)(486006)(6246003)(6512007)(9686003)(11346002)(446003)(476003)(186003)(25786009)(44832011)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1757;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QEW8bVLlDtv4XfWHlHEt0K+V9ef4GGJYRcUYigPQgtR/ohZv1YBP1pdwDIIypQxpAU1H7UBaYhwQPcNkJApj+eTwbyjAfUuhtiQDUX3wLVbu8I73cWh7Ts0Ecydd366smYtYpEyW4Xdje0UHvGMsbBeHTHX4I2IWUiR/MzbhGj/kONgjB2of0IIE3oF4JzUcivLdxlBIymoPaRsuxmxS9o1Qt4NJtYLE9/f43Yx+sCAZBXqjAWU5KdR1iepu75U3cb7ixq3m00EFg6Loukzd58n/GBAH3w307hBonF8YMEp9nyXFCjewd4FKcMebm1q84O/KJu5ouP7th7g83BP7ZRj+EQM937G+EYATlLuzrc+slexs/nY2Keu5Wi5AFsQoQL6eIAVyZHk3I7E2OL3zwL9ER2OhH73Eu2/Re7CGF/MZWvJTv0a0LZ00ru+ac/AwTVpoPPMTrocBWc8KWkvkEw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7E305AA8DABC9547B4055CD301BDA4EE@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8854c173-7ce1-4ed5-2202-08d67728e528
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 18:24:44.9676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1757
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi YunQiang,

On Tue, Jan 08, 2019 at 01:45:10PM +0800, YunQiang Su wrote:
> From: YunQiang Su <ysu@wavecomp.com>
>=20
> Octeon has an boot-time option to disable pcie.
>=20
> Since MSI depends on PCI-E, we should also disable MSI also with
> this options is on.

Does this fix a bug you're seeing? Or is it just intended to avoid
redundant work?

If it fixes a bug then I'll apply it to mips-fixes & copy stable,
otherwise I'll apply it to mips-next & not copy stable.

Thanks,
    Paul

> Signed-off-by: YunQiang Su <ysu@wavecomp.com>
> ---
>  arch/mips/pci/msi-octeon.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/pci/msi-octeon.c b/arch/mips/pci/msi-octeon.c
> index 2a5bb849b..288b58b00 100644
> --- a/arch/mips/pci/msi-octeon.c
> +++ b/arch/mips/pci/msi-octeon.c
> @@ -369,7 +369,9 @@ int __init octeon_msi_initialize(void)
>  	int irq;
>  	struct irq_chip *msi;
> =20
> -	if (octeon_dma_bar_type =3D=3D OCTEON_DMA_BAR_TYPE_PCIE) {
> +	if (octeon_dma_bar_type =3D=3D OCTEON_DMA_BAR_TYPE_INVALID) {
> +		return 0;
> +	} else if (octeon_dma_bar_type =3D=3D OCTEON_DMA_BAR_TYPE_PCIE) {
>  		msi_rcv_reg[0] =3D CVMX_PEXP_NPEI_MSI_RCV0;
>  		msi_rcv_reg[1] =3D CVMX_PEXP_NPEI_MSI_RCV1;
>  		msi_rcv_reg[2] =3D CVMX_PEXP_NPEI_MSI_RCV2;
> --=20
> 2.20.1
>=20
