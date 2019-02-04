Return-Path: <SRS0=rTdo=QL=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00549C282C4
	for <linux-mips@archiver.kernel.org>; Mon,  4 Feb 2019 19:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1112081B
	for <linux-mips@archiver.kernel.org>; Mon,  4 Feb 2019 19:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="RG/gYOAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfBDTx5 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:53:57 -0500
Received: from mail-eopbgr700121.outbound.protection.outlook.com ([40.107.70.121]:61351
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726821AbfBDTx5 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 4 Feb 2019 14:53:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3MNmN41rVFdfRwhKniuYTirZuOj+h5hio2oEJTBLZw=;
 b=RG/gYOAQncfEYjqdVGZ2EfIp7drlnnO0+UzDvGBBhGR5O8CZqHaYhEKk5JbaKVaVU6oynPIj8049G2Ra/0wUgrGdzcbVO7RUK4FeyPRk25jqBf9QBziWnb6hOU4PTPCgYJrpIJBZYK7E/vtEPVsfEl9g8Sw+UfYrVPawDQiTiFA=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1567.namprd22.prod.outlook.com (10.172.63.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.20; Mon, 4 Feb 2019 19:53:53 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 19:53:53 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Paul Burton <pburton@wavecomp.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] MIPS: Use lower case for addresses in nexys4ddr.dts
Thread-Topic: [PATCH] MIPS: Use lower case for addresses in nexys4ddr.dts
Thread-Index: AQHUvMNbFxehwwP5KUqKM4zM2jGMxg==
Date:   Mon, 4 Feb 2019 19:53:53 +0000
Message-ID: <20190204195337.9120-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1301CA0021.namprd13.prod.outlook.com
 (2603:10b6:301:29::34) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1567;6:pCISWTw7Yt4sTo3GZT9H3aBqPHQ5rSLx81oSFOuaOMUUFRsizoH08LAWB8Icl3Ef5d74RfH3cTzm7cTF0LmSc4WRt/iA6URWeh+kxiYH+IVeeJwxeU1VuaGeXscEPstXsrbr4TdQ8pBFnQO5+EI7uBkrkDJx5Mj750KM4in66XiNXHYHZzRsJRKOsjpXpvYHfEDwI0sIL1XqiWlL5quE5WPQ+MNmPo7V7ya+AadJxqwTcAxY0047GBLvn8gmXFrKgOIQ2hZVHQnIQ9wAotKqVKE+RwPU+dQ7ASR7icqAX9I6uQV91cfWZXR4a56zyNlUgOPPnN538aOebXb4mD7gqzeHLnVmvYFqEunMR5L/aKXdwtqFYdUk7/dGvZMFumJh2Cqj6lG1YZSwN0+Trvj8/lDc+eVXoc81WHAVP6xKs4jg/IzORg1E6eLU2a8FkZiAoZitbANpwCC6NSvgOOxk4A==;5:VKCBYQg3SVMNUMo/2lS5qi//z1vBQjkLzGEGb47ZlOF+MrSgnIoH3FIHJSJWPdTdkUhxn1wk4Os3hl3386PPWJtLtM4IfxJA6ymiVi2QSe63wBorR/e2jx9pIqK9ugfX/u9SiLoAttkVHeMte6Mqa900Q1X6omq3WFtIf2a5TMtcwQ2bHhn/C6W8xdBsGNIdasMlFWzT40jjNnunTqH8ww==;7:ndXrH2zagmO5MjFcIdLU4/eIlmpJ8OrM2ZJF8UUyFiWNyU7JffatXmAALlmYt9eYtlBJ8ePqFBliipKh9ckV6rONdzeHuUVTUJbugZg7Ilv2sRVqI/Z1Tkpc1XOE00+9RUAEVrTVz1bXNu/B1JA6ag==
x-ms-office365-filtering-correlation-id: ec336e0e-1d6b-4f2e-8e7d-08d68ada7d67
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1567;
x-ms-traffictypediagnostic: MWHPR2201MB1567:
x-microsoft-antispam-prvs: <MWHPR2201MB15674F80F14FCAC732A56A0BC16D0@MWHPR2201MB1567.namprd22.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39830400003)(366004)(376002)(396003)(136003)(189003)(199004)(256004)(53936002)(14444005)(450100002)(476003)(102836004)(3846002)(6116002)(36756003)(68736007)(386003)(2616005)(6506007)(8676002)(4326008)(66066001)(97736004)(14454004)(1076003)(6916009)(7736002)(316002)(71200400001)(305945005)(71190400001)(6486002)(25786009)(44832011)(478600001)(106356001)(186003)(5640700003)(54906003)(81156014)(105586002)(52116002)(42882007)(2906002)(8936002)(2351001)(81166006)(6436002)(99286004)(486006)(50226002)(6512007)(26005)(2501003)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1567;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Zk1FvwuzpHg5Uv6sAgXYwtU1EONaKYZR5EYAlLWP5b9hUppqtfLkCDQJBCPYCtZDABOfWF8br/97wqj06qN4IRaIR2CtayJy8iFUajL/Dps70dxk6RYpCUHMNZreHWCnf87JtvRdKRNNrdPb+8gj+B52Znnfkx2KcwluiV/BCcYvYD91yMnpdGS0pnx/Fr9anUoBeejhb4fu1qST6wFCgtoPTooRfm7GmcDGRZDWbWH7CUDibAvEYZV+WqCWGb5umOEWIr/CvRrmIOKLGFPN7DVmYxdOD3aTsxLrESdKoNveCcJq8QyyXX5FFtnRe6crtRNKeyb7g2mmpoPHzEVk+zLKzjFfzYHxdP6r2LH78zUo6fHGVUpULV/9Pm9X9bDcwGECwmyddBcFKVcTtWqqOXExg6bc5UfvWYmimPiAzKA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec336e0e-1d6b-4f2e-8e7d-08d68ada7d67
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 19:53:52.9755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1567
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

DTC introduced an i2c_bus_reg check in v1.4.7, used since Linux v4.20,
which complains about upper case addresses used in the unit name.

nexys4ddr.dts names an I2C device node "ad7420@4B", leading to:

  arch/mips/boot/dts/xilfpga/nexys4ddr.dts:109.16-112.8: Warning
    (i2c_bus_reg): /i2c@10A00000/ad7420@4B: I2C bus unit address format
    error, expected "4b"

Fix this by switching to lower case addresses throughout the file, as is
*mostly* the case in the file already & fairly standard throughout the
tree.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: stable@vger.kernel.org # v4.20+
---
 arch/mips/boot/dts/xilfpga/nexys4ddr.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts b/arch/mips/boot/dts/=
xilfpga/nexys4ddr.dts
index 2152b7ba65fb..cc8dbea0911f 100644
--- a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
+++ b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
@@ -90,11 +90,11 @@
 		interrupts =3D <0>;
 	};
=20
-	axi_i2c: i2c@10A00000 {
+	axi_i2c: i2c@10a00000 {
 	    compatible =3D "xlnx,xps-iic-2.00.a";
 	    interrupt-parent =3D <&axi_intc>;
 	    interrupts =3D <4>;
-	    reg =3D < 0x10A00000 0x10000 >;
+	    reg =3D < 0x10a00000 0x10000 >;
 	    clocks =3D <&ext>;
 	    xlnx,clk-freq =3D <0x5f5e100>;
 	    xlnx,family =3D "Artix7";
@@ -106,9 +106,9 @@
 	    #address-cells =3D <1>;
 	    #size-cells =3D <0>;
=20
-	    ad7420@4B {
+	    ad7420@4b {
 		compatible =3D "adi,adt7420";
-		reg =3D <0x4B>;
+		reg =3D <0x4b>;
 	    };
 	} ;
 };
--=20
2.20.1

