Return-Path: <SRS0=rTdo=QL=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B61FC282C4
	for <linux-mips@archiver.kernel.org>; Mon,  4 Feb 2019 21:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB3920811
	for <linux-mips@archiver.kernel.org>; Mon,  4 Feb 2019 21:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="YwOe8qWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfBDVSd (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:18:33 -0500
Received: from mail-eopbgr820107.outbound.protection.outlook.com ([40.107.82.107]:51633
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726843AbfBDVSd (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 4 Feb 2019 16:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDIKWmgkeO11m4kVw9seGTu+CWvVhK2ZcE7hfoTYtso=;
 b=YwOe8qWp8DbhQAVLgucjd//2bqursAils27Dce8ETq+y7gjfr/3hoY1ucT50MCYQkrGKJpaM5Nj1G+0CwZ0Yn69ON/RFixDl3hpXPbpY17eYbPxsbVUCP8o/IDghHxvaFEhsksPfuIpxRkDpWo6j+hiMl4cBm3bZEToonIV1Fo4=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1118.namprd22.prod.outlook.com (10.174.169.156) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Mon, 4 Feb 2019 21:18:24 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 21:18:24 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Enable hugepage support for MIPS64r6
Thread-Topic: [PATCH] MIPS: Enable hugepage support for MIPS64r6
Thread-Index: AQHUup4Ph9SefzS5I0eL9m7KKOs8kqXQKRWA
Date:   Mon, 4 Feb 2019 21:18:24 +0000
Message-ID: <MWHPR2201MB12775F459E493280197EB6F4C16D0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190202021836.29133-1-paul.burton@mips.com>
In-Reply-To: <20190202021836.29133-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0047.namprd02.prod.outlook.com
 (2603:10b6:a03:54::24) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1118;6:oRCrtRczq9f+tHm7DpqkQoTK7h2ZZYDRNftuLdZoXKf+fOYVuuab8i1byeWZ17Higg2t3eQD5YrVkOdm6s6iY1BZrfdQYqX/GooizwfUZjNF0GybNVxj4OktjXOT3xGUz6+s8ZeuG0pKTUUPbDkRJtnyD2l1pJ0hcE1Ry7/LT2ulv+QspKoHwzy/AvHyPBiJ7WUkK0deXcWBX/KaDvwwjNKPmuuegxZ2Sw0BMdEqnYCztsr9WQgaEX3lVgYqMN4Hv47DSUrf7KgEMHE08fYmEK8aKqCuwh3EKc4Lv4bDHzZoH9kAicrCU+YGQZVGLNDpkoqzSCItlh633Pa6Qb1FGYynMnnB+yOLeHMVlozfkkazzD+0kmJe/2e4ZBKKtaORT1p0QDoBw5jIfKXJhfKBphjNZDmAKN0469weQnvlzSKatXzAgO0DqFaF6CTNXcMgynqu9ceNU0lDn28jipAsgg==;5:toZYuDWQLc+2ez1ZmAYafix8f0vVaH/j/Pa6TW8psAnmY7mbfcN3JntWy+EungZ0bjU1UK2Q3jzzLPldsjag8Nq7cU1hXWeaDZRFns3BhcRDBtMMw1NMEQAOLQxTZzw8Tge4AkcbSSvSk/y8DJT2z6/7qTPjQ9vJTGCTbluVPeDyZe/0P87/DaSpDGLNWIt0nt2w87qdhoRXg7eVBQUvSw==;7:zQ+3nA0xKBiRtj5NkQGWL48ETrRCvJUkXKBOQWEEIXD+er/t34lNAoH8kWDgdlXH7Nwscxyw5C+VrNkoxouoImyI4leQTNCG4lD3DvHi1MydxasCEei4oIWFfQaSHGCnCd04vZ1EErWxSnPaeEQqCQ==
x-ms-office365-filtering-correlation-id: a3090497-c53c-4530-55b6-08d68ae64c07
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1118;
x-ms-traffictypediagnostic: MWHPR2201MB1118:
x-microsoft-antispam-prvs: <MWHPR2201MB11183B5CC3F19E117A7743E9C16D0@MWHPR2201MB1118.namprd22.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(39840400004)(396003)(346002)(189003)(199004)(76176011)(81156014)(81166006)(476003)(6116002)(11346002)(3846002)(7696005)(14454004)(486006)(52116002)(97736004)(4326008)(71190400001)(6436002)(229853002)(44832011)(33656002)(66066001)(9686003)(6506007)(55016002)(386003)(2906002)(99286004)(7736002)(54906003)(42882007)(71200400001)(102836004)(6862004)(478600001)(105586002)(186003)(6246003)(106356001)(26005)(256004)(25786009)(74316002)(446003)(305945005)(53936002)(8936002)(8676002)(316002)(4744005)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1118;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZArBPZGSEL9iiAs43hL3LrUCQksu573rQ1+w8ncVNHqvpZnSodiEaO/63LUzY92v1IEhYUQLa9PBMp7KyS0S4y/DMVyD8duRivOFx0/Wp7ZRmCz/3SvPcA2A6q/GRr6QZCIPJXn3XBX/K70a+SLejxB9zY72F/di/AovYWN1xfU8ZOpYfqWCbWhrBMoNeth+rCl5SxOZF6MopiwbxBgyAk7tuNt8/PWr7h8Z0FAIM1oozRl2kfhYZDA0+fcJ9bkoVN4scOOav7vT050sjunLd7vK1xGsitAtYCUTgHIjGLPdQZuSESWXeMW/guyaTvq/7sbR2usnLbD8I7tXVzwe1n8pNqC4RIDHQYH6dSipMNhgOoGU6ThsHltfoyc2agouuEz5kQRG8xaoL64BCoRYyNNlpxHUMsrQDSRoa2buAuM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3090497-c53c-4530-55b6-08d68ae64c07
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 21:18:24.1023
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
> Our hugepage support already exists for MIPS64 CPUs, and is already
> enabled for older architecture revisions. There's nothing MIPSr6
> specific involved, and our hugepage support already works fine for
> MIPS64r6 CPUs such as the I6500, so allow it to be selected in Kconfig.
>=20
> Signed-off-by: Paul Burton <paul.burton@mips.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
