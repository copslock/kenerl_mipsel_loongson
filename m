Return-Path: <SRS0=DhUk=RA=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC906C10F00
	for <linux-mips@archiver.kernel.org>; Mon, 25 Feb 2019 22:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3C0213A2
	for <linux-mips@archiver.kernel.org>; Mon, 25 Feb 2019 22:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="hWgw+eyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfBYWT6 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 25 Feb 2019 17:19:58 -0500
Received: from mail-eopbgr820127.outbound.protection.outlook.com ([40.107.82.127]:6221
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727357AbfBYWT5 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 25 Feb 2019 17:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zcwj0Z5isjtPAVwPQDhqfDzyQWVeuhsYG8ysC4O7o3U=;
 b=hWgw+eyALkorl0MUHPocbPlD2vKX1tw1wZ+IpTr8voH6XQ2lK0Y4M0TVbtpmAI+TbYUEH/DovK5GN1FQ94+zLV2dbu7L3oxOmikA7UbHmir0o9fsTLJahYKgcgGI3OI2xUjU/xc+e2mmwJmVYUNu2ksPgEPwxoTJXzKyKixkcuw=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1264.namprd22.prod.outlook.com (10.174.162.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Mon, 25 Feb 2019 22:19:53 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 22:19:53 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
CC:     Paul Burton <pburton@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "john@phrozen.org" <john@phrozen.org>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: lantiq: Remove separate GPHY Firmware loader
Thread-Topic: [PATCH] MIPS: lantiq: Remove separate GPHY Firmware loader
Thread-Index: AQHUyusuY1+5MaWgt0iGXGN4wZ6W9KXxGpsA
Date:   Mon, 25 Feb 2019 22:19:53 +0000
Message-ID: <MWHPR2201MB127707BA7F4A45AE606E803BC17A0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190222201347.29242-1-hauke@hauke-m.de>
In-Reply-To: <20190222201347.29242-1-hauke@hauke-m.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0108.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::49) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee8e2f1a-993a-4105-2dbc-08d69b6f5d5e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1264;
x-ms-traffictypediagnostic: MWHPR2201MB1264:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR2201MB1264;23:Ot4iORW1FFGb7wdHyFpWLdVKrdIQ6i/T5ftqZ?=
 =?iso-8859-1?Q?/d3sbS5DTx80XccnEitY8m0DTIBIj0tlhAT2xcfwiQqZX0Qh/iaB2OXXvP?=
 =?iso-8859-1?Q?Rwb4g690j+cfIwkDBh0fd+5Whpar3cZyFBPU/neFtsswPo9ALF33cRaFk2?=
 =?iso-8859-1?Q?EXuX92hmkPMN04y4qACSIChhxXdkrbPjHQL7zANH+995rtJFGMMaUr0j92?=
 =?iso-8859-1?Q?eK5ak3ODG631BpjFDrbtI7cl5YBMutNu7PQz0SJmZUSBdGPNYusMxsafTC?=
 =?iso-8859-1?Q?JM6/rNUuae6kROGIX2PoM1hTJgSKl3SKgDDxfhD0NyahWY5aK6VvfBqHQ6?=
 =?iso-8859-1?Q?r0Y6Fp6fKGjRpnKVMi3eURj6KyAdABO3w319DQfZV+C2JvedCSzIB43VOp?=
 =?iso-8859-1?Q?yzIqZcE1+0H2nnD3MFDqO5vXJGdo9Hkszd0Avr4IDPGg2PlE6YOerfxNsQ?=
 =?iso-8859-1?Q?RgKFKeSdE9O1qp2G0XJH0g8kBKJp9IwJct7LY88fAM3zZkdyZfZjP7/rK+?=
 =?iso-8859-1?Q?yzlhMIb5yjpfYloVnUldsT58fylFS70iaVy874tB8Y9TMGRplGJZ5iculp?=
 =?iso-8859-1?Q?Ixyu9OO8Iu2//dNgYs2PRlf1Ey4gZn9LAG1mU9MGkwx9TXtuRhAeo8teca?=
 =?iso-8859-1?Q?24uViWh0JyAUZWlGoMQq+KVsXJAFURIdoqle5hgo/7F/EunxunKQ2thgkA?=
 =?iso-8859-1?Q?IYBxTPrdRKhlDCHd/DW+0Mnlv1Vidb3Mom/6IJZZySJQLwfdDeUs7qqsAm?=
 =?iso-8859-1?Q?TwYM3DVtIZPCTtJTFgzd/Kd67ppNH0mLkGGQu0KNPWZMfVt3yaq3a778Yp?=
 =?iso-8859-1?Q?wRsWOl0YDKiCW0EiaHxg+g+lQpG1bnuIt62T24WqaFXOrd3K88aHgZ2hgp?=
 =?iso-8859-1?Q?7Fbhgva9ayifL5bwlbp29CKXt6q26QRMQlRhbIfCY58A4me8MEJloWaFdX?=
 =?iso-8859-1?Q?kxXVV/1Y7IqVbCAEApG0m/F2jvio/e92C/OllQFudzK/BSZU/8mJum2hYI?=
 =?iso-8859-1?Q?9vineb7QnsN9MyXvgtrUzFBNp3pz30n3aM+FelgJqAPd1htg0T1U3VVIP9?=
 =?iso-8859-1?Q?rH4fC2S4Gp2nJwTdHzAXxJYt7/tK5OTiAIMriulUede67JGLe11OhFLslC?=
 =?iso-8859-1?Q?gvxbtVAFeP2KivD3b87zi+e6Xc7dPKvsdkmFOxUYFBwC7EKh/VMEVPZcJo?=
 =?iso-8859-1?Q?Y2xWxGYSaIshBeR6QeuTAldm0Z68N0x6kfluf3aMl53oY0q/GupTFuiLjS?=
 =?iso-8859-1?Q?Kq6j381tzEbe1HltAdnHQhebkC3CA5iGVo6NrYnHQZHtsC+I+p34ShlXye?=
 =?iso-8859-1?Q?8O/T2gsKwysetVJzOzKG6I/G4idW+Be8yHpz6CWy4i0C/1lxvpKoiUtqTQ?=
 =?iso-8859-1?Q?BqeYjnyBLg=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB1264CD50E9676128569D7E11C17A0@MWHPR2201MB1264.namprd22.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39840400004)(136003)(366004)(189003)(199004)(305945005)(7696005)(52116002)(486006)(42882007)(316002)(54906003)(7736002)(256004)(476003)(106356001)(74316002)(66066001)(76176011)(53936002)(446003)(11346002)(6916009)(44832011)(99286004)(55016002)(33656002)(105586002)(97736004)(6116002)(3846002)(478600001)(14454004)(68736007)(8936002)(6436002)(52536013)(81166006)(81156014)(4326008)(229853002)(102836004)(25786009)(8676002)(4744005)(6346003)(6246003)(2906002)(5660300002)(71200400001)(71190400001)(26005)(9686003)(6506007)(186003)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1264;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JSg1jCmShpYP3zHsJeiLxNrYz2hV692LyhFzwJCZGwthw2siqLt0jvG2TOAYKlnyhO3GWi/WFizumAE4KcJ8XfDb9sODMVnT8YG1bap8oYbIpe1aRvCtmovxCvqAfZUAedN9rpXqEKrchM0S+EXRGMCkVRCcN3rMPYy55tYA1CiG7jjDTfRJvNZaaXBJYJmOSc1fqIOAHb2cfrDW8PbcY7ldd7lfqT2cd056XHaP3NBuTQz8xfgBuMdRc6JBND/DR7u7i/IB5QeM/cZESzlFYk8QdxlpFpdEvRAbVwQ05gXic+UZr49w0shTuS9+rq0iAwF4pgtY2p7A5P3sRyz9aJOT9Nx5sRAlwlbZXjQw5F0jauIguc0k1SIylpxUN7b/Gvq2nRAldJY1ygf4m0BX9FTTtHtM0lTeFhaCyBloev0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8e2f1a-993a-4105-2dbc-08d69b6f5d5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 22:19:52.7890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1264
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Hauke Mehrtens wrote:
> The separate GPHY Firmware loader driver is not used any more, the GPHY
> firmware is now loaded by the GSWIP switch driver which also makes use
> of the GPHY.
> Remove the old unused GPHY firmware loader driver.
>=20
> The GPHY firmware is useless without an Ethernet and switch driver, it
> should not harm if loading this does not work for system using an old
> device tree.
> I am not aware of any vendor separating the device tree from the kernel
> binary, it should be ok to remove this.
>=20
> The code and the functionality form this separate GPHY firmware loader
> was added to the gswip driver in commit 14fceff4771e ("net: dsa: Add
> Lantiq / Intel DSA driver for vrx200")
>=20
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
