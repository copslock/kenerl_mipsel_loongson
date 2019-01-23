Return-Path: <SRS0=SfrM=P7=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F9EC282C3
	for <linux-mips@archiver.kernel.org>; Wed, 23 Jan 2019 01:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B2820868
	for <linux-mips@archiver.kernel.org>; Wed, 23 Jan 2019 01:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Pcc45s+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfAWBeu (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 22 Jan 2019 20:34:50 -0500
Received: from mail-eopbgr800108.outbound.protection.outlook.com ([40.107.80.108]:49478
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726814AbfAWBet (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 22 Jan 2019 20:34:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNA6Tmhj7gnP6qqIQRuTQyEUaQcXfFO6ttsfSAY529I=;
 b=Pcc45s+A57isV/MxDkZkhLz0fHSEoLQq0hP3LdF/ZJUTyCaq9q4d6pTn0ssWF/iW8LJyl8CGdw93HYYTB7pFEeA6PzEndqe/vM4a6XVfBQqF/rYsuKBqYmd2+O39mN5ractD9bQzm8KocxzYmeJGjnxE2aEuzMRcYRZMWXUt6Ao=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1287.namprd22.prod.outlook.com (10.171.216.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.30; Wed, 23 Jan 2019 01:34:47 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::f560:2a93:e4fd:f50e]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::f560:2a93:e4fd:f50e%7]) with mapi id 15.20.1537.031; Wed, 23 Jan 2019
 01:34:47 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "keguang.zhang@gmail.com" <keguang.zhang@gmail.com>,
        Paul Burton <pburton@wavecomp.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 2/6] MIPS: Loongson32: workaround di issue
Thread-Topic: [PATCH 2/6] MIPS: Loongson32: workaround di issue
Thread-Index: AQHUslMr3zYjjhdNfUi8nqj6Gf3emqW8Ev2A
Date:   Wed, 23 Jan 2019 01:34:47 +0000
Message-ID: <CY4PR2201MB12725DE7236BE7B0EB8EF81AC1990@CY4PR2201MB1272.namprd22.prod.outlook.com>
References: <20190122130415.3440-2-jiaxun.yang@flygoat.com>
In-Reply-To: <20190122130415.3440-2-jiaxun.yang@flygoat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::37) To CY4PR2201MB1272.namprd22.prod.outlook.com
 (2603:10b6:910:61::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [96.64.207.177]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1287;6:v6Mq96fR5ap16jH+j6t9c07KPK88wXYTbeDDNUWAux9dbsdky/HdQ2R5eQECuuAj6SOcyLDTboNBC/WJ/6LCCmcUB9MQWj/A5Qcd1mUmz4OXN5bnKhI4r2QdEVp/gXGgZ10kXVfnClYxFoJJB1xzCFhP6XPDSc2ElsecGLqyDH7FvTsTxjScuCf43/ddOSH1o2LdHBIHaSxVUZYFP6L9FGdUPOyI7XIx5imdSnE61M+4EsP24bBIwDfwuDS1m+TFnWDJWpubHfsQ65gPn+neVlYL8SdpnzqJdfaHE6rowiC7p0qGVowvy95C5Bvof065ipBHmhSkF//j6Um+chUARIu6zGDjMf1mVziFzB0oIYuOQi3qYSFu/gTOJWzpMW1g4JnEmsJ3saX5KTpeFF2j9DDBK24VkYesOmgjQN9HTfZNvlMdvBvW1wjLgxzMHfyXiQolcA3DQBXgrqBeHpgs5A==;5:jroloIsuNGZbbQbdsB9ODW912STIt48VkX5nzMeMydUMv+VpKauPKWlJYgO5ruw6CkUzOdIORiFIsb02xOSIlRTSSgeeLfyE0DipPUxrQar44Nm3K+qV1K1FQAdT/RhiKZ1IdqzjSSkWOCM8XQKhXtq0oVtl/UFO7/Vtx1PpGxA1vhlHmwF1aOp7elAxvshAWRZgA40fMs2M9+UFpLU/pw==;7:SIZi3XSQa3rfnZewDKli8tv5Quk9y7MzRToCMsqrZ6ryhN6IXSVWSjVS+dpwLXBVFsuWGVKN5rHvyyoJG8rhoiZq9r+ypfEPvfo2iJ8HOaijznIFYU0eqJxUWD280k0I9WgvAYlQJzCYOjh1UwryCA==
x-ms-office365-filtering-correlation-id: 5795e5e9-4cc4-49a7-df34-08d680d2f591
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1287;
x-ms-traffictypediagnostic: CY4PR2201MB1287:
x-microsoft-antispam-prvs: <CY4PR2201MB12870EB1DD0F885D66092AEDC1990@CY4PR2201MB1287.namprd22.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(39840400004)(366004)(189003)(199004)(11346002)(478600001)(102836004)(8676002)(386003)(26005)(25786009)(97736004)(316002)(81166006)(8936002)(186003)(81156014)(14454004)(6916009)(229853002)(7736002)(71200400001)(71190400001)(6506007)(305945005)(6246003)(446003)(2906002)(33656002)(39060400002)(476003)(53936002)(44832011)(74316002)(486006)(4326008)(52116002)(7696005)(105586002)(6436002)(106356001)(99286004)(4744005)(9686003)(76176011)(66066001)(3846002)(55016002)(256004)(68736007)(54906003)(42882007)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1287;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kQSOvtBed3WannReR9bXv97fdM9zl9VaMQkK714ei2X87KvoRKg8Uj8Pmui0vZUbtPjG6+2UJpskyAkOObpF40j2SxFZgwLOvQdg5WDUR3+VNGv9oWwONg4go2FiuKZ9r1Xs021/aGnykClhO1EoHQ5wqFP3XI/En1K9wtiUKb8A+Hk2Laj3v+wGfIN8fqB5BcTjD4IPA9+2ln0UTjlZjnN+slsTkf7WK8B+lnQ11RNqv7vtJDnDbkcz5JSXFXVAibrV1Ub4HC5sdybcWpJzGMDaPZIoFxEwf78s910NOX0AuowCzeGcheaA5t9LEWhRM7FajqbxXEXjiOUAlK1Vg4Q6eJPpA4oCeczrvVOIiOwEzrcv3Qj5pAiIgOPc/obuCLZlDX3BPe0SfQ2dEnjhWFk8SZoPSoeYBXeHasFCJRM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5795e5e9-4cc4-49a7-df34-08d680d2f591
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 01:34:46.9406
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
> GS232 core used in Loongson-1 processors has a bug that
> di instruction doesn't save the irqflag immediately.
>=20
> Workaround by set irqflag in CP0 before di instructions
> as same as Loongson-3.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
