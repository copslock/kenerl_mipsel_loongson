Return-Path: <SRS0=qAeu=OX=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74133C43387
	for <linux-mips@archiver.kernel.org>; Fri, 14 Dec 2018 21:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE3B206DD
	for <linux-mips@archiver.kernel.org>; Fri, 14 Dec 2018 21:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="RVp1eSbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbeLNV3Z (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:29:25 -0500
Received: from mail-eopbgr790111.outbound.protection.outlook.com ([40.107.79.111]:65397
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730893AbeLNV3Z (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 14 Dec 2018 16:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rsh8r2MBDUA+bdl6I5pvAQdKO32AA/6MOwaIgXvfS58=;
 b=RVp1eSbEk4RbCLx0a7JV438QHGl/TXCQtOntdhrvSIY0TM8YXn+IUEeV0WI8rPsIb8hkGDI0B9+tbFSw/4cUMZybKChmGbaSqzthANuWYS0yBWNE4mMnIMZ2CKXm4asF1JHLPdlEOtkZyhr1R5H4Leg1XMFt5d3NuZNeYOsgoZc=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1744.namprd22.prod.outlook.com (10.164.206.162) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Fri, 14 Dec 2018 21:28:42 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%7]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 21:28:42 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Stefan Roese <sr@denx.de>
CC:     Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: MIPS (mt7688): EBase change in U-Boot breaks Linux
Thread-Topic: MIPS (mt7688): EBase change in U-Boot breaks Linux
Thread-Index: AQHUkfNMcpdXGl+ESEeHCV0Kj78/+qV72oOAgACZdgCAADdbAIAAAhyAgAANi4CAAFqIgIAAuwCAgADzjAA=
Date:   Fri, 14 Dec 2018 21:28:42 +0000
Message-ID: <20181214212840.xf3kqukf6ryjaiqk@pburton-laptop>
References: <e4f0fff9-a3c5-85ce-c4be-6e0aa0f74592@denx.de>
 <d81ac18d-47ed-02ec-bc37-f5a7e0ab9223@gmail.com>
 <543512d8-91ea-2a49-5423-680860c0ba9f@denx.de>
 <CACUy__X434rmJnX96i057-ir8yiCBjMac_V41HJ+pyG0xLPcRg@mail.gmail.com>
 <dad02a31-ed34-f99a-26c5-60e4a7209057@denx.de>
 <CACUy__XtyDY08KTTMnKoXXKq4oUrNYdRXZOmtuXEmnfD7UveiA@mail.gmail.com>
 <20181213194740.mtphrijpnkzo2za4@pburton-laptop>
 <4ff76006-c524-ebaa-235a-6b253ce9cc09@denx.de>
In-Reply-To: <4ff76006-c524-ebaa-235a-6b253ce9cc09@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MW2PR16CA0032.namprd16.prod.outlook.com (2603:10b6:907::45)
 To MWHPR2201MB1277.namprd22.prod.outlook.com (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1744;6:dBgsoWDEhYv63eFarE2r/jYI1YNL2bMi1EFK8Dl7+SdawvdtqatcHksjNuUrw89oRrWglT6EYmd3MsEbMTEFfsq0+WiC+wgmVZc+JL/caQWz4lsnB4+mWxy3iiFsVm5PnO7Ugp/TswiBKukEisqTf+7n7ULQhSeo7LhZalkhfAIxx+QJXW8GbEr9wAcSjeBEFOOuTSm/T4e6Rlqr/xUBKS2dC1FHV4k/bccIml7XF6KeHB+vo/Im8RT6PFLQYJTebdXN+t3vmjU6GTYn7x8GPVhDG0H+zLNciQKJqN5ooBBIWcSTMvewYorOabjCBCd1X1tHv8Sw587GVxg/3GtzK5LPfrMz+cbvOIPrQgFcsu9WeOQdgFucWVcjmoia8JQYXXWkdAVMdxGFqSURuMwJWDBAkn8+m8QcBtr3FoJ3vK76UrI2G+XeVS6XMNJmV7wawgZs4OAbuglzIMc5T1WjbQ==;5:/dwt49Jcb/wGBdYBCIj1cVr9uTxpQdDL0ob1cZKwNhqRG4IBqmCVt7OdtgwgA0JzZBwVzH8lSj2XkEF6IrXOQ4ap0EOAZ4TSlcp58SI6rJBvJGutKqMg29m2V3Gl1aILUzZyZ9OsQ5UjQjMlOfM6CKhwqVLWPag1z05fZH5FFsQ=;7:5KRT6O6fcTMZVBIam+1lb4/1r/ImecqpDa/softlVFWMe5ul29rnRF92XCcLCimUj8W6qusOXjCXV1+6yk6RYJs3MECA3l4jE/remHL2Upm5V0/PyjMekM5K3iYiQfEY3g8ydT8BaIIa0chRjYcSBQ==
x-ms-office365-filtering-correlation-id: f4955286-4071-4d56-6c79-08d6620b1eac
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1744;
x-ms-traffictypediagnostic: MWHPR2201MB1744:
x-microsoft-antispam-prvs: <MWHPR2201MB1744B928A698AF1EF4873029C1A10@MWHPR2201MB1744.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(10201501046)(3002001)(93006095)(148016)(149066)(150057)(6041310)(20161123564045)(2016111802025)(20161123558120)(20161123560045)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1744;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1744;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(346002)(39840400004)(366004)(136003)(396003)(199004)(189003)(476003)(316002)(54906003)(11346002)(9686003)(6512007)(8936002)(93886005)(81166006)(97736004)(99286004)(58126008)(7736002)(1076002)(81156014)(68736007)(53936002)(508600001)(2906002)(186003)(52116002)(76176011)(6246003)(966005)(386003)(6306002)(33896004)(6506007)(102836004)(26005)(44832011)(575784001)(71200400001)(71190400001)(6436002)(256004)(14454004)(42882007)(305945005)(229853002)(6916009)(33716001)(6116002)(4326008)(446003)(66066001)(3846002)(39060400002)(25786009)(5660300001)(486006)(6486002)(8676002)(106356001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1744;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: s7kRhWdIPawzCd/WFpUvkgVP5lCribs3xlOXJjegLQtOpwGHToGYI12esYIVEjVaBUQOYnRCbuGAUM0ShFYnZLMqrtvO6ejuN/3KtyBiyWDAkxnUYFtU2HdDHDEoZV0GXR/uuqx0aWef7/JIX+zeaCrh5uWpSZw3LGQbm/Ylg1jeKLR5ew4mwshFRztAWGb7YeJypzsUKkE+ybrwyaDlCaFB07peafOz8CimwbCJGWLv1bOEm91S8nimuVDJD49RIyFs2cWFZSRR5IhpVev81D13lrjeCWsSguzuZuRHFbGBCh+KFlWkPmNEptqTvDHO
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8A5A81BA7F1B4C4184B3CDA2F6A3453C@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4955286-4071-4d56-6c79-08d6620b1eac
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 21:28:42.6407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1744
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Stefan,

On Fri, Dec 14, 2018 at 07:56:59AM +0100, Stefan Roese wrote:
> > Does this Linux patch help by any chance?
> >=20
> > https://git.linux-mips.org/cgit/linux-mti.git/commit/?h=3Deng-v4.20&id=
=3D39e4d339a4540b66e9d9a8ea0da9ee41a21473b4
> >=20
> > I'm not sure I remember why I didn't get that upstreamed yet, I probabl=
y
> > wanted to research what other systems were doing... Speaking for Malta,
> > the kernel's board support has reserved the start of kseg0 for longer
> > than I've been involved.
>=20
> No, this patch does not solve this issue (bootup still hangs or crashes
> while mounting the rootfs). I can only assume that its too late to try
> to reserve this memory region as the memblock_reserve() call returns 0
> (no error).

Hmm, OK. Do you know what is getting overwritten? Is it part of the
kernel binary itself?

> > An alternative would be for Linux to allocate a page for use with the
> > exception vectors using memblock, and ignore the EBase value U-Boot lef=
t
> > us with. But just marking the area U-Boot used as reserved ought to do
> > the trick, and has the advantage of ensuring U-Boot's vectors don't get
> > overwritten before Linux sets up its own which sometimes allows U-Boot
> > to provide some useful output.
>=20
> I agree that re-using the U-Boot value would be optimal for boot-time
> error printing. But this does not seem to work on our platform AFAICT.
> So how to proceed? Should I enable CONFIG_CPU_MIPSR2_IRQ_VI or #define
> "cpu_has_veic" to 1 as Lantiq does?

I think the answer to the question above will be helpful - if it's the
kernel binary itself getting overwritten then we have 2 options:

  1) Move the kernel, ie. change load-y in arch/mips/ralink/Platform.

  2) Have Linux recognize that the address in EBase is unsuitable &
     allocate a new page.

Or perhaps even both - having Linux recognize & avoid the problem seems
good for robustness, but if the kernel binary is overwriting the
exception vectors it might be useful to move the kernel anyway so that
we don't prevent U-Boot's vectors from working in between loading the
kernel & booting it.

If it's not the kernel binary overwriting the vectors & then being
overwritten, then I'd be interested in knowing what is in that memory.
We shouldn't have allocated much of anything this early, but a possible
fix might be to reserve the page EBase resides in from bootmem_init().

Thanks,
    Paul
