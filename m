Return-Path: <SRS0=SfrM=P7=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1BCC282C5
	for <linux-mips@archiver.kernel.org>; Wed, 23 Jan 2019 01:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F14A217F5
	for <linux-mips@archiver.kernel.org>; Wed, 23 Jan 2019 01:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="m8vzjB8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfAWBeb (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 22 Jan 2019 20:34:31 -0500
Received: from mail-eopbgr800095.outbound.protection.outlook.com ([40.107.80.95]:16320
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726814AbfAWBea (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 22 Jan 2019 20:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3vnkECSz1qaQBCnpYEF69mMRbdytPjY1GIiqRemDyY=;
 b=m8vzjB8uleiGTh7/LP8O0i/RuT7NtQ7QCUfmcP3oIfwoZjpTspvwVByQy1T2rDibJ+6kbE6AroO3efKhkJ/Lppdx2a4UmYWFTod81Ca5p0fsr06EZ5gvzs+iVaXCeRdS+gFZzmtg8m3lLo7zh+VuTUDBSctnIDUfXIV8X3PeMqg=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1287.namprd22.prod.outlook.com (10.171.216.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.30; Wed, 23 Jan 2019 01:34:28 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::f560:2a93:e4fd:f50e]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::f560:2a93:e4fd:f50e%7]) with mapi id 15.20.1537.031; Wed, 23 Jan 2019
 01:34:28 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "keguang.zhang@gmail.com" <keguang.zhang@gmail.com>,
        Paul Burton <pburton@wavecomp.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 1/6] MIPS: Loongson32: Remove unused platform devices
Thread-Topic: [PATCH 1/6] MIPS: Loongson32: Remove unused platform devices
Thread-Index: AQHUslMkvVtYRodDHUajofYGd9LUmaW8EuYA
Date:   Wed, 23 Jan 2019 01:34:28 +0000
Message-ID: <CY4PR2201MB12723EF92091D72E29C5B2A6C1990@CY4PR2201MB1272.namprd22.prod.outlook.com>
References: <20190122130415.3440-1-jiaxun.yang@flygoat.com>
In-Reply-To: <20190122130415.3440-1-jiaxun.yang@flygoat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::18) To CY4PR2201MB1272.namprd22.prod.outlook.com
 (2603:10b6:910:61::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [96.64.207.177]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1287;6:Oi4/v6w1lORF+lw5SMIeK5WHRxCrqzHH2MFrxGlF8l2w692xAJYdshrpOIUtgtVIY/Pk6vM8YF3AA3QIyEkmK+tx1EIX4Hu7S0ntXOZK8msQOQrz1Zj+tTIQoCBu1SZNtcJfgYEDBFRiAgC7YwwG2MEenxhJVR89LMK6Y/BbvvhnDosZDHfpJWgFJ3MVsMUTh94ByALwyrniVFrAd9EaZqtRAjyj7T+lfsiBf/fnK8jXAm1gaefP4UgzHpFZ9F/0pLoDNDRxKyv98g7HLDuAP47f8Rj8DYmDfozqtYsKn/f0pKEwJxZFWYrmcHDpPYgDkijkONtGyWqQ24XKXhXIczUTVZ1Evhj02S50OCRC+rjgRlQlNNKbBl4ftMaP9usVUQNJ4H7b7IW9LwwYTW7Ekwtbr1QXdLWxXHd/5KDpvACrFo3BJyG0S7lVBToFq+N69Ffj1RsH5xcctTDqrUzwGA==;5:CrOjfLoUj6x8IPoMSwBmcekrCJjhbKCeWuHvIbz4jfKcoJaJ/k7pzgL3ZM6xGku96UQosMlbSHHP7oSTjN0RtJktZTuJLYl8OQyYaSw2yabJq7h8OYFMAaX4m+8Gws+N+UWwIkduOrlaHlRIYTBcj9ji+Ayv+E12dpE6XuWiYQXU4AsjhVom9vCc2H2uxecswMIwmD/+R40RUUy+o84mzA==;7:mE+Tf3PuhBipOHCI45tqvKomTgZTCiHC2/AbFEpa3g8sPzXB8eCmJKsNt+vdNJK//2l86HYTJ7OjvZ7U+PrLzUNpOo/hsQMz/gAa4Ifyb99pv8hC6tQPC3Hv6xtmnj3BgTQI6qHQszdX43kMbe9leg==
x-ms-office365-filtering-correlation-id: 11e269e9-4714-459d-4f47-08d680d2ea05
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1287;
x-ms-traffictypediagnostic: CY4PR2201MB1287:
x-microsoft-antispam-prvs: <CY4PR2201MB1287191DD618F6593F35AF62C1990@CY4PR2201MB1287.namprd22.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(39840400004)(366004)(189003)(199004)(11346002)(478600001)(102836004)(8676002)(386003)(26005)(25786009)(97736004)(316002)(81166006)(8936002)(186003)(81156014)(14454004)(6916009)(229853002)(7736002)(71200400001)(71190400001)(6506007)(305945005)(6246003)(446003)(2906002)(33656002)(558084003)(39060400002)(476003)(53936002)(44832011)(74316002)(486006)(4326008)(52116002)(7696005)(105586002)(6436002)(106356001)(99286004)(9686003)(76176011)(66066001)(3846002)(55016002)(256004)(68736007)(54906003)(42882007)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1287;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Al9zQgodSugJoQDSnbDcKJncxqrpI19IDqeiXxQyXshvCk4H9J7MXQLljqI8AUoEflLfipqUVxpg0OMdUf9inoAnBAoLr7Cplq0KzzONzyJA6dyCJHxUDgcOiQl73DdKb4cq89xItrUyf0SHIfnq7Tj1mexsCwRQlUmRqDZnGWP4nAeSqn5bveGNKr0UJcnqKepNxJC8bGRnshHV3ekAUkou8m+smKufcPVYDONo8u0i62XJ7FbsdKiPp7ZIpL7WKW93l2lrlDjIwdpmCywqAuLxY6TBcr+77pq8cjO0UUW8cEANJWFe241oZFi8KvSe5TW9dEjrJ7HKUbOSnwuVSM2NOFiOlv/P/FuzY7zkBK5hAHRtqBdrE5PtiD6FzGQC8M0hONlepSWdfqV+bB4ljWw77p+2HAjcJxyOWEaZMEg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e269e9-4714-459d-4f47-08d680d2ea05
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 01:34:27.5801
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
> platform.c contains several unused platform device with no
> drivers submited.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
