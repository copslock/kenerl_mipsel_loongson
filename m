Return-Path: <SRS0=tpXJ=QJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F05EC282D8
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 02:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FC720855
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 02:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="dEQZMcc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfBBCV4 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Feb 2019 21:21:56 -0500
Received: from mail-eopbgr800108.outbound.protection.outlook.com ([40.107.80.108]:52704
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbfBBCV4 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 1 Feb 2019 21:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ht8GUVXJiibEpTE2ufhOlIOLS0aBv/kOpCtor654BUE=;
 b=dEQZMcc4foSibDqLdh0VTadQxatd5RMFSlGRyKNmJ66CAIaoSrMYPmAO5NPWru/ZiQgy+97/9eahcKnznOVvLPNS1EldrhxNOKyHucwRmWjyZF4l8zS0ArQ9jswfc+V1zeUOOvL6r18aCYUx8wCrjOUdjFb18fyhx/oYKoIzrds=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1184.namprd22.prod.outlook.com (10.174.171.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Sat, 2 Feb 2019 02:21:53 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1580.019; Sat, 2 Feb 2019
 02:21:53 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH] MIPS: Enable hugepage support for MIPS64r6
Thread-Topic: [PATCH] MIPS: Enable hugepage support for MIPS64r6
Thread-Index: AQHUup4Ph9SefzS5I0eL9m7KKOs8kg==
Date:   Sat, 2 Feb 2019 02:21:53 +0000
Message-ID: <20190202021836.29133-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0025.prod.exchangelabs.com (2603:10b6:a02:80::38)
 To MWHPR2201MB1277.namprd22.prod.outlook.com (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1184;6:dRD6nhWaTxuZhPFUr5Jw3EDAsuHsZDbuIn3mLCvADG3vbgMdV0R5enpLFMk4pCoFSmQ3fw3GiXH9JrgoLoorjhoei3/JWPo7HD20j/taKYcPROHduDqKtYGfKIV7PVSv7I6nvlDQ8n8dzzPmsI/goWXfFu0hY38t2LPd1pcyJjs0bPeCVpQAO1MSocu+ZgZ8MjpGfESI61QmobDjBgmShIWbE7YG2b16VV0pgUXNg6cxVY/dw8I4Q7Ip6Ao0+Wotoy30ihiDj8GgDDcdfAZHTxSr3iFFUvcCEbxglqxP1VmEV/ouKNRN8uTe4zcoL0Nvj/PslrGqm4zedbt/29g9wd1um6M8GRn7jxi0apheVwIg+0A/NXcEFJeSlszyb42TBdbKjwUnFT/bUqcNRuPmpC4M1yvUYfUNs1e2kl+5MerfUtLOFE33fnvHmdfhxPRPZSyLKMrDD8JklypWAQSITA==;5:yfaPLoQaPGBoE0PbMUALWtqnxRNKWKq7hCjOgp/+NmF/jZa/qucAyJHcMnZ2NH8ppNNXmca486bu3IjzW3P29esg8blefrvH7+mlpiSAZy+so/izXX6+7d9hufpQdxKPuLVkvlCuEHW+/LIYEmA2CAA+QT8bLb5nkgl4Y1i/yOMz9XkgXXYeIz5CA/hYccnGFY4QnIamn4wE912L4LIycg==;7:6r4QlRilxBJF0uW4NvbBZK0/+6J8MJg/P4+ycd3WPXH996cITPHaXyYSS4CBF8S6Fp9YEXQCAGVtQLoJvG8QElXS8qkCYxF+UDZgujJXHVrWrjTQ9vYP/HcasLyOPNLKvZ6KprpzU+0087dTGeJDTA==
x-ms-office365-filtering-correlation-id: 64966740-2188-43e9-011a-08d688b5324e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1184;
x-ms-traffictypediagnostic: MWHPR2201MB1184:
x-microsoft-antispam-prvs: <MWHPR2201MB1184845F216D322AF460F478C1930@MWHPR2201MB1184.namprd22.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39840400004)(396003)(136003)(346002)(189003)(199004)(2351001)(26005)(42882007)(105586002)(5640700003)(68736007)(4744005)(6512007)(6436002)(2906002)(106356001)(186003)(6506007)(50226002)(53936002)(478600001)(8936002)(3846002)(386003)(6116002)(4326008)(102836004)(2501003)(71190400001)(2616005)(486006)(476003)(44832011)(107886003)(7736002)(1076003)(36756003)(99286004)(71200400001)(6916009)(305945005)(25786009)(8676002)(66066001)(316002)(52116002)(256004)(14454004)(6486002)(81156014)(81166006)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1184;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: w88lIrE0jc480imYa7sTPq6pokb6+B/ffTAMaJ+gXfQqBIbIQuXvHmrW3UyZGwSrXxLuxu09pzodwFX7v1dRBlK/NUNeppUtKm3Xqx8WOJDROsv0DHDEPkujXExKaOikJI+Lo0JFVA4uPXsEvUETRhgOzBFMWxEmPzm6IOYenxDj/yy1WuqqXcXgYuN5m2/LCOQ/8ZWb6FIrtZOM1rcsSPRE2CNK7jVzMccyHvl0cc+BSoVyinpU8lm/5zpLUtneOjPcF4kJmyHun6bTK7+1++SW5qUOF0fHcuSZyihYxoL7PPKddJIjwQ1JRyMBTyWuAjSjn83oJ1KfGqYTsBJWciKMqPla195xPx9ApKj9XJwojS5G42Q4tQEHumll28935iSth8byxaK9yJ4vWDksvPa/knSnRMJm/LvKcZa1PtU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64966740-2188-43e9-011a-08d688b5324e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 02:21:53.2873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1184
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Our hugepage support already exists for MIPS64 CPUs, and is already
enabled for older architecture revisions. There's nothing MIPSr6
specific involved, and our hugepage support already works fine for
MIPS64r6 CPUs such as the I6500, so allow it to be selected in Kconfig.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 0d14f51d0002..198ab2051dc5 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1541,6 +1541,7 @@ config CPU_MIPS64_R6
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
+	select CPU_SUPPORTS_HUGEPAGES
 	select CPU_SUPPORTS_MSA
 	select MIPS_O32_FP64_SUPPORT if 32BIT || MIPS32_O32
 	select HAVE_KVM
--=20
2.20.1

