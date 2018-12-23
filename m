Return-Path: <SRS0=3MQT=PA=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C56EC43387
	for <linux-mips@archiver.kernel.org>; Sun, 23 Dec 2018 16:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B402184D
	for <linux-mips@archiver.kernel.org>; Sun, 23 Dec 2018 16:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="r597JGDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbeLWQRB (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 23 Dec 2018 11:17:01 -0500
Received: from mail-eopbgr690108.outbound.protection.outlook.com ([40.107.69.108]:33041
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725832AbeLWQRA (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 23 Dec 2018 11:17:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JzWMBJy/KNZgmyzJ4iJEdJ2v29Hz6ADw7b3ZVm43Pc=;
 b=r597JGDGM2H+0j4YHatiHItxaJOLZ9P/9txIo2ITmG4aOXR2Wd/tgqtJ0APXvHfMUi5FIlPa8HPcslQZEhwxdq8DuhKfiRh8FA573ik+dfjCCM1Ja2C7ud229bf2ikta99QH/IgOjxF0gP+yMYR/K5KccxhZ8Tn+943196dr1N0=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1102.namprd22.prod.outlook.com (10.174.169.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Sun, 23 Dec 2018 16:16:59 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%9]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 16:16:58 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Manuel Lauss <manuel.lauss@gmail.com>
CC:     Linux-MIPS <linux-mips@vger.kernel.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 5/5] MIPS: Alchemy: update dma masks for devboard devices
Thread-Topic: [PATCH 5/5] MIPS: Alchemy: update dma masks for devboard devices
Thread-Index: AQHUl2mdR66vvkL9IU+qG8jdXSnQtqWMhwAA
Date:   Sun, 23 Dec 2018 16:16:58 +0000
Message-ID: <MWHPR2201MB12775D6827BDE737DA84941DC1BA0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181219070803.449981-6-manuel.lauss@gmail.com>
In-Reply-To: <20181219070803.449981-6-manuel.lauss@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::17) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.197.89.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1102;6:2KKzSOLD0+8zKHfl2nblv0bLtJeEN3ZFcbfv7deZvpng8wTcaC2O8ToZQzW+AabZ+QhdWxFNlYSJbffdHtSQA5yJ8enOn8l7kDIHTLzbf8a0YId/MOGiuN7u5LFBSaD9D4Ai+Zz+SiNd0jW7bj+e+o0MEOoGCyDprN5J9ocx0mVenjjrMn4hVEPNEf0sS69I2IPM8qqIo7j0ElQYn0G+tTa1WKp90qelhCL8yn0gWEOAZ9VEymeMi17s43WSayTMlUYGq13VApjNPa3hr0H3PlemudtdWKbEY45mpePtftzT6G9zG7417Rh7yNiFDjEtRz9ZvDBLFcihmy7pqbbOTVwaloFGjg6VjPL3Z+dVJ6PpTDRWmtyzYx2begA0SEMm/nCAsLgGy+uKH5LLRPbL4J0xjkqOxCqDv3kx1Pw379EEDyVYF3nFKDuFZyn8k2Ty903pKxmtAkC11zu4dTYnyQ==;5:596V8nO6JyRMF+AP1AzgVU9N6ghqbzE++TsD3ZM7V27OesREOQfCsPZT0YQi1VCM5Mc1RY6EtqlFXdVKjapfhGRo4tH6qdv/oEE4ldNoXMTjrA4b/jhj92IoUhSnnXUPBGwFFdcQ8rX3fz0A6AhThoWNpPmtQ0T7ob2EQzCmjMc=;7:wJe8HV0soNuLBbvP25UKr0ZjuEABl6TzquSsMtDJtY7rYZC4MJa6z/Ek4lB7GAXTziHjL7tDRs8gpmFIjR34lmYkxLVKKSqJukW+AyacPWocO2CsTPeKnrbgRiuA/lcScr1DOr0arzvt9muHMrabRQ==
x-ms-office365-filtering-correlation-id: 146aecce-2fba-4bad-a316-08d668f2104a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1102;
x-ms-traffictypediagnostic: MWHPR2201MB1102:
x-microsoft-antispam-prvs: <MWHPR2201MB11022DCA9367DA08FB862F89C1BA0@MWHPR2201MB1102.namprd22.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3002001)(93006095)(3231475)(944501520)(52105112)(6041310)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1102;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1102;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39830400003)(376002)(366004)(199004)(189003)(105586002)(6506007)(386003)(6116002)(71190400001)(102836004)(6436002)(229853002)(99286004)(6246003)(76176011)(71200400001)(26005)(33656002)(106356001)(3846002)(6916009)(68736007)(7696005)(52116002)(54906003)(186003)(316002)(5660300001)(97736004)(55016002)(39060400002)(8936002)(15650500001)(2906002)(256004)(4326008)(476003)(8676002)(81156014)(81166006)(9686003)(7736002)(305945005)(74316002)(42882007)(14454004)(446003)(508600001)(53936002)(66066001)(44832011)(25786009)(11346002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1102;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: beKddV9+t7clLlLj4GJr9rC3nMBuZtRQCn+JTssuholOeowACURFPqZGPZcdSWWeBz+UUcrNfhBwJzSPlDtvHonvvhzDF7g2Vp+Oa7qC5t+3tLE25ebEkmttL6qU4jWAckHnc+JHfxIz92Nx4vt3m9Xncrc10BvbCnhIbR7jP/PvFiFCp8TcDrs/AJHSOC3fgmOWgrGVQoxIe25eDAPOaiEht5JoL7I50POfYwzK+WjyOKNkLlery4cBcyyKlvhQ2MqZRINa/ApdbKRyaOWSNvEW2RKhMiAYeymmvxytetzRccMPHeQKEZcHk1iE64yO
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146aecce-2fba-4bad-a316-08d668f2104a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 16:16:58.7907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1102
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Manuel Lauss wrote:
> Fix the DMA masks for sound and mmc devices.
>=20
> Verified on DB1300 and DB1500.
>=20
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
