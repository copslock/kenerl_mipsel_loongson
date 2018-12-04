Return-Path: <SRS0=TQVq=ON=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91957C04EB9
	for <linux-mips@archiver.kernel.org>; Tue,  4 Dec 2018 00:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537D820850
	for <linux-mips@archiver.kernel.org>; Tue,  4 Dec 2018 00:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537D820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbeLDAG3 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:06:29 -0500
Received: from mail-eopbgr770094.outbound.protection.outlook.com ([40.107.77.94]:6464
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725903AbeLDAG2 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 3 Dec 2018 19:06:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkMdIGRaH/7CKrnxkqhaaqKrgYjZUDSA9cuNl3WNAR0=;
 b=hSpXNSUvwmbxZGxHO83A2BOWR7C8nb2cigL4QAn/d3lyL/NimpMn9lz/VIodf4AGrexQy2Pr/Nj+i23g4t7/hJDLBOipFODY52P3fzCLE8kVryeWrthUP8yQarwj00FBVOQBnYZhNPnUT3CD+u9gAxdcP+x5h5PbO6FWZskzTmc=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1488.namprd22.prod.outlook.com (10.174.170.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 00:06:24 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985%4]) with mapi id 15.20.1382.020; Tue, 4 Dec 2018
 00:06:24 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        Jiong Wang <jiong.wang@netronome.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "oss-drivers@netronome.com" <oss-drivers@netronome.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v2 bpf] mips: bpf: fix encoding bug for mm_srlv32_op
Thread-Topic: [PATCH v2 bpf] mips: bpf: fix encoding bug for mm_srlv32_op
Thread-Index: AQHUi1d3/x+GjpAZHEqjuorUVrDYEqVtnCEAgAAUmYCAAAL4gA==
Date:   Tue, 4 Dec 2018 00:06:24 +0000
Message-ID: <20181204000623.6tmqntmxi2dydrlz@pburton-laptop>
References: <1543876074-4372-1-git-send-email-jiong.wang@netronome.com>
 <MWHPR2201MB1277C127DA9E9CABBC6F96BEC1AE0@MWHPR2201MB1277.namprd22.prod.outlook.com>
 <20181203155545.6eb5520a@cakuba.netronome.com>
In-Reply-To: <20181203155545.6eb5520a@cakuba.netronome.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR01CA0027.prod.exchangelabs.com (2603:10b6:300:101::13)
 To MWHPR2201MB1277.namprd22.prod.outlook.com (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1488;6:kiXeJxlt+yupFEOw3pDo5q6fVWWwyohtGXUcDcvggLMtoIr6YbkGaFfFn4z5Ytkc/lcZgWoNQZFY1HSIPycUJd3TEgPBd+JDcG7dXRI3b+I/tmRbNrduo3kGfEYcBxSjWlEAqJPkHGQ19pSNgDrc8ys6DcggiqFnu3NAl5mzpgs1huuMypAkSPv0Y7Q09lkk+6eh8/rc1dWwaJHJB9hiUKshewjWY+TCeMh0b3HxSKdWFKl0eWmgUeW2MLpziWsj3+EkrLWP3aw0JdsQvuFx36JQNhJ7MJMleVx3LnXIqUJ9wkEqcaxEoZPe2Tu/+Y3av2eavMvav1MRYZnAS9IaCgjYUWDR1y0ig95AoabwyFmgcajTdxdpWtFTWW9RoHM2PypGylnO3cO/uD7Any3lOPN0fMQoGldnKnZJR5PZy5rhSLgT4Esyf31xd2fwqSJjieyaiecRkVbsJJjVZ4OA/Q==;5:czj2Ud8Dug6VJ9NLT+USr9l1ChQp9pN2vODKg3Yo8vxNcRD6ItaWkPhVLDXqqAQVOaMhcuHalDy/Iv5YUWKgH3YnZdMjf0ZTIUz53IEw9FJUHVVxP1b/oX07IFi80ZW5Dv8ssDOqRUix4ATNO5prkji8chXqZ2mad9MNff1ejxs=;7:Z6FrbdiC9HzwANjxOeQdShTjcCQrmAbmDnY8cdYLkAXXEYeznAtXKRiH3u1gYLoAVbU2JF39CbX2TVNHKgeZop+ruXGd6ZJ78DYYq06zL1ryYQySgI5E18TFk+4kdKXS1H0ODQ+Ow56KBJzv7XtPGg==
x-ms-office365-filtering-correlation-id: 9164d753-4d34-4b65-ea20-08d6597c544d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1488;
x-ms-traffictypediagnostic: MWHPR2201MB1488:
x-microsoft-antispam-prvs: <MWHPR2201MB1488D9106D747A6471B0DF3FC1AF0@MWHPR2201MB1488.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3231455)(999002)(944501493)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1488;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1488;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(396003)(39840400004)(346002)(366004)(376002)(189003)(199004)(6486002)(5660300001)(6246003)(106356001)(71190400001)(71200400001)(97736004)(102836004)(42882007)(105586002)(11346002)(446003)(6116002)(81156014)(3846002)(66066001)(25786009)(26005)(186003)(14454004)(81166006)(256004)(229853002)(1076002)(305945005)(53936002)(508600001)(8936002)(76176011)(8676002)(7736002)(6436002)(486006)(6506007)(9686003)(6512007)(386003)(99286004)(33896004)(44832011)(2906002)(58126008)(4326008)(54906003)(39060400002)(316002)(52116002)(33716001)(6916009)(476003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1488;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rB5IYIB+ePE3NoTqoXvCSl54HxdU8/aOndmoDC4iK5cicMi1Y/uAMfVtxL2nWNaD5xqxmAzsARFPLcw89RwD9Vte9bEKQ/nI0+nYdEW/nk6mRG/nsepjYrGWKI83SyeNXdAteRPNGraI98DEll1+6wTR3PGmvOydWA5EkU+W7vtMMA/JE/9mh8J3qNfHP0HgKv1OfY2cevxKPSvNfQFxI4twZFZP2Zf8s8P8iFmVVKbQrEIu33Rch9iyjqqtoRRTJ4peEOwVfRZESMHqUHtZvtBuI7SzivwJ4g9X1VkILcasJOUPdsvSk/OQSORQXNx1PR7LZ0H096+ro7XpjXb0jfjaBAzN0VtQrmvDvu9xddw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <415017584E46BD4687D9E4880EB2715B@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9164d753-4d34-4b65-ea20-08d6597c544d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 00:06:24.7535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1488
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Jakub,

On Mon, Dec 03, 2018 at 03:55:45PM -0800, Jakub Kicinski wrote:
> On Mon, 3 Dec 2018 22:42:04 +0000, Paul Burton wrote:
> > Jiong Wang wrote:
> > > For micro-mips, srlv inside POOL32A encoding space should use 0x50
> > > sub-opcode, NOT 0x90.
> > >=20
> > > Some early version ISA doc describes the encoding as 0x90 for both sr=
lv and
> > > srav, this looks to me was a typo. I checked Binutils libopcode
> > > implementation which is using 0x50 for srlv and 0x90 for srav.
> > >=20
> > > v1->v2:
> > > - Keep mm_srlv32_op sorted by value.
> > >=20
> > > Fixes: f31318fdf324 ("MIPS: uasm: Add srlv uasm instruction")
> > > Cc: Markos Chandras <markos.chandras@imgtec.com>
> > > Cc: Paul Burton <paul.burton@mips.com>
> > > Cc: linux-mips@vger.kernel.org
> > > Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> > > Acked-by: Song Liu <songliubraving@fb.com>
> > > Signed-off-by: Jiong Wang <jiong.wang@netronome.com> =20
> >=20
> > Applied to mips-fixes.
>=20
> Newbie process related question - are the arch JIT patches routed via
> arch trees or bpf-next?  Jiong has more (slightly conflicting) JIT
> patches to send - I wonder how they'll get applied and whether to wait
> for the mips -> Linus -> net -> bpf merge chain.

I'd expect that to be a case-by-case "what makes most sense this time?"
sort of question.

In this particular patch the code you're changing isn't specifically
BPF-related code, it's part of the MIPS uasm assembler which MIPS BPF
happens to use behind the scenes, so since it seemed like a pretty
standalone patch taking it through the MIPS tree made sense to me.

If you have related patches the best thing to do would be to submit them
together as a series. Then after the maintainers involved can see the
patches we can figure out the best way to apply them.

Thanks,
    Paul
