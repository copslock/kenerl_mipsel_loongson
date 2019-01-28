Return-Path: <SRS0=zZS8=QE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C269AC282CD
	for <linux-mips@archiver.kernel.org>; Mon, 28 Jan 2019 23:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A2A214DA
	for <linux-mips@archiver.kernel.org>; Mon, 28 Jan 2019 23:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="O5GGabcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfA1XQ0 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:16:26 -0500
Received: from mail-eopbgr800101.outbound.protection.outlook.com ([40.107.80.101]:30944
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726746AbfA1XQ0 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 28 Jan 2019 18:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9upWRBBfxgn8lffzK4nUTbsByikoDeKlMH7wRSFGxjk=;
 b=O5GGabcXC4pkTVapKMDgNSPNIjOPY2Yf0zAYIFtJdWfM2f5X1o626Kqe8Kw+i9oklOqn+uY7do57xIOs7ra3pIi5VruIVAYGEOSzN2lzVHJj1R9IfVuDlMPRfdy+6o8yF3mjU4p4nGQVV9dFbUoQ9F5ZM53lp9FdjjjpEDUhUEQ=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1247.namprd22.prod.outlook.com (10.174.162.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Mon, 28 Jan 2019 23:16:22 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1558.023; Mon, 28 Jan 2019
 23:16:22 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Kevin Hilman <khilman@baylibre.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Maciej W . Rozycki" <macro@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>
Subject: [PATCH] MIPS: VDSO: Include $(ccflags-vdso) in o32,n32 .lds builds
Thread-Topic: [PATCH] MIPS: VDSO: Include $(ccflags-vdso) in o32,n32 .lds
 builds
Thread-Index: AQHUt197+z06kmnkZECwkX3QHAg4ZA==
Date:   Mon, 28 Jan 2019 23:16:22 +0000
Message-ID: <20190128231518.31459-1-paul.burton@mips.com>
References: <20190128222106.19100-1-paul.burton@mips.com>
In-Reply-To: <20190128222106.19100-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0066.namprd22.prod.outlook.com
 (2603:10b6:300:12a::28) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1247;6:TJFIIMsDNE2S7CFCq1FZCgRBSS/wRej2p1/dUvK15gF5sNaul5/12t4snlcbmjnLsp88Xj/NinLAjYGlHcbSwtGgs95jlXGBGIvihd+xFMQXnkq37TCIcmVRdzLG0SavJF/pFKVU2MMavWkqRlBvIDfqaitOYoKXBkdbO8zaCjU8AcBSnC4GzMzv2KBeUhlvAc8CuCCp139RbwcN9bJD88wkFmYLL9rULOTD1SSj91FVMQZL842yFY0w8I0i71vzzknU9q/4OK+v5bT7rWpGdk9xAe4cBMSg6TTBWigYwe0bTcJQUCCxWOyUUwzbfy6hdhGvnguBtNqM7RZOEXmx4p83n+6QWN/mxXAHaJ1FRPo9LBLKY1k1pEQMt5IlJdSKvlpmFB/EDaUnp7KI4N7FEJ57NjXeHyxYJA0LbzAvRf2OtW/+zZ4bfJhbBMoAISqjg2LBfIoWDUy6t1JwtFDIuA==;5:N1i5scjSeRAklEGqEMxcZ7NQpbt0J+xcqJ0MEACvLLXpVxd0ZA4J63lP1vZUJsVmwFOqUQNbVmTJRr0VRPCxLvy2mWP2mHp+10INeHWV62/ICBmSiksoz8xng5szLWTrKbv+EL8eWWYKejXlHaLBFtNjlRqkxh8mcTw5+W72zeaeUOPufEt1JVr2YWU6U1GHI9l4iuCKbNeU8DxYEUCjrw==;7:QFbka/c3VTyGJ+hfiLToNc77ofY2kYVRo1eWBWSd6Xo+LygOeKu15x0ed2uyWh43eR29Fs3MAgZQNjsy5JGM7/xFuO1ykOJAv9+nm3drbSxTrKgwt5xQ5ZS6ZVDwHo3mzfYm0lRjuBJK3WKl8F8Jmg==
x-ms-office365-filtering-correlation-id: aab66d6e-6104-4740-f060-08d685769e0e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1247;
x-ms-traffictypediagnostic: MWHPR2201MB1247:
x-microsoft-antispam-prvs: <MWHPR2201MB12471C02F0C559942BD0BE0EC1960@MWHPR2201MB1247.namprd22.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(39840400004)(346002)(366004)(199004)(189003)(50226002)(54906003)(42882007)(6512007)(2501003)(66066001)(68736007)(2351001)(316002)(6916009)(8936002)(71200400001)(71190400001)(6436002)(14454004)(105586002)(107886003)(446003)(97736004)(76176011)(106356001)(14444005)(256004)(5640700003)(4326008)(305945005)(6506007)(36756003)(386003)(11346002)(1076003)(7736002)(52116002)(53936002)(3846002)(8676002)(102836004)(81156014)(81166006)(44832011)(2616005)(25786009)(476003)(186003)(26005)(478600001)(486006)(6486002)(99286004)(6116002)(2906002)(142923001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1247;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4KruPWcmcaUOuFUZrklyhVLAJggYCeaDBZ8BeSbrZBzV5BT5w+gm1RPdiCICK1MbyvsSLYXiYhpHQ5KRWy8NH7I0OicnJ1ykbvfMrExfn2Ok0CjUWcVDxPfqJO84+qRYvyBUy+0kF7F0cdZrIC+lkB4k2Vqs7hTZSf6nshkmY4ZIqQQBNcBUS8JJuvGZ1sGTrHuIH1dh+QsFND475tmCQcHdc6XD2SZHIkdj8rT6OfzztEmQGunbbZSf4npS88aphed6BKQLf7hb5mgi18qs1o2Ag871vIIVreYB/ZJ77XcrXbvN9pJ+mNJGU4ISMtu2Im01Sox0atMRfmYbjLABbAzxsDcNIUJhD4MBy9OFxfNEAFk0i0t95YDZm4F2/6PojoZ3u7opIoNpDwuMxmCvAaHeW3kZnMakOyYWPiTHAX0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab66d6e-6104-4740-f060-08d685769e0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 23:16:22.2043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1247
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

When generating vdso-o32.lds & vdso-n32.lds for use with programs
running as compat ABIs under 64b kernels, we previously haven't included
the compiler flags that are supposedly common to all ABIs - ie. those in
the ccflags-vdso variable.

This is problematic in cases where we need to provide the -m%-float flag
in order to ensure that we don't attempt to use a floating point ABI
that's incompatible with the target CPU & ABI. For example a toolchain
using current gcc trunk configured --with-fp-32=3Dxx fails to build a
64r6el_defconfig kernel with the following error:

  cc1: error: '-march=3Dmips1' requires '-mfp32'
  make[2]: *** [arch/mips/vdso/Makefile:135: arch/mips/vdso/vdso-o32.lds] E=
rror 1

Include $(ccflags-vdso) for the compat VDSO .lds builds, just as it is
included for the native VDSO .lds & when compiling objects for the
compat VDSOs. This ensures we consistently provide the -msoft-float flag
amongst others, avoiding the problem by ensuring we're agnostic to the
toolchain defaults.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---
 arch/mips/vdso/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 314949b2261d..0ede4deb8181 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -130,7 +130,7 @@ $(obj)/%-o32.o: $(src)/%.c FORCE
 	$(call cmd,force_checksrc)
 	$(call if_changed_rule,cc_o_c)
=20
-$(obj)/vdso-o32.lds: KBUILD_CPPFLAGS :=3D -mabi=3D32
+$(obj)/vdso-o32.lds: KBUILD_CPPFLAGS :=3D $(ccflags-vdso) -mabi=3D32
 $(obj)/vdso-o32.lds: $(src)/vdso.lds.S FORCE
 	$(call if_changed_dep,cpp_lds_S)
=20
@@ -170,7 +170,7 @@ $(obj)/%-n32.o: $(src)/%.c FORCE
 	$(call cmd,force_checksrc)
 	$(call if_changed_rule,cc_o_c)
=20
-$(obj)/vdso-n32.lds: KBUILD_CPPFLAGS :=3D -mabi=3Dn32
+$(obj)/vdso-n32.lds: KBUILD_CPPFLAGS :=3D $(ccflags-vdso) -mabi=3Dn32
 $(obj)/vdso-n32.lds: $(src)/vdso.lds.S FORCE
 	$(call if_changed_dep,cpp_lds_S)
=20
--=20
2.20.1

