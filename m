Return-Path: <SRS0=Zu9z=PB=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB36CC43387
	for <linux-mips@archiver.kernel.org>; Mon, 24 Dec 2018 09:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31C32171F
	for <linux-mips@archiver.kernel.org>; Mon, 24 Dec 2018 09:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=darbyshire-bryant.me.uk header.i=@darbyshire-bryant.me.uk header.b="y93TBeBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725268AbeLXJD2 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:03:28 -0500
Received: from mail-eopbgr40069.outbound.protection.outlook.com ([40.107.4.69]:7540
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725267AbeLXJD2 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 24 Dec 2018 04:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=darbyshire-bryant.me.uk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3whgRCf4+tfBTF0AqL9fYwDH/9EIC6DePmUhlj8yv+c=;
 b=y93TBeBXbCSNjEKLinoSSJAlNY7We3c3i34S4WLqTjRrIcrJb5RarXy3dBwEu+MSWLPqOqL7Wlemvak/GgAa6P3tGj14YPNCY1Orj35tcsF5tlio07C8qbFAUZVB0LFeTN4rdACneSfo/VGDNrOGtweH3qK87ygZu7iZOsjMhnU=
Received: from VI1PR0302MB2750.eurprd03.prod.outlook.com (10.171.105.143) by
 VI1PR0302MB2752.eurprd03.prod.outlook.com (10.171.105.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Mon, 24 Dec 2018 09:03:24 +0000
Received: from VI1PR0302MB2750.eurprd03.prod.outlook.com
 ([fe80::d77:d217:1660:c5d4]) by VI1PR0302MB2750.eurprd03.prod.outlook.com
 ([fe80::d77:d217:1660:c5d4%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 09:03:24 +0000
From:   Kevin 'ldir' Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>
To:     Hauke Mehrtens <hauke@hauke-m.de>
CC:     "paul.burton@mips.com" <paul.burton@mips.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "jonas.gorski@gmail.com" <jonas.gorski@gmail.com>
Subject: Re: [PATCH] MIPS: Add CPU option reporting to /proc/cpuinfo
Thread-Topic: [PATCH] MIPS: Add CPU option reporting to /proc/cpuinfo
Thread-Index: AQHUmxJAeVFEpnFmuk+WQwjlWhVAMaWNmOUA
Date:   Mon, 24 Dec 2018 09:03:24 +0000
Message-ID: <81623E5E-FAB2-4C91-B7F9-8C5BB8422D5C@darbyshire-bryant.me.uk>
References: <20181223225224.23042-1-hauke@hauke-m.de>
In-Reply-To: <20181223225224.23042-1-hauke@hauke-m.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ldir@darbyshire-bryant.me.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2a02:c7f:1240:ee00::dc83]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0302MB2752;6:umEyHUvSpTrZykYu5pVjlvmGnDVfYt3d68v52x7Pt3QzrDdtMArqgUWU+eED+SxZg68Cvf2TwJOvGciE1n3ZCLh/93V01qpz48y9+YhNHiXJL0QpLdILdjhlsZsqCzAOA6jN+PvQ8OIzV6LIL5Wz+4mJH4+vtEQWiV66R6ubjNoaJUWi3WR6xPSOtWhwOaKZRYlDecNx2qym/RgR9UkNTc99laIkqgI8qX0UZ0wmTWqP06khNOSCBpYrGHLmrLFBWbVYf3C9n6VYDqHs9/imXVYMsHgRcjlLggKPOw1ktMS1fYkHXwMojEHTsB3bV7nGepCw/Vf/FBfWeXJFxGIuVg9HoTdp92CYES8YVBJQhnXjMeB4BW5Gfg7aV3AG1YjrACSASwsTuzUxpFHcGsHZmOcXWMIdmwM68hv1mYFb3K9/MELiRFqycXSadSKtu3/n02wt8nn7VzXsKUDTq8lOYA==;5:iF36mVlPVHfuTxioddg1tkiDOgBqZLODoZNHtxplwx3r+fDLMEm4bsX1+oJSDiNcgjMWkypPn6Ue1mbI/ysn+FqKgD3irNt10bg7zNGxj79OOSMkQyIf0OI+o128Xdcn+SCphcH8LlYQD3nqOOtb1bf5TWL9vum6Rs/jcmKUQRY=;7:2wueBqwpWU7NEhLj0GDPglPrOaqhO9eVUw0yu54QXc+yNtyyBOJzyCRSTBfg/nHIoqvfs3eu9zUjaDAjJRVvPsVr58YKsAReSeUsjn9ibc9pZq8s1Z5jy4C74mX8ScgHT6IOWUJwWqcX+S5SHFUqkg==
x-ms-office365-filtering-correlation-id: 273f9fe2-9f41-4efd-486b-08d6697ea90d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0302MB2752;
x-ms-traffictypediagnostic: VI1PR0302MB2752:
x-microsoft-antispam-prvs: <VI1PR0302MB27526BC0DC115EBC9E2E3733C9BB0@VI1PR0302MB2752.eurprd03.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR0302MB2752;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0302MB2752;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(366004)(376002)(396003)(136003)(346002)(189003)(199004)(71190400001)(71200400001)(83716004)(305945005)(86362001)(256004)(4326008)(476003)(2616005)(74482002)(6486002)(508600001)(6916009)(316002)(14454004)(97736004)(25786009)(8936002)(54906003)(229853002)(39060400002)(7736002)(6116002)(46003)(6246003)(6436002)(8676002)(68736007)(106356001)(6512007)(105586002)(53936002)(2906002)(76176011)(53546011)(11346002)(5660300001)(186003)(81156014)(81166006)(82746002)(33656002)(486006)(99286004)(36756003)(102836004)(6506007)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0302MB2752;H:VI1PR0302MB2750.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: darbyshire-bryant.me.uk does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O7hEZcMVeDl/+ECz1gfIftno6WlZQ6Zx+yd7FLNAtSCW+tRBLtxD3T6HUA5mBJeP5Ad6Yshj+oFKHa7eAEwHkS6AFKI1cvQ457Bmy+ooc+nIGGK2rOPJ+7iMgblQrrhyL28n6AsE5zqnhN7Z7GJaR/dza96rQPDQpxEPvA2UekbOdKtzRwsn+9zRjw3aaEnrSFwti5twk3AEap+d6heqyQvoFswmCcIJLJkaEmQYq0nuUmb7oJ/CFIv56al0HnDIIudlRFLQxq76mDS+DwkqVApgTlzse0iv+AJNSArF7ojsuAMfLlbJ5PRaknp/+gu4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17D3979151D82047B312C9923C92B0C5@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: darbyshire-bryant.me.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 273f9fe2-9f41-4efd-486b-08d6697ea90d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 09:03:24.1118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9151708b-c553-406f-8e56-694f435154a4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0302MB2752
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org



> On 23 Dec 2018, at 22:52, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>=20
> Many MIPS CPUs have optional CPU features which are not activates for
> all CPU cores. Print the CPU options which are implemented in the core
> in /proc/cpuinfo. This makes it possible to see what features are
> supported and which are not supported. This should cover all standard
> MIPS extensions, before it only printed information about the main MIPS
> ASEs.
>=20
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---

Hi Hauke (& lists)

Apologies if I speak out of turn and/or ignorance.

The problem I have with this is that cpu_has_foo macros can (and often are =
in openwrt) overridden in by cpu-feature-overrides.h (e.g. arch/mips/includ=
e/asm/mach-ath79/cpu-feature-overrides.h) and thus the info shown represent=
s features that the kernel is capable of using and not features that the cp=
u core is actually capable.

As you know we ended up printing cpu config registers to be sure of what th=
e cpu was really (in theory) capable vs features that had been masked out d=
ue to overrides (and to cut a very long story short, found them to be the s=
ame in the end but they may not have been)

Cheers,

Kevin D-B

012C ACB2 28C6 C53E 9775  9123 B3A2 389B 9DE2 334A

