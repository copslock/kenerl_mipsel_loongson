Return-Path: <SRS0=SfrM=P7=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41CCC282C0
	for <linux-mips@archiver.kernel.org>; Wed, 23 Jan 2019 21:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22A921872
	for <linux-mips@archiver.kernel.org>; Wed, 23 Jan 2019 21:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="GLXzwhG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfAWVkf (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 23 Jan 2019 16:40:35 -0500
Received: from mail-eopbgr680130.outbound.protection.outlook.com ([40.107.68.130]:44809
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726352AbfAWVkf (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 23 Jan 2019 16:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjY1WzdfdNUoQ+pfa7ZJ4VgnZ2tMLfDMiwlUXaLYPgg=;
 b=GLXzwhG5VRFu1aq+PrEx1TgrLzdqLyVW21Uaw1dzOSFVG+rH/9Zv0HJHapBCXqGCsn8YE3h/r9n75ossylAOX9iNBPv4DFso3Bf9u3/N4VRRHdRi4SOAtCzUfPx72KDrmHpIuKf5OmpIeg52dhDNQZS3GxmMFM5+5tJRAgVm5iA=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1311.namprd22.prod.outlook.com (10.174.162.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Wed, 23 Jan 2019 21:40:31 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1558.016; Wed, 23 Jan 2019
 21:40:31 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
CC:     Kelvin Cheung <keguang.zhang@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/6] MIPS: Loongson32: Remove unused platform devices
Thread-Topic: [PATCH 1/6] MIPS: Loongson32: Remove unused platform devices
Thread-Index: AQHUslMkvVtYRodDHUajofYGd9LUmaW8EuYAgAAfLYCAAAP3AIABLdAA
Date:   Wed, 23 Jan 2019 21:40:31 +0000
Message-ID: <20190123214026.lhpu5bvxa3voul45@pburton-laptop>
References: <20190122130415.3440-1-jiaxun.yang@flygoat.com>
 <CY4PR2201MB12723EF92091D72E29C5B2A6C1990@CY4PR2201MB1272.namprd22.prod.outlook.com>
 <CAJhJPsU1DPBp6it0agNrDfLpQGRV0c45mH6mTi=wcwt0OZikkQ@mail.gmail.com>
 <32183566-60A0-4652-8B75-2CDA04208EF9@flygoat.com>
In-Reply-To: <32183566-60A0-4652-8B75-2CDA04208EF9@flygoat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::41) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1311;6:ou1A2a6dBITH9g+ytv/mSGJgYRcdwPAtqTFQzuf+G2RotzVTGMWdo/MA7ubFgDuj886Ldfd9G5nPpvipctsTMQSqEZ5WIe0kGWOkM0WNqpR9NlkDRG8hg5d7424HoJr1wbxQV/d5zEGDeEsHZiOM3w7hXlKj6APdRbix8JFaH0zxeoKDa/JJRqmcxxW0/Cnc3+VfYo6MrgUYaUChS3VP7oyGD6eXkSiASqLGm0Y31wysRLzzvNxR4b9ldN8uzDrHvh1w9HW1lIutLvXWrNkD1u0awiKzvOQAzJgYV6QlO1DP5XQHNn+u7j+j1SgErPcZmN/LoWqUYuD5wRRdfWyQXhT42HtWMOozcS6rvn5pSBRIfOYN76pjVEyzSGNMFmMul5KUEIVAZu1yMMlCDRKk/4nlHe/hxbR9MotFU1org3aXRF/za6wFeMSVpwr8jVTGdAUunqONGVSP0ihIz7BSLA==;5:UBoGNh6Rpyy3SDM2l7f8iRauePpzkTk+5BHoMoXtnzZ01gfTdgCArC8cuaXxZeLWm6W9NZ2gg4PxCoBvGWxUCq+CwiP1gx42/Wtwi8hi39Pl78MUGX+2/BD78AuzS4l7yjeGC2VExO81pP27dST7K8z6xODxjU0gbXSgv1C9ThV6qaTzJ59ENLUoohesN+g++Tabgvdsv525x4MeFa3ZAw==;7:EYE4QWBZ6Op7r6wEH8wqnX1GgqoNDN+yPPoQRIQ7LJssvrQ/cEF1NCjuLzScPaK1wRG4byFJ1vsT0qNf+f3WeMvhXMiBiTFb1IuFn3yyYHDvP5hXInm20fQzuDLK0ySO6KuITAXDtbfXg9+ExiK/vw==
x-ms-office365-filtering-correlation-id: 4daf7ca5-5dbe-48ec-049b-08d6817b65b1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1311;
x-ms-traffictypediagnostic: MWHPR2201MB1311:
x-microsoft-antispam-prvs: <MWHPR2201MB131133ADE8C439372D9A4ACEC1990@MWHPR2201MB1311.namprd22.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(7916004)(346002)(376002)(396003)(366004)(136003)(39840400004)(189003)(199004)(54906003)(9686003)(58126008)(6512007)(4744005)(316002)(42882007)(2906002)(71190400001)(76176011)(6916009)(99286004)(476003)(8936002)(52116002)(93886005)(71200400001)(97736004)(14454004)(33896004)(68736007)(53936002)(229853002)(1076003)(7736002)(256004)(81156014)(305945005)(6436002)(6506007)(386003)(81166006)(11346002)(446003)(186003)(102836004)(6486002)(8676002)(44832011)(6116002)(105586002)(39060400002)(26005)(4326008)(66066001)(33716001)(25786009)(106356001)(478600001)(3846002)(486006)(6246003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1311;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Jyx30Sxy/XpH6g6+XCpUlhj39B+lKcRwy/iEVZ7fKSx715Ox/THOsBeqWx9K0gdtmmMExTSKpxNQlQxS+O52n0xaLJXV05ScmZHxmAcAX55LNNOUFvVxmraNGbFxX1yW4Rzksllj7HH8pwVzIlFznI1vv/oOajoJdgH8bja7Xt7QE6opS0BEqu4f9Ug4RLmI+60RiRtm5nWv4xMJv0A0NcML1995xdiWFJ+Dk7UEEAn30CJtVIQjEw65B/8laPRzUMpHpomO5uxD3j57KmMCQb20ZrO0OBTJOzjiVGGYbwZGEKQJu04ruutiea8cxJv7cCLW1+iq5tIvtZUWGYdmC6cT9miK1G7ODMorgtFsIMKZWUOL9/b9V6iLoN2Ov5imbEXVTzlOndzFqV3YPJ/uQ9e0UfAA3aoqnK24Q+PKvW4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9BADA4F0E989ED45B3D700B639657E2E@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4daf7ca5-5dbe-48ec-049b-08d6817b65b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 21:40:30.6095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1311
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Jiaxun & Kevin,

On Wed, Jan 23, 2019 at 11:40:12AM +0800, Jiaxun Yang wrote:
> On January 23, 2019 11:26:01 AM GMT+08:00, Kelvin Cheung <keguang.zhang@g=
mail.com> wrote:
> >Hi Paul, Jiaxun,
> >The platform.[ch] is the common code for both Loongson1B and
> >Loongson1C.
> >And the DMA and NAND device are used by Loongson1B.
>=20
> Hi Kevin:
> It seemed like there are no drivers for these devices in mainline kernel.
> It would be nice if you can submit these driver before revert this patch.

I agree with Jiaxun here - if you want the platform code to be part of
mainline then the driver needs to be too. Conversely if you have drivers
that are not part of the mainline kernel then maintaining the platform
code to go with them should be a negligible amount of extra work.

> BTW: I'm currently working on refactor Loongson32 platform with DeviceTre=
e.

Neat - I look forward to seeing that :)

Thanks,
    Paul
