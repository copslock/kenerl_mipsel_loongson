Return-Path: <SRS0=Wred=QQ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04516C282C4
	for <linux-mips@archiver.kernel.org>; Sat,  9 Feb 2019 19:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4E220857
	for <linux-mips@archiver.kernel.org>; Sat,  9 Feb 2019 19:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="gG2C38zl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfBITrk (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 9 Feb 2019 14:47:40 -0500
Received: from mail-eopbgr730106.outbound.protection.outlook.com ([40.107.73.106]:58253
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727175AbfBITrk (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sat, 9 Feb 2019 14:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/n8cjwjKkYo+W8sBnhH3xYo+b0V6fGjGvrsKagG1Sw=;
 b=gG2C38zl2yGXpM0Qr+//w5NmapCsOGuwNSQP5DyQjc7BmNsFRw4oRiSwe1pMA/OR4tJ2GKyEiu3kbZ5efe7y6bIdP8SWeasPoMuhYme8/kxJ2t1NPlKbVC2/u20H6ilrdeHGjXrGPjhXb+uzK+BjU4xQSVk65sjoM+tCfxpSB/M=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1725.namprd22.prod.outlook.com (10.164.206.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Sat, 9 Feb 2019 19:47:37 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1601.016; Sat, 9 Feb 2019
 19:47:37 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Paul Burton <pburton@wavecomp.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] MIPS: Fix access_ok() for the last byte of user space
Thread-Topic: [PATCH] MIPS: Fix access_ok() for the last byte of user space
Thread-Index: AQHUwLBO2ONh4bPpiU2Vopk0m/AYyw==
Date:   Sat, 9 Feb 2019 19:47:36 +0000
Message-ID: <20190209194718.1294-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:a03:100::19) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1725;6:Asz0A1DVySNikqcHy8KAzYpYyrI9evnA7QiU+w8oNaa/eGmv+ZC5JqEl3d9IIVevod3T+uldMYBPIwYmxgTfgI6o7ngwc6Hg7klHujQEcokaVUMc3KVZtRDQUrM5Sr7aBLMBfafQ6CT8eVSTeSWoyx/GbmePNqvGzq8nc1TFH2S/ZgTut4mNkJFXmPsAOFUflXG8v150XEtS/tvqlfwAk22G0/DoEa608VSOud3pGVizSgT02eVciXCp+KqPVkKPIewzigpd0LedNYECDE/AXxvkF82m+mZoKRPOdVEpO6saYQdfBDnO2ImeDGJXHKFIyhjhhat8llbGtEw3nuEs5WrwJLFApUdBiyCZ1GXZBjmnkholgGgqmD6rcoEW0aX5SeIXIU6ZHr4xb/mMe8ygfJOkHQejhkkhn11mRdfhg5AOQqC34kTKJWgkMRs0xuGQDIK67UAQc1g37ZUWM9hS/g==;5:JUzJMSJREpwEdQ1nR2yVd1Sw7rYMIDPJAnRm8RQPRWl4CW610W6cOGgMGn2suGDzsAKyr5oP32Dv/Yd55DMcGAitZs+Vc0FxSOEm+u4BRk5nE0/xmMrkt6pNEHTJ3BKqFRhaey2V3uAsr+FC6/AWBhYCl5wC6AN8DuLmD3Y5JyoNozTmpvcNsjPi8WPXGkqkpJlWErYlcMXjG0hzt1iyyg==;7:v8A1ppkDrfOEx2U0Pb6FykOCj6VcFoGbitlkbWVdDCF2Bn93xhM6CX6RNVKpGQepdaq/jU13Z+C/OgmrMb++vKfPqS5Z0Vf/3pKTb2zIsVsE4R4E5YbobRXgOf2dzjL+JPw2dDcBcPMHkmzsdOdB7g==
x-ms-office365-filtering-correlation-id: a673fe4f-ea44-4f1a-9735-08d68ec770f0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1725;
x-ms-traffictypediagnostic: MWHPR2201MB1725:
x-microsoft-antispam-prvs: <MWHPR2201MB17256B4EDF78F668444AEE22C16A0@MWHPR2201MB1725.namprd22.prod.outlook.com>
x-forefront-prvs: 09435FCA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39840400004)(376002)(346002)(366004)(396003)(189003)(199004)(99286004)(71190400001)(52116002)(26005)(2501003)(478600001)(106356001)(50226002)(1076003)(6116002)(3846002)(386003)(71200400001)(105586002)(186003)(102836004)(66066001)(97736004)(36756003)(476003)(256004)(25786009)(6506007)(2351001)(14444005)(5640700003)(54906003)(53936002)(6436002)(305945005)(7736002)(81166006)(81156014)(44832011)(2616005)(6486002)(42882007)(316002)(6916009)(68736007)(2906002)(486006)(8676002)(4326008)(6512007)(14454004)(8936002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1725;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: prLPhnwVSNQrGWg3IdCMun/Pe2rAkmQzg3Wff1fineVBBD+p4ECa3hFkvUNOgsk3a3mbGMxPfVJBvEgp4t1njDrfrI53VRMzoENMiFZvowadIJOoETNLEen/6G/BEdFx6LlDjAlRqNFYwCUDoj/5WCeiR1WbHYaPGWn0APuZiE986naJB0uXMPg9KZiVSHnZW3ckprylY/V8H9hKFa9o+7uJNtrGZXmKMk0gRH5amFBeLCVdbg2dXZ/GMBJ9C/26scU/FA2kYKQ8oB7Df0XQtrAft2uTQp2s/20t2QQnIwmDjRjusvmtP6oP+DR56WznjZDFewmS8EQLiH1InOgrAI9p2R+SemDGt5MLSWD/Dewk2c6A2U2qN9RYjcfei0f5HipVhdYrkok4RdAaqLMJfr7ZVAwpyLHPRrWB/Gc/7e4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a673fe4f-ea44-4f1a-9735-08d68ec770f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2019 19:47:36.2634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1725
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The MIPS implementation of access_ok() incorrectly reports that access
to the final byte of user memory is not OK, much as the alpha & SH
versions did prior to commit 94bd8a05cd4d ("Fix 'acccess_ok()' on alpha
and SH").

For example on a MIPS64 system with __UA_LIMIT =3D=3D 0xffff000000000000 we
incorrectly fail in the following cases:

  access_ok(0xffffffffffff, 0x1) =3D 0
  access_ok(0xfffffffffffe, 0x2) =3D 0

Fix MIPS in the same way as alpha & SH, by subtracting one from the addr
+ size condition when size is non-zero. With this the access_ok() calls
above return 1 indicating that the access may be valid.

The cost of the improved check is pretty minimal - we gain 2410 bytes,
or 0.03%, in kernel code size for a 64r6el_defconfig kernel built using
GCC 8.1.0.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
---

 arch/mips/include/asm/uaccess.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uacces=
s.h
index d43c1dc6ef15..774c0f955ab0 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -128,7 +128,9 @@ static inline bool eva_kernel_access(void)
 static inline int __access_ok(const void __user *p, unsigned long size)
 {
 	unsigned long addr =3D (unsigned long)p;
-	return (get_fs().seg & (addr | (addr + size) | __ua_size(size))) =3D=3D 0=
;
+	unsigned long end =3D addr + size - !!size;
+
+	return (get_fs().seg & (addr | end | __ua_size(size))) =3D=3D 0;
 }
=20
 #define access_ok(addr, size)					\
--=20
2.20.1

