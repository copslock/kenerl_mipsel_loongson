Return-Path: <SRS0=3MQT=PA=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2C8C43387
	for <linux-mips@archiver.kernel.org>; Sun, 23 Dec 2018 16:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6367B2184D
	for <linux-mips@archiver.kernel.org>; Sun, 23 Dec 2018 16:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="UXtS0mL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbeLWQQe (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 23 Dec 2018 11:16:34 -0500
Received: from mail-eopbgr690136.outbound.protection.outlook.com ([40.107.69.136]:52294
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725832AbeLWQQe (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 23 Dec 2018 11:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDSZhFQKrZBF+BqTvvifkO9wTsgt80ml+0WC7qiascU=;
 b=UXtS0mL/frlPML3krzI4FnFioiAsQMSQERzupGXjmI/d7NQ7VRl2Pny+IXPjlm46CJiWpOusQF9E3yc+EDQDmMnrg7UEd2m5jkbymogslScvHW8oADpA7mnTnenDC+wVs1Sl8NYHs666INeYHh2AtxVIy8h8N+opN1nfW9a5IN8=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1102.namprd22.prod.outlook.com (10.174.169.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Sun, 23 Dec 2018 16:16:32 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%9]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 16:16:32 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Manuel Lauss <manuel.lauss@gmail.com>
CC:     Linux-MIPS <linux-mips@vger.kernel.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 1/5] MIPS: alchemy: cpu_all_mask is forbidden for clock
 event  devices
Thread-Topic: [PATCH 1/5] MIPS: alchemy: cpu_all_mask is forbidden for clock
 event  devices
Thread-Index: AQHUmtre3694yDcZ5E6Mf6lirDRF4A==
Date:   Sun, 23 Dec 2018 16:16:32 +0000
Message-ID: <MWHPR2201MB1277145BF09B9DA38908D1A6C1BA0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181219070803.449981-2-manuel.lauss@gmail.com>
In-Reply-To: <20181219070803.449981-2-manuel.lauss@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWXP265CA0046.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2d::34) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.197.89.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1102;6:ucvRtHAjQxpjwRVP0Er5INfOFlYnUoLrD9/lM64vjrIZsJBwAudvB7P70u2mc8BWGx9udIXBqRW4j2+kYuMQ1odsTqRX8subDpssG4XTldRWk86Z0iqpz92kJzMbEKi1PzREX8xJZSCl55HmCAz/BC36WFqgJZBRIcZBveK0lCP/hwdr+gHxUIc1ESiEWCCAFggoNQQ6nQ2KiEGY7GjLPcbXiJFKeOMQ4vPM0lnaOYNaeq8FUoyD4o7QpAxiiQd4G3JZYF2slNn4NGOs2MTIJcLQY6n2c0cjkzkEiLgoOUsGn6HNgXL1FFwv5pzJWl1FwAO7q3unhIVTyMyasCTK3FFz/YAVW2+1iA1A2Nmup2sgXos+6nE3PRZ6R1lYr4z9BrkIagvZ4asUE+4yIgZ00TtevUlMYOllQcJkh6wYd70TDNQl1FBxzfH4sJtUOc8JUlKop+DlejgGmzLOLeOc9w==;5:BpCOqQtUqlqxSeiWc3Z648fW1gMRZOAI/EDELssM6gyAXZFUjRb2YY1kq4llElAEJqlxmNGZVbIkhvX4C40jOUoiIZyHmiYgkKfg6IyruwUAsaWvcz1Bsi7jTTN99cACqT8QOhEeyDNV6UOKXVQLMpJRVloZrB1f0DPqGxk2Nds=;7:tU3A0YTvE7qlz0vP8bdv7BVQrGUgeAVwuUnikUZbBDYzyuA0G5xXYE49QJOSu1cJvHg0lEfQ1uMSHRjQp1qdf+Rt/SPGxVLQ+xXknHwRWzWQnkjFsMKEbGa6s6Ctd62rxgDD+vdgbT0PRbBAsEMTaQ==
x-ms-office365-filtering-correlation-id: 737bdbe7-d1c6-4e2b-9e1f-08d668f200ca
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1102;
x-ms-traffictypediagnostic: MWHPR2201MB1102:
x-microsoft-antispam-prvs: <MWHPR2201MB1102CFF86440942EB3E9A2B1C1BA0@MWHPR2201MB1102.namprd22.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3002001)(93006095)(3231475)(944501520)(52105112)(6041310)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1102;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1102;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39830400003)(376002)(366004)(199004)(189003)(105586002)(6506007)(386003)(6116002)(71190400001)(102836004)(6436002)(229853002)(99286004)(6246003)(76176011)(71200400001)(26005)(33656002)(106356001)(3846002)(6916009)(68736007)(7696005)(52116002)(54906003)(186003)(316002)(5660300001)(97736004)(55016002)(39060400002)(8936002)(2906002)(256004)(14444005)(4326008)(476003)(8676002)(81156014)(81166006)(9686003)(7736002)(305945005)(74316002)(42882007)(14454004)(446003)(508600001)(53936002)(66066001)(44832011)(25786009)(11346002)(486006)(21443002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1102;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: z8CMdYWs1q2wCdDqby0rnHrTFyydXKvbfWw+KosxeZ7BoOfAkzm02BhORm3+b9S6+YAjvXBalJY6IA9hYZTSe0VYohWE87gDETwvqXs5Hy5h9rds8j5QU+QeAFC1BzTx7mrXUcJmpdb5JTYXycZM+PsKpWnw9RZcoq8UZIZ75gc64DUzBjSKIH3/PR/XVGJI3/W9rPNsSDCBd9GAu5sLbmMmfzJxtKr1HoaD3YxefBHE5W8BqHw3zrJJrFxpJqAUE6LQt+JQnhoyRmijcUabJqyWJkb38vy3CQpaL4tZ4x/UW1pYJUV3mqKHtrBFJV79
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 737bdbe7-d1c6-4e2b-9e1f-08d668f200ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 16:16:32.6959
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
> change alchemy clock event device cpu_all_mask to cpu_possible_mask.
> Gets rid of a warning, which then does the same substitution:
> WARNING: CPU: 0 PID: 0 at kernel/time/clockevents.c:468 clockevents_regis=
ter_device+0x130/0x140
> rtcmatch2 cpumask =3D=3D cpu_all_mask, using cpu_possible_mask instead
>=20
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
