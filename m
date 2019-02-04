Return-Path: <SRS0=rTdo=QL=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43F8C282C4
	for <linux-mips@archiver.kernel.org>; Mon,  4 Feb 2019 21:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8126F20811
	for <linux-mips@archiver.kernel.org>; Mon,  4 Feb 2019 21:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="HkyleP/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbfBDVSY (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:18:24 -0500
Received: from mail-eopbgr800092.outbound.protection.outlook.com ([40.107.80.92]:6212
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726843AbfBDVSY (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 4 Feb 2019 16:18:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DpL4Gq0QMsTuG1WNfoecB7uCdlv+OtpGTMp50gSG/M=;
 b=HkyleP/QCuLsdt+wCbYFJTTBh8ezcA2sVYNYEhUigSdc85uO0OjbXnBws2708NawUOdBiE/56o5Gx5EhuwK35/fyJmYuQ9pSyrDSKmgQ2WCAWN7maupwMQ95ST0I419ZFJ6rlmK2cJr/+nkz/LPGS2CFXKbpoecv5+a+gOI+c/A=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1118.namprd22.prod.outlook.com (10.174.169.156) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Mon, 4 Feb 2019 21:18:22 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 21:18:22 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Remove open-coded cmpxchg() in set_pte()
Thread-Topic: [PATCH] MIPS: Remove open-coded cmpxchg() in set_pte()
Thread-Index: AQHUupsmv09CGozFQkuvge0V6n8JYaXQKRcA
Date:   Mon, 4 Feb 2019 21:18:22 +0000
Message-ID: <MWHPR2201MB127783C67A6A5850B469C60CC16D0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190202015957.12404-1-paul.burton@mips.com>
In-Reply-To: <20190202015957.12404-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0003.namprd08.prod.outlook.com
 (2603:10b6:a03:100::16) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1118;6:kMD3TmHu65HNEIJTaz0xOoauEU2VGIsb+3nAmfyZb/y3CzpBj8VggG0AFff3Tnv6OOQGiKQqrKWQwYvOWU1+p4nF9xdN7AR3EFdAeMH+gyDYVJNaogQArZJPHjMlkBBpv1mZ8EeAGyiVuE/3D7AdHhIlCDBLBlNw1ONDK2wqoVdMF+Yaol7zWCjFmo+CWatqiMGsFBanTcZ9BLLekTTwVvCm1jBjIE2TQkRo2OG6HqBWiHbX4pS409+xtkswClttfwdFf3K035ZrC3gEz/spcjVNUYAgKfFHbu6Xzk8SGvVN7lMQ4c0S4ycEiNO/9Y/L6LJ1Iv0lUg+2N5JpsaIJIvottxmdVHOrxeijQ6L7epBG11G8nC1avC6lcKkfqXdXm+Hug1hze54KqjjDKFtcUJXqgcWIYlRzhtisn8bwJKST9OF325skpaYp1iuqUoqO6WRk2WROxVnKH9GR3Zslow==;5:N6SdgpD1d2FBYJgUEryH3DpRM3apxzBu/LChP+6x0q96sQhfgcwKU4eSsMBY0PzWrQdnqi9mbIoqVf6Diou4W+ghcW1HgLi1ubcfomSHJeK8+JZfppgNr59gQFn4XdBbJSmJDaXiRUacEF13mFte5moolGV3bkHhy6SpIJtcO71AS9F/4x0jcRXs9NqGoXEecKsZhhKU1bwwupe67cUwhQ==;7:kA8dxp+2o14lnbcCyOfDJAZFY2jCKghzuISISNWZoDAcowowMLVmWnzxlszl16FQIIesS+WsRKPPPEEZQGs7Y1mg1tmIoMXIQ5BWCgho3dHWtXC8lMgni91vAZ+SB6fu5UrhccD+vkqHCOJehbpZHg==
x-ms-office365-filtering-correlation-id: bcb40e18-930d-49b7-6ac5-08d68ae64a9b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1118;
x-ms-traffictypediagnostic: MWHPR2201MB1118:
x-microsoft-antispam-prvs: <MWHPR2201MB1118541F2A301AA537C7F5A2C16D0@MWHPR2201MB1118.namprd22.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(39840400004)(396003)(346002)(189003)(199004)(76176011)(81156014)(81166006)(476003)(6116002)(11346002)(3846002)(7696005)(14454004)(486006)(52116002)(97736004)(4326008)(71190400001)(6436002)(229853002)(44832011)(33656002)(66066001)(9686003)(6506007)(55016002)(386003)(2906002)(99286004)(7736002)(54906003)(42882007)(71200400001)(102836004)(6862004)(478600001)(105586002)(186003)(6246003)(106356001)(26005)(256004)(25786009)(74316002)(446003)(305945005)(53936002)(8936002)(8676002)(316002)(4744005)(68736007)(133343001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1118;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A3ucUxJbFR/8owqfndukBmMCcYZhxe+wOhFZzZ759aLfktV+BMg4diD0NeCvS9TvsSBVAdarbrVRdWUYQUP5/acWjRm9j16KXOVxkSE6vRQ0mid1v6sohnimVClwV62WBK3/jCa+vN+aneRteQ+enT64xV5Qhlj0lJT6xQ4EzoArXPnywb2YB596SMjfzCsq+ygYwW3Btvvs3aygCoXW6dMO+u/Lj+3xWdyAJc5WTf5agYBmOyLWKrEX+C+VyG7whFwQY3T8AnjqRoLHPDeGvUbrVPcVxyDSfYEwIdkCcoVUU/NinOnbqpNhBoY5auZubZb6NPGuJQXtIBrp/5ym06Nd8kVRMSa8ykWYS+Yijd2TA63g3IdZWhRZFyuW+nOhfWq13n8shuUuxEAc3oDlvHKgFr62ZiYwax79excREl0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb40e18-930d-49b7-6ac5-08d68ae64a9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 21:18:21.7173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1118
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Paul Burton wrote:
> set_pte() contains an open coded version of cmpxchg() - it atomically
> replaces the buddy pte's value if it is currently zero. Simplify the
> code considerably by just using cmpxchg() instead of reinventing it.
>=20
> Signed-off-by: Paul Burton <paul.burton@mips.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
