Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 00:14:08 +0100 (CET)
Received: from mail-eopbgr680125.outbound.protection.outlook.com ([40.107.68.125]:11886
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992889AbeKGXOAYwwdU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 00:14:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsijW2GbT6pTNE4ktUxIXpsK+I2diIgaxA4wtPed7zk=;
 b=otc10vuNSKdUcUdzR37MHPHvMTvcIj/m32TY2NQ9mFCgVmFjKFQX531EdESGiPgPGXfR/tnNmS5TEH5TZYzleZhZhq5SzROBPcSyNylrdyYCUgleujwfDqAlPov14866YKe10/NYMSJXKLlwSh1RlFAosM03jBP+GeD0YiREJAw=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1472.namprd22.prod.outlook.com (10.174.170.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Wed, 7 Nov 2018 23:13:59 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 23:13:59 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 02/20] MIPS: BCM5xxx: Remove dead init_fpu code
Thread-Topic: [PATCH 02/20] MIPS: BCM5xxx: Remove dead init_fpu code
Thread-Index: AQHUdu+QLjcnQuW4b0KEP9IwTOrjUA==
Date:   Wed, 7 Nov 2018 23:13:58 +0000
Message-ID: <20181107231341.4614-3-paul.burton@mips.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1472;6:tvNbh380Wln4LeNG3I9oXDYwWqU4lScLcb2yWKan+kHaQuB7dQYsw/9X30T2BN2mxIKOUlUPZWzJFQpC/ksfJgme6vfnpX4a3DXLtn87nUNCPqpRzx9C33QkqvmHeNwpF8rq+BeewgMLuYJ9RF6CNIk3qNyapRD9tK4+YsL2xbsB/CoxI0FwZiOBK8SPJKzy7rpeZoqFI/EUHB8QWdmNySzpnTvNneBlWdeqAIudbvaf+252/VckopkzgohqzvZLjpjoByrQIR9uP/+Bbm1WF3XIBwYbXGiOyOrZudzwppQtGT6wTL2ajDseh1hIr8q461Fo9PB5GSIeXg+rJ+IJMCJ2KPpAQjj3O9uSit9twvZnssOqBFCiFXJ7veGMGtDcDp4LQc9zGHMCbKyq+vb4uElDhp4cowMN1po+xMGP5A6SH3OiBF9cRVx1bHlBarT7DbBemq3zYfToQeFQ3qyFKA==;5:RtEld3deVfzAAZUF/iGZiwm8WxDwQJ84PrH0px2DIp8lPiG+0usK4ooPBLNb2AS1WOZNPNAlVgayPsozWq6yetnvQ3RAHdNkRyeIRXbVme1fzuTO8vfB/CLGNnDOqHLn51VDTycDVp+gxB9uopqYhmXebHmuouGWkdEKR2SpfAA=;7:+QxbQwCp+7saVnf8QcSu6jR40ZseCv/wJPWGWx8ef7uVsKY0O8XS+AZ+BX0sd7ZlGGQUivo/1zZDzG2KmBehwvXEdBb3dB+86D9eUB8qLUvrgIyNauAdDXbk4jhD0vi7uBpLmXKdnlveoGOG/7UpTQ==
x-ms-office365-filtering-correlation-id: c35ef33c-315b-4799-2e2e-08d64506b27a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1472;
x-ms-traffictypediagnostic: MWHPR2201MB1472:
x-microsoft-antispam-prvs: <MWHPR2201MB1472C0DA8D437ABF13624365C1C40@MWHPR2201MB1472.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(3231382)(944501410)(52105095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1472;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1472;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(136003)(376002)(39840400004)(189003)(199004)(99286004)(52116002)(256004)(26005)(186003)(386003)(76176011)(446003)(11346002)(102836004)(44832011)(476003)(2616005)(486006)(7736002)(5640700003)(2906002)(6506007)(6512007)(71200400001)(6436002)(71190400001)(316002)(2501003)(14454004)(8676002)(81156014)(97736004)(3846002)(6116002)(25786009)(8936002)(1076002)(81166006)(2900100001)(6916009)(6486002)(36756003)(66066001)(53936002)(305945005)(68736007)(107886003)(508600001)(5660300001)(4326008)(42882007)(2351001)(105586002)(106356001)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1472;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nY9x17OFgumuiwX+Ntxp6D5lyJlmwayXHhlbK9SQpKVJTP9gDllHOxT51ROnBImgPV2Hiw1rL+kQA7XEeSQm2eCB3VVRkZiijPsfdsAJ+pPXWTVtRsZl0fwPwS7vxaYyt6Adty5nqz3zvoHdfrcPZGCFVs0dYlyyVBjD7Xq7qKMgyA1jy/dT0uHxbAI+hEF4O5HiVwMn4Rab2RC5D5bfypjqZxZE2A+lhzcgoY25DzAIyBFNJyqRtlySA1lHGd7sh2Nb2Es2wAFilxaba+krSN0lLd7vcb//nDLbErFx8RNHx50s6L+lV2JOtFEOZIofvvZhWKt7djhJRSDkyLrBPg1Fcluq2dMDgYo8HZx/OEA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c35ef33c-315b-4799-2e2e-08d64506b27a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 23:13:59.0139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1472
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67138
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

The BMIPS5xxx core_init function contains a call to an init_fpu function
inside an #ifdef whose condition never evaluates true. Remove the dead
code. FPU initialization happens later, primarily when a userland
program attempts to use it.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/kernel/bmips_5xxx_init.S | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/mips/kernel/bmips_5xxx_init.S b/arch/mips/kernel/bmips_5xxx_init.S
index adaa82e00f2b..9e422d186a17 100644
--- a/arch/mips/kernel/bmips_5xxx_init.S
+++ b/arch/mips/kernel/bmips_5xxx_init.S
@@ -632,12 +632,6 @@ core_init:
 	bal	set_zephyr
 	nop
 
-#if ENABLE_FPU==1
-	/* initialize the Floating point unit (both TPs) */
-	bal	init_fpu
-	nop
-#endif
-
 	/* set low latency memory bus */
 	li	a0, 1
 	bal	set_llmb
-- 
2.19.1
