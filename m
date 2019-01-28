Return-Path: <SRS0=zZS8=QE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EC2C282CD
	for <linux-mips@archiver.kernel.org>; Mon, 28 Jan 2019 22:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042CE21738
	for <linux-mips@archiver.kernel.org>; Mon, 28 Jan 2019 22:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="XHnymAsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfA1WVV (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:21:21 -0500
Received: from mail-eopbgr680123.outbound.protection.outlook.com ([40.107.68.123]:40032
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726668AbfA1WVV (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 28 Jan 2019 17:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZE7Wu6eS5BAWpvzDm3xMEGdkkZH6kpVCvd2sS7in0eU=;
 b=XHnymAsuX9HITi0wkB2+/ij+sdP8EEwINZfXhV1d0Atmecp1LiOjEY3xOlftSRqzh1UdKhwmBMAUiE23tipl3rL6Oc9mUXlZUVkEPYdrulZ3sIAYflU3wCMKyygPctsxaCamZxOCa2fNaskcFmWw4s+clVtu8WU9bWjwdUYscl8=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1264.namprd22.prod.outlook.com (10.174.162.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Mon, 28 Jan 2019 22:21:18 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1558.023; Mon, 28 Jan 2019
 22:21:17 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Paul Burton <pburton@wavecomp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Maciej W . Rozycki" <macro@linux-mips.org>
Subject: [PATCH] MIPS: VDSO: Use same -m%-float cflag as the kernel proper
Thread-Topic: [PATCH] MIPS: VDSO: Use same -m%-float cflag as the kernel
 proper
Thread-Index: AQHUt1fJgj73RYZvOE+WwXH4dUqACg==
Date:   Mon, 28 Jan 2019 22:21:17 +0000
Message-ID: <20190128222106.19100-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0056.namprd15.prod.outlook.com
 (2603:10b6:101:1f::24) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1264;6:KlNQ+9cLqlPFohIgWXTk41LkXfC0w0UL3mJdl9JC1kcdI1iecytUdm3l/gVcafsy9p/xm+MItZpntXPfqtYspihGrWguZb6pVLnOZegdWF0utZuWu6K25h8kISD3CnfEO2E2EXhiGgSZsincHiermtnxZ2XMDyg80Mp1ZI1ejXSRO2KkJGDTPD4qUsANWHqM2o2bpWMr/SjTsqy97r4SbjNj0i14THHgTtHppN4F8FGjCyfFzVtHkOlhw5KRVwRgYkKA8m9gFAvn0BJfn6kxFceeT4M8SbDe5tejpKOxmMwB0YSv01wYQNPxGjsJKmRZEEhZwziUGqwqlOkZea4ypSWhMlWSEV/Q/yqm7bb/zdCOcAmaC3kflnq/x/7yu2oYiJyqalf2UsH5DSMUqQOPP2e/KyRQnOfsSZxNvYKS1RwrxY4YIICNX4ripuKGvgwEEwYxDXCU2hqhwucHuRydGg==;5:lS/slREAvvMMjJ+mR1lq3GDbrOozDzELFbh2G38XeCCMuVwErRfp1iV7E8hQtrvH3VO7Gh9iYS915Xf2/UuWs55xgiu16fhpKC4wg91cuntyjeyEOQ9+DZ92X1pD0HD2S85HoTMnRFwjTlSMD93AKHTnjPfJK03hwHDj+3vt7XkPLt7XlDqGVqjPxeGnNMjYx6yu34fOdRaRpaMF2LqsXg==;7:QkwkQQ8jo8chDhDgVB59CnqWBmwC5KClrasTalSBAFFmkPZHRqqAjW27dAJoJqDzMiq9/INWkcWsxvIfuyFmSqQXqhIQ/eCr+UOW10/byKyFQVjfo5VuVNmLDc0Zb4VjU/+OmapQHXrc2xHp28ZGSA==
x-ms-office365-filtering-correlation-id: 4519d400-5ca0-4a99-f215-08d6856eec17
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1264;
x-ms-traffictypediagnostic: MWHPR2201MB1264:
x-microsoft-antispam-prvs: <MWHPR2201MB126458116206D372A9591CCFC1960@MWHPR2201MB1264.namprd22.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(376002)(39830400003)(366004)(199004)(189003)(6916009)(50226002)(966005)(316002)(71200400001)(53936002)(71190400001)(44832011)(42882007)(486006)(81166006)(14454004)(54906003)(8676002)(2351001)(81156014)(4326008)(99286004)(478600001)(8936002)(36756003)(66066001)(6116002)(106356001)(97736004)(6512007)(105586002)(6306002)(6486002)(7736002)(6436002)(3846002)(2501003)(305945005)(476003)(52116002)(26005)(1076003)(186003)(102836004)(6506007)(386003)(25786009)(2616005)(14444005)(256004)(2906002)(68736007)(5640700003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1264;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OUMospbxttzPaBbhEdvObF28kd//7jM/7YWoJKUjeNxDSnZb3kIJMbtgarVcIq02ZBNPiASLnx5gXrPAx64n3djARSSRQV4/cTOy2kAIzxz3FB4MnHlQ8Jbp+84N/nmeWf+n72OMJz4XoHXZL3orgWLtPjI3gRIVmkQm8ZUGOHjnkc6rv9miLGTzHsNSKiwTNIH8PJVeVFUftjq4iTRvatBd+QUnjN88a7gcJEIge/b8mm2oZJcrtmRT3g51Kl+SURhLpvmTEQ9XMWDp1cbxknzWaOYGVZdD04xJP5hPYOnDlBdB8f7GqZzHi2wSKeY7p0wx4JXoVr2JCcTBj7NdmnJbtf2KLASIjVP5DE7gryceJeecJpCc23NiAMkeec+4B4pgYelH482XANJ/bjmk22qOp5T+mskb2lORqmcVNKM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4519d400-5ca0-4a99-f215-08d6856eec17
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 22:21:17.1674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1264
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The MIPS VDSO build currently doesn't provide the -msoft-float flag to
the compiler as the kernel proper does. This results in an attempt to
use the compiler's default floating point configuration, which can be
problematic in cases where this is incompatible with the target CPU's
-march=3D flag. For example decstation_defconfig fails to build using
toolchains in which gcc was configured --with-fp-32=3Dxx with the
following error:

    LDS     arch/mips/vdso/vdso.lds
  cc1: error: '-march=3Dr3000' requires '-mfp32'
  make[2]: *** [scripts/Makefile.build:379: arch/mips/vdso/vdso.lds] Error =
1

The kernel proper avoids this error because we build with the
-msoft-float compiler flag, rather than using the compiler's default.
Pass this flag through to the VDSO build so that it too becomes agnostic
to the toolchain's floating point configuration.

Note that this is filtered out from KBUILD_CFLAGS rather than simply
always using -msoft-float such that if we switch the kernel to use
-mno-float in the future the VDSO will automatically inherit the change.

The VDSO doesn't actually include any floating point code, and its
.MIPS.abiflags section is already manually generated to specify that
it's compatible with any floating point ABI. As such this change should
have no effect on the resulting VDSO, apart from fixing the build
failure for affected toolchains.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Kevin Hilman <khilman@baylibre.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Maciej W. Rozycki <macro@linux-mips.org>
References: https://lore.kernel.org/linux-mips/1477843551-21813-1-git-send-=
email-linux@roeck-us.net/
References: https://kernelci.org/build/id/5c4e4ae059b5142a249ad004/logs/
---
 arch/mips/vdso/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index f6fd340e39c2..314949b2261d 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -8,6 +8,7 @@ ccflags-vdso :=3D \
 	$(filter -E%,$(KBUILD_CFLAGS)) \
 	$(filter -mmicromips,$(KBUILD_CFLAGS)) \
 	$(filter -march=3D%,$(KBUILD_CFLAGS)) \
+	$(filter -m%-float,$(KBUILD_CFLAGS)) \
 	-D__VDSO__
=20
 ifdef CONFIG_CC_IS_CLANG
--=20
2.20.1

