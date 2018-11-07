Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 00:14:23 +0100 (CET)
Received: from mail-eopbgr680128.outbound.protection.outlook.com ([40.107.68.128]:31840
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992919AbeKGXOFY0HeU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 00:14:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xr32xpBm5OfoxY0m2Vz+qMf9TQO8wopkPdgraDau2w=;
 b=Luze3sBY6Ju7pkv/J57X+g096Qfw/s9JoQm4Ns25rDGV0Nlho8IVM0gneIJQmEHNcxXwtnzqpwo3FC22yPhUCOu8oWIhA4cr0ra4E8e9lZ5dXvIIkuKlksnVl+1o+ydQpsOsS6YiQihIz69ajKmJSA9jNFl4M6VoYyDgVGMfq6c=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1472.namprd22.prod.outlook.com (10.174.170.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Wed, 7 Nov 2018 23:14:04 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 23:14:04 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 08/20] MIPS: Hardcode cpu_has_fpu=0 when
 CONFIG_MIPS_FP_SUPPORT=n
Thread-Topic: [PATCH 08/20] MIPS: Hardcode cpu_has_fpu=0 when
 CONFIG_MIPS_FP_SUPPORT=n
Thread-Index: AQHUdu+TPCSy+OP1dk68j04ke1dahQ==
Date:   Wed, 7 Nov 2018 23:14:03 +0000
Message-ID: <20181107231341.4614-9-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1472;6:7cTudd4qoClJKT4/dOZr0Vzoz9dXt+unghbFy64fwuKwEwgFXNqhpx7/UDC5CJRPooJtrJJ0eCAkqylT+0UM7iU8gAIHvbUtIG9Rk3/x/YlOKxKJM6wmpBROraeIkkHuelccKlT5XXUxcO9qsUE4881D9yoRW9XfTYizrfhf/INh/XC3hyUKDQNiQ1kXb9CGsMaiywbXR2/ka1+tJL+68yF2Qai0WX6I+70BU399t2ajmehYx9fDJo+QMVKZrxWlaiuerxU2nmzJTP37IsxF+ExPgounoylvkT345h62RPZ6uXkkd08hyznlbzzWzgzXjnRHDQG1M+HiMl/uy9+JsrEFTtVO3WD2CHrXxazN3jaqAHCzCgbDXNChAgQC48LaVoskvFp+nNGUhS0m1N0hTAV5wLJrQwFHRhALG0BNtzD0AJ6VCNUQAFEaH6AlyE6+Zx4CT9BCPyS6G4m1JtvTsg==;5:0GgSOYSngymAhQT7rZ9PE0gWNIy4erbzr0Nf5Fyp3nw8YzCe2kVow7KuE9WAyBbRq1IyFMmzMWX4aNly+K0gGRRXS9jHS4drO/KPJHxSqaB4SshUy9HJ0WySuKCqT3pXMYrvHD3+NWTzVFBo924Sit4G5iirws/H/WExFm1o5Ss=;7:+p+bXv1idx7SvXt4HibOP/dPLsEym+qqYJysDy+kC2UJ1VO8mrLca3JvSXITloLp4zOkpTaT/g2su8gcbh+mBwp3M7SHQAEC5yFuWZVc6DVlrVSffZ40MdnN05VYYTWZIfoyngyZ9dvywdUFaXctjA==
x-ms-office365-filtering-correlation-id: e679e230-7a76-4691-d254-08d64506b541
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1472;
x-ms-traffictypediagnostic: MWHPR2201MB1472:
x-microsoft-antispam-prvs: <MWHPR2201MB14728AAB24464C997FCFEAAAC1C40@MWHPR2201MB1472.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(3231382)(944501410)(52105095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1472;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1472;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(136003)(376002)(39840400004)(189003)(199004)(99286004)(52116002)(256004)(26005)(186003)(386003)(76176011)(446003)(11346002)(102836004)(44832011)(476003)(2616005)(486006)(7736002)(5640700003)(2906002)(6506007)(6512007)(71200400001)(6436002)(71190400001)(316002)(2501003)(14454004)(8676002)(81156014)(97736004)(3846002)(6116002)(25786009)(8936002)(1076002)(81166006)(2900100001)(6916009)(6486002)(36756003)(66066001)(53936002)(305945005)(68736007)(107886003)(508600001)(5660300001)(4326008)(42882007)(2351001)(105586002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1472;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: leR2ETux9DhzqN4N/ND7ml8RUhkvlxuXvKBsGhCVHxswNcmKSkmoqcuVJf/7LB4wXIGRNxHuKw+Sy7kvKH8ePl6b5i/L7t266+7WUzVkGG9ygJAqm5LTpvTAmZZJA/mLeF3C+vJREsyp2XcOLJJpBwAiRQWzCk0nZqDv7p6WbS4m/h0Qwxlswcndl1khCRA1BrZ7CWmirFxTKLCkEmwQUA3c4OAjdm6Q5dOQmbnspJ+XwTayNqWADF9ra9/IOIbRVRCDJ/TtFzCV50wuTYyj3+pL6pre/twLPMrUoXCZ6K99RiYoOuHi0KlSHJynZELCDq+jwCtPJewPUhJAtrZzZVgt2GpBZSk+9qjhOf/w+A8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e679e230-7a76-4691-d254-08d64506b541
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 23:14:03.9589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1472
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67144
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

When CONFIG_MIPS_FP_SUPPORT=n we don't support floating point, so
there's no point in detecting presence of an FPU. Hardcode
cpu_has_fpu=0 such that we optimize out code that makes use of the FPU.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/include/asm/cpu-features.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 0edba3e75747..da68acad3a8f 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -115,10 +115,15 @@
 #endif
 /* Don't override `cpu_has_fpu' to 1 or the "nofpu" option won't work.  */
 #ifndef cpu_has_fpu
-#define cpu_has_fpu		(current_cpu_data.options & MIPS_CPU_FPU)
-#define raw_cpu_has_fpu		(raw_current_cpu_data.options & MIPS_CPU_FPU)
+# ifdef CONFIG_MIPS_FP_SUPPORT
+#  define cpu_has_fpu		(current_cpu_data.options & MIPS_CPU_FPU)
+#  define raw_cpu_has_fpu	(raw_current_cpu_data.options & MIPS_CPU_FPU)
+# else
+#  define cpu_has_fpu		0
+#  define raw_cpu_has_fpu	0
+# endif
 #else
-#define raw_cpu_has_fpu		cpu_has_fpu
+# define raw_cpu_has_fpu	cpu_has_fpu
 #endif
 #ifndef cpu_has_32fpr
 #define cpu_has_32fpr		__isa_ge_or_opt(1, MIPS_CPU_32FPR)
-- 
2.19.1
