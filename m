Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 00:14:59 +0100 (CET)
Received: from mail-bl2nam02on0095.outbound.protection.outlook.com ([104.47.38.95]:33683
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992852AbeKGXOaE2M1U convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 00:14:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSogF11VfYw2VQyqrfBvBTf3lgRj3uDC98VSjr+geCk=;
 b=OZ0OId54+YDGnTbO4d33l68M6o4ZeF6gIRmD4pZdlzwZTo6wzhCG+hlkCog+jfNcRnHASz7gPh5aQVPcfIDrP2gK77Ct1npgINIr97U0KIaCLlxBMKX5bgSlSTk6ndgqeACqKQf6L1rpSGR2YYlXt+hL9tGaxkPMlf8jttl88yQ=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1581.namprd22.prod.outlook.com (10.174.167.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 7 Nov 2018 23:14:09 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 23:14:09 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 17/20] MIPS: Avoid FCSR sanitization when
 CONFIG_MIPS_FP_SUPPORT=n
Thread-Topic: [PATCH 17/20] MIPS: Avoid FCSR sanitization when
 CONFIG_MIPS_FP_SUPPORT=n
Thread-Index: AQHUdu+Wguf0GIdHPEmhvjaO89ub4w==
Date:   Wed, 7 Nov 2018 23:14:09 +0000
Message-ID: <20181107231341.4614-18-paul.burton@mips.com>
References: <20181107231341.4614-1-paul.burton@mips.com>
In-Reply-To: <20181107231341.4614-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0028.namprd21.prod.outlook.com
 (2603:10b6:300:129::14) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1581;6:U5+7mAiyxrCzZeZ8HNC47fHP+RkZKjngbRboZoD7RjZ5REUHpnCIgLfdvBgnD5zgLGx3XcAg+qtiZixmnV6jwty6UrTFljl2Mrrq0SC2JTD1m1ZerXWTJjfjgfvIrHChjuyJSLhzbCIg1JPLpJbpxIKQ/Tb1GbUZRKBjqK9/RbrqM4bvXDvWgkPDnwQMnyewbtgAr1NgSrW1f0ccnKYB2clG5soZcQDqtW1eJRnagFeLSfR5cEECsZSpoIIL0AC0PNbSK7Iy4uGPorC9F74OBAgWynwSNCEb2kkWe81jGmuh6t2Sqygvnz2U9K9VOKxQr9K/1K5liA7ijLeJdiI79C1kh3yMJxB4QY61v2Mf7d+m7h2fs0H3Nll/oiLdk6W34iL719dIcIUGecEreVyvRRbF9a5UvxMtKCeuZGO1Z2HPFNFFdhQzuGBgJwdJ7tAvC8tU2SMnd4jDtpIxBfzqog==;5:vnmeV9K3BRRcv1dOQ4O8PH8QHF6XT/wFOy8QxVdZFyoIKFQ8MF96Kocau6ps09ecdbPLNNjGM+guEPcTkvy5Cjv/afvWBAZosvip4+ylWeYz+l7fItuHgTAkCToBYIDzBxV3g3HNcvr1zKLvgyl+ERevNYk1MhqFgsfOwn3jxIs=;7:i1viUaIFJKN3Df3MQavOykEIaeJit805koOd2ZdM3Dk8qRe9KGYj7QNNAqF4giZJHNQWW0NqoMWhezNjA3t45dX7Tzwb+hFS7TnMUcJOvJ/0d+DRVxW0iphJB/8bTKBLj+n2pwCvMNQ9DzUrzg3sRA==
x-ms-office365-filtering-correlation-id: 4dae2f1f-2baf-4cbc-cc37-08d64506b8e9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1581;
x-ms-traffictypediagnostic: MWHPR2201MB1581:
x-microsoft-antispam-prvs: <MWHPR2201MB15812DD0C44578B9F863D68AC1C40@MWHPR2201MB1581.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1581;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1581;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(396003)(136003)(376002)(346002)(189003)(199004)(14454004)(99286004)(6486002)(97736004)(36756003)(66066001)(68736007)(486006)(446003)(105586002)(11346002)(2906002)(2616005)(476003)(6116002)(44832011)(1076002)(3846002)(2351001)(106356001)(53936002)(6512007)(6436002)(5640700003)(256004)(14444005)(7736002)(25786009)(71200400001)(26005)(305945005)(386003)(186003)(6916009)(42882007)(6506007)(2501003)(76176011)(71190400001)(52116002)(5660300001)(8936002)(8676002)(316002)(4326008)(81166006)(508600001)(2900100001)(107886003)(102836004)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1581;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: j3yNL0kvTo0LHgroLAnVEA+307GeCV8z2Egtg3iqHop0pAGGGNlIsAKDlxrw9hpPcCSD1qgYqq0YmZ4m4m2QWFTyYZ17SUsNP+eqwSiyQaPzMCzA2OsYMo7cwTqv4WyhT7YVbXuOJYaUkghx1d6YqL276t09okJWECnYJZ5whROVrqWl9C1TjPkVbNPvzCrFhBNip8X4r82ZIDmGBMYNhmZbtsMlTCKlOQUQUNNIRGzD7WRvrDLNWZWAUV0SW0PdTDm/QuCvlqgU79u4MgHsq4nnP05RLUjHSYYDitkaoj7Fxd9E7eidhOQ4d7hx9IYiLkGTCGYQnBjA7enM9yAKInDy6VvO5NETbzD8AlM6iDQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dae2f1f-2baf-4cbc-cc37-08d64506b8e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 23:14:09.6135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1581
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

When CONFIG_MIPS_FP_SUPPORT=n we don't support floating point, so we
don't need to worry about floating point exceptions pending in the
Floating point Control & Status Register (FCSR) during switch_to(). Stub
out the __sanitize_fcr31() macro in this case.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/switch_to.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/switch_to.h b/arch/mips/include/asm/switch_to.h
index e610473d61b8..0f813bb753c6 100644
--- a/arch/mips/include/asm/switch_to.h
+++ b/arch/mips/include/asm/switch_to.h
@@ -84,7 +84,8 @@ do {									\
  * Check FCSR for any unmasked exceptions pending set with `ptrace',
  * clear them and send a signal.
  */
-#define __sanitize_fcr31(next)						\
+#ifdef CONFIG_MIPS_FP_SUPPORT
+# define __sanitize_fcr31(next)						\
 do {									\
 	unsigned long fcr31 = mask_fcr31_x(next->thread.fpu.fcr31);	\
 	void __user *pc;						\
@@ -95,6 +96,9 @@ do {									\
 		force_fcr31_sig(fcr31, pc, next);			\
 	}								\
 } while (0)
+#else
+# define __sanitize_fcr31(next)
+#endif
 
 /*
  * For newly created kernel threads switch_to() will return to
-- 
2.19.1
