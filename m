Return-Path: <SRS0=OKHG=RD=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EAEC43381
	for <linux-mips@archiver.kernel.org>; Thu, 28 Feb 2019 03:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34942183F
	for <linux-mips@archiver.kernel.org>; Thu, 28 Feb 2019 03:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Leyzxv4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbfB1DRu (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 27 Feb 2019 22:17:50 -0500
Received: from mail-eopbgr710138.outbound.protection.outlook.com ([40.107.71.138]:61968
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730131AbfB1DRu (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 27 Feb 2019 22:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8Lea5KWqPs3ylH4e+ejM3t8yq7xTsTYZ1mj9V9WHdU=;
 b=Leyzxv4T9Sh7pZMPXR67zjAXMmGmxvaWGqRZQ5QLXBIv+zDnYDHmWsjBrQmo68axnix9RYOKwwSXLkuZWVobUrwUKhRYalSfuL3XIEz8YvHVAmbf4LUCAdHjZdVKVzCl1aFOtgw1Y+l+k1gkHXywFArKIq/IlZDx4vOQGbz3yhU=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1023.namprd22.prod.outlook.com (10.174.167.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 28 Feb 2019 03:17:46 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1643.019; Thu, 28 Feb 2019
 03:17:46 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "kernel@xen0n.name" <kernel@xen0n.name>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Wang Xuerui <wangxuerui@qiniu.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [RFC PATCH 2/2] MIPS: VDSO: support extcc-based timekeeping
Thread-Topic: [RFC PATCH 2/2] MIPS: VDSO: support extcc-based timekeeping
Thread-Index: AQHUzCSSf8LCIfkbQ0Sl3lA5yQeLfaX0kA+A
Date:   Thu, 28 Feb 2019 03:17:46 +0000
Message-ID: <20190228031745.c3smchntpnwzfxuz@pburton-laptop>
References: <20190224093635.1242-1-kernel@xen0n.name>
 <20190224093635.1242-3-kernel@xen0n.name>
In-Reply-To: <20190224093635.1242-3-kernel@xen0n.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:a03:40::22) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6dd9eb1-4c65-4ef4-a62a-08d69d2b4f6b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1023;
x-ms-traffictypediagnostic: MWHPR2201MB1023:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;MWHPR2201MB1023;23:9MpVaOjiNiIuICxD/RLgWQkecWF4KyG6JzOhYla?=
 =?us-ascii?Q?mylIPnnguGJVy6jhXAefSiHEaplf5bJ83ZeHNrv7WyUIUuyvAfmeNSzgTz9N?=
 =?us-ascii?Q?WzArpmd+D8E83gZ6QVPUjTB3oqgetIUffaSKRJDsEgQeEFYtZv1p/hwuDtc6?=
 =?us-ascii?Q?5yIlUZSNoP9QPLiy/qZixlmZomjhbogJb2aplYaSoCzicrGi53ztM29+3iEY?=
 =?us-ascii?Q?HxZ5SDJ1ubHyw9hX05NwoACSzWoZI/XYl0tWIVQHxx7H8WubbU8ZPdzeb+Dr?=
 =?us-ascii?Q?flnnUauAqy76aCa8OPJ302xK/LyDYg3LY5efZKt1xbnnhWKRzp2VMcui+t8V?=
 =?us-ascii?Q?J1/rADhv19G+nY1eLjl/9ah+GluoFLK0D/2JvnzAODbnvHOhx3rjIFemyKkH?=
 =?us-ascii?Q?pYqhLt/p55YPF6k84FDEmCtr/G70otGjpDKZtTHCKV0Wve8a9+h+Eh/7JqUP?=
 =?us-ascii?Q?EaY/ukoHKLYt+YuB2+XRDiV/C3B3bwJdLgtQQnGiqi+e+mwPF3QOEP6mfGmr?=
 =?us-ascii?Q?8rTceK+VtPy7TyQIVKv0cDVh4TYV4V+6vF7F3ItKZhlkrmt40+qg5CzzWDY6?=
 =?us-ascii?Q?ScfG49/IB4Hs7vwkajkmKRaNbjm5xrrb8v6dVMdtuCg1ROwrdGgw7ucsYDFD?=
 =?us-ascii?Q?9YI1Sc23eQuHPwB/WtCG1cmClhlI92m+ot03tZchadxjHr32Gse8cAXfIe6o?=
 =?us-ascii?Q?MsyNfxP5BOMTran0rngppiI3N3CJfLbURlgSp5OipYvG87xiPdufIZ4BZim4?=
 =?us-ascii?Q?jihiibBDUNMuuyq3urWm4xGoQGE/66bdVneb1UiEW1Q/1OjpDHXQLCzGIW3n?=
 =?us-ascii?Q?E8Asz7KQLa5nwbLHXduk5nak+PTUQSHF2S2s+iUtGQ8TiNm96Dzn/QZIvtGq?=
 =?us-ascii?Q?0ZYfzJ6ZloaNYoljMf1vf8Cnpz1q/wV0kre+P587lIGbI1U4LLjKEr00MS5C?=
 =?us-ascii?Q?V/tgA4k6mlc2ncPa16z4UeVXanwxBfAaKlzxGyVvz+vfpZRUzUvCt9nfIqB6?=
 =?us-ascii?Q?T74tw9puzQAc+WoGj+fwZBnYjTwzde78Tn3eX/Qz6yz1wjjCX/nd3Bx5CUeP?=
 =?us-ascii?Q?BFqofeXBQbbo6dYUz/ha+a3oQZ3O0/t29+dG+g34ot37qaaV4i6/Whu+R6xh?=
 =?us-ascii?Q?pJ2QUuNLPFPhiFg2HXGwebUXiFf0fIr1U7BondJXJatYe9UOR1jx7MePQct3?=
 =?us-ascii?Q?aZ2T5M5HVTO5FKDMoKyfsxc7ZwKUOxfhL9/P2s91bVapBsTCjGwLbbzu638b?=
 =?us-ascii?Q?x7AwpLEdkz4709lu0CV5WYqMSInNeDuOMsVokznLdRzTD8/ahgbuTVTjVc99?=
 =?us-ascii?Q?xbpTFZahQFzNZS2DwQiT+iOoezbSi2teSVFjEYF5TQ7aZixPd4RA3yx4qhhg?=
 =?us-ascii?Q?Xil7Qx9PJjKJeR8+qFxI77e4/9es=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB10231ACC769290CEEE2AAC2BC1750@MWHPR2201MB1023.namprd22.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(39840400004)(396003)(346002)(366004)(136003)(199004)(189003)(1730700003)(8676002)(256004)(5660300002)(33716001)(99286004)(42882007)(54906003)(6436002)(5640700003)(7736002)(6486002)(229853002)(2906002)(6512007)(476003)(53936002)(9686003)(486006)(11346002)(2351001)(305945005)(316002)(6246003)(478600001)(97736004)(106356001)(446003)(44832011)(4326008)(186003)(8936002)(105586002)(25786009)(6116002)(81156014)(3846002)(26005)(58126008)(52116002)(2501003)(102836004)(386003)(6506007)(81166006)(6916009)(76176011)(68736007)(71190400001)(1076003)(14454004)(71200400001)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1023;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fsPabnwMPwFsgZ/eLbx+XrEsHdRrfbb0F0BXi9Cdghff27d2JqeXK/ExHmjKVLHDnpvMTdi26QChlUEtsPvHzkTr7dL3UjzVbbQrEL2tUVHfQfmSJvbef2z79nk2UevqDntV7rdrJPAtGH1q2Vwr+NePJUiCdvGoboCV7oYKOTjpd+uhT2bwdJ3MCmfCowNqFya1iNFCK2ym3SHz7MSWCiwqRSG07st5BVQtv5jc/84CPMaRjShtGlX4nBCqADnUqbgkMMfWceyvXLk4f+GWLrPlZVonh67SNGlDf2G0h2N3rRrOLuZKzZIzbOwjKaOjoX+QOKw25mZmbZaIhAsX9LUtoTuQdmoMhaL877UuHGw1cX7vPnQ//N63w9Jp8NVCVfYN77d/RbXLBvm+MTvqSOxJrBP+gfGGjNqobFlsk+Q=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9D8A47697CD19F498893FB068568D2FD@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6dd9eb1-4c65-4ef4-a62a-08d69d2b4f6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 03:17:46.0562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1023
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Wang,

On Sun, Feb 24, 2019 at 05:36:35PM +0800, kernel@xen0n.name wrote:
> From: Wang Xuerui <wangxuerui@qiniu.com>
>=20
> The clocksource bits are ready, just wire things up in VDSO for a
> significant user-space timekeeping performance gain.  There are several
> ABI problems uncovered by vdsotest though, but daily usage of the test
> system didn't expose any of them.  These inconsistencies will be fixed
> in a later commit (presently TODO).

I'm afraid that's not how this works... :)

We should make sure this works properly before merging it - could you
provide details of the problems vdsotest found?

> According to vdsotest (formatting is manually added, only the affected
> figures are shown):
>=20
>     category                          before  after
>     --------                          ------  -----
>     clock-gettime-monotonic: syscall: 409     401 nsec/call
>     clock-gettime-monotonic:    libc: 476     141 nsec/call
>     clock-gettime-monotonic:    vdso: 462     123 nsec/call
>=20
>     clock-gettime-realtime:  syscall: 405     407 nsec/call
>     clock-gettime-realtime:     libc: 474     142 nsec/call
>     clock-gettime-realtime:     vdso: 457     125 nsec/call
>=20
>     gettimeofday:            syscall: 406     407 nsec/call
>     gettimeofday:               libc: 455     121 nsec/call
>     gettimeofday:               vdso: 440     102 nsec/call

I'd rather be sure the kernel gives the right answer than have it give
the wrong answer 4x faster, so this looks promising but let's fix the
test failures before moving forwards.

Thanks,
    Paul
