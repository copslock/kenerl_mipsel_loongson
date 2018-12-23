Return-Path: <SRS0=3MQT=PA=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1D5C43387
	for <linux-mips@archiver.kernel.org>; Sun, 23 Dec 2018 16:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5082184D
	for <linux-mips@archiver.kernel.org>; Sun, 23 Dec 2018 16:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="atdbKsjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbeLWQQo (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 23 Dec 2018 11:16:44 -0500
Received: from mail-eopbgr750114.outbound.protection.outlook.com ([40.107.75.114]:4000
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725832AbeLWQQo (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 23 Dec 2018 11:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhrC1jY/rby1Z/uKvLxes7LlAS36zIt/AYBIUHb7SQQ=;
 b=atdbKsjXamjqnc09RNSn2p40WnP3VH+ZqJnQ5AWpYwmjtKIkQpOCyjd42qSTec0IgwbiMYM9ANSgSn4ZBWm3cnJJAdb9vvNbcKUUIFZXL5DdyzrbTRtn8Sb1C2WSdWBOFog+aOOnB86J/FyRmW/0nY16teGXn/ClKbPPkbdMmPI=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1102.namprd22.prod.outlook.com (10.174.169.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Sun, 23 Dec 2018 16:16:41 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%9]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 16:16:41 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Manuel Lauss <manuel.lauss@gmail.com>
CC:     Linux-MIPS <linux-mips@vger.kernel.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 3/5] MIPS: Alchemy: drop DB1000 IrDA support bits
Thread-Topic: [PATCH 3/5] MIPS: Alchemy: drop DB1000 IrDA support bits
Thread-Index: AQHUl2mdBHd8SkZ9Wk+ZhMDATXAjY6WMhuyA
Date:   Sun, 23 Dec 2018 16:16:41 +0000
Message-ID: <MWHPR2201MB1277C109F58F93272FC4F74FC1BA0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181219070803.449981-4-manuel.lauss@gmail.com>
In-Reply-To: <20181219070803.449981-4-manuel.lauss@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWXP265CA0029.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2d::17) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.197.89.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1102;6:FBtCNvL3QPM6iovJbIQ6pyrKxTSyGgwolA0iqBw5tXZxJCB/xFawMOjLABs1u+MXK7IfGOHVqIJnbIuLgh4uSietCo+6NSa55QTy/yi/VdtkT8a7SLmwo/ZL7bHIq0EnqLhNPZrbj7WJlwDRNB5EMRae8S0LvJmu5tUpsPhrC/te1iCv9UYzBdoyiy2AQ6s6LFWcMlWrikLhJ/F4O3AqAEEiSgDAIZNy5T2YqRw91SRWzPLfzqlfYL0Asb9ycN0wWmi793cYn+ZJnHT0Rxp7rUKcsN48FQh4bUp53REcKn65zrGVe+vQMk8hr49t/8Eum2FgrpXW8bttNHSosokLrBKTOooFpkg/yCwILF6v4Em+WuyDDFw1FR9v20DRagI3kVB4/0zGnRfahinvpkNox5BN2RjwMhoPYu8Uia122lc8vgJMWtbgDlDGL4jniooLBw123wFhC/yjLllp2q8Fbw==;5:AeL4w5EGWvMQ43XYJAmNXmCJYMMoSGrXonbYwby+XzGHA8dBpgn2yZ9jvmI1tjjXRO5BtKnon9dAtECSRie/7i4lHlv/JWOf4m/DQ3SsX2pKD6meytgfeahZS6ZsSMMdSXZangv0+BT0VWxs81dwqmPGCW2IWLQgfnBztdps+IQ=;7:0nQoVuJfVcJ3vJRcHeIikdGEJKWIVAD2Yuk6S0woJeLVS3HZPk8P/L2R7bR4egfto0I4NOrnvTZMjbGkWLMaqobQ/lKeegaIWceaVbHeYVz+aebRg78xaieU5cLDdkC2/eMfcVFk9nk5FGLAmwyryg==
x-ms-office365-filtering-correlation-id: 85f1561a-60e1-43c3-10cb-08d668f20613
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1102;
x-ms-traffictypediagnostic: MWHPR2201MB1102:
x-microsoft-antispam-prvs: <MWHPR2201MB11029332F0AF3B41E90166D8C1BA0@MWHPR2201MB1102.namprd22.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3002001)(93006095)(3231475)(944501520)(52105112)(6041310)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1102;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1102;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39830400003)(376002)(366004)(199004)(189003)(105586002)(6506007)(386003)(6116002)(71190400001)(102836004)(6436002)(558084003)(229853002)(99286004)(6246003)(76176011)(71200400001)(26005)(33656002)(106356001)(3846002)(6916009)(68736007)(7696005)(52116002)(54906003)(186003)(316002)(5660300001)(97736004)(55016002)(39060400002)(8936002)(2906002)(256004)(4326008)(476003)(8676002)(81156014)(81166006)(9686003)(7736002)(305945005)(74316002)(42882007)(14454004)(446003)(508600001)(53936002)(66066001)(44832011)(25786009)(11346002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1102;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RJAqVJvg8Er1Wp2kULds6mv9C7kAC/ejWL+BjRJCmCTDyQwaTJaRat6p2Zn+Ssp8beORKK5rFXoCp1wY/8N7ksdhVTlHPAlDDRBqvqXk+vgmPpyrt0R/hM4ZjQsx4n1VwHWdGvMVC7XonCHSd45JdSCKtYLimELFhFhMqWr/WWVLL6z2Tj2wp4eYGYXKrQn8GX6d6NZ4J8VEHwTdQ7TygrXRUB/QOTabsd8LLvAH+iuBfIjaCdr75Gl3JE/Mirf1Y/7kdz9F7Umr0OhPRfU6m31DQ9vH9Qwbm+mCU+25eC4mQsgDPR6d2k5DTWG7JxRg
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f1561a-60e1-43c3-10cb-08d668f20613
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 16:16:41.5303
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
> The IrDA drivers are gone, drop the now unused DB1000 board
> support for it.
>=20
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
