Return-Path: <SRS0=SfrM=P7=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB674C282C3
	for <linux-mips@archiver.kernel.org>; Wed, 23 Jan 2019 01:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B7920868
	for <linux-mips@archiver.kernel.org>; Wed, 23 Jan 2019 01:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="PCRh2y1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfAWBer (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 22 Jan 2019 20:34:47 -0500
Received: from mail-eopbgr800092.outbound.protection.outlook.com ([40.107.80.92]:16352
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726814AbfAWBer (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 22 Jan 2019 20:34:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p79ujkmuRxhMXxCfoUA/f7d38rmKGX8f28dH0tvHbJs=;
 b=PCRh2y1SFEU4QfM5Xn7u7oLWDCOXojl9pNM69Wzg3GbkF7qRL6DxVbDh9b7OV6TXcZodOt84gt9eMSecCszgif5qmYjyBqOR+aZR/mkAuseTmzAuXdw4lZuXwG8/692P0aVlpk+N9hnLJwqTkIflTEfZIxzruHBvTguEgPqE1/Y=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1287.namprd22.prod.outlook.com (10.171.216.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.30; Wed, 23 Jan 2019 01:34:44 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::f560:2a93:e4fd:f50e]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::f560:2a93:e4fd:f50e%7]) with mapi id 15.20.1537.031; Wed, 23 Jan 2019
 01:34:44 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "keguang.zhang@gmail.com" <keguang.zhang@gmail.com>,
        Paul Burton <pburton@wavecomp.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 5/6] MIPS: Loongson32: Set load address to 0x80200000
Thread-Topic: [PATCH 5/6] MIPS: Loongson32: Set load address to 0x80200000
Thread-Index: AQHUslNT5I6nf6DM5kyjKVp3RUSxyKW8EvqA
Date:   Wed, 23 Jan 2019 01:34:44 +0000
Message-ID: <CY4PR2201MB12720B98BF0225DE7A85390CC1990@CY4PR2201MB1272.namprd22.prod.outlook.com>
References: <20190122130415.3440-5-jiaxun.yang@flygoat.com>
In-Reply-To: <20190122130415.3440-5-jiaxun.yang@flygoat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::30) To CY4PR2201MB1272.namprd22.prod.outlook.com
 (2603:10b6:910:61::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [96.64.207.177]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1287;6:0+V0gd94GQc6BQ2ckn0kBBRWh1shtUaI9LkkFK5kN5Ct1c6g0RyLcxxgrTfvQKQmL3DqLYQwKUXDEQS0eWqhAaYCoIyDttqL/L3nz7AHaIthPwEpuOBehXmZ5rath6M1q2N/FPTO8dlY7u6PmCAOsyT+YMg5UtSN3jLsp1ZHOY/PW2d0jLx8HZga0eHitSevBbdVDpNdJjP9NcneZCvZb2z84DOupbvF+NFgxuh5cP2rhe00dLEfRgXmF10Gojpn46AGxq4hn2k7MGAjL3LFGZ4qDhZjv8uA68IO32Tb5r3WFeLo+FXLJooyBDAbQR+G/G4Tzw25TXA0Hhk79Jo73WsDa0QIyjuprUtQqQbKFH3Z7gf1pZ+IrgNDXk705ohhfCmbzlnZme9e2DFyATjnYu34kFTToH1DWEAvG3T6K/iUdzTMkNYNW/9sxZuBFvN+vZ4G1Qv9tzuYgI9Qz2Yx1g==;5:2CmjBSrdWbstdzSnrhSvh9G+rqdMUZ2FU1X3r25TZ07PNtDfNVdP5dv0lhJNTdojDu9qPObsEQ2fi10MaIwcGDc3Mo3LVFLsSZ7X9MDJ+XFfmoA/gS0D+Nyee6Nk8sIfqauWcfk4+585WQy2IQnVaEnXYPkBVMbS7Lp3ueUclziVNHttdzFZitoGHS4qT1w9tRIzRvfl23WrJLvfQpbYQw==;7:InH8/xqNmU/VAYp/2pZ2X/bc3IKZ4czoCFnEtftRLcpzsTqT+SWl4Hh3jf1yO+9oF7GYdaqjcaZCnKPsQLA5iZ7Dr5zDnEmjrTXP/vqynR7iIXhsA4ZABEH4vEX/mUjfqBZeiOyU6XMmimEnoor4xw==
x-ms-office365-filtering-correlation-id: 118f805c-b0bc-413b-c49e-08d680d2f3f7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1287;
x-ms-traffictypediagnostic: CY4PR2201MB1287:
x-microsoft-antispam-prvs: <CY4PR2201MB12875E56A6AAEA2FAF243D8DC1990@CY4PR2201MB1287.namprd22.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(39840400004)(366004)(189003)(199004)(11346002)(478600001)(102836004)(8676002)(386003)(26005)(25786009)(97736004)(316002)(81166006)(8936002)(186003)(81156014)(14454004)(6916009)(229853002)(7736002)(71200400001)(71190400001)(6506007)(305945005)(6246003)(446003)(2906002)(33656002)(39060400002)(476003)(53936002)(44832011)(74316002)(486006)(4326008)(52116002)(7696005)(105586002)(6436002)(106356001)(99286004)(4744005)(9686003)(76176011)(66066001)(3846002)(55016002)(256004)(68736007)(54906003)(42882007)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1287;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: D13epFOxjfoDGRPwQMinFthIVHoYwPWjX1u4MJKFNrZ2vbD7WDHlTGZV3WhlyABjQ2DNnJ7fIap6lZYJzaVwKhR2C7IdboVCSIlgBeiqlAxz0tO/rn7rQLirhtZSHEcvE3Oau2S5bGEpW7IxGEFCa5bfqhFiJ38a51ubp3dMTTei77V6A5UDAE1yLFTbpwvKEd4IpPGA6Mc2PH6bZ0AucDTLHzm02U6i8tCzeI2/+UqGgXNrUwt82Zxa/viM58rMU1QabC69DTWO2+mekFMf6wEGCp523lPfl6gu5FTjUMlMPeS6AZHynXfW100E7aVINX3tZyrFBixaIjn3SoDPHm0UkqQSd/vdXslDFo+FY2+JlOYiM2xof1iWUBJ5htPeYo/thOLBUulRmcr231p57KHhRktgZ46hXrGKb5Foia8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118f805c-b0bc-413b-c49e-08d680d2f3f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 01:34:44.2842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1287
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Jiaxun Yang wrote:
> PMON bootloader on Loongson-1C will use memory between
> 0x80100000 and 0x80200000 as stack.
>=20
> Use 0x80100000 as load address may hang the bootloader
> during loading.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
