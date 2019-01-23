Return-Path: <SRS0=SfrM=P7=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D550C282C3
	for <linux-mips@archiver.kernel.org>; Wed, 23 Jan 2019 01:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B47220868
	for <linux-mips@archiver.kernel.org>; Wed, 23 Jan 2019 01:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="LAoUdvmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfAWBex (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 22 Jan 2019 20:34:53 -0500
Received: from mail-eopbgr800110.outbound.protection.outlook.com ([40.107.80.110]:44341
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726814AbfAWBex (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 22 Jan 2019 20:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8gUcctjC/Q8jxLvul+fJAvhyAcVt4KtdBezKyuqpic=;
 b=LAoUdvmohn85VR8UtrqWgORCCgYT4kAeCDdBHdlQyXtqyrVyQUsnwwwmOTotMp/zzq+kiETcGBXuaYK3DPFpRcPjY8kgVBNVqZLtkhSwjr1SHVdOtHQuuPft/ctBJmNdcES0iUqaWsEy805QtnVMhmzgKsg+TfC0Ak3TjYX3LiY=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1287.namprd22.prod.outlook.com (10.171.216.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.30; Wed, 23 Jan 2019 01:34:50 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::f560:2a93:e4fd:f50e]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::f560:2a93:e4fd:f50e%7]) with mapi id 15.20.1537.031; Wed, 23 Jan 2019
 01:34:50 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "keguang.zhang@gmail.com" <keguang.zhang@gmail.com>,
        Paul Burton <pburton@wavecomp.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 3/6] MIPS: Loongson32: Revert ISA level to MIPS32R2
Thread-Topic: [PATCH 3/6] MIPS: Loongson32: Revert ISA level to MIPS32R2
Thread-Index: AQHUslNEJQl1bWOFwkKm0fTgc08hgKW8EwAA
Date:   Wed, 23 Jan 2019 01:34:50 +0000
Message-ID: <CY4PR2201MB1272E213AD831A2E7AF9D635C1990@CY4PR2201MB1272.namprd22.prod.outlook.com>
References: <20190122130415.3440-3-jiaxun.yang@flygoat.com>
In-Reply-To: <20190122130415.3440-3-jiaxun.yang@flygoat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR05CA0104.namprd05.prod.outlook.com
 (2603:10b6:104:1::30) To CY4PR2201MB1272.namprd22.prod.outlook.com
 (2603:10b6:910:61::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [96.64.207.177]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1287;6:XSvFYJwxWuuym9YVvEClNL7zTvU0CU3bp+lAHH7jNd+ARcBvOKnPFetwi6MIrqq6jcvZtxUEZqDCVhq+0lcTYuRARVXagJThzJmVoaV3hJKy2AgKLs04+wR2VLnG2MHMhOvZZB2me3DmEZdOsCvOmQgeAl4enlRqOTmrv4ShMrRZTBEPLpUA/F9ncQM4fDGysoLy6hbJ8lD3oUJaWJOXve81N2ETKjzs09nLCyTI6Ufg9gwCzVYayBFzlifyUrJu8gqw3tDhLLaEqZ+IUsiuT7DmJ0bAQjpnTiA18KpOb/2weKMQJ+If4Dgu801pJH8zDiLVxmwGKG5aQdhDr+jcGmnxGHHYY30Xze8KABG1LxhxH/MlG+i0/71i5UgxhEs8mvwcjrJkoMruBz02+uGspURAAPAKemMLUqOTFP4hiIlxiZdj9j8BC40XOextXGh/hi3nibZUpuUwHKjLbFTE4Q==;5:7Y+CE/eJxiodrAzHcvp8bPdC0XGFB8SKHzrEqPQFOVeFcX3IUvEvKwhg+H3iFf2PIUcOEzOlFbDMpi213vsUc1Zqu7ExVqiGEWl0G9FpF0HzXeHGniM/43nF4FRhqlloRWNw8laobHYLu2TSmXYDOhfTNJV4PrnvPPqVEbQe4fmYxS37IBOu8kq5xZZxBNPmVPHVydvqNjqh0yayMGeCqw==;7:wCwFeshbLB/c18H8LCxQV8xxNHwVCFHDqg4qPPom8tEreheq4XtvEX2Jb490Mv9CQ+zQNoj/WFfiCQMDDvn093q9Ex7C1yWzSnOsrsUjs32X6Ml8IZPeJW+sbuDVrkgHfMPl1ILCdldHBGpT2ap5mQ==
x-ms-office365-filtering-correlation-id: 01e984c8-b3f7-4d33-bae3-08d680d2f78d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1287;
x-ms-traffictypediagnostic: CY4PR2201MB1287:
x-microsoft-antispam-prvs: <CY4PR2201MB1287F3DDE35F0122E066C7C5C1990@CY4PR2201MB1287.namprd22.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(39840400004)(366004)(189003)(199004)(11346002)(478600001)(102836004)(8676002)(386003)(26005)(25786009)(97736004)(316002)(81166006)(8936002)(186003)(81156014)(14454004)(6916009)(229853002)(7736002)(71200400001)(71190400001)(6506007)(305945005)(6246003)(446003)(2906002)(33656002)(39060400002)(476003)(53936002)(44832011)(74316002)(486006)(4326008)(52116002)(7696005)(105586002)(6436002)(106356001)(99286004)(4744005)(9686003)(76176011)(66066001)(3846002)(55016002)(256004)(68736007)(54906003)(42882007)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1287;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VqBSv2RHfU4S9gQ1UfJmG9qk7FNps60sHOZtv6OfvhFQmaCVadGsdatDBEZrxaVaYZ9eFqS/niyjZzI9Sb/BL03G4ggPSQAnkEawHiswoEIRZK0XznUL5E+5hSs+7XFiCIwr/t7ZHd6nmFO9Cx2ppwAs6OvBXnkTAL2nvlbR4E5gtzj19gborA2kJm35TTL3xd4K9+Fhk5Sug2xc6/lO72/74vt7CwlLZtZShaJXzo4flZBD5DzUFlg1A6fIaSaoHMIvhcPnL+pAEdYIrTCf71ALEEO2t7ZVrJlAL1z/9D7tpyz384+LWnWeZ6/oqJkNP8eUiOJYewLUQbwnRvnlXb7dc0lGYiXUnt9h1VzHwSfu0ZV7C1BlFeoXht7b4IsKp16zHiMrSTfxgJepq9IEtGcEibbPsFdM3k5hnMfKuQE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e984c8-b3f7-4d33-bae3-08d680d2f78d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 01:34:50.2533
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
> GS232 core have implemented all necessary mips32r2 instructions.
> Serval missing FP instructions can be emulated by kernel.
>=20
> The issue of di instruction have been solved.
> Thus we revert the ISA level back to MIPS32R2.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
