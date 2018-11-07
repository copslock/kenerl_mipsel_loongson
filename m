Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 00:20:06 +0100 (CET)
Received: from mail-eopbgr690093.outbound.protection.outlook.com ([40.107.69.93]:18716
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992824AbeKGXTp1VC1U convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 00:19:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhbbUp3qCb+EpAOlEwviTZjNdof3rQPPl4GYU2wzc3o=;
 b=bhUI9wdbmLtcdvu90HbOlWgk7Ck13Ld20Om1GxLtor/fqyjZEgquS3z8pYImnejLr4iOlLvrgXmNJ5KeHAB81N4Xg7PNZi5wJQhEBNlwPsgQfWs+9A7ibPcCkIQgp4WiQMVj/Qx4WeOiJcFJLP4IEypUVf8EEI9HiWUVyqWJ144=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1485.namprd22.prod.outlook.com (10.174.170.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Wed, 7 Nov 2018 23:19:41 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 23:19:41 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH] MIPS: Hardcode cpu_has_mmips=1 for microMIPS kernels
Thread-Topic: [PATCH] MIPS: Hardcode cpu_has_mmips=1 for microMIPS kernels
Thread-Index: AQHUdvBc6FH/gm/eXUqshhyWFnaOnQ==
Date:   Wed, 7 Nov 2018 23:19:41 +0000
Message-ID: <20181107231931.6136-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2001CA0005.namprd20.prod.outlook.com
 (2603:10b6:301:15::15) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1485;6:bAFHNuEfGfqJBZ6XIQbAdGcPMH0XHKN4rTlPWCR1R6aXArMGPG7ERB7v1jObeOx+AUkzC71vEtOttgPKrsh9zQ+AxLW0ZLYABRr0RHlOvp/i2IsjfJVsCY3Vh7tofbLIotQWG0anM3x0yQAQJSIMYFvAr04EW8pdYROOviZMuh5p9WPHrCIXnTamqwIeVKhJz5QlguPL1njzRW9zHu2O+D3uDoQ0LUvJlxDbSnuezcTSFfTgcxpClI4SF9cHqKGLtaMXkIe5A233PGDhPD4IpsZC1cOEYEjXz/5Il9XMDxuJW+dER2IwekVCl/QzWNexBVoa7rHdcpo84xf95Z6PrBqBvplR/Cuoq84juVRgkmLPJsZK8Uw0dSeMFPZ9YM56ShZoY0uJ38W1OllttzB3KxkCljlDfiyTTw4GRHi/EgpaBbf5mv4AKszA4bDQw2+bgTWxqkk1agd7uQWK8h44ww==;5:TFW3eT7INAAuyMaeknUkOd3UzE8Z0TOFRldhagkcBtiJcLxeIl4lwtIhMXaK11HlzFU6UbTmhgKKDyclWd/FBiYUQvMyRln2F0MKf+DWNtwLCk5WqT8LYqCfrHU0ZeozRYlh1974iGwtykTsXjNdLET6ZqiQO5Nmr5U6IVSn6rA=;7:NP7VxPqJHnyPnd/9psSyHsLOyw3SY8dEA/fz/Hin9sJTvH5uYJpTmZ7cO7EYsCM9QIAQUPR9VGRruFhyURjzhV1DORopJwQxgEF93bFpa26YwDx6gZjvknSS5jm/qwJtfCZfC+7KTyHbgapwazC2RA==
x-ms-office365-filtering-correlation-id: 3f55da69-4c2d-488a-eb14-08d645077ed3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1485;
x-ms-traffictypediagnostic: MWHPR2201MB1485:
x-microsoft-antispam-prvs: <MWHPR2201MB1485CFC117BFF82C5A83DCBEC1C40@MWHPR2201MB1485.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1485;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1485;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(376002)(39840400004)(136003)(189003)(199004)(6512007)(71200400001)(25786009)(305945005)(71190400001)(2351001)(2501003)(2616005)(44832011)(97736004)(2906002)(14454004)(42882007)(486006)(256004)(316002)(14444005)(508600001)(2900100001)(4326008)(476003)(386003)(6486002)(6436002)(6506007)(52116002)(107886003)(5640700003)(1857600001)(99286004)(105586002)(5660300001)(7736002)(26005)(106356001)(36756003)(8936002)(6916009)(6116002)(1076002)(3846002)(8676002)(53936002)(186003)(66066001)(102836004)(81156014)(81166006)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1485;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: W24ChvLQ1/FtyxBkB7Ackkx+fmYMd7f0Rhue5LZ6LBiAIWTd1zadKDLFJo8FjIyO9V4hg/4dcKTSIlMwNbRXLl+2yPJJjG4oUzw2laTqauIymE0Mdc9oOkfpq0nGk/7iTFRFDCcsOjz+hjc2ombqtLCgHshs8LF0eambqwiWha8rw7C5IBa+BZ7W0tX1AU6YMirCrK0nQ8i0ctYr3AsCBz+r0ecpRXpBF7QBio2ALzZOhPj6/n9g8iJcGXgpqfOuvfQnbaRSk1sKTX7MMP9il/8lBZBVKS5Xwn6trJxkCow2RqocLOwA0vodMxRXbknBnNHkNOXx/PnwEKmf3SSMZUbabCEuzmojs7/Dk2ISjmI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f55da69-4c2d-488a-eb14-08d645077ed3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 23:19:41.7961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1485
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67157
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

If we built the kernel targeting the microMIPS ISA then the very fact
that the kernel is running implies that the CPU supports microMIPS. Thus
we can hardcode cpu_has_mmips to 1 allowing the compiler greater scope
for optimisation due to the compile-time constant.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/cpu-features.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 0edba3e75747..8669fdb503a5 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -195,7 +195,9 @@
 #endif
 
 #ifndef cpu_has_mmips
-# ifdef CONFIG_SYS_SUPPORTS_MICROMIPS
+# if defined(__mips_micromips)
+#  define cpu_has_mmips		1
+# elif defined(CONFIG_SYS_SUPPORTS_MICROMIPS)
 #  define cpu_has_mmips		__opt(MIPS_CPU_MICROMIPS)
 # else
 #  define cpu_has_mmips		0
-- 
2.19.1
