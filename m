Return-Path: <SRS0=Rn8T=QP=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E65C169C4
	for <linux-mips@archiver.kernel.org>; Fri,  8 Feb 2019 05:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5132920863
	for <linux-mips@archiver.kernel.org>; Fri,  8 Feb 2019 05:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="IWHIqZF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfBHF5P (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 8 Feb 2019 00:57:15 -0500
Received: from mail-eopbgr810131.outbound.protection.outlook.com ([40.107.81.131]:56128
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725940AbfBHF5O (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 8 Feb 2019 00:57:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBfx1O7JrTg0tEEQk4+PNtkxKhzYTFq+OwdLEPD4oc4=;
 b=IWHIqZF8O5kFHCNhey5CaSwWsC/65afXh+1TIi8PnoW8yBZ2ed1sK7a6V8TRjNf3y1SI/4D4hzdIhmSLcAQ+T7ZKTsSaABoGtYVFbfmEtwpw3qlBaj5rxKJZgIEVMvo3IMmx+exu9jEjRrP0I46e9yknntZf8N7EWqwlJ433HHs=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1070.namprd22.prod.outlook.com (10.174.169.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Fri, 8 Feb 2019 05:57:11 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Fri, 8 Feb 2019
 05:57:11 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "dave@stgolabs.net" <dave@stgolabs.net>,
        "dbueso@suse.de" <dbueso@suse.de>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: + mips-c-r4k-do-no-use-mmap_sem-for-gup_fast.patch added to -mm
 tree
Thread-Topic: + mips-c-r4k-do-no-use-mmap_sem-for-gup_fast.patch added to -mm
 tree
Thread-Index: AQHUv3FRGd3D5kwGB06QH21t1QVvHqXVZ10A
Date:   Fri, 8 Feb 2019 05:57:10 +0000
Message-ID: <20190208055708.sxlvcfyjayiwrozc@pburton-laptop>
References: <20190208054407.gjyKBBYUS%akpm@linux-foundation.org>
In-Reply-To: <20190208054407.gjyKBBYUS%akpm@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0062.namprd11.prod.outlook.com
 (2603:10b6:a03:80::39) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:647:4100:4687:76db:7cfe:65a3:6aea]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1070;6:EAkJX/aKp53lY+pxHNA5+3fADLO7NpKyrZs7oMz8R06WOTVrJlYacHCcIbm6xmIfZLY8Q6JYg7N95MLcg3XoT/Vf7/RhfY4j+Us8PJ2zGC3fTnIXGw1HbDZTOhcGymMoiEth1GbRinmTLWPvQWB59TYeOpxnkHjeM/RIs24VIvZQjpJBV8bB8rvCPlFSDBP//dkE0EDqKl6CgnB0Fp9f8FnU/xc4a4MnaylPeg+RNo8G8Wp4/TCyo/TWjixA7t6HIL1hKBSJVlIsPo3Xn81ufwaG/JLOp63ZQ549zo8d+8c9y8KAnj9wcAM6y6NxvSVrVlJdw2Fti9zYRAqfB+3TMvx4g4xZ68aXcGnq6LYI+INCUOtqISuTCEZrlLGz2+IEZpz+0WDgILsGUB4e0BamQ4LJbIV4x9+zyScjVobqLjsJscf1GwtJy5Ulij0cwgjwGjvmAOE8XLOsQfofNRTbng==;5:HQXrkLxa4Dim5+LiCwWj6u4hw5juxJtpsd6aFv5Q9XSFJrczkYxpj7/CzA1R/MJXF+HS9uxid5cdZvKlxE3oeBEVE2nJdCorExQUDr7u3yeUCqatiDmuiuxo8YM6JgmFebsjQVCeMaGGywX5iPiL7LF590nqeA8l3b59BFcR3qxIa4n/no4cB1JyES8sYz87p/0mP9+SLPBoS1bbQMudDQ==;7:3FshxQbQ9eqyA3jBw8wNw3je7W89tp3ALZW9J+xUFlE8bAGDFqKGUuWsYb0Yvyr+C3p/yLWvxbSxeXae8rbzOlvkNJKQP4TqY3v5THgFHNHGpuLKLQ3pksOSVndPoQzHsO5mhLXvqzc3eqF7MI8AbQ==
x-ms-office365-filtering-correlation-id: 5cd89efc-933c-4cfc-9f59-08d68d8a43bf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1070;
x-ms-traffictypediagnostic: MWHPR2201MB1070:
x-ms-exchange-purlcount: 4
x-microsoft-antispam-prvs: <MWHPR2201MB1070DD0648BA381A6FBE7CE6C1690@MWHPR2201MB1070.namprd22.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(136003)(366004)(346002)(189003)(199004)(97736004)(3716004)(6116002)(71190400001)(71200400001)(305945005)(7736002)(6916009)(5640700003)(6436002)(6486002)(2501003)(76176011)(68736007)(42882007)(102836004)(46003)(229853002)(386003)(52116002)(256004)(33896004)(14444005)(186003)(6506007)(9686003)(6512007)(6306002)(2351001)(446003)(11346002)(106356001)(105586002)(486006)(44832011)(8676002)(1076003)(53936002)(81166006)(81156014)(6246003)(14454004)(966005)(2906002)(54906003)(1730700003)(33716001)(508600001)(53376002)(8936002)(4326008)(25786009)(58126008)(476003)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1070;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I2wXHSCCeEIXuORGLSWmoZKz8LmfK1FAXX63Xg53zffDQhWugiJlMPN0LjyiUUzfsb/7k9pBVHDOgpn45kOVaU2SJrezYSmysZyWGjo7Jy8mWC+AVo/6iiQvry4BkNDUjsBWBUwdtw+LBl1ezRI4a1QuR2GJlur67N3JRUFDaDebbvw7gXvnGB1QHJ3OjaMQebrDrP0bkwWlL6HQ+XHJL9RgjHuzxMjSIVIsE2Jwi6/UW+kKXLMmmeYGkTMW2YyR0cLg3wWCydfdqWm3IkUlY+R0/8j/LCbRTPNx6Vib/DsQaMpPXJPMXPk0XWPoP6x7osKyiwK+bd//wFYDt4Ja6jkD9voEPsKzN4TMKfkVcjxjGJloEc5vvmXPJ7vJRdwuFmAEff39Xmqq8J8riWGz2UZQFECLxBIfIyhJXp3qWsM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <836DD39E6FD9E046B74ED0286061B0B3@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd89efc-933c-4cfc-9f59-08d68d8a43bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 05:57:10.0137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1070
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Andrew,

On Thu, Feb 07, 2019 at 09:44:07PM -0800, akpm@linux-foundation.org wrote:
>=20
> The patch titled
>      Subject: arch/mips/mm/c-r4k.c: do not use mmap_sem for gup_fast()
> has been added to the -mm tree.  Its filename is
>      mips-c-r4k-do-no-use-mmap_sem-for-gup_fast.patch
>=20
> This patch should soon appear at
>     http://ozlabs.org/~akpm/mmots/broken-out/mips-c-r4k-do-no-use-mmap_se=
m-for-gup_fast.patch
> and later at
>     http://ozlabs.org/~akpm/mmotm/broken-out/mips-c-r4k-do-no-use-mmap_se=
m-for-gup_fast.patch
>=20
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
>=20
> *** Remember to use Documentation/process/submit-checklist.rst when testi=
ng your code ***
>=20
> The -mm tree is included into linux-next and is updated
> there every 3-4 working days
>=20
> ------------------------------------------------------
> From: Davidlohr Bueso <dave@stgolabs.net>
> Subject: arch/mips/mm/c-r4k.c: do not use mmap_sem for gup_fast()
>=20
> It is well known that because the mm can internally call the regular
> gup_unlocked if the lockless approach fails and take the sem there, the
> caller must not hold the mmap_sem already.
>=20
> Link: http://lkml.kernel.org/r/20190207053740.26915-3-dave@stgolabs.net
> Fixes: e523f289fe4d ("MIPS: c-r4k: Fix sigtramp SMP call to use kmap")
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Whilst I don't object to you merging this too strongly, I thought I'd
point out again that as I already replied to Davidlohr [1] the code
being changed here is unused in mainline & all affected stable branches.
In mips-next it's entirely removed. As such this patch will have no
effect on the kernel's behaviour & cause a minor conflict with
mips-next.

Thanks,
    Paul

[1] https://lore.kernel.org/linux-mips/20190207190007.jz4rz6e6qxwazxm7@pbur=
ton-laptop/
